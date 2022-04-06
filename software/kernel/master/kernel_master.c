/*!\file kernel_master.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * Kernel master is the system manager kernel.
 *
 * \detailed
 * kernel_master is the core of the OS running into the managers processors (local and global).
 * It assumes two operation modes: global or local. The operation modes is defined by the global variable is_global_master.
 * Local operation mode: runs into local managers. Manage the applications and task mapping.
 * Global operation mode: runs into global manager. Runs all functions of the local operation mode, further the applications admission control.
 * The kernel_master file uses several modules that implement specific functions
 */

#include "kernel_master.h"

#include "../../include/plasma.h"
#include "../../modules/utils.h"
#include "../../include/services.h"
#include "../../modules/packet.h"
#include "../../modules/new_task.h"
#include "../../modules/cluster_scheduler.h"
#include "../../modules/reclustering.h"
#include "../../modules/applications.h"
#include "../../modules/processors.h"
#include "../../modules/control_messages_fifo.h"
#include "../../modules/csiphash.h"
#include "../../modules/lfsr.h"

#include "../../modules/osz_master.h"


NewTask * pending_new_task;

/*Local Manager (LM) global variables*/
unsigned int 	pending_app_to_map = 0; 					//!< Controls the number of pending applications already handled by not completely mapped
unsigned char 	is_global_master;							//!< Defines if this kernel is at global or local operation mode
unsigned int 	global_master_address;						//!< Used to stores the global master address, is useful in local operation mode
unsigned int 	terminated_task_master[MAX_TASKS_APP];		//!< Auxiliary array that stores the terminated task list

/*Global Master (GM) global variables*/
unsigned int 	total_mpsoc_resources = (MAX_LOCAL_TASKS * MAX_SLAVE_PROCESSORS);	//!< Controls the number of total slave processors pages available. Is the admission control variable
unsigned int 	cluster_load[CLUSTER_NUMBER];										//!< Keep the cluster load, updated at every applications start and finish
unsigned int 	terminated_app_count = 0;											//!< Used to fires the END OF ALL APPLIATIONS
unsigned int 	waiting_app_allocation = 0;											//!< Signal that an application is not fully mapped
unsigned int 	app_id_counter = 0;

extern int shape_index;
//extern Shapes shapes[MAX_SHAPES];
//extern Shapes Secure_Zone[MAX_SHAPES];

lfsr_t glfsr_d0;
lfsr_t glfsr_c0;


/** Assembles and sends a APP_TERMINATED packet to the global master
 *  \param app The Applications address
 *  \param terminated_task_list The terminated task list of the application
 */
void send_app_terminated(Application *app, unsigned int * terminated_task_list){

	ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = global_master_address;

	p->service = APP_TERMINATED;

	p->app_ID = app->app_ID;

	p->app_task_number = app->tasks_number;

	send_packet(p, (unsigned int) terminated_task_list, app->tasks_number);

	while (MemoryRead(DMNI_SEND_ACTIVE));

}

/** Assembles and sends a TASK_ALLOCATION packet to a slave kernel
 *  \param new_t The NewTask instance
 */
void send_task_allocation(NewTask * new_t){

	ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = new_t->allocated_processor;

	p->service = TASK_ALLOCATION;

	p->master_ID = new_t->master_ID;

	p->task_ID = new_t->task_ID;

	p->code_size = new_t->code_size;

	send_packet(p, (0x10000000 | new_t->initial_address), new_t->code_size);

	//putsv(" time before - ", MemoryRead(TICK_COUNTER));
	//puts("Task allocation send - id: "); puts(itoa(p->task_ID)); puts(" send to proc: "); puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1])); puts("\n");
	//putsv(" time  after- ", MemoryRead(TICK_COUNTER));
}

/** Assembles and sends a TASK_RELEASE packet to a slave kernel
 *  \param app The Application instance
 */
void send_task_release(Application * app){
	int flag = 0;
	ServiceHeader *p;
	unsigned int app_tasks_location[app->tasks_number];

	for (int i =0; i<app->tasks_number; i++){
		app_tasks_location[i] = app->tasks[i].allocated_proc;
	}
	
	for (int i =0; i<app->tasks_number; i++){

		if(app->tasks[i].status == REQUESTED){

			p = get_service_header_slot();
			p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = app->tasks[i].allocated_proc;

			p->service = TASK_RELEASE;
	
			p->app_task_number = app->tasks_number;
	
			p->task_ID = app->tasks[i].id;
	
			p->data_size = app->tasks[i].data_size;
	
			p->bss_size = app->tasks[i].bss_size;
	
			p->secure = app->secure;

			//puts("\nsecure: "); puts(itoh(p->secure));
	
			if(!proc_is_migrating(app->tasks[i].allocated_proc)){
				send_packet(p, (unsigned int) app_tasks_location, app->tasks_number);
	
				app->tasks[i].status = TASK_RUNNING;
			}
			else{
				flag = 1;
			}
		}
	//putsv("\n -> send TASK_RELEASE to task ", p->task_ID);
	//puts(" in proc "); puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1])); puts("\n----\n");
	}
	if(flag == 0)
		app->status = RUNNING;

	while(MemoryRead(DMNI_SEND_ACTIVE));
}
void send_tasks_location(Application * app){
	int flag = 0;
	ServiceHeader *p;
	unsigned int app_tasks_location[app->tasks_number];
	for (int i =0; i<app->tasks_number; i++){
		app_tasks_location[i] = app->tasks[i].allocated_proc;
	}
	
	for (int i =0; i<app->tasks_number; i++){
			p = get_service_header_slot();
	
			p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = app->tasks[i].allocated_proc;
	
			p->service = TASKS_LOCATION;
	
			p->app_task_number = app->tasks_number;
	
			p->task_ID = app->tasks[i].id;
	
				send_packet(p, (unsigned int) app_tasks_location, app->tasks_number);
	
		}
}

/** Assembles and sends a APP_ALLOCATION_MAP packet to the global master
 *  \param app The Application instance
 *  \param task_info An array containing relevant task informations
 */
void send_app_allocation_map(Application * app, unsigned int * task_info, int tasks_map_number){

	ServiceHeader *p;

	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = global_master_address;

	p->service = APP_ALLOCATION_MAP;

	p->master_ID = net_address;

	p->app_task_number = tasks_map_number;

	//putsv("Send new APP REQUEST to master - id: ", p->task_ID );
	//putsv("App id: ", app->app_ID);

	if(get_net_address() != global_master_address)
		send_packet(p, (unsigned int) task_info, app->tasks_number*4);

	send_packet_io(p, (unsigned int) task_info, tasks_map_number*4, INJECTOR);

	while (MemoryRead(DMNI_SEND_ACTIVE));

}


/** Assembles and sends a TASK_MIGRATION packet to a slave kernel
 *  \param task_ID The task ID to be migrated
 *  \param new_proc The new processor address of task_ID
 * BY FOCHI
 */
int send_full_task_migration(int task_ID, int old_proc, int new_proc){
	ServiceHeader *p = get_service_header_slot();
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = old_proc;
	p->service = TASK_MIGRATION;
	p->task_ID = task_ID;
	p->allocated_processor = new_proc;
	send_packet(p, 0, 0);
	//putsvsv("Task migration order of task ", task_ID, " to proc ", old_proc);
	puts("Task migration order of task "); puts(itoh(task_ID)); puts(" to processor "); puts(itoh(old_proc)); puts("\n");
	change_task_location_TCB(task_ID, old_proc, new_proc);

	return 1;

}

/** Requests a new application to the global master kernel
 *  \param app Application to be requested
 */
void request_application(Application *app){
	Task *t;
	NewTask nt;
	unsigned int task_info[app->tasks_number*4];
	int index_counter, tasks_mapped = 0;

	puts("\nRequest APP\n");

	pending_app_to_map--;
	index_counter = 0;

	for (int i=0; i<app->tasks_number; i++){
		t = &app->tasks[i];
		if (t->allocated_proc == -1){
			putsv("ERROR task id not allocated: ", t->id);
			while(1);
		}

		if(!proc_is_migrating(t->allocated_proc)){
			puts("Request allocation of task "); puts(itoh(t->id)); puts(" to processor "); puts(itoh(t->allocated_proc)); puts("\n");
			task_info[index_counter++] = t->id;
			task_info[index_counter++] = t->allocated_proc;
			task_info[index_counter++] = t->initial_address;
			task_info[index_counter++] = t->code_size;
			t->status = REQUESTED;
			tasks_mapped++;
		}
	}

	send_task_release(app);
	send_app_allocation_map(app, task_info, tasks_mapped);
}

/** Handles a pending application. A pending application it the one which there is some task to be inserted into reclustering
 */
void handle_pending_application(){

	Application *app = 0;
	int request_app = 0;

	puts("Handle next application \n");

	/*Selects an application pending to be mapped due reclustering*/
	app = get_next_pending_app();

	//This line fires the reclustering protocol
	request_app = reclustering_next_task(app);

	if (request_app){

		app->status = READY_TO_LOAD;

		request_application(app);
	}
}

/** Handles an application which terminated its execution
 *  \param appID Application ID of the terminated app
 *  \param app_task_number Application task number
 *  \param app_master_addr Application master XY address
 */
void handle_app_terminated(int appID, unsigned int app_task_number, unsigned int app_master_addr){

	unsigned int task_master_addr;
	int borrowed_cluster, original_cluster;

	putsv("\n --- > Handle APP terminated- app ID: ", appID);
	//puts("original master addrr "); puts(itoh(app_master_addr)); puts("\n");

	original_cluster = get_cluster_ID(app_master_addr >> 8, app_master_addr & 0xFF);

	for (int i=0; i<app_task_number; i++){
		task_master_addr = terminated_task_master[i];

		//puts("Terminated task id "); puts(itoa(appID << 8 | i)); puts(" with physycal master addr "); puts(itoh(task_master_addr)); puts("\n");

		if (task_master_addr != app_master_addr && task_master_addr != net_address){

			borrowed_cluster = get_cluster_ID(task_master_addr >> 8, task_master_addr & 0xFF);

			release_cluster_resources(borrowed_cluster, 1);

		} else if (task_master_addr != net_address){ // Because only the global calls this funtion
			//puts("Remove original\n");
			release_cluster_resources(original_cluster, 1);
		}
	}
	total_mpsoc_resources += app_task_number;
	terminated_app_count++;
	puts("SIMUL_PROGRESS "); puts(itoa(((terminated_app_count*100)/APP_NUMBER)));puts("%\n");

	//puts("\n-------\n");

	if (terminated_app_count == APP_NUMBER){
		puts("FINISH ");puts(itoa(MemoryRead(TICK_COUNTER))); puts("\n");
		MemoryWrite(END_SIM,1);
	}

}

void request_task_of_application(int proc_address){
	Application *app;
	Task *t;
	NewTask nt;
	unsigned int task_info[80];
	int index_counter, taskID0, tasks_mapped = 0;
	puts("entrou request.. proc_address: "); puts(itoh(proc_address)); puts("\n");
    taskID0 = get_task_id_processor(proc_address) &  0XFFFF;
	puts("request task id : "); puts(itoh(taskID0)); puts("\n");
	app = get_application_ptr(taskID0>>8); 
	index_counter = 0;

	for (int i=0; i<app->tasks_number; i++){
		t = &app->tasks[i];
		if (t->allocated_proc == -1){
			putsv("ERROR task id not allocated: ", t->id);
			while(1);
		}
		//putsv("Task status: ", t->status);
		//puts("processor: "); puts(itoh(t->allocated_proc)); puts("\n");
		//puts("   status: "); puts(itoh(t->status)); puts("\n");
		if(t->status == OFF && t->allocated_proc == proc_address){
			puts("Achou para alocar depois migração \n");
			t->status = REQUESTED;
			puts("Request allocation of task "); puts(itoh(t->id)); puts(" to processor "); puts(itoh(t->allocated_proc)); puts("\n");
			task_info[index_counter++] = t->id;
			task_info[index_counter++] = t->allocated_proc;
			task_info[index_counter++] = t->initial_address;
			task_info[index_counter++] = t->code_size;
			tasks_mapped++;
		}
	}

	send_task_release(app);
	send_app_allocation_map(app, task_info, tasks_mapped);
}


int Aplly_LSFR(lfsr_data_t polynom_d, lfsr_data_t init_value_d, lfsr_data_t polynom_c, lfsr_data_t init_value_c)
{
    unsigned char bit0, bitc0, bitr = 0;
    char byte = 0, bitpos = 7;
    unsigned long long bitcounter = 0, ones = 0, zeros = 0, dropped = 0;
//    lfsr_data_t polynom_d, init_value_d,
                //polynom_c, init_value_c;

    GLFSR_init(&glfsr_d0, polynom_d, init_value_d);

    GLFSR_init(&glfsr_c0, polynom_c, init_value_c);

    do {
        bit0  = GLFSR_next(&glfsr_d0);
        bitc0 = GLFSR_next(&glfsr_c0);


        if (bitc0) {
            bitr = bit0;

            if (bitpos < 0) {
//                fprintf(fp, "%c", byte);
                bitpos = 7;
                byte = 0;
            }

            byte |= bitr << bitpos;
            bitpos--;

            bitr ? ones++ : zeros++;
        } else {
            dropped++;
        }

        bitcounter++;
    //} while (!((glfsr_d0.data == init_value_d) && (glfsr_c0.data == init_value_c)));
    } while (bitcounter < 128);

    return 0;
}





/** Handles a new packet from NoC
 */
void handle_packet() {
	char key[16] = {0,1,2,3,4,5,6,7,8,9,0xa,0xb,0xc,0xd,0xe,0xf};
	char data_Ke[24], rnd[24];
	uint64_t Km;
	ServiceHeader *send_value;
	int allocated_processor;


	int app_id, allocated_tasks, index_counter, master_addr;
	volatile ServiceHeader p;
	NewTask nt;
	Application *app;
	unsigned int task_info[MAX_TASKS_APP*4];

	read_packet((ServiceHeader *)&p);

//	puts("Message: ");puts(itoh(p.service)); puts("\n");
//	puts("Source : ");puts(itoh(p.source_PE)); puts("\n");
	

	switch (p.service){

	case NEW_APP:
		handle_new_app(p.app_ID, 0, p.app_descriptor_size);
		break;

	case TASK_ALLOCATED:

		putsv("\n -> TASK ALLOCATED from task ", p.task_ID);
		app_id = p.task_ID >> 8;

		app = get_application_ptr(app_id);

		allocated_tasks = set_task_allocated(app, p.task_ID);

		putsv("Allocated tasks: ", allocated_tasks);

		if (allocated_tasks == app->tasks_number){
			if(app->secure == 1){
				int RH_addr=0;
				int LL_addr=(XDIMENSION << 8) + YDIMENSION;
				int location;
				for(int i=0; i<app->tasks_number; i++){
					location = get_task_location(app->tasks[i].id);
					if((location >> 8) > (RH_addr >> 8)){//test highier X: RH_X
						RH_addr = (location & 0xf00) | (RH_addr & 0x0ff);
					}
					if((location >> 8) < (LL_addr >> 8)){//test lower X: LL_X 
						LL_addr = (location & 0xf00) | (LL_addr & 0x0ff);
					}
					if((location & 0xff) > (RH_addr & 0xff)){//test highier Y: RH_Y
						RH_addr = (RH_addr & 0xf00) | (location & 0x0ff);
					}
					if((location & 0xff) < (LL_addr & 0xff)){//test lower Y: LL_Y
						LL_addr = (LL_addr & 0xf00) | (location & 0x0ff	);
					}
				}
				LL_addr = ((LL_addr >> 4) & 0xf0) | ((LL_addr) & 0xf);
				RH_addr = ((RH_addr >> 4) & 0xf0) | ((RH_addr) & 0xf);
				// puts("RH_addr:"); puts(itoh(RH_addr)); puts("\n");
				// puts("LL_addr:"); puts(itoh(LL_addr)); puts("\n");
				set_RH_Address(app->app_ID, RH_addr);
				puts("STARTSZ:");puts(itoa(MemoryRead(TICK_COUNTER)));puts("\n");	
				Seek(SET_SECURE_ZONE_SERVICE, get_net_address(), LL_addr, RH_addr);
			}
		}

		break;

	case INITIALIZE_CLUSTER:
		global_master_address = p.source_PE;

		reclustering_setup(p.cluster_ID);

		initialize_slaves();


		break;

	case LOAN_PROCESSOR_REQUEST:
	//case LOAN_PROCESSOR_DELIVERY:
	//case LOAN_PROCESSOR_RELEASE:

		handle_reclustering((ServiceHeader *)&p);

		break;

	case APP_ALLOCATION_MAP:

		putsv(" MAp Received - ", MemoryRead(TICK_COUNTER));

		DMNI_read_data((unsigned int)task_info, p.app_task_number*4);
		//Aplly_LSFR
		// If secure only!!!!!!!!!!!!!!!
		//if(app->secure == 1){
/*		
			for(int i=0; i<24;i++)
				rnd[i] = i ^ 0xAB;

			Km = siphash24((void *) rnd , 24, key);

			puts("Km: ");  puts(itoh(Km));  puts("\n");

			index_counter = 1;
		
			//puts(" task number: ");	puts(itoh(p.app_task_number)); puts("\n");

			for(int i=0; i< p.app_task_number; i++){

				allocated_processor = task_info[index_counter];

				send_value = get_service_header_slot();

				send_value->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = allocated_processor;

				send_value->service = RND_VALUE;

				send_value->source_PE = global_master_address;

				send_packet(send_value, (unsigned int) rnd, 6);

				puts(" RND value to: "); puts(itoh(allocated_processor)); puts("\n");

				index_counter += 4;

			}

			putsv(" Init LSFR - ", MemoryRead(TICK_COUNTER));
			Aplly_LSFR(Km, 0X12, Km, 0xA1);
			putsv(" end LSFR - ", MemoryRead(TICK_COUNTER));

			index_counter = 1;
		
			//puts(" task number: ");	puts(itoh(p.app_task_number)); puts("\n");

			for(int i=0; i< p.app_task_number; i++){

				allocated_processor = task_info[index_counter];

				send_value = get_service_header_slot();

				send_value->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = allocated_processor;

				send_value->service = KE_VALUE;

				send_value->source_PE = global_master_address;

				send_packet(send_value, (unsigned int) data_Ke, 6);

				puts(" Ke value to: "); puts(itoh(allocated_processor)); puts("\n");

				index_counter += 4;

			}			

		//}
*/

//-------------------------------------------------------------------------------------------------------------
		//puts("New app allocation request\n");

//		index_counter = 0;

		//DMNI_read_data((unsigned int)task_info, p.app_task_number*4);

//		for(int i=0; i< p.app_task_number; i++){
//
//			nt.task_ID = task_info[index_counter++];
//			nt.allocated_processor = task_info[index_counter++];
//			nt.initial_address = task_info[index_counter++];
//			nt.code_size = task_info[index_counter++];
//			nt.master_ID = p.master_ID;
//
//			//add_new_task(&nt);
//
//			puts("New task requisition: "); puts(itoa(nt.task_ID)); puts(" allocated proc ");
//			puts(itoh(nt.allocated_processor)); puts("\n");
//			//putsv("time - ", MemoryRead(TICK_COUNTER)); 
//
//			/*These lines above mantain the cluster resource control at a global master perspective*/
//			master_addr = get_master_address(nt.allocated_processor);
//
//			//net_address is equal to global master address, it is necessary to verifies if is master because the master controls the cluster resources by gte insertion of new tasks request
//			if (master_addr != net_address && master_addr != nt.master_ID){
//
//				//Reuse of the variable master_addr to store the cluster ID
//				master_addr = get_cluster_ID(master_addr >> 8, master_addr & 0xFF);
//
//				//puts("Reservou por reclustering\n");
//
//				allocate_cluster_resource(master_addr, 1);
//			}
//
//		}
//
		waiting_app_allocation = 0;

		break;

	case APP_TERMINATED:

		DMNI_read_data((unsigned int)terminated_task_master, p.app_task_number);

		handle_app_terminated(p.app_ID, p.app_task_number, p.source_PE);

		break;

	case TASK_TERMINATED:

			puts("ERROR: End Task received through NoC; Seek must be used to do this.\n");

		break;

	case TASK_TERMINATED_OTHER_CLUSTER:

		page_released(clusterID, p.source_PE, p.task_ID);

		break;

	case TASK_MIGRATED:

		putsv("End migration at time - ", MemoryRead(TICK_COUNTER));
		putsv("Task migrated id: ", p.task_ID);
		puts("New processor address: "); puts(itoh( p.source_PE)); puts("\n");

		if(sub_migrations(p.task_ID >> 8) == 0){

			app_id = p.task_ID >> 8;

			app = get_application_ptr(app_id); 

			send_tasks_location(app);

			Seek(UNFREEZE_TASK_SERVICE, p.released_proc << 16 | get_net_address(), p.task_ID >> 8, 0);

			putsv("Send UNFREEZE appid: ", p.task_ID >> 8);
		    putsv("Time - ", MemoryRead(TICK_COUNTER));

			Seek(CLEAR_SERVICE, p.released_proc << 16 | get_net_address(), 0, 0);
		}
		remove_from_migration_list(p.released_proc ,p.task_ID);
		puts("Requesting allocation...\n");
		request_task_of_application(p.released_proc);
		break;

	case SLACK_TIME_REPORT:

		update_proc_slack_time(p.source_PE, p.cpu_slack_time);

		break;



	default:
		puts("ERROR: service unknown ");puts(itoh(p.service)); puts("\n");
		putsv("Time: ", MemoryRead(TICK_COUNTER));
		break;
	}

}

/** Initializes the cluster load by zeroing the cluster_load[] array
 */
void initialize_cluster_load(){
	for(int i=0; i<CLUSTER_NUMBER; i++){
		cluster_load[i] = 0;
	}
}

/** Initializes all slave processor by sending a INITIALIZE_SLAVE packet to each one
 */
void initialize_slaves(){

	int proc_address; //, index_counter;
	unsigned int LL_addr, RH_addr;	

	init_processors();

	//init_shapes();

	for(int j=cluster_info[clusterID].yi; j<=cluster_info[clusterID].yf; j++) {

		for(int i=cluster_info[clusterID].xi; i<=cluster_info[clusterID].xf; i++) {

			proc_address = i*256 + j;//Forms the proc address
			
			
			if( proc_address != net_address) {

				//Fills the struct processors
				add_processor(proc_address);

			}
			else
				add_processor(proc_address);
		}
	}

	//print_processors();

    LL_addr = ((cluster_info[clusterID].xi & 0xf) << 4) | (cluster_info[clusterID].yi & 0xf); 
    RH_addr = ((cluster_info[clusterID].xf & 0xf) << 4) | (cluster_info[clusterID].yf & 0xf);
	//puts("RH_addr:"); puts(itoh(RH_addr)); puts("\n");
	//puts("LL_addr:"); puts(itoh(LL_addr)); puts("\n");            
	Seek(INITIALIZE_SLAVE_SERVICE, (INITIALIZE_SLAVE_SERVICE <<16 | get_net_address()), LL_addr, RH_addr);

	puts("Slaves inicializados:\n");


}

#ifdef GRAY_AREA
void initialize_IO(int peripheralID){

	ServiceHeader *p = get_service_header_slot();

	p->service = IO_INIT;

	p->requesting_processor = get_net_address();

	// p->task_ID = consumer_task;

	p->peripheral_ID = peripheralID;

	//add_msg_request(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1], consumer_task, peripheral_ID); //caimi: arrumar header

	send_packet_io(p, 0, 0, peripheralID);
}
#endif

/** Initializes all local managers by sending a INITIALIZE_CLUSTER packet to each one
 */
void initialize_clusters(){


	int cluster_master_address;
	ServiceHeader *p;

	Seek(INITIALIZE_CLUSTER_SERVICE, (INITIALIZE_CLUSTER_SERVICE<<16 | get_net_address()), 0, 0);

	puts("Inicializou mestre global com ID "); puts(itoa(0)); puts("\n");

	Seek(CLEAR_SERVICE, (INITIALIZE_CLUSTER_SERVICE<<16 | get_net_address()), 0, 0);

	reclustering_setup(0);
}

/** Handles a new application incoming from the global manager or by repository
 * \param app_ID Application ID to be handled
 * \param ref_address Pointer to the application descriptor. It can point to a array (local manager) or the repository directly (global manager)
 * \param app_descriptor_size Size of the application descriptor
 */
void handle_new_app(int app_ID, volatile unsigned int *ref_address, unsigned int app_descriptor_size){

	Application *application;
	int mapping_completed = 0;

	int PEs_number, shape_location;
	int xi_initial=0, yi_initial=0, xf_initial=0, yf_initial=0;

	//INICIO DO PROTOCOLO
	putsv("#### BEGIN PROTOCOL OVERHEAD - ", MemoryRead(TICK_COUNTER));

	//Cuidado com app_descriptor_size muito grande, pode estourar a memoria
	unsigned int app_descriptor[app_descriptor_size];

	DMNI_read_data( (unsigned int) app_descriptor, app_descriptor_size);
	ref_address = app_descriptor;

	//Creates a new app by reading from ref_address
	application = read_and_create_application(app_ID, ref_address);
	if(application->secure == 1){

		shape_location = get_static_SZ(app_id_counter-1); // passar por parametro

		if( shape_location == 0 ){
  			PEs_number = create_shapes(MAX_LOCAL_TASKS, application->tasks_number);
  			print_shapes_found(PEs_number);
  			shape_location = search_shape(PEs_number);
  		}

//#ifdef DEBUG_RUARO
		putsv("end shape - ", MemoryRead(TICK_COUNTER));
	  	putsv("Index: ", shape_index);
	    	puts("\nShape location: ");  puts(itoh(shape_location)); puts("\n");
//#endif
	    if( shape_location != -1 ){
			alloc_Secure_Zone(shape_index);
			print_migrating_list();	
	    } 
	    else{ 
	    	puts("\nERROR: don't found a shape to allocate the secure application in this cluster");
	    	while(1);
	    }
	}
	//Fills the cluster load
	for(int k=0; k < application->tasks_number; k++){
		cluster_load[clusterID] += application->tasks[k].computation_load;
		#ifdef GRAY_AREA
		for (int i = 0; i < application->tasks[k].dependences_number; i++){
			initialize_IO(application->tasks[k].dependences[i].flits);
	    	puts("Enviado INITIALIZE para IO: ");  puts(itoa(application->tasks[k].dependences[i].flits)); puts("\n");
		}
		#endif
	}

	pending_app_to_map++;

	mapping_completed = application_mapping(clusterID, application->app_ID);//

	if (mapping_completed){
		putsv("end mapping - ", MemoryRead(TICK_COUNTER));

		application->status = READY_TO_LOAD;

		request_application(application);

	} else {

		puts("Application waiting reclustering\n");

		application->status = WAITING_RECLUSTERING;

	}
}


int SeekInterruptHandler(){
	
	int LL_addr, RH_addr, master_address,selected_cluster,selected_cluster_proc;
	unsigned int app_id,task_id, i, PE_address, MAC_status;
	static unsigned int seek_unr_count = 0;
	unsigned int backtrack, backtrack1, backtrack2;
	int allocated_tasks, aux;
	Application *app;
	 // terminated_task_list[MAX_APP_SIZE];;
	unsigned int target, source, service, payload;
	//for backtrack
	MemoryWrite(SEEK_BACKTRACK_REG_SEL,0);//TODO extender para um backtrack maior que 32 bits
	backtrack = MemoryRead(SEEK_BACKTRACK);
	MemoryWrite(SEEK_BACKTRACK_REG_SEL,1);
	backtrack1 = MemoryRead(SEEK_BACKTRACK);
	MemoryWrite(SEEK_BACKTRACK_REG_SEL,2);
	backtrack2 = MemoryRead(SEEK_BACKTRACK);
	payload = MemoryRead(SEEK_PAYLOAD_REGISTER);
	target = MemoryRead(SEEK_TARGET_REGISTER);
	source = MemoryRead(SEEK_SOURCE_REGISTER);
	service = MemoryRead(SEEK_SERVICE_REGISTER);
	switch(service){
		case TARGET_UNREACHABLE_SERVICE:
			puts(itoa(MemoryRead(TICK_COUNTER))); puts(" Received SeekUnreachable "); puts(itoh(source)); puts("\n");
			
			//Seek(CLEAR_SERVICE, source, target, 0);
			//global variable for finding seek
			slot_seek = GetFreeSlotSourceRouting(source>>16);
			//puts("slot: "); puts(itoh(slot_seek)); puts("\n");
			if(slot_seek != -1){
			//use this slot for destination
				SR_Table[slot_seek].target = source>>16;
				SR_Table[slot_seek].tableSlotStatus = SR_USADO;
			//puts("source: "); puts(itoh(source)); puts("\n");
			//puts("target: "); puts(itoh(target)); puts("\n");
			//puts("Send Searchpath"); puts("\n");
			//perform backtrack
			Seek(SEARCHPATH_SERVICE, ((seek_unr_count<<16) | (get_net_address()&0xffff)), source>>16, 0);
			seek_unr_count++;
			//puts("seek_unr_count: "); puts(itoh(seek_unr_count)); puts("\n");
			}
			// else{
			// 	puts("SR ja existente: "); puts(itoh(source)); puts("\n");
			// }
		break;
		case BACKTRACK_SERVICE:
			//puts("Received backtrack: "); puts(itoh(backtrack)); puts("\n");
			// seek_puts("backtrack\n");
			slot_seek = ProcessTurns(backtrack, backtrack1, backtrack2);
			// seek_puts("slot: "); seek_puts(itoa(slot_seek)); seek_puts("\n");
			//while(seek_interruption){}
			Seek(CLEAR_SERVICE, ((SR_Table[slot_seek].target<<16) | (get_net_address()&0xffff)), 0,0);
			aux = resend_control_message(backtrack, backtrack1, backtrack2, SR_Table[slot_seek].target);
			if(aux == -1){
				puts("ERROR: no msg deliver\n");
			}
			else{
				ClearSlotSourceRouting(SR_Table[slot_seek].target);
				//puts("Clear Slot - Target: "); puts(itoh(SR_Table[slot_seek].target)); puts("\n");
			}
			//puts("end backtrack\n");
		break;
		case END_TASK_SERVICE:
			puts("End task SERVICE Task_ID: "); puts(itoh(payload)); puts("\n");
			//hemps8
			app_id = (payload >> 4) & 0x0F;
			app = get_application_ptr(app_id);
			puts("App: "); puts(itoh(app)); puts("\n");
		
			//recalculates task_id
			task_id = (app_id << 8) + (payload & 0x0F);
			set_task_terminated(app, task_id);
			puts("terminated: "); puts(itoh(task_id)); puts("\n");
			PE_address = get_master_address(source  & 0xffff);
			if (PE_address == net_address){
			 	page_released(clusterID, (source & 0xffff), task_id);
			}
			puts("Released from: "); puts(itoh(source & 0xffff)); puts("\n");
			//Test if is necessary to terminated the app
			if (app->terminated_tasks == app->tasks_number){
			
				puts("All Tasks Finished AppID: "); puts(itoh(app_id)); puts("\n");
				//puts("Secure: "); puts(itoh(app->secure)); puts("\n");
				if(app->secure == 1){
					Seek(OPEN_SECURE_ZONE_SERVICE, MemoryRead(TICK_COUNTER)<<16 | get_net_address(), app_id, app->RH_Address);
				}
				else{
			
					for (int i=0; i<app->tasks_number; i++){
						if (app->tasks[i].borrowed_master != -1){
							terminated_task_master[i] = app->tasks[i].borrowed_master;
						} else {
							terminated_task_master[i] = net_address;
						}
					}
					if (is_global_master) {
						handle_app_terminated(app->app_ID, app->tasks_number, net_address);
					} else {
						send_app_terminated(app, terminated_task_master); // Poderia ser via Seek
					}
					remove_application(app->app_ID);
				}	
			}				
		break;

		case END_TASK_OTHER_CLUSTER_SERVICE:
			// puts("End task Other cluster"); puts("\n");
			page_released(clusterID, (source&0XFFFF), ((payload << 4) & 0xF00) | (payload & 0x0F));
			// puts("Release OK: "); puts(itoh(((payload << 4) & 0xF00) | (payload & 0x0F))); puts("\n");
		break;
		case SECURE_ZONE_CLOSED_SERVICE:
			puts("Received Secure Zone Closed. RH_addr: "); puts(itoh(payload));puts("\n");
		
			app_id = get_AppID_with_RH_Address(payload);
			puts("\nApp_id to START: "); puts(itoh(app_id));  puts("\n");
			puts("\npayload: "); puts(itoh(payload));  puts("\n");
			if(app_id != -1)
				//Seek(START_APP_SERVICE, (app_id<<16 |get_net_address()), payload, app_id);
				Seek(START_APP_SERVICE, ((app_id << 24) | ((MemoryRead(TICK_COUNTER) << 16) & 0xFF0000) | get_net_address()), payload, app_id);
				
			else
				putsv("\nThis Master don't have a secure zone with RH Address ", payload);
			
			//TEMPO DE RELEASE
			puts("\n\n***** APP "); puts(itoa(app_id)); putsv(" RUNNING AT: ", MemoryRead(TICK_COUNTER));

		break;
		case SET_SZ_RECEIVED_SERVICE:
			aux = get_Secure_Zone_index(payload);
			app_id = get_AppID_with_RH_Address(payload);
			if(aux != -1){
				// puts(itoh(Secure_Zone[aux].cut));
				RH_addr = Secure_Zone[aux].cut >> 16;
				LL_addr = Secure_Zone[aux].cut & 0XFFFF;

				LL_addr = ((LL_addr >> 4) & 0xf0) | ((LL_addr) & 0xf);
				RH_addr = ((RH_addr >> 4) & 0xf0) | ((RH_addr) & 0xf);

				master_address = get_net_address();
				master_address = ((master_address >> 4) & 0xf0) | ((master_address) & 0xf);

				//puts("Cut RH_addr: "); puts(itoh(RH_addr)); puts("\n");
				//puts("Cut LL_addr: "); puts(itoh(LL_addr)); puts("\n");

				if(Secure_Zone[aux].cut != -1)
					//Seek(SET_EXCESS_SZ_SERVICE, (app_id <<16 | get_net_address()), LL_addr, RH_addr);
					Seek(SET_EXCESS_SZ_SERVICE, ((app_id << 24) | ((MemoryRead(TICK_COUNTER) << 16) & 0xFF0000) | get_net_address()), LL_addr, RH_addr);
				else
					//Seek(SET_EXCESS_SZ_SERVICE, (app_id <<16 | get_net_address()), master_address, master_address);
					//Seek(SET_EXCESS_SZ_SERVICE, ((app_id << 24) | ((MemoryRead(TICK_COUNTER) << 16) & 0xFF0000) | get_net_address()), master_address, master_address);
					Seek(SET_EXCESS_SZ_SERVICE, ((app_id << 24) | ((MemoryRead(TICK_COUNTER) << 16) & 0xFF0000) | get_net_address()), payload, payload);

			}
			else {
				puts("Secure Zone not found!!!\nRH_address: "); puts(itoh(payload)); puts("\n");
				while(1);
			}
		break;
		case SECURE_ZONE_OPENED_SERVICE:
			puts("Received Secure Zone Opened"); puts("\n");
			app = get_application_ptr(payload);
			for (int i=0; i<app->tasks_number; i++){
				if (app->tasks[i].borrowed_master != -1){
					terminated_task_master[i] = app->tasks[i].borrowed_master;
				} else {
					terminated_task_master[i] = net_address;
				}
			}
			if (is_global_master) {
				handle_app_terminated(app->app_ID, app->tasks_number, net_address);
			} else {
				send_app_terminated(app, terminated_task_master);
			}
			free_Secure_Zone(app->RH_Address);
			remove_application(app->app_ID);
		break;
		case TASK_ALLOCATED_SERVICE:
			app_id = (payload >> 4) & 0x0F;
			//puts("Task Allocated: "); puts(itoh(source)); puts("\n");
			app = get_application_ptr(app_id);
			//recalculates task_id
			task_id = (app_id << 8) + (payload & 0x0F);
			allocated_tasks = set_task_allocated(app, task_id);
			/*if(app->secure == 1){
				MAC_status = (source >> 24);
				if(MAC_status == 0){
					puts("ERROR on MAC received by Task "); puts(itoh(payload)); puts("\n");
				}
			}*/
			puts("Task Allocated: "); puts(itoh(payload)); puts("\n");
			puts("Total: "); puts(itoh(allocated_tasks)); puts("\n");
			putsv("time - ", MemoryRead(TICK_COUNTER)); 
			if (allocated_tasks == app->tasks_number){
					puts("All task allocated for app "); puts(itoa(app_id)); putsv(" at time ", MemoryRead(TICK_COUNTER)); 
					if(app->secure == 1){
						int RH_addr=0;
						int LL_addr=(XDIMENSION << 8) + YDIMENSION;
						int location;
						for(int i=0; i<app->tasks_number; i++){
							location = get_task_location(app->tasks[i].id);
							if((location >> 8) > (RH_addr >> 8)){//test highier X: RH_X
								RH_addr = (location & 0xf00) | (RH_addr & 0x0ff);
							}
							if((location >> 8) < (LL_addr >> 8)){//test lower X: LL_X 
								LL_addr = (location & 0xf00) | (LL_addr & 0x0ff);
							}
							if((location & 0xff) > (RH_addr & 0xff)){//test highier Y: RH_Y
								RH_addr = (RH_addr & 0xf00) | (location & 0x0ff);
							}
							if((location & 0xff) < (LL_addr & 0xff)){//test lower Y: LL_Y
								LL_addr = (LL_addr & 0xf00) | (location & 0x0ff	);
							}
						}
						LL_addr = ((LL_addr >> 4) & 0xf0) | ((LL_addr) & 0xf);
						RH_addr = ((RH_addr >> 4) & 0xf0) | ((RH_addr) & 0xf);
						//puts("RH_addr: "); puts(itoh(RH_addr)); puts("\n");
						//puts("LL_addr: "); puts(itoh(LL_addr)); puts("\n");
						set_RH_Address(app->app_ID, RH_addr);
						//get_Secure_Zone_index(RH_addr);
						puts("SET_SECURE_ZONE at time: "); puts(itoa(MemoryRead(TICK_COUNTER))); puts("\n");
						//Seek(SET_SECURE_ZONE_SERVICE, (get_Secure_Zone_index(RH_addr)<<16 | get_net_address()), LL_addr, RH_addr);
						//Seek(SET_SECURE_ZONE_SERVICE, (MemoryRead(TICK_COUNTER)<<16 | get_net_address()), LL_addr, RH_addr);
						Seek(SET_SECURE_ZONE_SERVICE, ((app_id << 24) | ((MemoryRead(TICK_COUNTER) << 16) & 0xFF0000) | get_net_address()), LL_addr, RH_addr);
					}		
			}
		break;
		case INITIALIZE_CLUSTER_SERVICE:
			global_master_address = (source & 0xffff);
			PE_address = get_net_address();				
			//find index in cluster_info from PE_address
			for( i = 1; i < CLUSTER_NUMBER; i++){
				if((cluster_info[i].master_x == ((PE_address >>8) & 0xff)) && (cluster_info[i].master_y == (PE_address & 0xff))){
					reclustering_setup(i);
					break;
				}
			}
			// if is last index send CLEAR of Initialize cluster service
			if(i == CLUSTER_NUMBER-1)
				puts("Slaves inicializados, enviando o clear\n"); //puts para sincronização
				Seek(CLEAR_SERVICE, source, 0, 0);
			initialize_slaves();
		break;
		// case LOAN_PROCESSOR_REQUEST_SERVICE:
		// 	handle_reclustering_request_from_seek((source&0xffff), target, payload);
		// break;
		// case LOAN_PROCESSOR_RELEASE_SERVICE:
		//     handle_reclustering_release_from_seek((source&0xffff), target, payload);
		// break;
		case RCV_FREEZE_TASK_SERVICE:
					puts("RCV_FREEZE_TASK "); puts(itoh(source)); puts("\n"); // used to reset the time_out
		
		break;
		
		//----------------------------------------------------------------------
		// the services bellow if received by master is of another cluster
		case OPEN_SECURE_ZONE_SERVICE:
		case START_APP_SERVICE:
		case SET_SECURE_ZONE_SERVICE:
		case NEW_APP_ACK_SERVICE:
		case INITIALIZE_SLAVE_SERVICE:
		case GMV_READY_SERVICE:
		break;
		case NEW_APP_SERVICE:
			if (is_global_master){//keep in mind manter uma estrutura de qual injector pediu alocação ..

				Seek(CLEAR_SERVICE, source, 0, 0);
				selected_cluster = SearchCluster(clusterID, payload); //acha um cluster para colocar as apps
				total_mpsoc_resources -= payload;
				allocate_cluster_resource(selected_cluster, payload);
				waiting_app_allocation = 1; //flag para evitar que outra aplicação seja alocada junto
				selected_cluster_proc = get_cluster_proc(selected_cluster); //Pega o endereço do mestre local
				Seek(NEW_APP_ACK_SERVICE, ((MemoryRead(TICK_COUNTER) << 16) & 0xFFFF0000) | app_id_counter, selected_cluster_proc, source); 
				puts("Sent NEW APP ACK\n");
				app_id_counter++;	
			}
		break;
		//-----------------------------------------------------------------------
		default:
			puts("Received unknown seek service\n");
			puts("Master receiving a slave service???\n");
		break;
	}

	return 0;

}


int main() {
	
	set_net_address(MemoryRead(NI_CONFIG));
	//By default HeMPS assumes that GM is positioned at address 0
	//if ( get_net_address() == 0){
	if ( get_net_address() == (cluster_info[0].master_x*256+ cluster_info[0].master_y )){

		puts("This kernel is global master\n");

		is_global_master = 1;

		global_master_address = net_address;

		initialize_clusters();

		initialize_slaves();

		initialize_cluster_load();

	} else {

		puts("This kernel is local master\n");

		is_global_master = 0;
	}


	initialize_applications();

	init_new_task_list();

	init_service_header_slots();

	initialize_CM_FIFO();


	//send ready by brnoc
	if (is_global_master){
		puts("Kernel GMV Initialized\n");
		Seek(GMV_READY_SERVICE, get_net_address(), 0, 0);
		Seek(CLEAR_SERVICE, get_net_address(), 0, 0);
	}
	else
		puts("Kernel CM Initialized\n");
	
	for (;;) {

		//LM looping
		if (noc_interruption){

			handle_packet();

		}
		else if(seek_interruption){

				SeekInterruptHandler();

		}

		else if (pending_app_to_map && is_reclustering_NOT_active()){

			handle_pending_application();
		} 

		manage_SZ_migration();
	}

	return 0;
}
