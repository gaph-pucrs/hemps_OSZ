/*!\file reclustering.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * This module implements function relative to reclustering
 * This module is used by the kernel manager
 * \detailed
 * Reclustering is a functionality that enable the system to borrow some resources (free pages) of a cluster to another cluster
 */


#include "reclustering.h"
#include "../include/services.h"
#include "utils.h"
#include "cluster_scheduler.h"
#include "processors.h"
#include "packet.h"
#include "seek.h"

#define RECLUSTERING_DEBUG	0		//!<When enable compile the puts in this file

Reclustering reclustering;			//!<Reclustering structure instance

//Max o levels of MPSoCs
int max_neighbors_level = 0;		//!<Max of neighbors clusters for each reclustering level

//Cluster dimmensions
unsigned int clusterID;					//!<Current cluster ID
unsigned int starting_x_cluster_size;	//!<Starting X size of cluster when reclustering is started
unsigned int starting_y_cluster_size;	//!<Starting Y size of cluster when reclustering is started

/**Setup a reclustering, called by kernel and configure the cluster ID and initializes some variables
 * \param c_id Current cluster ID
 */
void reclustering_setup(int c_id){

	clusterID = c_id;

	starting_x_cluster_size = cluster_info[clusterID].xf - cluster_info[clusterID].xi + 1;

	starting_y_cluster_size = cluster_info[clusterID].yf - cluster_info[clusterID].yi + 1;

#if RECLUSTERING_DEBUG
	putsv("CLuster id: ", clusterID);
#endif

	reclustering.active = 0;

	if ((XDIMENSION/XCLUSTER) > (YDIMENSION/YCLUSTER)) {
		max_neighbors_level = (XDIMENSION/XCLUSTER) - 1;
	} else {
		max_neighbors_level = (YDIMENSION/YCLUSTER) - 1;
	}
}

/**Test if the reclustering is not active
 * \return 1 if is not active, 0 if is active
 */
inline int is_reclustering_NOT_active(){
	return !reclustering.active;
}

/**Assembles and sends a LOAN_PROCESSOR_REQUEST packet to the neighbor master kernel
 * \param address Neighbor master address
 * \param taskID Task ID target of reclustering
 */
void send_loan_proc_request(int address, int taskID){

	ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = address;

	//p->service = LOAN_PROCESSOR_REQUEST;

	p->task_ID = taskID;

	p->allocated_processor = (cluster_info[clusterID].master_x << 8) | cluster_info[clusterID].master_y;

	send_packet(p, 0, 0);

	#if RECLUSTERING_DEBUG
			puts("-> send loan proc REQUEST para proc "); puts(itoh(address)); putsv(" task id ", taskID);
	#endif

}

/**Assembles and sends a LOAN_PROCESSOR_DELIVERY packet to the target of reclustering (requesting) master kernel
 * \param master_address Requesting reclustering master address
 * \param taskID Task ID target of reclustering
 * \param proc Allocated processor
 * \param hops Number of hops from the target processor
 */
void send_loan_proc_delivery(int master_address, int taskID, int proc, int hops){

	ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = master_address;

//	p->service = LOAN_PROCESSOR_DELIVERY;

	p->task_ID = taskID;

	p->hops = hops;

	p->allocated_processor = proc;

	send_packet(p, 0, 0);

	#if RECLUSTERING_DEBUG
		puts("-> send loan proc DELIVERY para proc "); puts(itoh(master_address)); putsv(" task id ", taskID);
	#endif
}

/**Assembles and sends a LOAN_PROCESSOR_RELEASE packet to the neighbor master kernel
 * \param master_address Neighbor master address
 * \param release_proc Address of the released processor
 * \param taskID Task ID target of reclustering
 */
void send_loan_proc_release(int master_address, int release_proc, int taskID){

		ServiceHeader *p = get_service_header_slot();

		p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = master_address;

	//	p->service = LOAN_PROCESSOR_RELEASE;

		p->task_ID = taskID;

		p->released_proc = release_proc;

		send_packet(p, 0, 0);

	#if RECLUSTERING_DEBUG
		puts("-> send loan proc RELEASE para proc "); puts(itoh(master_address)); puts(" releasing the proc "); puts(itoh(release_proc)); puts("\n");
	#endif

}

/**Fires a new round of the reclustering protocol. This function send the load request to the neighboors masters
 * delimited by the reclustering.neighbors_level variable
 */
void fires_reclustering_protocol(){


	unsigned int aux_appID_task_ID, allocated_processor, i;
	int diff_X, diff_Y;

	reclustering.pending_loan_delivery = 0;
	reclustering.current_borrowed_proc = -1;
	reclustering.current_borrowed_master = -1;
	reclustering.min_loan_proc_hops = 0xFFFFFF;	

	// calculate number of responses expected according request PE Address
    for(i = 0; i < CLUSTER_NUMBER; i++){
        diff_X = cluster_info[i].master_x - cluster_info[clusterID].master_x ;
        diff_Y = cluster_info[i].master_y - cluster_info[clusterID].master_y ;
        diff_X = (diff_X < 0) ? -diff_X : diff_X;
        diff_Y = (diff_Y < 0) ? -diff_Y : diff_Y;
		if((diff_X <= XCLUSTER +1) && (diff_Y <= YCLUSTER +1)){      
			reclustering.pending_loan_delivery++;
        }		
    }
    // discount itself
    reclustering.pending_loan_delivery--;
    // Mount and send Load_Processor_Request passing LMP Address and task_ID
	allocated_processor = (cluster_info[clusterID].master_x << 8) | cluster_info[clusterID].master_y;
       aux_appID_task_ID = ((reclustering.task->id >> 4) & 0x30) | (reclustering.task->id & 0x0F);
//	Seek(LOAN_PROCESSOR_REQUEST_SERVICE, get_net_address(), allocated_processor, aux_appID_task_ID);

}



/**handle reclustering request incoming from LMP.
 * The kernel master kwnows that the packet is a reclustering related packet and
 * calls this function passing the reclustering information needed.
 * \param source_PE: address of PE that send the loan_processor_request
 * \param allocated_processor: address of master cluster
 * \param task_ID: the ID of task that needs reclustering
 */
void handle_reclustering_request_from_seek(int source_PE, int allocated_processor, int task_ID){
		int aux_task_ID, mapped_proc, hops;
		int diff_X, diff_Y;

		#if RECLUSTERING_DEBUG
			puts("\nReceive LOAN_PROCESSOR_REQUEST "); puts(" from proc "); puts(itoh(source_PE)); puts("\n");
			puts("\nTask ID small: "); puts(itoh(task_ID)); puts("\n");
		#endif

        diff_X = (source_PE >> 8)   - cluster_info[clusterID].master_x ;
        diff_Y = (source_PE & 0xff) - cluster_info[clusterID].master_y ;

        diff_X = (diff_X < 0) ? -diff_X : diff_X;
        diff_Y = (diff_Y < 0) ? -diff_Y : diff_Y;

		if((diff_X <= XCLUSTER +1) && (diff_Y <= YCLUSTER +1)){
			aux_task_ID = ((task_ID & 0x30) << 4) | (task_ID & 0xf);
			if (cluster_info[clusterID].free_resources <= 0){

				send_loan_proc_delivery(source_PE, aux_task_ID, -1, -1);

			} else {

				//Procura pelo processador mais proximo do processador requisitnate
				mapped_proc = map_task(0, aux_task_ID, 0);

				hops = (allocated_processor >> 8) + (mapped_proc >> 8);
				hops += (allocated_processor & 0xFF) + (mapped_proc & 0xFF);

			#if RECLUSTERING_DEBUG
				puts("Alocou proc "); puts(itoh(mapped_proc)); puts("  Task_ID expanded: "); puts(itoh(aux_task_ID)); puts("\n");
			#endif

				send_loan_proc_delivery(source_PE, aux_task_ID, mapped_proc, hops);

				page_used(clusterID, mapped_proc, aux_task_ID);

			}
		}
}	

/**handle reclustering release incoming from LMP.
 * The kernel master kwnows that the packet is a reclustering related packet and
 * calls this function passing the reclustering information needed.
 * \param source_PE: address of PE that send the loan_processor_release
 * \param allocated_processor: address of PE that was choose to run the task previously requested
 * \param task_ID: the ID of task that needs reclustering
 */
void handle_reclustering_release_from_seek(int source_PE, int allocated_processor, int task_ID){
	int aux_task_ID, PE_address;
	int diff_X, diff_Y;


	#if RECLUSTERING_DEBUG
		puts("\nReceive LOAN_PROCESSOR_RELEASE "); puts(" from proc "); puts(itoh(source_PE)); puts(" task id "); puts(itoh(task_ID));
		puts("\nallocated processor: "); puts(itoh(allocated_processor)); puts("\n");
	#endif

	// calculates if this PE need manipulate the incomming Loan_Processor_Release
    diff_X = (source_PE >> 8)   - cluster_info[clusterID].master_x ;
    diff_Y = (source_PE & 0xff) - cluster_info[clusterID].master_y ;

    diff_X = (diff_X < 0) ? -diff_X : diff_X;
    diff_Y = (diff_Y < 0) ? -diff_Y : diff_Y;


	if((diff_X <= XCLUSTER +1) && (diff_Y <= YCLUSTER +1)){
		// if yes mount the task_ID 
		aux_task_ID = ((task_ID & 0x30) << 4) | (task_ID & 0xf); 
		// search the processor allocated 
 		PE_address = get_task_location(aux_task_ID);
 		// If PE_address == -1 any processor was previously allocated
 		if(PE_address != -1){
			if( PE_address != allocated_processor){
				// if PE allocated by this LMP is different of PE selected by requester
				// the PE allocated by this LMP is released
				page_released(clusterID, PE_address, aux_task_ID);
			}
		}
	}
}


/**handle reclustering packets incoming from kernel master.
 * The kernel master kwnows that the packet is a reclustering related packet and
 * calls this function passing the ServiceHeader pointer.
 * \param p ServiceHeader pointer
 */
void handle_reclustering(ServiceHeader * p){

	int mapped_proc, aux_appID_task_ID;
	Application *app;
	int hops;

	switch(p->service){

	// case LOAN_PROCESSOR_REQUEST:

	// 	#if RECLUSTERING_DEBUG
	// 		puts("\nReceive LOAN_PROCESSOR_REQUEST "); puts(" from proc "); puts(itoh(p->source_PE)); puts("\n");
	// 	#endif

	// 	if (cluster_info[clusterID].free_resources <= 0){

	// 		send_loan_proc_delivery(p->source_PE, p->task_ID, -1, -1);

	// 	} else {

	// 		//Procura pelo processador mais proximo do processador requisitnate
	// 		mapped_proc = map_task(0, p->task_ID, 0);

	// 		hops = (p->allocated_processor >> 8) + (mapped_proc >> 8);
	// 		hops += (p->allocated_processor & 0xFF) + (mapped_proc & 0xFF);

	// 	#if RECLUSTERING_DEBUG
	// 		puts("Alocou proc "); puts(itoh(mapped_proc)); puts("\n");
	// 	#endif

	// 		send_loan_proc_delivery(p->source_PE, p->task_ID, mapped_proc, hops);

	// 		page_used(clusterID, mapped_proc, p->task_ID);

	// 	}

	// 	break;

	// case LOAN_PROCESSOR_DELIVERY:

	// 	#if RECLUSTERING_DEBUG
	// 		puts("\nReceive LOAN_PROCESSOR_DELIVERY "); puts(" from proc "); puts(itoh(p->source_PE)); puts("\n");
	// 		putsv("Numeros de delivery pendentes: ", reclustering.pending_loan_delivery);
	// 	#endif

	// 	// counter decrement
	// 	reclustering.pending_loan_delivery--;

	//   // The reclustering receives all Loan_Processor_Delivery
	//   // then select the closer (by hop number) and send Loan_Processor_Release passing
	//   // the PE address of selected processor to execute the task_ID
	  		
	// 	// if hops received is small of actual change the selected processor
	// 	if (p->hops < reclustering.min_loan_proc_hops){
	// 		reclustering.min_loan_proc_hops = p->hops;

	// 		reclustering.current_borrowed_proc = p->allocated_processor;

	// 		reclustering.current_borrowed_master = p->source_PE;
	// 	}

	// 	//if all responses incomming then send the Loan_Processor_Release
	// 	if (reclustering.pending_loan_delivery == 0){

	// 		#if RECLUSTERING_DEBUG
	// 			puts("Fim da rodada\n");
	// 		#endif

	// 		// Clear seek form previous Loan_Processor_Request
	// 		Seek(CLEAR_SERVICE, get_net_address(), 0, 0);

	// 		//if one processor was selected from responses
	// 		if (reclustering.current_borrowed_proc != -1){

	// 			//At this point the reclustering has benn finished successifully
	// 			puts("Reclustering acabou com sucesso, tarefa alocada no proc "); puts(itoh(reclustering.current_borrowed_proc)); putsv(" com id ", reclustering.task->id);

	// 			reclustering.active = 0;

	// 			reclustering.task->allocated_proc = reclustering.current_borrowed_proc;

	// 			reclustering.task->borrowed_master = reclustering.current_borrowed_master;

	// 			//mount and send the Loan_Processor_Release message
	// 			aux_appID_task_ID = ((p->task_ID >> 4) & 0x30) | (p->task_ID & 0x0F);
	// 			Seek(LOAN_PROCESSOR_RELEASE_SERVICE, get_net_address(), reclustering.task->allocated_proc , aux_appID_task_ID);	

	// 			//Searches for a new task waiting reclustering
	// 			app = get_application_ptr((reclustering.task->id >> 8));

	// 			// Clear seek form previous Loan_Processor_Release
	// 			Seek(CLEAR_SERVICE, get_net_address(), 0 , 0);	
	// 			puts("  "); puts("\n");

	// 			reclustering_next_task(app);

	// 		} 
	// 		else {

	// 			puts("ERROR: reclustering falhou");

	// 		}
	// 	}

	// break;

	// case LOAN_PROCESSOR_RELEASE:

	// 	#if RECLUSTERING_DEBUG
	// 		puts("\nReceive LOAN_PROCESSOR_RELEASE "); puts(" from proc "); puts(itoh(p->source_PE)); putsv(" task id ", p->task_ID);
	// 	#endif

	// 	page_released(clusterID, p->released_proc, p->task_ID);

	// 	break;
	}
}

/**Searches for first application task not mapped yet, firing the reclustering
 * \param app Application pointer
 * \return 1 - if the application have all its task mapped, 0 - if the reclustering was initiated
 */
int reclustering_next_task(Application *app){

	Task *t = 0;

	/*Select the app task waiting for reclustering*/
	for (int i=0; i<app->tasks_number; i++){

		/*If task is not allocated to any processor*/
		if (app->tasks[i].allocated_proc == -1){

			t = &app->tasks[i];

			break;
		}
	}

	/*Means that the application has all its task already mapped*/
	if (t == 0){
		return 1;
	}


#if RECLUSTERING_DEBUG
		putsv("\nReclustering next task", t->id);
#endif

	/*fires reclustering protocol*/
	reclustering.active = 1;

	reclustering.task = t;

	reclustering.neighbors_level = 1;

	fires_reclustering_protocol();

	return 0;
}
