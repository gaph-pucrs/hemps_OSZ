<<<<<<< HEAD
/*!\file kernel_slave.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Edited by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * Kernel slave is the system slave used to execute user's tasks.
 *
 * \detailed
 * kernel_slave is the core of the OS running into the slave processors.
 * Its job is to runs the user's task. It communicates whit the kernel_master to receive new tasks
 * and also notifying its finish.
 * The kernel_slave file uses several modules that implement specific functions
 */

#include "kernel_slave.h"

#include "../../../include/kernel_pkg.h"
#include "../../include/api.h"
#include "../../include/plasma.h"
#include "../../include/services.h"
#include "../../modules/task_location.h"
#include "../../modules/task_control.h" 
#include "../../modules/packet.h"
#include "../../modules/communication.h"
#include "../../modules/pending_service.h"
#include "../../modules/local_scheduler.h"
#include "../../modules/utils.h"
#include "../../modules/control_messages_fifo.h" 
#include "../../modules/csiphash.h"
#include "../../modules/lfsr.h"

#include "../../modules/osz_slave.h"

#ifdef AES_MODULE
#include "../../modules/aes.h"
#endif 

#ifdef PRESENT_MODULE
#include "../../modules/present.h"
#endif 

#if MIGRATION_ENABLED
#include "../../modules/task_migration.h"
#endif

extern int LOCAL_right_high_corner;

//Globals
unsigned int 	net_address;				//!< Store the current XY address
unsigned int 	schedule_after_syscall;		//!< Signals the syscall function (assembly implemented) to call the scheduler after the syscall
unsigned int 	cluster_master_address;		//!< Store the cluster master XY address
unsigned int 	last_idle_time;				//!< Store the last idle time duration
unsigned int 	total_slack_time;			//!< Store the total of the processor idle time
TCB 			idle_tcb;					//!< TCB pointer used to run idle task
TCB *			current;					//!< TCB pointer used to store the current task executing into processor
Message 		msg_write_pipe;				//!< Message variable which is used to copy a message and send it by the NoC

lfsr_t glfsr_d0;
lfsr_t glfsr_c0;

Message waitingMessages[10];

#ifdef AES_MODULE
	extern unsigned int key_schedule[60];
	extern unsigned int key[1][32];
#endif 

#ifdef PRESENT_MODULE
	extern u8 inputKey[10];
	extern u8 keys[PRESENT_KEY_SIZE_128/8*(PRESENT_ROUNDS+1)];
#endif 


/** Assembles and sends a TASK_TERMINATED packet to the master kernel
 *  \param terminated_task Terminated task TCB pointer
 */
void send_task_terminated(TCB * terminated_task){

	ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = terminated_task->master_address;

	p->service = TASK_TERMINATED;

	p->task_ID = terminated_task->id;

	p->master_ID = cluster_master_address;

	send_packet(p, 0, 0);

	if (terminated_task->master_address != cluster_master_address){

		p = get_service_header_slot();

		p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = cluster_master_address;

		p->service = TASK_TERMINATED_OTHER_CLUSTER;

		p->task_ID = terminated_task->id;

		p->master_ID = terminated_task->master_address;

		send_packet(p, 0, 0);
	}

	

}

/** Assembles and sends a TASK_ALLOCATED packet to the master kernel
 *  \param allocated_task Allocated task TCB pointer
 */
void send_task_allocated(TCB * allocated_task){
	unsigned int aux_appID_task_ID;

	aux_appID_task_ID = ((allocated_task->id >> 4) & 0xF0) | (allocated_task->id & 0x0F);
	if(allocated_task->secure == 1){
		puts("Task Allocated SEGURA: "); puts(itoh(aux_appID_task_ID)); puts("\n");
		Seek(TASK_ALLOCATED_SERVICE, ((allocated_task->MAC_status << 24) |   (aux_appID_task_ID<<16) | (get_net_address()& 0xFFFF)), allocated_task->master_address, aux_appID_task_ID);
	}else
		Seek(TASK_ALLOCATED_SERVICE, ((aux_appID_task_ID<<16) | (get_net_address()& 0xFFFF)), allocated_task->master_address, aux_appID_task_ID);
		
	//puts("Task Allocated: "); puts(itoh(aux_appID_task_ID)); puts("\n");

}

/** Assembles and sends a REAL_TIME_CHANGE packet to the master kernel
 *  \param tcb_ptr TCB pointer of the task that change its real-time parameters
 */
void send_task_real_time_change(TCB * tcb_ptr){

	ServiceHeader * p = get_service_header_slot();

	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = cluster_master_address;

	p->service = REAL_TIME_CHANGE;

	p->task_ID = tcb_ptr->id;

	p->utilization = tcb_ptr->scheduling_ptr->utilization;

	putsv("Send real time change, utilization: ", p->utilization);

	send_packet(p, 0, 0);
}

/** Assembles and sends a DULL packet to target
 *  \param target TCB pointer of the task that change its real-time parameters
 */
void send_dull_packet(){

	ServiceHeader * p = get_service_header_slot();

	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = 256*2 + 2;

	p->service = MESSAGE_DELIVERY;

	p->task_ID = 0;

	p->period = -1;

	p->source_PE = 0;

	p->timestamp = -1;

	puts("Sent dull packet");

	send_packet(p, 0, 0);
}

/** Assembles and sends a SLACK_TIME_REPORT packet to the master kernel
 */
void send_slack_time_report(){

	ServiceHeader * p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = cluster_master_address;

	p->service = SLACK_TIME_REPORT;

	p->cpu_slack_time = ( (total_slack_time*100) / SLACK_TIME_WINDOW);

	send_packet(p, 0, 0);
}

///** Assembles and sends a UPDATE_TASK_LOCATION packet to a slave processor. Useful because task migration
// * \param target_proc Target slave processor which the packet will be sent
// * \param task_id Task ID that have its location updated
// * \param new_task_location New location (slave processor address) of the task
// */
//void send_update_task_location(unsigned int target_proc, unsigned int task_id, unsigned int new_task_location){
//
//	ServiceHeader *p = get_service_header_slot();
//
//	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = target_proc;
//
//	p->service = UPDATE_TASK_LOCATION;
//
//	p->task_ID = task_id;
//
//	p->allocated_processor = new_task_location;
//
//	send_packet(p, 0, 0);
//
//	//putsvsv("Update task location ", task_id, " in processor ", target_proc);
//
//}





/** Useful function to writes a message into the task page space
 * \param task_tcb_ptr TCB pointer of the task
 * \param msg_lenght Lenght of the message to be copied
 * \param msg_data Message data
 */
void write_local_msg_to_task(TCB * task_tcb_ptr, int msg_lenght, int * msg_data){

	Message * msg_ptr;

	msg_ptr = (Message*)((task_tcb_ptr->offset) | ((unsigned int)task_tcb_ptr->reg[3])); //reg[3] = address message

	msg_ptr->length = msg_lenght;

	for (int i=0; i<msg_ptr->length; i++)
		msg_ptr->msg[i] = msg_data[i];

	//Unlock the blocked task
	task_tcb_ptr->reg[0] = TRUE;

	//Set to ready to execute into scheduler
	task_tcb_ptr->scheduling_ptr->status = READY;
}

/** Syscall handler. It is called when a task calls a function defined into the api.h file
 * \param service Service of the syscall
 * \param arg0 Generic argument
 * \param arg1 Generic argument
 * \param arg2 Generic argument
 */
int Syscall(unsigned int service, unsigned int arg0, unsigned int arg1, unsigned int arg2) {

	Message *msg_read;
	Message *msg_write;
	PipeSlot *pipe_ptr;
	unsigned int aux_appID_task_ID;
	int consumer_task;
	int producer_task;
	int producer_PE;
	int consumer_PE;
	int appID, slotSR;
	int i,j, port_io;

	unsigned int auxSlot, PER_X_addr, PER_Y_addr;
	long int auxBT;

	schedule_after_syscall = 0;

	switch (service) {

		case DULL:

			send_dull_packet();

			return 1;

		case EXIT:

			schedule_after_syscall = 1;

			if (MemoryRead(DMNI_SEND_ACTIVE)){
				return 0;
			}
			#ifdef SESSION_MANAGER
			for (j = 0; j < MAX_SESSIONS; j++) // Termina as sessões abertas que tenham essa tarefa como consumidora
  			{
				if ((Sessions[j].consumer == current->id) && (Sessions[j].status != BLANK)){
					// puts("Terminando a Sessao:\n");
					Seek(MSG_REQUEST_CONTROL, 
					((0xFFC0 << 16) | (Sessions[j].pairIndex << 16) | ((Sessions[j].producer << 8) & 0xFF00) | (Sessions[j].consumer & 0xFF))
					,get_task_location(Sessions[j].producer)
					,((Sessions[j].consumer >> 8) & 0xFF));
					// printSessionStatus(Sessions, j);
					clearSession(Sessions, j);
				}
			}

			j = checkRunningSession(Sessions, current->id);
			if (j >= 0){
				// puts("Session ");
				// printSessionStatus(Sessions, j);
				// puts(" still running\n");
				return 0;
			}
			#endif
			puts("Task id: "); puts(itoa(current->id)); putsv(" terminated at ", MemoryRead(TICK_COUNTER));

			// adjust appID e taskID to 6 bits
			aux_appID_task_ID = ((current->id >> 4) & 0xF0) | (current->id & 0x0F);
			Seek(END_TASK_SERVICE, ((current->master_address<<16) | (get_net_address()&0xffff)), current->master_address, aux_appID_task_ID);
			if(current->master_address != cluster_master_address){
			 	Seek(END_TASK_OTHER_CLUSTER_SERVICE, ((cluster_master_address<<16) | (get_net_address()&0xffff)), cluster_master_address, aux_appID_task_ID);
			}

			clear_scheduling(current->scheduling_ptr);

			appID = current->id >> 8;

			//clear_app_tasks_locations(current->id);

			if (!is_another_task_running(appID)){

				//clear_app_tasks_locations(appID);
			}

			remove_last_msg_waiting_ack(current->id);

			//printSessionStatus(Sessions,current->id);

		return 1;

		case WRITEPIPE:
			tInit = MemoryRead(TICK_COUNTER);
			
			#ifdef SESSION_MANAGER
			timeoutMonitor(Sessions, tInit);
			#endif

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

 			//puts("current master: "); puts(itoh(current->master_address)); puts(" cluster master: ");  puts(itoh(cluster_master_address)); puts("\n");

			producer_task =  current->id;
			consumer_task = (int) arg1;

			appID = producer_task >> 8;
			consumer_task = (appID << 8) | consumer_task;

			//puts("WRITEPIPE - prod: "); puts(itoa(producer_task)); putsv(" consumer ", consumer_task);

			consumer_PE = get_task_location(consumer_task);

			//Test if the consumer task is not allocated
			if (consumer_PE == -1){
				//Task is blocked until its a TASK_RELEASE packet
				current->scheduling_ptr->status = BLOCKED;
				return 0;
			}

			/*Points the message in the task page. Address composition: offset + msg address*/
			msg_read = (Message *)((current->offset) | arg0);

			consumer_PE = remove_message_request(producer_task, consumer_task);

			if (consumer_PE == net_address){//message is local

				TCB * requesterTCB = searchTCB(consumer_task);

				write_local_msg_to_task(requesterTCB, msg_read->length, msg_read->msg);

				#if MIGRATION_ENABLED
					if (requesterTCB->proc_to_migrate != -1){
						puts("Migrou no write pipe\n");
						migrate_dynamic_memory(requesterTCB);

						schedule_after_syscall = 1;
					}
				#endif

			}else{//message is NOT local

				//########################### ADD PIPE #################################
				pipe_ptr = add_PIPE(producer_task, consumer_task, msg_read);
				//########################### ADD PIPE #################################
				
				if (pipe_ptr == 0){//there is no space in the pipe
					schedule_after_syscall = 1;
					return 0;
				}

				if (consumer_PE != -1){//message has been requested
					#ifdef SESSION_MANAGER
					// tInit = MemoryRead(TICK_COUNTER);
					session_puts("SYSCALL: Eviando delivery WRITEPIPE\n ");
					send_message_delivery_control(Sessions, producer_task, consumer_task, consumer_PE);
					// tEnd= MemoryRead(TICK_COUNTER);
					// session_time_puts("REQ SEND= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
					#endif
					pipe_ptr->status = WAITING_ACK;
					send_message_delivery(producer_task, consumer_task, consumer_PE, msg_read);
				} 
			}

		tEnd= MemoryRead(TICK_COUNTER);
		session_time_puts("WRITEPIPE= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
		return 1;

		case READPIPE:
			tInit = MemoryRead(TICK_COUNTER);
			#ifdef SESSION_MANAGER
			timeoutMonitor(Sessions, tInit);
			#endif

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

			consumer_task =  current->id;
			producer_task = (int) arg1;

			appID = consumer_task >> 8;
			producer_task = (appID << 8) | producer_task;

			//puts("READPIPE - prod: "); puts(itoa(producer_task)); putsv(" consumer ", consumer_task);

			producer_PE = get_task_location(producer_task);

			//Test if the producer task is not allocated
			if (producer_PE == -1){
				//Task is blocked until its a TASK_RELEASE packet
				current->scheduling_ptr->status = BLOCKED;
				return 0;
			}

			if (producer_PE == net_address){ //Local producer

				//Searches if the message is in PIPE (local producer)
				pipe_ptr = remove_PIPE(producer_task, consumer_task);

				if (pipe_ptr == 0){

					//Stores the request into the message request table (local producer)
					insert_message_request(producer_task, consumer_task, net_address);

				} else {

					//Message was found in pipe, writes to the consumer page address (local producer)

					msg_write = (Message*) arg0;

					msg_write = (Message*)((current->offset) | ((unsigned int)msg_write));

					msg_write->length = pipe_ptr->message.length;

					for (int i = 0; i<msg_write->length; i++) {
						msg_write->msg[i] = pipe_ptr->message.msg[i];
					}

					return 1;
				}

			} else { //Remote producer : Sends the message request (remote producer)
				#ifdef SESSION_MANAGER
				send_message_request_control(Sessions, producer_task, consumer_task, producer_PE);
				#endif
				// session_puts("Req Via  READPIPE");
				// session_puts("producer:");session_puts(itoh(producer_task)); session_puts("\n");
    			// session_puts("consumer:");session_puts(itoh(consumer_task)); session_puts("\n");
				send_message_request(producer_task, consumer_task, producer_PE, net_address);
			}

			//Sets task as waiting blocking its execution, it will execute again when the message is produced by a WRITEPIPE or incoming message Delivery
			current->scheduling_ptr->status = WAITING;

			schedule_after_syscall = 1;
			tEnd= MemoryRead(TICK_COUNTER);
			session_time_puts("READPIPE= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
			return 0;

		case GETTICK:

			return MemoryRead(TICK_COUNTER);

		break;

		case ECHO:

			puts(itoa(MemoryRead(TICK_COUNTER))); puts("_");
			puts(itoa(net_address>>8));puts("x");puts(itoa(net_address&0xFF)); puts("_");
			puts(itoa(current->id >> 8)); puts("_");
			puts(itoa(current->id & 0xFF)); puts("_");
			puts((char *)((current->offset) | (unsigned int) arg0));
			puts("\n");

		break;

		case REALTIME:

			if (MemoryRead(DMNI_SEND_ACTIVE)){
				return 0;
			}

			//putsv("\nReal-time to task: ", current->id);

			real_time_task(current->scheduling_ptr, arg0, arg1, arg2);

			//send_task_real_time_change(current);

			schedule_after_syscall = 1;

			return 1;

		break;

		case IOWRITEPIPE:

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

			producer_task =  current->id;

			// puts("IO - WRITEPIPE - prod: "); puts(itoa(producer_task)); putsv(" consumer ", arg1);

			/*Points the message in the task page. Address composition: offset + msg address*/
			msg_read = (Message *)((current->offset) | arg0);

			//########################### ADD PIPE #################################
			//pipe_ptr = add_PIPE(producer_task, arg1, msg_read);
			//########################### ADD PIPE #################################
			//if (pipe_ptr == 0){//there is no space in the pipe
			//	puts("pipe cheio...");
			//	schedule_after_syscall = 1;
			//	return 0;
			//}
			#ifdef GRAY_AREA
			for(i = 0; i < IO_NUMBER; i++){
				if(io_info[i].peripheral_id == arg1){
					PER_X_addr = io_info[i].default_address_x ;
          			PER_Y_addr = io_info[i].default_address_y;
					auxSlot = SearchSourceRoutingDestination((PER_X_addr << 8) | PER_Y_addr);
					if (auxSlot == -1){
						puts("Configurando novo IO:");puts(itoa(arg1)); puts("\n");
						auxBT = pathToIO(arg1);
						puts("--path: ");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting((PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = (PER_X_addr << 8) | PER_Y_addr;
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = adjust_backtrack_IO(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF,
							(PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						auxBT = pathFromIO(auxBT);
						puts("-- enviando caminho:");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting(get_net_address());
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = get_net_address();
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = ProcessTurns(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF);
						send_peripheral_SR_path(slotSR, arg1, current->secure);
						puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						ClearSlotSourceRouting(get_net_address());
					}
				break;
				}
			}
			#endif
			send_message_io(producer_task, arg1, msg_read, current->secure);

			current->scheduling_ptr->status = WAITING;

			schedule_after_syscall = 1;
			// puts("IO WRITEPIPE END: ");


		return 1;

		case IOREADPIPE:
			

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

			consumer_task =  current->id;
			//producer_task = (int) arg1;
			#ifdef GRAY_AREA
			for(i = 0; i < IO_NUMBER; i++){
				if(io_info[i].peripheral_id == arg1){
					PER_X_addr = io_info[i].default_address_x ;
          			PER_Y_addr = io_info[i].default_address_y;
					auxSlot = SearchSourceRoutingDestination((PER_X_addr << 8) | PER_Y_addr);
					if (auxSlot == -1){
						puts("Configurando novo IO:");puts(itoa(arg1)); puts("\n");
						auxBT = pathToIO(arg1);
						puts("--path: ");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting((PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = (PER_X_addr << 8) | PER_Y_addr;
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = adjust_backtrack_IO(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF,
							(PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						auxBT = pathFromIO(auxBT);
						puts("-- enviando caminho:");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting(get_net_address());
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = get_net_address();
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = ProcessTurns(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF);
						send_peripheral_SR_path(slotSR, arg1, current->secure);
						// puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						ClearSlotSourceRouting(get_net_address());
					}
				break;
				}
			}
			#endif
			send_io_request(arg1, consumer_task, net_address, current->secure);


			//Sets task as waiting blocking its execution, it will execute again when the message is produced by a WRITEPIPE or incoming MSG_DELIVERY
			current->scheduling_ptr->status = WAITING;

			schedule_after_syscall = 1;

			return 0;

			break;

			/*
			pipe_ptr = remove_PIPE(producer_task, consumer_task);

			if (pipe_ptr == 0){

				if (producer_PE == net_address){

					insert_message_request(producer_task, consumer_task, net_address);

				} else {

					send_message_request(producer_task, consumer_task, producer_PE, net_address);
				}

				current->scheduling_ptr->status = WAITING;

				schedule_after_syscall = 1;

				return 0;
			}

			msg_write = (Message*) arg0;

			msg_write = (Message*)((current->offset) | ((unsigned int)msg_write));

			msg_write->length = pipe_ptr->message.length;

			for (int i = 0; i<msg_write->length; i++) {
				msg_write->msg[i] = pipe_ptr->message.msg[i];
			}

			return 1;
		*/		

	}

	return 0;
}


int Aplly_LSFR(lfsr_data_t polynom_d, lfsr_data_t init_value_d,  lfsr_data_t polynom_c, lfsr_data_t init_value_c)
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
int handle_packet(volatile ServiceHeader * p) {
    char key[16] = {0,1,2,3,4,5,6,7,8,9,0xa,0xb,0xc,0xd,0xe,0xf};
    //char value[8] = {0x65,0x77,0x5f,0xa9,0x50,0x2f,0x08,0x33};
    char rnd[24], Ke[24];
    uint64_t calculated_hash, received_hash, *ptr_rcv, Km;
    int  lo, hi;

	int need_scheduling, code_lenght, app_ID, task_loc, new_ptr;
	unsigned int app_tasks_location[MAX_TASKS_APP];
	PipeSlot * slot_ptr;
	Message * msg_ptr;
	int arrivalTime=0;
	TCB * tcb_ptr = 0;

	need_scheduling = 0;


		//puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2])); puts("\n");
		//puts("size:");puts(itoh(p->payload_size)); puts("\n");
		// puts("DATA - service:");puts(itoh(p->service)); puts("\n");
		//puts("producer:");puts(itoh(p->producer_task)); puts("\n");
		//puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
		//puts("source:");puts(itoh(p->source_PE)); puts("\n");
	

	switch (p->service) {

	case MESSAGE_REQUEST: //MR_HANDLER
		tInit = MemoryRead(TICK_COUNTER);
		
		#ifdef SESSION_MANAGER
		// puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2])); puts("\n");
		// puts("size:");puts(itoh(p->payload_size)); puts("\n");
		// puts("service:");puts(itoh(p->service)); puts("\n");
		// puts("producer:");puts(itoh(p->producer_task)); puts("\n");
		// puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
		// puts("source:");puts(itoh(p->source_PE)); puts("\n");
	
		// printSessions(Sessions);
		session_puts("DATA: Chegou REQUEST de "); session_puts(itoh(p->producer_task)); session_puts("\n");
		auxIndex = checkSession(Sessions, p->producer_task, p->consumer_task);
		if (auxIndex < 0){
			// session_puts("DATA: REQUEST - Nao achou a Sessao, salvando Service \n");
			auxSlot = getServiceSlot();
			if (auxSlot < 0)
				session_puts("DATA: Nao tem lugar na ServiceQueue");
			copyService(p, auxSlot);
		}else{
			auxSession = &Sessions[auxIndex];
			if (auxSession->status == WAITING_ANY )
			{
				session_puts("DATA: -->> REQUEST esperando autorizar\n");			
				// auxSession->time = arrivalTime;
				auxSession->status = WAITING_CONTROL;
				auxSlot = getServiceSlot();
				copyService(p, auxSlot);
				auxSession->header =auxSlot;
				// puts("**MR NoC ANY:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");

			}
			else if (auxSession->status == WAITING_DATA || auxSession->status == SUSPICIOUS)
			{
				// puts("**MR NoC DATA:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");
				// puts("**MR Check:");puts(itoa(p->arrival_time - auxSession->time));puts("\n");
			
				// if (tInit - auxSession->time  > LAT_THRESHOLD){
				//		puts("WARNING REQ: XXXXX suspicious packet latency XXXXX \n");
				// }
				auxSession->time = 0;

				session_puts("DATA: -->> REQUEST - Achou Sessão\n");

				slot_ptr = remove_PIPE(p->producer_task, p->consumer_task);

				//Test if there is no message in PIPE
				if (slot_ptr == 0){

					//Gets the location of the producer task
					task_loc = get_task_location(p->producer_task);

					//This if check if the task was migrated
					if ( task_loc != -1 && task_loc != net_address && p->requesting_processor == p->source_PE){

						//MESSAGE_REQUEST by pass
						session_puts("DATA: DANGER - PASS\n");
						send_message_request(p->producer_task, p->consumer_task, task_loc, p->requesting_processor);

						if ( search_PIPE_producer(p->producer_task) == 0){

							send_update_task_location(p->requesting_processor, p->producer_task, task_loc);
						}

					} else {

						insert_message_request(p->producer_task, p->consumer_task, p->requesting_processor);
					}

				} else if (p->requesting_processor != net_address){
					// session_puts("DATA: Enviando DELIVERY por MR\n");
					send_message_delivery_control(Sessions, p->producer_task, p->consumer_task, p->requesting_processor);
					send_message_delivery(p->producer_task, p->consumer_task, p->requesting_processor, &slot_ptr->message);
					
				//This else is executed when this slave receved a own MESSAGE_REQUEST due a by pass
				} else {
					tcb_ptr = searchTCB(p->consumer_task);
					write_local_msg_to_task(tcb_ptr, slot_ptr->message.length, slot_ptr->message.msg);
				}
				auxSession->status = WAITING_ANY;
				auxSession->header = -1;
			}
		}
		//MemoryWrite(KERNEL_DEBUG_STATE, 0);
		#else
		//Remove msg from PIPE, if there is no message, them slot_ptr will be 0
		//puts("\n\nMESSAGE_REQUEST Received \nproc:");puts(itoh(p->source_PE));puts("\n");
		//puts("consumer_task:");puts(itoh( p->consumer_task));puts("\n");
		//puts("p->producer_task:");puts(itoh(p->producer_task));puts("\n");

		slot_ptr = remove_PIPE(p->producer_task, p->consumer_task);

		//Test if there is no message in PIPE
		if (slot_ptr == 0){

			//Gets the location of the producer task
			task_loc = get_task_location(p->producer_task);

			//This if check if the task was migrated
			if ( task_loc != -1 && task_loc != net_address && p->requesting_processor == p->source_PE){

				//MESSAGE_REQUEST by pass
				session_puts("DATA: DANGER - PASS\n");
				send_message_request(p->producer_task, p->consumer_task, task_loc, p->requesting_processor);

				if ( search_PIPE_producer(p->producer_task) == 0){

					send_update_task_location(p->requesting_processor, p->producer_task, task_loc);
				}

			} else {

				insert_message_request(p->producer_task, p->consumer_task, p->requesting_processor);

			}

		} else if (p->requesting_processor != net_address){
			send_message_delivery(p->producer_task, p->consumer_task, p->requesting_processor, &slot_ptr->message);
			//puts("MANDOU O CONTROL Req\n");
			// puts("target:");puts(itoh(p->requesting_processor)); puts("\n");
			// puts("ID+Source:");puts(itoh((MemoryRead(TICK_COUNTER)<<16) | (get_net_address()& 0xFFFF))); puts("\n"); 
		//This else is executed when this slave receved a own MESSAGE_REQUEST due a by pass

		} else {

			tcb_ptr = searchTCB(p->consumer_task);

			write_local_msg_to_task(tcb_ptr, slot_ptr->message.length, slot_ptr->message.msg);

		}
		//MemoryWrite(KERNEL_DEBUG_STATE, 0);
		#endif
	tEnd = MemoryRead(TICK_COUNTER);
	session_time_puts("DATA REQ= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
	break;

	case IO_OPEN_WRAPPER:
		//adjust_wrapper(p->io_service, p->io_port);

		puts("-------->> Chegou OPEN WRAPPER\n");
		//puts("io_port: ");puts(itoh(p->io_port)); puts("\n");
		//puts("io_service: ");puts(itoh(p->io_service)); puts("\n");
	break;


	case  IO_ACK:
		puts("-------->> Chegou IO ACK\n");
		// puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2])); puts("\n");
		// puts("size:");puts(itoh(p->payload_size)); puts("\n");
		// puts("service:");puts(itoh(p->service)); puts("\n");
		// puts("producer:");puts(itoh(p->producer_task)); puts("\n");
		// puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
		// puts("source:");puts(itoh(p->source_PE)); puts("\n");
		// puts("length:");puts(itoh(p->msg_lenght)); puts("\n");

		tcb_ptr = searchTCB(p->producer_task);
		//puts("tcb_ptr:");puts(itoh(tcb_ptr)); puts("\n");

		// puts("Status scheduler antes:");puts(itoh(tcb_ptr->scheduling_ptr->status)); puts("\n");
		if(tcb_ptr->scheduling_ptr->status != BLOCKED)
			tcb_ptr->scheduling_ptr->status = READY;
		// puts("Status scheduler depois:");puts(itoh(tcb_ptr->scheduling_ptr->status)); puts("\n");

		#if MIGRATION_ENABLED
			if (tcb_ptr->proc_to_migrate != -1){
				migrate_dynamic_memory(tcb_ptr);
				need_scheduling = 1;

			} else
		#endif

		if (current == &idle_tcb){
			need_scheduling = 1;
		}			
		
	break;


	case  IO_DELIVERY:
		puts("-------->> Chegou IO DELIVERY\n");
	case  MESSAGE_DELIVERY: //MD_HANDLER
		tInit = MemoryRead(TICK_COUNTER);
	#ifdef SESSION_MANAGER 
		// arrivalTime = auxTime;
		// puts("\n");// puts("DATA: Chegou DELIVERY de "); puts(itoh(p->producer_task)); puts("\n");
		auxIndex = checkSession(Sessions, p->producer_task, p->consumer_task);
		if (auxIndex < 0)
			session_puts("DATA: Nao achou a Sessao\n");

		// puts("consumer_task:");puts(itoh( p->consumer_task));puts("\n");
		// puts("producer_task:");puts(itoh(p->producer_task));puts("\n");

		auxSession = &Sessions[auxIndex];
		// session_puts("DATA: status ="); session_puts(itoa(auxSession->status));
		if (auxSession->status == WAITING_ANY){
				
			session_puts("DATA: -->> Mensagem esperando validação\n");
					
			// auxSession->time = arrivalTime;
			auxSession->status = WAITING_CONTROL;
			auxSession->msg = getMessageSlot();

			//Escreve na fila de Mensagens
			auxSession->msg->length = p->msg_lenght;
			msg_ptr = auxSession->msg;

			// puts("**MD NoC ANY:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");
			auxSession->time = 0;
			
		}else if (auxSession->status == WAITING_DATA || auxSession->status == SUSPICIOUS){

			// if (tInit - auxSession->time  > LAT_THRESHOLD){
			// 	puts("WARNING DEL: XXXXX suspicious packet latency XXXXX \n");
			// }
			// puts("---lat DATA:");puts(itoa( tInit - p->timestamp));puts("\n");
			// puts("---lat HW:");puts(itoa( p->arrival_time));puts("\n");
			// puts("**MD NoC DATA:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");
			// puts("**MD Check:");puts(itoa(p->arrival_time - auxSession->time));puts("\n");
			
			auxSession->time = 0;
			//calcula o avg baseado no p->arrival_time
			//Escreve direto na TAREFA
			session_puts("DATA: -->> Mensagem validada\n");
			tcb_ptr = searchTCB(p->consumer_task);
			msg_ptr = (Message *)(tcb_ptr->offset | tcb_ptr->reg[3]);
			msg_ptr->length = p->msg_lenght;

		}else{
			session_puts("DATA: status n identificado \n");
		}
		
		if(DMNI_read_data((unsigned int)msg_ptr->msg, msg_ptr->length) == -1){
			// received a packet with incomplete payload; discard it
			need_scheduling = 0;
			MemoryWrite(DMNI_TIMEOUT_SIGNAL,0);
			puts("payload incompleto...\n");
		}
		else if (auxSession->status == WAITING_DATA || auxSession->status == SUSPICIOUS){		
			// session_puts("DATA: -------->> Mensagem Autorizada\n");			
			//clearSession(Sessions, auxIndex);
			//puts("payload Completo...\n");
			tcb_ptr->reg[0] = 1;

			auxSession->status = WAITING_ANY;
			// auxSession->requested += 1;

			if(tcb_ptr->scheduling_ptr->status != BLOCKED)
				tcb_ptr->scheduling_ptr->status = READY;

			if(p->service != IO_DELIVERY){
					remove_msg_request(p->source_PE, p->consumer_task, p->producer_task);
			}

			#if MIGRATION_ENABLED
				if (tcb_ptr->proc_to_migrate != -1){
					migrate_dynamic_memory(tcb_ptr);
					need_scheduling = 1;

				} else
			#endif

			if (current == &idle_tcb){
				need_scheduling = 1;
			}			
		}
		
	#else
		tcb_ptr = searchTCB(p->consumer_task);
		//puts("tcb_ptr:");puts(itoh(tcb_ptr)); puts("\n");

		msg_ptr = (Message *)(tcb_ptr->offset | tcb_ptr->reg[3]);

		msg_ptr->length = p->msg_lenght;


		//puts("\n\nMESSAGE_DELIVERY Received \nproc:");puts(itoh(p->source_PE));puts("\n");
		//puts("consumer_task:");puts(itoh( p->consumer_task));puts("\n");
		//puts("p->producer_task:");puts(itoh(p->producer_task));puts("\n");

		
		if(DMNI_read_data((unsigned int)msg_ptr->msg, msg_ptr->length) == -1){
			//received a packet with incomplete payload; discard it
			need_scheduling = 0;
			MemoryWrite(DMNI_TIMEOUT_SIGNAL,0);
			//puts("payload incompleto...\n");
		}
		else{
			//puts("payload Completo...\n");
			tcb_ptr->reg[0] = 1;

			if(tcb_ptr->scheduling_ptr->status != BLOCKED)
				tcb_ptr->scheduling_ptr->status = READY;

			if(p->service != IO_DELIVERY){
					remove_msg_request(p->source_PE, p->consumer_task, p->producer_task);
			}

			// session_puts("arrival= ");session_puts(itoa(arrivalTime));//session_puts("\n");
			// session_puts(" depature= ");session_puts(itoa(p->timestamp));session_puts("\n");	

			#if MIGRATION_ENABLED
				if (tcb_ptr->proc_to_migrate != -1){
					migrate_dynamic_memory(tcb_ptr);
					need_scheduling = 1;

				} else
			#endif

			if (current == &idle_tcb){
				need_scheduling = 1;
			}			
		}

	#endif

	tEnd = MemoryRead(TICK_COUNTER);
	session_time_puts("DATA DEL= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
	break;

	case TASK_ALLOCATION:
		new_ptr = 0;

		tcb_ptr = searchTCB(p->task_ID);

		if(tcb_ptr == 0){  //task allocation before task_release

			tcb_ptr = search_free_TCB();

			tcb_ptr->id = p->task_ID;
			
			tcb_ptr->scheduling_ptr->status = BLOCKED;  

			new_ptr = 1;
		}
		// common code independent of function order: task allocation <---> task_release
		tcb_ptr->pc = 0;

		puts("Task id: "); puts(itoa(tcb_ptr->id)); putsv(" allocated at ", MemoryRead(TICK_COUNTER));

		code_lenght = p->code_size;

		tcb_ptr->text_lenght = code_lenght;

		tcb_ptr->master_address = p->master_ID;

		tcb_ptr->proc_to_migrate = -1;

		tcb_ptr->scheduling_ptr->remaining_exec_time = MAX_TIME_SLICE;

		DMNI_read_data(tcb_ptr->offset, code_lenght);

		//printTaskInformations(tcb_ptr, 1, 0, 0);

//************************************
		/*if(tcb_ptr->secure == 1){
		

			code_lenght = code_lenght - 2;

			//puts("size:");puts(itoa((code_lenght*4))); puts("\n");
			//puts("addr:");puts(itoh(tcb_ptr->offset)); puts("\n");

			putsv("Init MAC - ", MemoryRead(TICK_COUNTER)); 
			calculated_hash = siphash24((void *)tcb_ptr->offset, code_lenght*4, key);

			

			ptr_rcv = (uint64_t *)(tcb_ptr->offset + (code_lenght*4));
			received_hash =  *ptr_rcv;

			//hash = siphash24(value, 8, key);

	    	hi = calculated_hash >> 32;
	    	lo = calculated_hash & 0xFFFFFFFF;

			//puts("Calculated hash hi:"); puts(itoh(hi)); puts("\n");
			//puts("Calculated hash lo:"); puts(itoh(lo)); puts("\n");

	    	hi = received_hash >> 32;
	    	lo = received_hash & 0xFFFFFFFF;

			//puts("  Received hash hi:"); puts(itoh(hi)); puts("\n");
			//puts("  Received hash lo:"); puts(itoh(lo)); puts("\n");		
			//puts("Address MAC: "); puts(itoh(ptr_rcv)); puts("\n");

			//if (calculated_hash == received_hash){
			if (received_hash == received_hash){
				tcb_ptr->MAC_status = 1;
				putsv("MAC check: Ok - ", MemoryRead(TICK_COUNTER));
			}
			else{
				tcb_ptr->MAC_status = 0;
				puts("ERROR: Calculated MAC is not equal received MAC"); puts("\n");
			}

		}*/
		tcb_ptr->MAC_status = 1;
//************************************		

		if (current == &idle_tcb){
			need_scheduling = 1;
		}

		if(new_ptr == 0){  //task allocation after task_release

			tcb_ptr->text_lenght = code_lenght- tcb_ptr->data_lenght;  // aqui

			if(tcb_ptr->secure != 1)						// aqui
				tcb_ptr->scheduling_ptr->status = READY;
			else
				tcb_ptr->scheduling_ptr->status = BLOCKED;

			send_task_allocated(tcb_ptr);

			putsv("Send Task Allocated (TA): ", tcb_ptr->id);
		}

		break;

	case TASK_RELEASE:
		new_ptr = 0;

		tcb_ptr = searchTCB(p->task_ID);

		if(tcb_ptr == 0){  //task_release before task_allocation 

			tcb_ptr = search_free_TCB();

			tcb_ptr->id = p->task_ID;

			tcb_ptr->scheduling_ptr->status = BLOCKED;

			new_ptr = 1;
		}
		puts("Task id: "); puts(itoa(tcb_ptr->id)); putsv(" released at ", MemoryRead(TICK_COUNTER));

		app_ID = p->task_ID >> 8;

		tcb_ptr->data_lenght = p->data_size;

		tcb_ptr->bss_lenght = p->bss_size;

		if(p->secure)
			tcb_ptr->secure = 1;
		else
			tcb_ptr->secure = 0;
		//tcb_ptr->secure = p->secure;

		DMNI_read_data( (unsigned int) app_tasks_location, p->app_task_number);

		if (get_task_location(tcb_ptr->id) == -1){
			for (int i = 0; i < p->app_task_number; i++){
				add_task_location(app_ID << 8 | i, app_tasks_location[i]);
			}
		}			
		
		if (current == &idle_tcb){   
			need_scheduling = 1;
		}
		
		if(new_ptr == 0){

			tcb_ptr->text_lenght = tcb_ptr->text_lenght - tcb_ptr->data_lenght;  

			if(tcb_ptr->secure != 1)						
				tcb_ptr->scheduling_ptr->status = READY;
			else
				tcb_ptr->scheduling_ptr->status = BLOCKED;

			send_task_allocated(tcb_ptr);

			putsv("Send Task Allocated (TR): ", tcb_ptr->id);
		}
		break;


	case TASKS_LOCATION:
		new_ptr = 0;

		tcb_ptr = searchTCB(p->task_ID);

		//puts("Task id: "); puts(itoa(tcb_ptr->id)); putsv(" LOCATIONS at ", MemoryRead(TICK_COUNTER));

		app_ID = p->task_ID >> 8;

		DMNI_read_data( (unsigned int) app_tasks_location, p->app_task_number);

		//if (get_task_location(tcb_ptr->id) == -1){
			for (int i = 0; i < p->app_task_number; i++){
				migration_puts("Location "); migration_puts(itoa(i)); 
				migration_puts(": "); migration_puts(itoh(app_tasks_location[i])); migration_puts("\n");
				change_task_location(app_ID << 8 | i, app_tasks_location[i]);
				update_msg_request_migration(i, app_tasks_location[i]);
			}
		//}			

		break;		

	case UPDATE_TASK_LOCATION:

	//	puts("UPDATE_TASK_LOCATION");  puts("\n");
	//	puts("p->task_ID "); puts(itoa(p->task_ID & 0xFF)); puts("\n");
	//	puts("app ID >> "); puts(itoa(p->task_ID >> 8)); puts("\n"); 
		if (is_another_task_running(p->task_ID >> 8)){ // FOCHI ADD 01/06/2017 orientações do Ruaro.
	//				puts("entrou");  puts("\n");
			update_msg_request_table((p->task_ID & 0xFF), p->allocated_processor);//			FOCHI ADD 02/10/2017 orientações do Caimi.
			remove_task_location(p->task_ID);
			add_task_location(p->task_ID, p->allocated_processor);
		}

		break;

	case INITIALIZE_SLAVE:

		cluster_master_address = p->source_PE;

		putsv("Slave initialized by cluster address: ", cluster_master_address);

		break;

	case RND_VALUE:

		puts("RND VALUE MESSAGE RECEIVED");  puts("\n");

		DMNI_read_data(rnd, 6);

		Km = siphash24((void *) rnd , 24, key);
		
		puts("Km: ");  puts(itoh(Km));  puts("\n");

		break;


	case KE_VALUE:

		puts("Cripted KE VALUE MESSAGE received");  puts("\n");
        // putsv(" time - ", MemoryRead(TICK_COUNTER));

		DMNI_read_data(Ke, 6);

		//Aplly_LSFR(received_hash, 0X12, received_hash, 0xA1);

		putsv(" KE decripted - ", MemoryRead(TICK_COUNTER));
		
		break;



	#if MIGRATION_ENABLED
		case TASK_MIGRATION:
		case MIGRATION_CODE:
		case MIGRATION_TCB:
		case MIGRATION_TASK_LOCATION:
		case MIGRATION_PRODUCER_MSG_REQUEST:
		case MIGRATION_CONSUMER_MSG_REQUEST:
		case MIGRATION_STACK:
		case MIGRATION_DATA_BSS:
		case MIGRATION_PIPE:

			//cluster_master_address = get_master_address(get_net_address()); //fochi

			need_scheduling = handle_migration(p, cluster_master_address);

		break;
	#endif

	default:
			puts("ERROR: service unknown ");puts(itoh(p->service)); puts("\n");
			putsv("Time: ", MemoryRead(TICK_COUNTER));
			puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1])); puts("\n");
			puts("size:");puts(itoh(p->payload_size)); puts("\n");
			puts("service:");puts(itoh(p->service)); puts("\n");
			puts("producer:");puts(itoh(p->producer_task)); puts("\n");
			puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
			puts("source:");puts(itoh(p->source_PE)); puts("\n");
		break;
	}

	return need_scheduling;
}

/** Generic task scheduler call
 */
void Scheduler() {

	Scheduling * scheduled;
	unsigned int scheduler_call_time;

	scheduler_call_time = MemoryRead(TICK_COUNTER);

	MemoryWrite(SCHEDULING_REPORT, SCHEDULER);

	#if MIGRATION_ENABLED
		if (current->proc_to_migrate != -1 && current->scheduling_ptr->status == RUNNING){
			puts("Chamou scheduler\n");
			migrate_dynamic_memory(current);
		}
	#endif
	
	// print_task();

	scheduled = LST(scheduler_call_time);

	if (scheduled){

		//This cast is an approach to reduce the scheduler call overhead
		current = (TCB *) scheduled->tcb_ptr;

		MemoryWrite(SCHEDULING_REPORT, current->id);

	} else {

		//puts("Idle Task Running\n");
		current = &idle_tcb;	// schedules the idle task

		last_idle_time = MemoryRead(TICK_COUNTER);

        MemoryWrite(SCHEDULING_REPORT, IDLE);
	}

	MemoryWrite(TIME_SLICE, get_time_slice() );

	OS_InterruptMaskSet(IRQ_SCHEDULER);

}


int SeekInterruptHandler(){
	unsigned int target, source, service, payload;
	static unsigned int seek_unr_count = 0;
	unsigned int backtrack, backtrack1, backtrack2;
	int aux = 0;
	extern TCB tcbs[MAX_LOCAL_TASKS];
	extern int wrapper_value;
	unsigned int my_X_addr, my_Y_addr;
	unsigned int RH_X_addr, RH_Y_addr;
	unsigned int LL_X_addr, LL_Y_addr;
	unsigned int right_high_corner, left_low_corner;
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
	int t1, t2, t3;
	// For Sessions
	unsigned int auxProducer, auxConsumer, auxCode, auxNumber;
	Message * msg_ptr;
	TCB * tcb_ptr = 0;
	PipeSlot* tmpSlot;
	ServiceHeader* auxService = 0;
	int task_loc;
	static prevTUS = -1;
	
	switch(service){
		case TARGET_UNREACHABLE_SERVICE:
			puts("Received TARGET_UNREACHABLE_SERVICE\n");
			puts("source: "); puts(itoh(source)); puts("\n");
			puts("target: "); puts(itoh(target)); puts("\n");
			puts("payload: "); puts(itoh(payload)); puts("\n");
			//perform clear
			//Seek(CLEAR_SERVICE, source, target, 0);
			//global variable for finding seek
			if ((payload == prevTUS)){ //TUS agora vem com o timestamp no payload para evitar reverberação
				puts("----repetido\n");
				break;
			}
			puts("Source: "); puts(itoh(source)); puts("\n");
			slot_seek = GetFreeSlotSourceRouting(source>>16);
			
			if(slot_seek != -1){
				//seek_puts("slot: "); seek_puts(itoa(slot_seek)); seek_puts("\n");
				SR_Table[slot_seek].target = source>>16;
				SR_Table[slot_seek].tableSlotStatus = SR_USADO;
			}	
			if(seek_unr_count == (source>>16)){
				seek_unr_count++;
			}
			
			aux =  search_Target(source>>16);
			puts(itoh(aux));puts("\n")
			#ifndef GRAY_AREA
			if(((aux == search_Service(IO_REQUEST)) || (aux == search_Service(IO_DELIVERY))) && (aux != -1)){
				send_wrapper_close_back__open_forward(aux);
			}
			#endif

			Seek(SEARCHPATH_SERVICE, ((seek_unr_count<<16) | (get_net_address()&0xffff)), source>>16, 0);
			seek_unr_count++;
			prevTUS = payload;
		break;

		case BACKTRACK_SERVICE:
			puts("Received BACKTRACK_SERVICE\n");
			// puts("backtrack: "); puts(itoh(backtrack)); puts("\n");
			// puts("backtrack1: "); puts(itoh(backtrack1)); puts("\n");
			// puts("backtrack2: "); puts(itoh(backtrack2)); puts("\n");

			
			slot_seek = ProcessTurns(backtrack, backtrack1, backtrack2);
			// seek_puts("slot: "); seek_puts(itoa(slot_seek)); seek_puts("\n");
			Seek(CLEAR_SERVICE, ((SR_Table[slot_seek].target<<16) | (get_net_address()&0xffff)), 0,0);
			aux = resend_messages(SR_Table[slot_seek].target);
			// puts("resend 1:"); puts(itoa(aux)); puts("\n");
			aux = aux + resend_msg_request(SR_Table[slot_seek].target);
			// puts("resend 2:"); puts(itoa(aux)); puts("\n");


			if(aux == 0){
				aux =  search_Target(source>>16);
				#ifndef GRAY_AREA
				if(((aux == search_Service(IO_REQUEST)) || (aux == search_Service(IO_DELIVERY))) && (aux != -1)){
					send_wrapper_close_forward(aux);
				}	
				#endif
				// puts("target: "); puts(itoh(SR_Table[slot_seek].target)); puts("\n");			
            	aux = resend_control_message(backtrack, backtrack1, backtrack2, SR_Table[slot_seek].target);
        	}

			if(aux == 0){
				int peripheral_id;
				peripheral_id = find_io_peripheral(get_net_address());
				if(peripheral_id){
					puts(" SR Peripheral\n"); 
					send_peripheral_SR_path(slot_seek, peripheral_id, target);
				}
			}
		break;

		case SET_SECURE_ZONE_SERVICE:
			// seek_puts("Received SET_SECURE_ZONE"); seek_puts("\n");
			Set_Secure_Zone(target, payload, source); // verificação interna
		break;

		#ifdef SESSION_MANAGER
		case MSG_DELIVERY_CONTROL: //MDC_HANDLER
			tInit = MemoryRead(TICK_COUNTER);
			session_puts("CONTROL: Received MSG_DELIVERY_CONTROL\n"); 
			
			auxNumber = (source & 0xFFFF); // Number of received MESSAGE_DELIVERY
			auxCode = ((source >> 16) & 0xFFC0); // 10-bit Code
			auxIndex = (source >> 16) & 0x3F;    // 6-bit Index

			if (Sessions[auxIndex].pairIndex == 0x3F){  // The first MDControl is the Session_ACK
				Sessions[auxIndex].pairIndex = payload; // Confirming the index of the sender to do the direct indexing
			}

			
			if(auxIndex != 0x3F)
			{
				auxSession = &Sessions[auxIndex];   // Get the Session pointer (much used)
				auxConsumer = auxSession->consumer; 
				auxProducer = auxSession->producer;

				if (auxSession->sent == auxNumber){ // Checks if it is a repeated MDC accidentally entering the kernel
					session_puts("ERROR(MDC): Repeated MDC\n");
				}
				else if (auxSession->status == WAITING_CONTROL) // If the Data arrived first, the status will be WAITING_CONTROL
				{
					msg_ptr = auxSession->msg;
					if (msg_ptr == -1)
						puts("CONTROL: Nao achou a sessão criada pelo MD\n"); 

					tcb_ptr = searchTCB(auxConsumer);

					if (tcb_ptr == 0)
						session_puts("CONTROL: Nao achou a tarefa nas TCB\n"); 

					write_local_msg_to_task(tcb_ptr, msg_ptr->length, msg_ptr->msg);

					if (remove_msg_request(get_task_location(auxProducer), auxConsumer, auxProducer) == 0)
						session_puts("CONTROL: Request não encontrado:\n");
					
					if (auxSession->requested != (source & 0xFFFF) +1)
						session_puts("ERRO(antes): numeros recebidos e enviados errados\n");

					auxSession->sent += 1;
					auxSession->status = WAITING_ANY;
					msg_ptr->length = -1 ; //clearMessageSlot(msg_ptr);

				}else if (auxSession->status == WAITING_ANY){ // If this is first, computate the sent values and set to WAITING_DATA, MD will handle the rest
					auxSession->sent += 1;
					auxSession->status = WAITING_DATA;
					auxSession->time = tInit;
				}
			}else{
				puts("CONTROL: ERRO MDR nao achou a Sessao!\n"); 
			}
		tEnd = MemoryRead(TICK_COUNTER);
		session_time_puts("CONTROL DEL= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
		break;

		case MSG_REQUEST_CONTROL: //MRR_HANDLER
			tInit = MemoryRead(TICK_COUNTER);

			auxConsumer = (payload << 8) | (source & 0xFF);
			auxProducer = (payload << 8) | ((source >> 8) & 0xFF);
			auxCode = ((source >> 16) & 0xFFC0); // 10 bits de código 
			auxIndex = ((source >> 16) & 0x3F); // 6 bits do índice 
			auxNumber = source & 0xFFFF;
			auxService = -1;

			if (auxCode == 0xFFC0){ // END_SESSION // Se o código for "11 1111 1111"
				// session_puts("CONTROL: Received END_SESSION\n");
				clearSession(Sessions, auxIndex); // O índice vem junto no "code"
			}
			else if(Sessions[auxIndex].code != auxCode) //START_SESSION
			{
				// session_puts("CONTROL: Received START_SESSION\n");
				if (checkSessionCode(Sessions, auxCode) == START_SESSION){
					auxIndex = createSession(Sessions, auxProducer, auxConsumer, (auxCode | auxIndex)); // Session Creation 
					Sessions[auxIndex].header = checkWaitingServices(waitingServices, auxProducer, auxConsumer, MESSAGE_REQUEST); // Checking for pending MRs
				}
			}
			// t1 = MemoryRead(TICK_COUNTER);
			if (Sessions[auxIndex].code == auxCode) //default
			{
				// session_puts("CONTROL: Received MRC\n");
				auxSession = &Sessions[auxIndex];
				//AuxService needs to be retrieved and, in case of new Session, both steps need to be done here- Control and Data
				auxService = auxSession->header;

				if ((auxSession->requested == auxNumber) && (auxNumber != 1) ){ // Repeated MRC 
					// session_puts("ERRO(req): Recebendo MRC repetido\n");
				}else{
					auxSession->requested += 1;  

					if ((auxSession->status == WAITING_ANY) || (auxService != -1)){ 
						// session_puts("---- Receipt Primeiro, registrando chegada\n");
						// auxSession->header = auxService;
						auxSession->status = WAITING_DATA;
						auxSession->time = tInit;
						
					}
					// t2 = MemoryRead(TICK_COUNTER);
					if ((auxSession->status == WAITING_CONTROL) || (auxService != -1)){
						// session_puts("---- Receipt Segundo, resgatando MR\n");
						
						// auxService = auxSession->header;

						tmpSlot = remove_PIPE(auxService->producer_task, auxService->consumer_task);

						//Test if there is no message in PIPE
						if (tmpSlot == 0){
							// session_puts("---- sem mensagem no PIPE\n");
							//Gets the location of the producer task
							task_loc = get_task_location(auxService->producer_task);

							//This if check if the task was migrated
							if ( task_loc != -1 && task_loc != net_address && auxService->requesting_processor == auxService->source_PE){

								//MESSAGE_REQUEST by pass
								send_message_request(auxService->producer_task, auxService->consumer_task, task_loc, auxService->requesting_processor);

								if ( search_PIPE_producer(auxService->producer_task) == 0){

									send_update_task_location(auxService->requesting_processor, auxService->producer_task, task_loc);
								}

							} else {
								insert_message_request(auxService->producer_task, auxService->consumer_task, auxService->requesting_processor);
							}

						} else if (auxService->requesting_processor != net_address){
							// session_puts("---- enviando MD e MDR\n");
							// t3 = MemoryRead(TICK_COUNTER);
							send_message_delivery_control(Sessions, auxService->producer_task, auxService->consumer_task, auxService->requesting_processor);
							send_message_delivery(auxService->producer_task, auxService->consumer_task, auxService->requesting_processor, &tmpSlot->message);
						} else {
							// session_puts("---- deu no Pass\n");
							tcb_ptr = searchTCB(auxService->consumer_task);
							write_local_msg_to_task(tcb_ptr, tmpSlot->message.length, tmpSlot->message.msg);
						}
						auxService->service = BLANK; //clearServiceSlot(auxService);
						auxSession->status = WAITING_ANY;
						auxSession->header = -1;
					}
				}
			}		
		tEnd = MemoryRead(TICK_COUNTER);
		session_time_puts("CONTROL REQ= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
		// session_time_puts("T1= ");session_time_puts(itoa(t1-tInit));session_time_puts("\n");
		// session_time_puts("T2= ");session_time_puts(itoa(t2-tInit));session_time_puts("\n");
		// session_time_puts("T3= ");session_time_puts(itoa(t3-tInit));session_time_puts("\n");

		break;
		#endif

		case SET_EXCESS_SZ_SERVICE:
			puts("Received SET_EXCESS_SZ_SERVICE\n"); 
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			// puts("payload: "); puts(itoh(payload)); puts("\n");
			// Ignorar se for secure já
			if (LOCAL_right_high_corner != -1){
				Unset_Secure_Zone(target, payload, source);
				//cut - LL, RH, master
				//NoCut - LL, RH, master
			}
		break;

		case START_APP_SERVICE:
			//puts("Received START_APP"); puts("\n");
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			// puts("payload: "); puts(itoh(payload)); puts("\n");
			//seek_puts("RH: "); seek_puts(itoh(LOCAL_right_high_corner)); seek_puts("\n");
			//seek_puts("Address: "); seek_puts(itoh(get_net_address())); seek_puts("\n");
			aux = unblock_tasks_of_App(payload);
			seek_puts("Tasks Unbloqued: "); seek_puts(itoh(aux)); seek_puts("\n");
			// putsv("time - ", MemoryRead(TICK_COUNTER));
			aux = ((get_net_address() & 0xF00) >> 4) + (get_net_address() & 0x00F);
			if(LOCAL_right_high_corner == aux){
				seek_puts("clear START_APP service!"); seek_puts("\n");
				Seek(CLEAR_SERVICE, source, source, payload);
			}
			
			// aux = unblock_tasks_of_App(payload);
			// seek_puts("Tasks Unbloqued: "); seek_puts(itoh(aux)); seek_puts("\n");
			//return aux;
		break;

		case OPEN_SECURE_ZONE_SERVICE:
			seek_puts("Received OPEN_SECURE_ZONE"); seek_puts("\n");
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			//puts("payload: "); puts(itoh(payload)); puts("\n");
			// Seek(OPEN_SECURE_ZONE_SERVICE, get_net_address(), app_id, app->RH_Address);
			aux = ((get_net_address() & 0xF00) >> 4) + (get_net_address() & 0x00F);
			if(LOCAL_right_high_corner == aux){
				//puts("Send Clear Open"); puts("\n");
				Seek(CLEAR_SERVICE, source, source, payload);
			}
			
			
			for(int i = 0; i < MAX_LOCAL_TASKS; i++){
				if ((tcbs[i].id >> 8) == target){
					//seek_puts("appID: ");  seek_puts(itoh(target)); seek_puts("\n");
					//seek_puts("previous wrappers: ");  seek_puts(itoh(wrapper_value)); seek_puts("\n");
					MemoryWrite(WRAPPER_REGISTER, 0);
					ClearAllSourceRouting();
					wrapper_value = 0;
					//seek_puts("before wrappers: ");  seek_puts(itoh(wrapper_value)); seek_puts("\n");
					LOCAL_right_high_corner = -1;
					break;
				}	
			}
			clear_all_memory_areas(target);
			if(LOCAL_right_high_corner == payload){
				seek_puts("Open wrappers");  seek_puts("\n");
				MemoryWrite(WRAPPER_REGISTER, 0);
			}
			//aux = payload;
			payload = ((payload << 4) & 0xF00) | (payload & 0x0F);
			if(get_net_address() == payload){
				Seek(SECURE_ZONE_OPENED_SERVICE, get_net_address(), source, target);
			}
		break;	

		case INITIALIZE_SLAVE_SERVICE:
			left_low_corner = target; 
			right_high_corner = payload;
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			// puts("payload: "); puts(itoh(payload)); puts("\n");
			
			my_X_addr = (get_net_address() & 0xF00) >> 8;
			my_Y_addr = get_net_address() & 0x00F;
		
			RH_X_addr = (right_high_corner & 0xF0) >> 4;
			RH_Y_addr = right_high_corner & 0x0F;
		
			LL_X_addr = (left_low_corner & 0xF0) >> 4;
			LL_Y_addr = left_low_corner & 0x0F;
			if((my_X_addr == RH_X_addr) && (my_Y_addr == RH_Y_addr)){
				 puts("Clear: "); puts(itoh(payload)); puts("\n");
				Seek(CLEAR_SERVICE, source, source, 0);
			}
			if((my_X_addr <=  RH_X_addr) && (my_X_addr >= LL_X_addr))
				if((my_Y_addr <=  RH_Y_addr) && (my_Y_addr >= LL_Y_addr)){
					cluster_master_address = source & 0x0ffff;	
					puts("Cluster Master Address: "); puts(itoh(cluster_master_address)); puts("\n");
				}
		break;

		case FREEZE_TASK_SERVICE:
				//print_task();	
				puts(itoa(MemoryRead(TICK_COUNTER))); puts("\n");
			 	puts("Received FREEZE_TASK_SERVICE"); puts("\n");
					
				aux = freeze_tasks_of_App(target);
				
				Seek(CLEAR_SERVICE, source, target ,payload);
				payload = ((payload << 4 ) & 0XF00) | (payload & 0x0F);
				if(payload == get_net_address()){
					puts("send FREEZE_TASK_RCV app: "); puts(itoh(payload)); puts("\n");
					Seek(RCV_FREEZE_TASK_SERVICE, get_net_address(), source ,payload);
				}
				puts("Tasks FREZZED: "); puts(itoh(aux)); puts("\n");
				//print_task();	
			return aux;
		break;

		case UNFREEZE_TASK_SERVICE: //enviado pelo Mastre WARD do cluster
			puts("Received UNFREEZE_TASK_SERVICE"); puts("\n");
			aux = unfreeze_tasks_of_App(target);
			puts("Tasks UNFREZZED: "); puts(itoh(aux)); puts("\n");
			//print_locations();
			return aux;
		break;	

		// case WAIT_KERNEL_SERVICE: //enviado pelo Mestre WARD do cluster
		// 	puts("Received WAIT_KERNEL_SERVICE from "); puts(itoh((source&0xFFFF))); puts("\n"); //WARNING puts necessário para sincronização
		// 	Seek(WAIT_KERNEL_SERVICE_ACK, target, (source&0xFFFF),0);//Send to slave a warning to became a new master
		// 	puts("Send WAIT_KERNEL_SERVICE_ACK to "); puts(itoh((source&0xFFFF))); puts("\n"); //WARNING puts necessário para sincronização
		// 	MemoryWrite(DMA_WAIT_KERNEL,1);
		// 	MemoryWrite(CLOCK_HOLD_WAIT_KERNEL, 0);
		// break;

		case INITIALIZE_CLUSTER_SERVICE:
		// case LOAN_PROCESSOR_REQUEST_SERVICE:
		// case LOAN_PROCESSOR_RELEASE_SERVICE:
		break;
		
		case GMV_READY_SERVICE: // remover
		// 	puts("Kernel GMV Serbvice Recebido\n"); //Testando se chegou isso
		break;
		case NEW_APP_SERVICE:
		case NEW_APP_ACK_SERVICE:
		break;
					
		default:
			//seek_puts("Received unknown seek service\n");
		break;
	}
	return 1;
}


int get_cluster_ID(int x, int y){
	puts("get cluster x: "); puts(itoh(x)); puts(" y:  "); puts(itoh(y)); puts("\n");
	for (int i=0; i<CLUSTER_NUMBER; i++){
		if (cluster_info[i].master_x == x && cluster_info[i].master_y == y){
			return i;
		}
	}
	puts("ERROR - cluster nao encontrado\n");
	return -1;
}



/** Function called by assembly (into interruption handler). Implements the routine to handle interruption in HeMPS
 * \param status Status of the interruption. Signal the interruption type
 */
void OS_InterruptServiceRoutine(unsigned int status) {

	MemoryWrite(SCHEDULING_REPORT, INTERRUPTION);

	volatile ServiceHeader p;
	ServiceHeader * next_service;
	unsigned call_scheduler;

	if (current == &idle_tcb){
		total_slack_time += MemoryRead(TICK_COUNTER) - last_idle_time;
	}

	call_scheduler = 0;

	if ( status & IRQ_NOC ){
		auxTime = MemoryRead(TICK_COUNTER);
		// puts("Tempo da Interrupção: ");puts(itoa(auxTime));puts("\n");
		//printar o tempo do novo tratamento
		if (read_packet(&p) != -1){
			if (MemoryRead(DMNI_SEND_ACTIVE) && (p.service == MESSAGE_REQUEST || p.service == TASK_MIGRATION) ){

				add_pending_service(&p);

			} else {

				call_scheduler = handle_packet(&p);
			}
		}
		else{//failed packet reception
			MemoryWrite(DMNI_TIMEOUT_SIGNAL,0);
		}

	} else if (status & IRQ_PENDING_SERVICE) {

		next_service = get_next_pending_service();
		if (next_service){
			call_scheduler = handle_packet(next_service);
		}
	}

	if (status & IRQ_SLACK_TIME){
		send_slack_time_report();
		total_slack_time = 0;
		MemoryWrite(SLACK_TIME_MONITOR, 0);
	}

	if ( status & IRQ_SCHEDULER ){

		call_scheduler = 1;
	}

	if ( status & IRQ_SEEK ){

			call_scheduler = SeekInterruptHandler();
	}

	if (call_scheduler){

		Scheduler();

	} else if (current == &idle_tcb){

		last_idle_time = MemoryRead(TICK_COUNTER);

		MemoryWrite(SCHEDULING_REPORT, IDLE);

	} else {
		MemoryWrite(SCHEDULING_REPORT, current->id);
	}

	#ifdef SESSION_MANAGER
	timeoutMonitor(Sessions, MemoryRead(TICK_COUNTER));
	#endif
	
    /*runs the scheduled task*/
    ASM_RunScheduledTask(current);
}

/** Clear a interruption mask
 * \param Mask Interruption mask clear
 */
unsigned int OS_InterruptMaskClear(unsigned int Mask) {

    unsigned int mask;

    mask = MemoryRead(IRQ_MASK) & ~Mask;
    MemoryWrite(IRQ_MASK, mask);

    return mask;
}

/** Set a interruption mask
 * \param Mask Interruption mask set
 */
unsigned int OS_InterruptMaskSet(unsigned int Mask) {

    unsigned int mask;

    mask = MemoryRead(IRQ_MASK) | Mask;
    MemoryWrite(IRQ_MASK, mask);

    return mask;
}

/** Idle function
 */
void OS_Idle() {
	for (;;){
		MemoryWrite(CLOCK_HOLD, 1);
	}
}

int main(){
	MemoryWrite(CLOCK_HOLD_WAIT_KERNEL, 1);

	ASM_SetInterruptEnable(FALSE);

	MemoryWrite(WRAPPER_MASK_GO_REGISTER,0XFFFFFFFF);
	MemoryWrite(WRAPPER_MASK_BACK_REGISTER,0XFFFFFFFF);

	#ifdef AES_MODULE
		putsv("Key Size:", KEY_SIZE); 
		putsv("INIT aes key - ", MemoryRead(TICK_COUNTER)); 
		aes_key_setup(&key[0][0], key_schedule, KEY_SIZE);   
		putsv("END aes key - ", MemoryRead(TICK_COUNTER)); 
	#endif

	#ifdef PRESENT_MODULE
		putsv("Key Size:", PRESENT_KEY_SIZE_128); 
		putsv("INIT aes key - ", MemoryRead(TICK_COUNTER)); 
		present_64_80_key_schedule(inputKey, keys);
		putsv("END aes key - ", MemoryRead(TICK_COUNTER)); 
	#endif


	idle_tcb.pc = (unsigned int) &OS_Idle;
	idle_tcb.id = 0;
	idle_tcb.offset = 0;
	//idle_tcb.scheduling_ptr->status = READY;

	total_slack_time = 0;

	last_idle_time = MemoryRead(TICK_COUNTER);

	current = &idle_tcb;

	net_address = MemoryRead(NI_CONFIG);

	set_net_address(net_address);

	puts("Initializing PE: "); puts(itoh(net_address)); puts("\n");

	init_communication();

	// printGray();


	initFTStructs();

	initSessions();

	init_service_header_slots();

	init_task_location();

	init_TCBs();

	initialize_CM_FIFO();

	/*disable interrupts*/
	OS_InterruptMaskClear(0xffffffff);

	//if (get_net_address() == 0x00000202){
	//puts("maooiii: "); puts(itoh(((io_info[0].default_address_x << 8) | io_info[0].default_address_y))); puts("\n");	
	//puts("maooiii: "); puts(itoh(io_info[0].default_port)); puts("\n");	
	//ServiceHeader *p = get_service_header_slot();
//
//	//p->service = MIGRATION_CODE;
//
//	//send_packet_io(p, 0, 0, 9);
//
//
//	//p->service = MIGRATION_CODE;
//
//	//send_packet_io(p, 0, 0, 8);
//
//
	//}


	/*enables timeslice counter and wrapper interrupts*/

	//WARNING: NOT ENABLING this fucking shit of IRQ_SLACK_TIME
	//by Wachter
	OS_InterruptMaskSet(IRQ_SEEK | IRQ_SCHEDULER | IRQ_NOC | IRQ_PENDING_SERVICE);

	/*runs the scheduled task*/
	ASM_RunScheduledTask(current);

	return 0;
}
=======
/*!\file kernel_slave.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Edited by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * Kernel slave is the system slave used to execute user's tasks.
 *
 * \detailed
 * kernel_slave is the core of the OS running into the slave processors.
 * Its job is to runs the user's task. It communicates whit the kernel_master to receive new tasks
 * and also notifying its finish.
 * The kernel_slave file uses several modules that implement specific functions
 */

#include "kernel_slave.h"

#include "../../../include/kernel_pkg.h"
#include "../../include/api.h"
#include "../../include/plasma.h"
#include "../../include/services.h"
#include "../../modules/task_location.h"
#include "../../modules/task_control.h" 
#include "../../modules/packet.h"
#include "../../modules/communication.h"
#include "../../modules/pending_service.h"
#include "../../modules/local_scheduler.h"
#include "../../modules/utils.h"
#include "../../modules/control_messages_fifo.h" 
#include "../../modules/csiphash.h"
#include "../../modules/lfsr.h"

#include "../../modules/osz_slave.h"

#ifdef AES_MODULE
#include "../../modules/aes.h"
#endif 

#ifdef PRESENT_MODULE
#include "../../modules/present.h"
#endif 

#if MIGRATION_ENABLED
#include "../../modules/task_migration.h"
#endif

extern int LOCAL_right_high_corner;

//Globals
unsigned int 	net_address;				//!< Store the current XY address
unsigned int 	schedule_after_syscall;		//!< Signals the syscall function (assembly implemented) to call the scheduler after the syscall
unsigned int 	cluster_master_address;		//!< Store the cluster master XY address
unsigned int 	last_idle_time;				//!< Store the last idle time duration
unsigned int 	total_slack_time;			//!< Store the total of the processor idle time
TCB 			idle_tcb;					//!< TCB pointer used to run idle task
TCB *			current;					//!< TCB pointer used to store the current task executing into processor
Message 		msg_write_pipe;				//!< Message variable which is used to copy a message and send it by the NoC

lfsr_t glfsr_d0;
lfsr_t glfsr_c0;

Message waitingMessages[10];

#ifdef AES_MODULE
	extern unsigned int key_schedule[60];
	extern unsigned int key[1][32];
#endif 

#ifdef PRESENT_MODULE
	extern u8 inputKey[10];
	extern u8 keys[PRESENT_KEY_SIZE_128/8*(PRESENT_ROUNDS+1)];
#endif 


/** Assembles and sends a TASK_TERMINATED packet to the master kernel
 *  \param terminated_task Terminated task TCB pointer
 */
void send_task_terminated(TCB * terminated_task){

	ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = terminated_task->master_address;

	p->service = TASK_TERMINATED;

	p->task_ID = terminated_task->id;

	p->master_ID = cluster_master_address;

	send_packet(p, 0, 0);

	if (terminated_task->master_address != cluster_master_address){

		p = get_service_header_slot();

		p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = cluster_master_address;

		p->service = TASK_TERMINATED_OTHER_CLUSTER;

		p->task_ID = terminated_task->id;

		p->master_ID = terminated_task->master_address;

		send_packet(p, 0, 0);
	}

	

}

/** Assembles and sends a TASK_ALLOCATED packet to the master kernel
 *  \param allocated_task Allocated task TCB pointer
 */
void send_task_allocated(TCB * allocated_task){
	unsigned int aux_appID_task_ID;

	aux_appID_task_ID = ((allocated_task->id >> 4) & 0xF0) | (allocated_task->id & 0x0F);
	if(allocated_task->secure == 1){
		puts("Task Allocated SEGURA: "); puts(itoh(aux_appID_task_ID)); puts("\n");
		Seek(TASK_ALLOCATED_SERVICE, ((allocated_task->MAC_status << 24) |   (aux_appID_task_ID<<16) | (get_net_address()& 0xFFFF)), allocated_task->master_address, aux_appID_task_ID);
	}else
		Seek(TASK_ALLOCATED_SERVICE, ((aux_appID_task_ID<<16) | (get_net_address()& 0xFFFF)), allocated_task->master_address, aux_appID_task_ID);
		
	//puts("Task Allocated: "); puts(itoh(aux_appID_task_ID)); puts("\n");

}

/** Assembles and sends a REAL_TIME_CHANGE packet to the master kernel
 *  \param tcb_ptr TCB pointer of the task that change its real-time parameters
 */
void send_task_real_time_change(TCB * tcb_ptr){

	ServiceHeader * p = get_service_header_slot();

	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = cluster_master_address;

	p->service = REAL_TIME_CHANGE;

	p->task_ID = tcb_ptr->id;

	p->utilization = tcb_ptr->scheduling_ptr->utilization;

	putsv("Send real time change, utilization: ", p->utilization);

	send_packet(p, 0, 0);
}

/** Assembles and sends a DULL packet to target
 *  \param target TCB pointer of the task that change its real-time parameters
 */
void send_dull_packet(){

	ServiceHeader * p = get_service_header_slot();

	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = 256*2 + 2;

	p->service = MESSAGE_DELIVERY;

	p->task_ID = 0;

	p->period = -1;

	p->source_PE = 0;

	p->timestamp = -1;

	puts("Sent dull packet");

	send_packet(p, 0, 0);
}

/** Assembles and sends a SLACK_TIME_REPORT packet to the master kernel
 */
void send_slack_time_report(){

	ServiceHeader * p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = cluster_master_address;

	p->service = SLACK_TIME_REPORT;

	p->cpu_slack_time = ( (total_slack_time*100) / SLACK_TIME_WINDOW);

	send_packet(p, 0, 0);
}

///** Assembles and sends a UPDATE_TASK_LOCATION packet to a slave processor. Useful because task migration
// * \param target_proc Target slave processor which the packet will be sent
// * \param task_id Task ID that have its location updated
// * \param new_task_location New location (slave processor address) of the task
// */
//void send_update_task_location(unsigned int target_proc, unsigned int task_id, unsigned int new_task_location){
//
//	ServiceHeader *p = get_service_header_slot();
//
//	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = target_proc;
//
//	p->service = UPDATE_TASK_LOCATION;
//
//	p->task_ID = task_id;
//
//	p->allocated_processor = new_task_location;
//
//	send_packet(p, 0, 0);
//
//	//putsvsv("Update task location ", task_id, " in processor ", target_proc);
//
//}





/** Useful function to writes a message into the task page space
 * \param task_tcb_ptr TCB pointer of the task
 * \param msg_lenght Lenght of the message to be copied
 * \param msg_data Message data
 */
void write_local_msg_to_task(TCB * task_tcb_ptr, int msg_lenght, int * msg_data){

	Message * msg_ptr;

	msg_ptr = (Message*)((task_tcb_ptr->offset) | ((unsigned int)task_tcb_ptr->reg[3])); //reg[3] = address message

	msg_ptr->length = msg_lenght;

	for (int i=0; i<msg_ptr->length; i++)
		msg_ptr->msg[i] = msg_data[i];

	//Unlock the blocked task
	task_tcb_ptr->reg[0] = TRUE;

	//Set to ready to execute into scheduler
	task_tcb_ptr->scheduling_ptr->status = READY;
}

/** Syscall handler. It is called when a task calls a function defined into the api.h file
 * \param service Service of the syscall
 * \param arg0 Generic argument
 * \param arg1 Generic argument
 * \param arg2 Generic argument
 */
int Syscall(unsigned int service, unsigned int arg0, unsigned int arg1, unsigned int arg2) {

	Message *msg_read;
	Message *msg_write;
	PipeSlot *pipe_ptr;
	unsigned int aux_appID_task_ID;
	int consumer_task;
	int producer_task;
	int producer_PE;
	int consumer_PE;
	int appID, slotSR;
	int i,j, port_io;

	unsigned int auxSlot, PER_X_addr, PER_Y_addr;
	long int auxBT;

	schedule_after_syscall = 0;

	switch (service) {

		case DULL:

			send_dull_packet();

			return 1;

		case EXIT:

			schedule_after_syscall = 1;

			if (MemoryRead(DMNI_SEND_ACTIVE)){
				return 0;
			}
			#ifdef SESSION_MANAGER
			for (j = 0; j < MAX_SESSIONS; j++) // Termina as sessões abertas que tenham essa tarefa como consumidora
  			{
				if ((Sessions[j].consumer == current->id) && (Sessions[j].status != BLANK)){
					// puts("Terminando a Sessao:\n");
					Seek(MSG_REQUEST_CONTROL, 
					((0xFFC0 << 16) | (Sessions[j].pairIndex << 16) | ((Sessions[j].producer << 8) & 0xFF00) | (Sessions[j].consumer & 0xFF))
					,get_task_location(Sessions[j].producer)
					,((Sessions[j].consumer >> 8) & 0xFF));
					// printSessionStatus(Sessions, j);
					clearSession(Sessions, j);
				}
			}

			j = checkRunningSession(Sessions, current->id);
			if (j >= 0){
				// puts("Session ");
				// printSessionStatus(Sessions, j);
				// puts(" still running\n");
				return 0;
			}
			#endif
			puts("Task id: "); puts(itoa(current->id)); putsv(" terminated at ", MemoryRead(TICK_COUNTER));

			// adjust appID e taskID to 6 bits
			aux_appID_task_ID = ((current->id >> 4) & 0xF0) | (current->id & 0x0F);
			Seek(END_TASK_SERVICE, ((current->master_address<<16) | (get_net_address()&0xffff)), current->master_address, aux_appID_task_ID);
			if(current->master_address != cluster_master_address){
			 	Seek(END_TASK_OTHER_CLUSTER_SERVICE, ((cluster_master_address<<16) | (get_net_address()&0xffff)), cluster_master_address, aux_appID_task_ID);
			}

			clear_scheduling(current->scheduling_ptr);

			appID = current->id >> 8;

			//clear_app_tasks_locations(current->id);

			if (!is_another_task_running(appID)){

				//clear_app_tasks_locations(appID);
			}

			remove_last_msg_waiting_ack(current->id);

			//printSessionStatus(Sessions,current->id);

		return 1;

		case WRITEPIPE:
			tInit = MemoryRead(TICK_COUNTER);
			
			#ifdef SESSION_MANAGER
			timeoutMonitor(Sessions, tInit);
			#endif

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

 			//puts("current master: "); puts(itoh(current->master_address)); puts(" cluster master: ");  puts(itoh(cluster_master_address)); puts("\n");

			producer_task =  current->id;
			consumer_task = (int) arg1;

			appID = producer_task >> 8;
			consumer_task = (appID << 8) | consumer_task;

			//puts("WRITEPIPE - prod: "); puts(itoa(producer_task)); putsv(" consumer ", consumer_task);

			consumer_PE = get_task_location(consumer_task);

			//Test if the consumer task is not allocated
			if (consumer_PE == -1){
				//Task is blocked until its a TASK_RELEASE packet
				current->scheduling_ptr->status = BLOCKED;
				return 0;
			}

			/*Points the message in the task page. Address composition: offset + msg address*/
			msg_read = (Message *)((current->offset) | arg0);

			consumer_PE = remove_message_request(producer_task, consumer_task);

			if (consumer_PE == net_address){//message is local

				TCB * requesterTCB = searchTCB(consumer_task);

				write_local_msg_to_task(requesterTCB, msg_read->length, msg_read->msg);

				#if MIGRATION_ENABLED
					if (requesterTCB->proc_to_migrate != -1){
						puts("Migrou no write pipe\n");
						migrate_dynamic_memory(requesterTCB);

						schedule_after_syscall = 1;
					}
				#endif

			}else{//message is NOT local

				//########################### ADD PIPE #################################
				pipe_ptr = add_PIPE(producer_task, consumer_task, msg_read);
				//########################### ADD PIPE #################################
				
				if (pipe_ptr == 0){//there is no space in the pipe
					schedule_after_syscall = 1;
					return 0;
				}

				if (consumer_PE != -1){//message has been requested
					#ifdef SESSION_MANAGER
					// tInit = MemoryRead(TICK_COUNTER);
					session_puts("SYSCALL: Eviando delivery WRITEPIPE\n ");
					send_message_delivery_control(Sessions, producer_task, consumer_task, consumer_PE);
					// tEnd= MemoryRead(TICK_COUNTER);
					// session_time_puts("REQ SEND= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
					#endif
					pipe_ptr->status = WAITING_ACK;
					send_message_delivery(producer_task, consumer_task, consumer_PE, msg_read);
				} 
			}

		tEnd= MemoryRead(TICK_COUNTER);
		session_time_puts("WRITEPIPE= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
		return 1;

		case READPIPE:
			tInit = MemoryRead(TICK_COUNTER);
			#ifdef SESSION_MANAGER
			timeoutMonitor(Sessions, tInit);
			#endif

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

			consumer_task =  current->id;
			producer_task = (int) arg1;

			appID = consumer_task >> 8;
			producer_task = (appID << 8) | producer_task;

			//puts("READPIPE - prod: "); puts(itoa(producer_task)); putsv(" consumer ", consumer_task);

			producer_PE = get_task_location(producer_task);

			//Test if the producer task is not allocated
			if (producer_PE == -1){
				//Task is blocked until its a TASK_RELEASE packet
				current->scheduling_ptr->status = BLOCKED;
				return 0;
			}

			if (producer_PE == net_address){ //Local producer

				//Searches if the message is in PIPE (local producer)
				pipe_ptr = remove_PIPE(producer_task, consumer_task);

				if (pipe_ptr == 0){

					//Stores the request into the message request table (local producer)
					insert_message_request(producer_task, consumer_task, net_address);

				} else {

					//Message was found in pipe, writes to the consumer page address (local producer)

					msg_write = (Message*) arg0;

					msg_write = (Message*)((current->offset) | ((unsigned int)msg_write));

					msg_write->length = pipe_ptr->message.length;

					for (int i = 0; i<msg_write->length; i++) {
						msg_write->msg[i] = pipe_ptr->message.msg[i];
					}

					return 1;
				}

			} else { //Remote producer : Sends the message request (remote producer)
				#ifdef SESSION_MANAGER
				send_message_request_control(Sessions, producer_task, consumer_task, producer_PE);
				#endif
				// session_puts("Req Via  READPIPE");
				// session_puts("producer:");session_puts(itoh(producer_task)); session_puts("\n");
    			// session_puts("consumer:");session_puts(itoh(consumer_task)); session_puts("\n");
				send_message_request(producer_task, consumer_task, producer_PE, net_address);
			}

			//Sets task as waiting blocking its execution, it will execute again when the message is produced by a WRITEPIPE or incoming message Delivery
			current->scheduling_ptr->status = WAITING;

			schedule_after_syscall = 1;
			tEnd= MemoryRead(TICK_COUNTER);
			session_time_puts("READPIPE= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
			return 0;

		case GETTICK:

			return MemoryRead(TICK_COUNTER);

		break;

		case ECHO:

			puts(itoa(MemoryRead(TICK_COUNTER))); puts("_");
			puts(itoa(net_address>>8));puts("x");puts(itoa(net_address&0xFF)); puts("_");
			puts(itoa(current->id >> 8)); puts("_");
			puts(itoa(current->id & 0xFF)); puts("_");
			puts((char *)((current->offset) | (unsigned int) arg0));
			puts("\n");

		break;
		case REALTIME:

			if (MemoryRead(DMNI_SEND_ACTIVE)){
				return 0;
			}

			//putsv("\nReal-time to task: ", current->id);

			real_time_task(current->scheduling_ptr, arg0, arg1, arg2);

			//send_task_real_time_change(current);

			schedule_after_syscall = 1;

			return 1;

		break;

		case IOWRITEPIPE:

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

			producer_task =  current->id;

			// puts("IO - WRITEPIPE - prod: "); puts(itoa(producer_task)); putsv(" consumer ", arg1);

			/*Points the message in the task page. Address composition: offset + msg address*/
			msg_read = (Message *)((current->offset) | arg0);

			//########################### ADD PIPE #################################
			//pipe_ptr = add_PIPE(producer_task, arg1, msg_read);
			//########################### ADD PIPE #################################
			//if (pipe_ptr == 0){//there is no space in the pipe
			//	puts("pipe cheio...");
			//	schedule_after_syscall = 1;
			//	return 0;
			//}
			#ifdef GRAY_AREA
			for(i = 0; i < IO_NUMBER; i++){
				if(io_info[i].peripheral_id == arg1){
					PER_X_addr = io_info[i].default_address_x ;
          			PER_Y_addr = io_info[i].default_address_y;
					auxSlot = SearchSourceRoutingDestination((PER_X_addr << 8) | PER_Y_addr);
					if (auxSlot == -1){
						puts("Configurando novo IO:");puts(itoa(arg1)); puts("\n");
						auxBT = pathToIO(arg1);
						puts("--path: ");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting((PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = (PER_X_addr << 8) | PER_Y_addr;
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = adjust_backtrack_IO(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF,
							(PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						// auxBT = pathFromIO(auxBT);
						auxBT = IOtoAP(arg1);
						puts("-- enviando caminho:");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting(get_net_address());
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = get_net_address();
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = ProcessTurns(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF);
						send_peripheral_SR_path(slotSR, arg1, current->secure);
						puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						ClearSlotSourceRouting(get_net_address());
					}
				break;
				}
			}
			#endif
			send_message_io(producer_task, arg1, msg_read, current->secure);

			current->scheduling_ptr->status = WAITING;

			schedule_after_syscall = 1;
			// puts("IO WRITEPIPE END: ");


		return 1;

		case IOREADPIPE:
			

			if ( MemoryRead(DMNI_SEND_ACTIVE) ){
				return 0;
			}

			consumer_task =  current->id;
			//producer_task = (int) arg1;
			#ifdef GRAY_AREA
			for(i = 0; i < IO_NUMBER; i++){
				if(io_info[i].peripheral_id == arg1){
					PER_X_addr = io_info[i].default_address_x ;
          			PER_Y_addr = io_info[i].default_address_y;
					auxSlot = SearchSourceRoutingDestination((PER_X_addr << 8) | PER_Y_addr);
					if (auxSlot == -1){
						puts("Configurando novo IO:");puts(itoa(arg1)); puts("\n");
						auxBT = pathToIO(arg1);
						puts("--path: ");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting((PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = (PER_X_addr << 8) | PER_Y_addr;
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = adjust_backtrack_IO(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF,
							(PER_X_addr << 8) | PER_Y_addr);
						// puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						// auxBT = pathFromIO(auxBT);
						auxBT = IOtoAP(arg1);
						puts("-- enviando caminho:");puts(itoh(auxBT)); puts("\n");
						slotSR = GetFreeSlotSourceRouting(get_net_address());
						// puts("--slot: ");puts(itoa(slotSR)); puts("\n");
						SR_Table[slotSR].target = get_net_address();
    					SR_Table[slotSR].tableSlotStatus = SR_USADO;
						slotSR = ProcessTurns(
							auxBT & 0xffffFFFF,
  							auxBT >> 32 & 0xffffFFFF,
  							auxBT >> 64 & 0xffffFFFF);
						send_peripheral_SR_path(slotSR, arg1, current->secure);
						puts("--slot_adjust: ");puts(itoa(slotSR)); puts("\n");
						ClearSlotSourceRouting(get_net_address());
					}
				break;
				}
			}
			#endif
			send_io_request(arg1, consumer_task, net_address, current->secure);


			//Sets task as waiting blocking its execution, it will execute again when the message is produced by a WRITEPIPE or incoming MSG_DELIVERY
			current->scheduling_ptr->status = WAITING;

			schedule_after_syscall = 1;

			return 0;

			break;

			/*
			pipe_ptr = remove_PIPE(producer_task, consumer_task);

			if (pipe_ptr == 0){

				if (producer_PE == net_address){

					insert_message_request(producer_task, consumer_task, net_address);

				} else {

					send_message_request(producer_task, consumer_task, producer_PE, net_address);
				}

				current->scheduling_ptr->status = WAITING;

				schedule_after_syscall = 1;

				return 0;
			}

			msg_write = (Message*) arg0;

			msg_write = (Message*)((current->offset) | ((unsigned int)msg_write));

			msg_write->length = pipe_ptr->message.length;

			for (int i = 0; i<msg_write->length; i++) {
				msg_write->msg[i] = pipe_ptr->message.msg[i];
			}

			return 1;
		*/		

	}

	return 0;
}


int Aplly_LSFR(lfsr_data_t polynom_d, lfsr_data_t init_value_d,  lfsr_data_t polynom_c, lfsr_data_t init_value_c)
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
int handle_packet(volatile ServiceHeader * p) {
    char key[16] = {0,1,2,3,4,5,6,7,8,9,0xa,0xb,0xc,0xd,0xe,0xf};
    //char value[8] = {0x65,0x77,0x5f,0xa9,0x50,0x2f,0x08,0x33};
    char rnd[24], Ke[24];
    uint64_t calculated_hash, received_hash, *ptr_rcv, Km;
    int  lo, hi;

	int need_scheduling, code_lenght, app_ID, task_loc, new_ptr;
	unsigned int app_tasks_location[MAX_TASKS_APP];
	PipeSlot * slot_ptr;
	Message * msg_ptr;
	int arrivalTime=0;
	TCB * tcb_ptr = 0;

	need_scheduling = 0;


		//puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2])); puts("\n");
		//puts("size:");puts(itoh(p->payload_size)); puts("\n");
		// puts("DATA - service:");puts(itoh(p->service)); puts("\n");
		//puts("producer:");puts(itoh(p->producer_task)); puts("\n");
		//puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
		//puts("source:");puts(itoh(p->source_PE)); puts("\n");
	

	switch (p->service) {

	case MESSAGE_REQUEST: //MR_HANDLER
		tInit = MemoryRead(TICK_COUNTER);
		
		#ifdef SESSION_MANAGER
		// puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2])); puts("\n");
		// puts("size:");puts(itoh(p->payload_size)); puts("\n");
		// puts("service:");puts(itoh(p->service)); puts("\n");
		// puts("producer:");puts(itoh(p->producer_task)); puts("\n");
		// puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
		// puts("source:");puts(itoh(p->source_PE)); puts("\n");
	
		// printSessions(Sessions);
		session_puts("DATA: Chegou REQUEST de "); session_puts(itoh(p->producer_task)); session_puts("\n");
		auxIndex = checkSession(Sessions, p->producer_task, p->consumer_task);
		if (auxIndex < 0){
			// session_puts("DATA: REQUEST - Nao achou a Sessao, salvando Service \n");
			auxSlot = getServiceSlot();
			if (auxSlot < 0)
				session_puts("DATA: Nao tem lugar na ServiceQueue");
			copyService(p, auxSlot);
		}else{
			auxSession = &Sessions[auxIndex];
			if (auxSession->status == WAITING_ANY )
			{
				session_puts("DATA: -->> REQUEST esperando autorizar\n");			
				// auxSession->time = arrivalTime;
				auxSession->status = WAITING_CONTROL;
				auxSlot = getServiceSlot();
				copyService(p, auxSlot);
				auxSession->header =auxSlot;
				// puts("**MR NoC ANY:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");

			}
			else if (auxSession->status == WAITING_DATA || auxSession->status == SUSPICIOUS)
			{
				// puts("**MR NoC DATA:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");
				// puts("**MR Check:");puts(itoa(p->arrival_time - auxSession->time));puts("\n");
			
				// if (tInit - auxSession->time  > LAT_THRESHOLD){
				//		puts("WARNING REQ: XXXXX suspicious packet latency XXXXX \n");
				// }
				auxSession->time = 0;

				session_puts("DATA: -->> REQUEST - Achou Sessão\n");

				slot_ptr = remove_PIPE(p->producer_task, p->consumer_task);

				//Test if there is no message in PIPE
				if (slot_ptr == 0){

					//Gets the location of the producer task
					task_loc = get_task_location(p->producer_task);

					//This if check if the task was migrated
					if ( task_loc != -1 && task_loc != net_address && p->requesting_processor == p->source_PE){

						//MESSAGE_REQUEST by pass
						session_puts("DATA: DANGER - PASS\n");
						send_message_request(p->producer_task, p->consumer_task, task_loc, p->requesting_processor);

						if ( search_PIPE_producer(p->producer_task) == 0){

							send_update_task_location(p->requesting_processor, p->producer_task, task_loc);
						}

					} else {

						insert_message_request(p->producer_task, p->consumer_task, p->requesting_processor);
					}

				} else if (p->requesting_processor != net_address){
					// session_puts("DATA: Enviando DELIVERY por MR\n");
					send_message_delivery_control(Sessions, p->producer_task, p->consumer_task, p->requesting_processor);
					send_message_delivery(p->producer_task, p->consumer_task, p->requesting_processor, &slot_ptr->message);
					
				//This else is executed when this slave receved a own MESSAGE_REQUEST due a by pass
				} else {
					tcb_ptr = searchTCB(p->consumer_task);
					write_local_msg_to_task(tcb_ptr, slot_ptr->message.length, slot_ptr->message.msg);
				}
				auxSession->status = WAITING_ANY;
				auxSession->header = -1;
			}
		}
		//MemoryWrite(KERNEL_DEBUG_STATE, 0);
		#else
		//Remove msg from PIPE, if there is no message, them slot_ptr will be 0
		//puts("\n\nMESSAGE_REQUEST Received \nproc:");puts(itoh(p->source_PE));puts("\n");
		//puts("consumer_task:");puts(itoh( p->consumer_task));puts("\n");
		//puts("p->producer_task:");puts(itoh(p->producer_task));puts("\n");

		slot_ptr = remove_PIPE(p->producer_task, p->consumer_task);

		//Test if there is no message in PIPE
		if (slot_ptr == 0){

			//Gets the location of the producer task
			task_loc = get_task_location(p->producer_task);

			//This if check if the task was migrated
			if ( task_loc != -1 && task_loc != net_address && p->requesting_processor == p->source_PE){

				//MESSAGE_REQUEST by pass
				session_puts("DATA: DANGER - PASS\n");
				send_message_request(p->producer_task, p->consumer_task, task_loc, p->requesting_processor);

				if ( search_PIPE_producer(p->producer_task) == 0){

					send_update_task_location(p->requesting_processor, p->producer_task, task_loc);
				}

			} else {

				insert_message_request(p->producer_task, p->consumer_task, p->requesting_processor);

			}

		} else if (p->requesting_processor != net_address){
			send_message_delivery(p->producer_task, p->consumer_task, p->requesting_processor, &slot_ptr->message);
			//puts("MANDOU O CONTROL Req\n");
			// puts("target:");puts(itoh(p->requesting_processor)); puts("\n");
			// puts("ID+Source:");puts(itoh((MemoryRead(TICK_COUNTER)<<16) | (get_net_address()& 0xFFFF))); puts("\n"); 
		//This else is executed when this slave receved a own MESSAGE_REQUEST due a by pass

		} else {

			tcb_ptr = searchTCB(p->consumer_task);

			write_local_msg_to_task(tcb_ptr, slot_ptr->message.length, slot_ptr->message.msg);

		}
		//MemoryWrite(KERNEL_DEBUG_STATE, 0);
		#endif
	tEnd = MemoryRead(TICK_COUNTER);
	session_time_puts("DATA REQ= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
	break;

	case IO_OPEN_WRAPPER:
		//adjust_wrapper(p->io_service, p->io_port);

		puts("-------->> Chegou OPEN WRAPPER\n");
		//puts("io_port: ");puts(itoh(p->io_port)); puts("\n");
		//puts("io_service: ");puts(itoh(p->io_service)); puts("\n");
	break;


	case  IO_ACK:
		puts("-------->> Chegou IO ACK\n");
		// puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2])); puts("\n");
		// puts("size:");puts(itoh(p->payload_size)); puts("\n");
		// puts("service:");puts(itoh(p->service)); puts("\n");
		// puts("producer:");puts(itoh(p->producer_task)); puts("\n");
		// puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
		// puts("source:");puts(itoh(p->source_PE)); puts("\n");
		// puts("length:");puts(itoh(p->msg_lenght)); puts("\n");

		tcb_ptr = searchTCB(p->producer_task);
		//puts("tcb_ptr:");puts(itoh(tcb_ptr)); puts("\n");

		// puts("Status scheduler antes:");puts(itoh(tcb_ptr->scheduling_ptr->status)); puts("\n");
		if(tcb_ptr->scheduling_ptr->status != BLOCKED)
			tcb_ptr->scheduling_ptr->status = READY;
		// puts("Status scheduler depois:");puts(itoh(tcb_ptr->scheduling_ptr->status)); puts("\n");

		#if MIGRATION_ENABLED
			if (tcb_ptr->proc_to_migrate != -1){
				migrate_dynamic_memory(tcb_ptr);
				need_scheduling = 1;

			} else
		#endif

		if (current == &idle_tcb){
			need_scheduling = 1;
		}			
		
	break;


	case  IO_DELIVERY:
		puts("-------->> Chegou IO DELIVERY\n");
	case  MESSAGE_DELIVERY: //MD_HANDLER
		tInit = MemoryRead(TICK_COUNTER);
	#ifdef SESSION_MANAGER 
		// arrivalTime = auxTime;
		// puts("\n");// puts("DATA: Chegou DELIVERY de "); puts(itoh(p->producer_task)); puts("\n");
		auxIndex = checkSession(Sessions, p->producer_task, p->consumer_task);
		if (auxIndex < 0)
			session_puts("DATA: Nao achou a Sessao\n");

		// puts("consumer_task:");puts(itoh( p->consumer_task));puts("\n");
		// puts("producer_task:");puts(itoh(p->producer_task));puts("\n");

		auxSession = &Sessions[auxIndex];
		// session_puts("DATA: status ="); session_puts(itoa(auxSession->status));
		if (auxSession->status == WAITING_ANY){
				
			session_puts("DATA: -->> Mensagem esperando validação\n");
					
			// auxSession->time = arrivalTime;
			auxSession->status = WAITING_CONTROL;
			auxSession->msg = getMessageSlot();

			//Escreve na fila de Mensagens
			auxSession->msg->length = p->msg_lenght;
			msg_ptr = auxSession->msg;

			// puts("**MD NoC ANY:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");
			auxSession->time = 0;
			
		}else if (auxSession->status == WAITING_DATA || auxSession->status == SUSPICIOUS){

			// if (tInit - auxSession->time  > LAT_THRESHOLD){
			// 	puts("WARNING DEL: XXXXX suspicious packet latency XXXXX \n");
			// }
			// puts("---lat DATA:");puts(itoa( tInit - p->timestamp));puts("\n");
			// puts("---lat HW:");puts(itoa( p->arrival_time));puts("\n");
			// puts("**MD NoC DATA:");puts(itoa(p->arrival_time - p->timestamp));puts("\n");
			// puts("**MD Check:");puts(itoa(p->arrival_time - auxSession->time));puts("\n");
			
			auxSession->time = 0;
			//calcula o avg baseado no p->arrival_time
			//Escreve direto na TAREFA
			session_puts("DATA: -->> Mensagem validada\n");
			tcb_ptr = searchTCB(p->consumer_task);
			msg_ptr = (Message *)(tcb_ptr->offset | tcb_ptr->reg[3]);
			msg_ptr->length = p->msg_lenght;

		}else{
			session_puts("DATA: status n identificado \n");
		}
		
		if(DMNI_read_data((unsigned int)msg_ptr->msg, msg_ptr->length) == -1){
			// received a packet with incomplete payload; discard it
			need_scheduling = 0;
			MemoryWrite(DMNI_TIMEOUT_SIGNAL,0);
			puts("payload incompleto...\n");
		}
		else if (auxSession->status == WAITING_DATA || auxSession->status == SUSPICIOUS){		
			// session_puts("DATA: -------->> Mensagem Autorizada\n");			
			//clearSession(Sessions, auxIndex);
			//puts("payload Completo...\n");
			tcb_ptr->reg[0] = 1;

			auxSession->status = WAITING_ANY;
			// auxSession->requested += 1;

			if(tcb_ptr->scheduling_ptr->status != BLOCKED)
				tcb_ptr->scheduling_ptr->status = READY;

			if(p->service != IO_DELIVERY){
					remove_msg_request(p->source_PE, p->consumer_task, p->producer_task);
			}

			#if MIGRATION_ENABLED
				if (tcb_ptr->proc_to_migrate != -1){
					migrate_dynamic_memory(tcb_ptr);
					need_scheduling = 1;

				} else
			#endif

			if (current == &idle_tcb){
				need_scheduling = 1;
			}			
		}
		
	#else
		tcb_ptr = searchTCB(p->consumer_task);
		//puts("tcb_ptr:");puts(itoh(tcb_ptr)); puts("\n");

		msg_ptr = (Message *)(tcb_ptr->offset | tcb_ptr->reg[3]);

		msg_ptr->length = p->msg_lenght;


		//puts("\n\nMESSAGE_DELIVERY Received \nproc:");puts(itoh(p->source_PE));puts("\n");
		//puts("consumer_task:");puts(itoh( p->consumer_task));puts("\n");
		//puts("p->producer_task:");puts(itoh(p->producer_task));puts("\n");

		
		if(DMNI_read_data((unsigned int)msg_ptr->msg, msg_ptr->length) == -1){
			//received a packet with incomplete payload; discard it
			need_scheduling = 0;
			MemoryWrite(DMNI_TIMEOUT_SIGNAL,0);
			//puts("payload incompleto...\n");
		}
		else{
			//puts("payload Completo...\n");
			tcb_ptr->reg[0] = 1;

			if(tcb_ptr->scheduling_ptr->status != BLOCKED)
				tcb_ptr->scheduling_ptr->status = READY;

			if(p->service != IO_DELIVERY){
					remove_msg_request(p->source_PE, p->consumer_task, p->producer_task);
			}

			// session_puts("arrival= ");session_puts(itoa(arrivalTime));//session_puts("\n");
			// session_puts(" depature= ");session_puts(itoa(p->timestamp));session_puts("\n");	

			#if MIGRATION_ENABLED
				if (tcb_ptr->proc_to_migrate != -1){
					migrate_dynamic_memory(tcb_ptr);
					need_scheduling = 1;

				} else
			#endif

			if (current == &idle_tcb){
				need_scheduling = 1;
			}			
		}

	#endif

	tEnd = MemoryRead(TICK_COUNTER);
	session_time_puts("DATA DEL= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
	break;

	case TASK_ALLOCATION:
		new_ptr = 0;

		tcb_ptr = searchTCB(p->task_ID);

		puts("[ALLOCATION] searching TCB:"); puts(itoa(p->task_ID));puts("\n");
		if(tcb_ptr == 0){  //task allocation before task_release

			tcb_ptr = search_free_TCB();

			tcb_ptr->id = p->task_ID;
			
			tcb_ptr->scheduling_ptr->status = BLOCKED;  

			new_ptr = 1;
		}
		// common code independent of function order: task allocation <---> task_release
		tcb_ptr->pc = 0;

		puts("Task id: "); puts(itoa(tcb_ptr->id)); putsv(" allocated at ", MemoryRead(TICK_COUNTER));

		code_lenght = p->code_size;

		tcb_ptr->text_lenght = code_lenght;

		tcb_ptr->master_address = p->master_ID;
		puts("MasterID "); puts(itoa(tcb_ptr->master_address)); puts("\n");

		tcb_ptr->proc_to_migrate = -1;

		tcb_ptr->scheduling_ptr->remaining_exec_time = MAX_TIME_SLICE;

		DMNI_read_data(tcb_ptr->offset, code_lenght);

		//printTaskInformations(tcb_ptr, 1, 0, 0);

//************************************
		/*if(tcb_ptr->secure == 1){
		

			code_lenght = code_lenght - 2;

			//puts("size:");puts(itoa((code_lenght*4))); puts("\n");
			//puts("addr:");puts(itoh(tcb_ptr->offset)); puts("\n");

			putsv("Init MAC - ", MemoryRead(TICK_COUNTER)); 
			calculated_hash = siphash24((void *)tcb_ptr->offset, code_lenght*4, key);

			

			ptr_rcv = (uint64_t *)(tcb_ptr->offset + (code_lenght*4));
			received_hash =  *ptr_rcv;

			//hash = siphash24(value, 8, key);

	    	hi = calculated_hash >> 32;
	    	lo = calculated_hash & 0xFFFFFFFF;

			//puts("Calculated hash hi:"); puts(itoh(hi)); puts("\n");
			//puts("Calculated hash lo:"); puts(itoh(lo)); puts("\n");

	    	hi = received_hash >> 32;
	    	lo = received_hash & 0xFFFFFFFF;

			//puts("  Received hash hi:"); puts(itoh(hi)); puts("\n");
			//puts("  Received hash lo:"); puts(itoh(lo)); puts("\n");		
			//puts("Address MAC: "); puts(itoh(ptr_rcv)); puts("\n");

			//if (calculated_hash == received_hash){
			if (received_hash == received_hash){
				tcb_ptr->MAC_status = 1;
				putsv("MAC check: Ok - ", MemoryRead(TICK_COUNTER));
			}
			else{
				tcb_ptr->MAC_status = 0;
				puts("ERROR: Calculated MAC is not equal received MAC"); puts("\n");
			}

		}*/
		tcb_ptr->MAC_status = 1;
//************************************		

		if (current == &idle_tcb){
			need_scheduling = 1;
		}

		if(new_ptr == 0){  //task allocation after task_release

			tcb_ptr->text_lenght = code_lenght- tcb_ptr->data_lenght;  // aqui

			if(tcb_ptr->secure != 1)						// aqui
				tcb_ptr->scheduling_ptr->status = READY;
			else
				tcb_ptr->scheduling_ptr->status = BLOCKED;

			send_task_allocated(tcb_ptr);
			puts("[AFTER]Task id: "); puts(itoa(tcb_ptr->id)); puts("\n");
			puts("[AFTER]MasterID "); puts(itoa(tcb_ptr->master_address)); puts("\n");

			putsv("Send Task Allocated (TA): ", tcb_ptr->id);
		}

		break;

	case TASK_RELEASE:
		new_ptr = 0;

		tcb_ptr = searchTCB(p->task_ID);

		if(tcb_ptr == 0){  //task_release before task_allocation 

			tcb_ptr = search_free_TCB();

			tcb_ptr->id = p->task_ID;

			tcb_ptr->scheduling_ptr->status = BLOCKED;

			new_ptr = 1;
		}
		puts("Task id: "); puts(itoa(tcb_ptr->id)); putsv(" released at ", MemoryRead(TICK_COUNTER));

		app_ID = p->task_ID >> 8;

		tcb_ptr->data_lenght = p->data_size;

		tcb_ptr->bss_lenght = p->bss_size;

		if(p->secure)
			tcb_ptr->secure = 1;
		else
			tcb_ptr->secure = 0;
		//tcb_ptr->secure = p->secure;

		DMNI_read_data( (unsigned int) app_tasks_location, p->app_task_number);

		if (get_task_location(tcb_ptr->id) == -1){
			for (int i = 0; i < p->app_task_number; i++){
				add_task_location(app_ID << 8 | i, app_tasks_location[i]);
			}
		}			
		
		if (current == &idle_tcb){   
			need_scheduling = 1;
		}
		
		if(new_ptr == 0){

			tcb_ptr->text_lenght = tcb_ptr->text_lenght - tcb_ptr->data_lenght;  

			if(tcb_ptr->secure != 1)						
				tcb_ptr->scheduling_ptr->status = READY;
			else
				tcb_ptr->scheduling_ptr->status = BLOCKED;

			send_task_allocated(tcb_ptr);

			putsv("Send Task Allocated (TR): ", tcb_ptr->id);
		}
		break;


	case TASKS_LOCATION:
		new_ptr = 0;

		tcb_ptr = searchTCB(p->task_ID);

		//puts("Task id: "); puts(itoa(tcb_ptr->id)); putsv(" LOCATIONS at ", MemoryRead(TICK_COUNTER));

		app_ID = p->task_ID >> 8;

		DMNI_read_data( (unsigned int) app_tasks_location, p->app_task_number);

		//if (get_task_location(tcb_ptr->id) == -1){
			for (int i = 0; i < p->app_task_number; i++){
				migration_puts("Location "); migration_puts(itoa(i)); 
				migration_puts(": "); migration_puts(itoh(app_tasks_location[i])); migration_puts("\n");
				change_task_location(app_ID << 8 | i, app_tasks_location[i]);
				update_msg_request_migration(i, app_tasks_location[i]);
			}
		//}			

		break;		

	case UPDATE_TASK_LOCATION:

	//	puts("UPDATE_TASK_LOCATION");  puts("\n");
	//	puts("p->task_ID "); puts(itoa(p->task_ID & 0xFF)); puts("\n");
	//	puts("app ID >> "); puts(itoa(p->task_ID >> 8)); puts("\n"); 
		if (is_another_task_running(p->task_ID >> 8)){ // FOCHI ADD 01/06/2017 orientações do Ruaro.
	//				puts("entrou");  puts("\n");
			update_msg_request_table((p->task_ID & 0xFF), p->allocated_processor);//			FOCHI ADD 02/10/2017 orientações do Caimi.
			remove_task_location(p->task_ID);
			add_task_location(p->task_ID, p->allocated_processor);
		}

		break;

	case INITIALIZE_SLAVE:

		cluster_master_address = p->source_PE;

		putsv("Slave initialized by cluster address: ", cluster_master_address);

		break;

	case RND_VALUE:

		puts("RND VALUE MESSAGE RECEIVED");  puts("\n");

		DMNI_read_data(rnd, 6);

		Km = siphash24((void *) rnd , 24, key);
		
		puts("Km: ");  puts(itoh(Km));  puts("\n");

		break;


	case KE_VALUE:

		puts("Cripted KE VALUE MESSAGE received");  puts("\n");
        // putsv(" time - ", MemoryRead(TICK_COUNTER));

		DMNI_read_data(Ke, 6);

		//Aplly_LSFR(received_hash, 0X12, received_hash, 0xA1);

		putsv(" KE decripted - ", MemoryRead(TICK_COUNTER));
		
		break;



	#if MIGRATION_ENABLED
		case TASK_MIGRATION:
		case MIGRATION_CODE:
		case MIGRATION_TCB:
		case MIGRATION_TASK_LOCATION:
		case MIGRATION_PRODUCER_MSG_REQUEST:
		case MIGRATION_CONSUMER_MSG_REQUEST:
		case MIGRATION_STACK:
		case MIGRATION_DATA_BSS:
		case MIGRATION_PIPE:

			//cluster_master_address = get_master_address(get_net_address()); //fochi

			need_scheduling = handle_migration(p, cluster_master_address);

		break;
	#endif

	default:
			puts("ERROR: service unknown ");puts(itoh(p->service)); puts("\n");
			putsv("Time: ", MemoryRead(TICK_COUNTER));
			puts("header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1])); puts("\n");
			puts("size:");puts(itoh(p->payload_size)); puts("\n");
			puts("service:");puts(itoh(p->service)); puts("\n");
			puts("producer:");puts(itoh(p->producer_task)); puts("\n");
			puts("consumer:");puts(itoh(p->consumer_task)); puts("\n");
			puts("source:");puts(itoh(p->source_PE)); puts("\n");
		break;
	}

	return need_scheduling;
}

/** Generic task scheduler call
 */
void Scheduler() {

	Scheduling * scheduled;
	unsigned int scheduler_call_time;

	scheduler_call_time = MemoryRead(TICK_COUNTER);
	MemoryWrite(SCHEDULING_REPORT, SCHEDULER);

	#if MIGRATION_ENABLED
		if (current->proc_to_migrate != -1 && current->scheduling_ptr->status == RUNNING){
			puts("Chamou scheduler\n");
			migrate_dynamic_memory(current);
		}
	#endif
	
	// print_task();

	scheduled = LST(scheduler_call_time);

	if (scheduled){

		//This cast is an approach to reduce the scheduler call overhead
		current = (TCB *) scheduled->tcb_ptr;

		MemoryWrite(SCHEDULING_REPORT, current->id);

	} else {

		//puts("Idle Task Running\n");
		current = &idle_tcb;	// schedules the idle task

		last_idle_time = MemoryRead(TICK_COUNTER);

        MemoryWrite(SCHEDULING_REPORT, IDLE);
	}

	MemoryWrite(TIME_SLICE, get_time_slice() );

	OS_InterruptMaskSet(IRQ_SCHEDULER);

}


int SeekInterruptHandler(){
	unsigned int target, source, service, payload;
	static unsigned int seek_unr_count = 0;
	unsigned int backtrack, backtrack1, backtrack2;
	int aux = 0;
	extern TCB tcbs[MAX_LOCAL_TASKS];
	extern int wrapper_value;
	unsigned int my_X_addr, my_Y_addr;
	unsigned int RH_X_addr, RH_Y_addr;
	unsigned int LL_X_addr, LL_Y_addr;
	unsigned int right_high_corner, left_low_corner;
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
	int t1, t2, t3;
	// For Sessions
	unsigned int auxProducer, auxConsumer, auxCode, auxNumber;
	Message * msg_ptr;
	TCB * tcb_ptr = 0;
	PipeSlot* tmpSlot;
	ServiceHeader* auxService = 0;
	int task_loc;
	static prevTUS = -1;
	
	switch(service){
		case TARGET_UNREACHABLE_SERVICE:
			puts("Received TARGET_UNREACHABLE_SERVICE\n");
			puts("source: "); puts(itoh(source)); puts("\n");
			puts("target: "); puts(itoh(target)); puts("\n");
			puts("payload: "); puts(itoh(payload)); puts("\n");
			//perform clear
			//Seek(CLEAR_SERVICE, source, target, 0);
			//global variable for finding seek
			if ((payload == prevTUS)){ //TUS agora vem com o timestamp no payload para evitar reverberação
				puts("----repetido\n");
				break;
			}
			puts("Source: "); puts(itoh(source)); puts("\n");
			slot_seek = GetFreeSlotSourceRouting(source>>16);
			
			if(slot_seek != -1){
				//seek_puts("slot: "); seek_puts(itoa(slot_seek)); seek_puts("\n");
				SR_Table[slot_seek].target = source>>16;
				SR_Table[slot_seek].tableSlotStatus = SR_USADO;
			}	
			if(seek_unr_count == (source>>16)){
				seek_unr_count++;
			}
			aux =  search_Target(source>>16);

			#ifndef GRAY_AREA
			if(((aux == search_Service(IO_REQUEST)) || (aux == search_Service(IO_DELIVERY))) && (aux != -1)){
				send_wrapper_close_back__open_forward(aux);
			}
			#endif

			Seek(SEARCHPATH_SERVICE, ((seek_unr_count<<16) | (get_net_address()&0xffff)), source>>16, 0);
			seek_unr_count++;
			prevTUS = payload;
		break;

		case BACKTRACK_SERVICE:
			puts("Received BACKTRACK_SERVICE\n");
			// puts("backtrack: "); puts(itoh(backtrack)); puts("\n");
			// puts("backtrack1: "); puts(itoh(backtrack1)); puts("\n");
			// puts("backtrack2: "); puts(itoh(backtrack2)); puts("\n");

			
			slot_seek = ProcessTurns(backtrack, backtrack1, backtrack2);
			// seek_puts("slot: "); seek_puts(itoa(slot_seek)); seek_puts("\n");
			Seek(CLEAR_SERVICE, ((SR_Table[slot_seek].target<<16) | (get_net_address()&0xffff)), 0,0);
			aux = resend_messages(SR_Table[slot_seek].target);
			// puts("resend 1:"); puts(itoa(aux)); puts("\n");
			aux = aux + resend_msg_request(SR_Table[slot_seek].target);
			// puts("resend 2:"); puts(itoa(aux)); puts("\n");


			if(aux == 0){
				aux =  search_Target(source>>16);
				#ifndef GRAY_AREA
				if(((aux == search_Service(IO_REQUEST)) || (aux == search_Service(IO_DELIVERY))) && (aux != -1)){
					send_wrapper_close_forward(aux);
				}	
				#endif
				// puts("target: "); puts(itoh(SR_Table[slot_seek].target)); puts("\n");			
            	aux = resend_control_message(backtrack, backtrack1, backtrack2, SR_Table[slot_seek].target);
        	}

			if(aux == 0){
				int peripheral_id;
				peripheral_id = find_io_peripheral(get_net_address());
				if(peripheral_id){
					puts(" SR Peripheral\n"); 
					send_peripheral_SR_path(slot_seek, peripheral_id, target);
				}
			}
		break;

		case SET_SECURE_ZONE_SERVICE:
			// seek_puts("Received SET_SECURE_ZONE"); seek_puts("\n");
			Set_Secure_Zone(target, payload, source); // verificação interna
		break;

		case SET_AP_SERVICE:
			puts("Received SET_AP_SERVICE"); seek_puts("\n");
			MemoryWrite(KAP_REGISTER, 0x021);
			puts("--source(caller): "); puts(itoh(source)); puts("\n");
			puts("--target(AP addr): "); puts(itoh(target)); puts("\n");
			puts("--payload(port): "); puts(itoh(payload)); puts("\n");

			MemoryWrite(AP_MASK, ~(3 << (payload*2))); // Mascarar as duas portas, 01 - E, 23 - W, 45-N, 67-S 

		break;

		#ifdef SESSION_MANAGER
		case MSG_DELIVERY_CONTROL: //MDC_HANDLER
			tInit = MemoryRead(TICK_COUNTER);
			session_puts("CONTROL: Received MSG_DELIVERY_CONTROL\n"); 
			
			auxNumber = (source & 0xFFFF); // Number of received MESSAGE_DELIVERY
			auxCode = ((source >> 16) & 0xFFC0); // 10-bit Code
			auxIndex = (source >> 16) & 0x3F;    // 6-bit Index

			if (Sessions[auxIndex].pairIndex == 0x3F){  // The first MDControl is the Session_ACK
				Sessions[auxIndex].pairIndex = payload; // Confirming the index of the sender to do the direct indexing
			}

			
			if(auxIndex != 0x3F)
			{
				auxSession = &Sessions[auxIndex];   // Get the Session pointer (much used)
				auxConsumer = auxSession->consumer; 
				auxProducer = auxSession->producer;

				if (auxSession->sent == auxNumber){ // Checks if it is a repeated MDC accidentally entering the kernel
					session_puts("ERROR(MDC): Repeated MDC\n");
				}
				else if (auxSession->status == WAITING_CONTROL) // If the Data arrived first, the status will be WAITING_CONTROL
				{
					msg_ptr = auxSession->msg;
					if (msg_ptr == -1)
						puts("CONTROL: Nao achou a sessão criada pelo MD\n"); 

					tcb_ptr = searchTCB(auxConsumer);

					if (tcb_ptr == 0)
						session_puts("CONTROL: Nao achou a tarefa nas TCB\n"); 

					write_local_msg_to_task(tcb_ptr, msg_ptr->length, msg_ptr->msg);

					if (remove_msg_request(get_task_location(auxProducer), auxConsumer, auxProducer) == 0)
						session_puts("CONTROL: Request não encontrado:\n");
					
					if (auxSession->requested != (source & 0xFFFF) +1)
						session_puts("ERRO(antes): numeros recebidos e enviados errados\n");

					auxSession->sent += 1;
					auxSession->status = WAITING_ANY;
					msg_ptr->length = -1 ; //clearMessageSlot(msg_ptr);

				}else if (auxSession->status == WAITING_ANY){ // If this is first, computate the sent values and set to WAITING_DATA, MD will handle the rest
					auxSession->sent += 1;
					auxSession->status = WAITING_DATA;
					auxSession->time = tInit;
				}
			}else{
				puts("CONTROL: ERRO MDR nao achou a Sessao!\n"); 
			}
		tEnd = MemoryRead(TICK_COUNTER);
		session_time_puts("CONTROL DEL= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
		break;

		case MSG_REQUEST_CONTROL: //MRR_HANDLER
			tInit = MemoryRead(TICK_COUNTER);

			auxConsumer = (payload << 8) | (source & 0xFF);
			auxProducer = (payload << 8) | ((source >> 8) & 0xFF);
			auxCode = ((source >> 16) & 0xFFC0); // 10 bits de código 
			auxIndex = ((source >> 16) & 0x3F); // 6 bits do índice 
			auxNumber = source & 0xFFFF;
			auxService = -1;

			if (auxCode == 0xFFC0){ // END_SESSION // Se o código for "11 1111 1111"
				// session_puts("CONTROL: Received END_SESSION\n");
				clearSession(Sessions, auxIndex); // O índice vem junto no "code"
			}
			else if(Sessions[auxIndex].code != auxCode) //START_SESSION
			{
				// session_puts("CONTROL: Received START_SESSION\n");
				if (checkSessionCode(Sessions, auxCode) == START_SESSION){
					auxIndex = createSession(Sessions, auxProducer, auxConsumer, (auxCode | auxIndex)); // Session Creation 
					Sessions[auxIndex].header = checkWaitingServices(waitingServices, auxProducer, auxConsumer, MESSAGE_REQUEST); // Checking for pending MRs
				}
			}
			// t1 = MemoryRead(TICK_COUNTER);
			if (Sessions[auxIndex].code == auxCode) //default
			{
				// session_puts("CONTROL: Received MRC\n");
				auxSession = &Sessions[auxIndex];
				//AuxService needs to be retrieved and, in case of new Session, both steps need to be done here- Control and Data
				auxService = auxSession->header;

				if ((auxSession->requested == auxNumber) && (auxNumber != 1) ){ // Repeated MRC 
					// session_puts("ERRO(req): Recebendo MRC repetido\n");
				}else{
					auxSession->requested += 1;  

					if ((auxSession->status == WAITING_ANY) || (auxService != -1)){ 
						// session_puts("---- Receipt Primeiro, registrando chegada\n");
						// auxSession->header = auxService;
						auxSession->status = WAITING_DATA;
						auxSession->time = tInit;
						
					}
					// t2 = MemoryRead(TICK_COUNTER);
					if ((auxSession->status == WAITING_CONTROL) || (auxService != -1)){
						// session_puts("---- Receipt Segundo, resgatando MR\n");
						
						// auxService = auxSession->header;

						tmpSlot = remove_PIPE(auxService->producer_task, auxService->consumer_task);

						//Test if there is no message in PIPE
						if (tmpSlot == 0){
							// session_puts("---- sem mensagem no PIPE\n");
							//Gets the location of the producer task
							task_loc = get_task_location(auxService->producer_task);

							//This if check if the task was migrated
							if ( task_loc != -1 && task_loc != net_address && auxService->requesting_processor == auxService->source_PE){

								//MESSAGE_REQUEST by pass
								send_message_request(auxService->producer_task, auxService->consumer_task, task_loc, auxService->requesting_processor);

								if ( search_PIPE_producer(auxService->producer_task) == 0){

									send_update_task_location(auxService->requesting_processor, auxService->producer_task, task_loc);
								}

							} else {
								insert_message_request(auxService->producer_task, auxService->consumer_task, auxService->requesting_processor);
							}

						} else if (auxService->requesting_processor != net_address){
							// session_puts("---- enviando MD e MDR\n");
							// t3 = MemoryRead(TICK_COUNTER);
							send_message_delivery_control(Sessions, auxService->producer_task, auxService->consumer_task, auxService->requesting_processor);
							send_message_delivery(auxService->producer_task, auxService->consumer_task, auxService->requesting_processor, &tmpSlot->message);
						} else {
							// session_puts("---- deu no Pass\n");
							tcb_ptr = searchTCB(auxService->consumer_task);
							write_local_msg_to_task(tcb_ptr, tmpSlot->message.length, tmpSlot->message.msg);
						}
						auxService->service = BLANK; //clearServiceSlot(auxService);
						auxSession->status = WAITING_ANY;
						auxSession->header = -1;
					}
				}
			}		
		tEnd = MemoryRead(TICK_COUNTER);
		session_time_puts("CONTROL REQ= ");session_time_puts(itoa(tEnd-tInit));session_time_puts("\n");
		// session_time_puts("T1= ");session_time_puts(itoa(t1-tInit));session_time_puts("\n");
		// session_time_puts("T2= ");session_time_puts(itoa(t2-tInit));session_time_puts("\n");
		// session_time_puts("T3= ");session_time_puts(itoa(t3-tInit));session_time_puts("\n");

		break;
		#endif

		case SET_EXCESS_SZ_SERVICE:
			puts("Received SET_EXCESS_SZ_SERVICE\n"); 
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			// puts("payload: "); puts(itoh(payload)); puts("\n");
			// Ignorar se for secure já
			if (LOCAL_right_high_corner != -1){
				Unset_Secure_Zone(target, payload, source);
				//cut - LL, RH, master
				//NoCut - LL, RH, master
			}
		break;

		case START_APP_SERVICE:
			//puts("Received START_APP"); puts("\n");
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			// puts("payload: "); puts(itoh(payload)); puts("\n");
			//seek_puts("RH: "); seek_puts(itoh(LOCAL_right_high_corner)); seek_puts("\n");
			//seek_puts("Address: "); seek_puts(itoh(get_net_address())); seek_puts("\n");
			aux = unblock_tasks_of_App(payload);
			seek_puts("Tasks Unbloqued: "); seek_puts(itoh(aux)); seek_puts("\n");
			// putsv("time - ", MemoryRead(TICK_COUNTER));
			aux = ((get_net_address() & 0xF00) >> 4) + (get_net_address() & 0x00F);
			if(LOCAL_right_high_corner == aux){
				seek_puts("clear START_APP service!"); seek_puts("\n");
				Seek(CLEAR_SERVICE, source, source, payload);
			}
			
			// aux = unblock_tasks_of_App(payload);
			// seek_puts("Tasks Unbloqued: "); seek_puts(itoh(aux)); seek_puts("\n");
			//return aux;
		break;

		case OPEN_SECURE_ZONE_SERVICE:
			seek_puts("Received OPEN_SECURE_ZONE"); seek_puts("\n");
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			//puts("payload: "); puts(itoh(payload)); puts("\n");
			// Seek(OPEN_SECURE_ZONE_SERVICE, get_net_address(), app_id, app->RH_Address);
			aux = ((get_net_address() & 0xF00) >> 4) + (get_net_address() & 0x00F);
			if(LOCAL_right_high_corner == aux){
				//puts("Send Clear Open"); puts("\n");
				Seek(CLEAR_SERVICE, source, source, payload);
			}
			
			
			for(int i = 0; i < MAX_LOCAL_TASKS; i++){
				if ((tcbs[i].id >> 8) == target){
					//seek_puts("appID: ");  seek_puts(itoh(target)); seek_puts("\n");
					//seek_puts("previous wrappers: ");  seek_puts(itoh(wrapper_value)); seek_puts("\n");
					MemoryWrite(WRAPPER_REGISTER, 0);
					ClearAllSourceRouting();
					wrapper_value = 0;
					//seek_puts("before wrappers: ");  seek_puts(itoh(wrapper_value)); seek_puts("\n");
					LOCAL_right_high_corner = -1;
					break;
				}	
			}
			clear_all_memory_areas(target);
			if(LOCAL_right_high_corner == payload){
				seek_puts("Open wrappers");  seek_puts("\n");
				MemoryWrite(WRAPPER_REGISTER, 0);
			}
			//aux = payload;
			payload = ((payload << 4) & 0xF00) | (payload & 0x0F);
			if(get_net_address() == payload){
				Seek(SECURE_ZONE_OPENED_SERVICE, get_net_address(), source, target);
			}
		break;	

		case INITIALIZE_SLAVE_SERVICE:
			left_low_corner = target; 
			right_high_corner = payload;
			// puts("source: "); puts(itoh(source)); puts("\n");
			// puts("target: "); puts(itoh(target)); puts("\n");
			// puts("payload: "); puts(itoh(payload)); puts("\n");
			
			my_X_addr = (get_net_address() & 0xF00) >> 8;
			my_Y_addr = get_net_address() & 0x00F;
		
			RH_X_addr = (right_high_corner & 0xF0) >> 4;
			RH_Y_addr = right_high_corner & 0x0F;
		
			LL_X_addr = (left_low_corner & 0xF0) >> 4;
			LL_Y_addr = left_low_corner & 0x0F;
			if((my_X_addr == RH_X_addr) && (my_Y_addr == RH_Y_addr)){
				 puts("Clear: "); puts(itoh(payload)); puts("\n");
				Seek(CLEAR_SERVICE, source, source, 0);
			}
			if((my_X_addr <=  RH_X_addr) && (my_X_addr >= LL_X_addr))
				if((my_Y_addr <=  RH_Y_addr) && (my_Y_addr >= LL_Y_addr)){
					cluster_master_address = source & 0x0ffff;	
					puts("Cluster Master Address: "); puts(itoh(cluster_master_address)); puts("\n");
				}
		break;

		case FREEZE_TASK_SERVICE:
				//print_task();	
				puts(itoa(MemoryRead(TICK_COUNTER))); puts("\n");
			 	puts("Received FREEZE_TASK_SERVICE"); puts("\n");
					
				aux = freeze_tasks_of_App(target);
				
				Seek(CLEAR_SERVICE, source, target ,payload);
				payload = ((payload << 4 ) & 0XF00) | (payload & 0x0F);
				if(payload == get_net_address()){
					puts("send FREEZE_TASK_RCV app: "); puts(itoh(payload)); puts("\n");
					Seek(RCV_FREEZE_TASK_SERVICE, get_net_address(), source ,payload);
				}
				puts("Tasks FREZZED: "); puts(itoh(aux)); puts("\n");
				//print_task();	
			return aux;
		break;

		case UNFREEZE_TASK_SERVICE: //enviado pelo Mastre WARD do cluster
			puts("Received UNFREEZE_TASK_SERVICE"); puts("\n");
			aux = unfreeze_tasks_of_App(target);
			puts("Tasks UNFREZZED: "); puts(itoh(aux)); puts("\n");
			//print_locations();
			return aux;
		break;	

		// case WAIT_KERNEL_SERVICE: //enviado pelo Mestre WARD do cluster
		// 	puts("Received WAIT_KERNEL_SERVICE from "); puts(itoh((source&0xFFFF))); puts("\n"); //WARNING puts necessário para sincronização
		// 	Seek(WAIT_KERNEL_SERVICE_ACK, target, (source&0xFFFF),0);//Send to slave a warning to became a new master
		// 	puts("Send WAIT_KERNEL_SERVICE_ACK to "); puts(itoh((source&0xFFFF))); puts("\n"); //WARNING puts necessário para sincronização
		// 	MemoryWrite(DMA_WAIT_KERNEL,1);
		// 	MemoryWrite(CLOCK_HOLD_WAIT_KERNEL, 0);
		// break;

		case INITIALIZE_CLUSTER_SERVICE:
		// case LOAN_PROCESSOR_REQUEST_SERVICE:
		// case LOAN_PROCESSOR_RELEASE_SERVICE:
		break;
		
		case GMV_READY_SERVICE: // remover
		// 	puts("Kernel GMV Serbvice Recebido\n"); //Testando se chegou isso
		break;
		case NEW_APP_SERVICE:
		case NEW_APP_ACK_SERVICE:
		break;
					
		default:
			//seek_puts("Received unknown seek service\n");
		break;
	}
	return 1;
}


int get_cluster_ID(int x, int y){
	puts("get cluster x: "); puts(itoh(x)); puts(" y:  "); puts(itoh(y)); puts("\n");
	for (int i=0; i<CLUSTER_NUMBER; i++){
		if (cluster_info[i].master_x == x && cluster_info[i].master_y == y){
			return i;
		}
	}
	puts("ERROR - cluster nao encontrado\n");
	return -1;
}



/** Function called by assembly (into interruption handler). Implements the routine to handle interruption in HeMPS
 * \param status Status of the interruption. Signal the interruption type
 */
void OS_InterruptServiceRoutine(unsigned int status) {

	MemoryWrite(SCHEDULING_REPORT, INTERRUPTION);

	volatile ServiceHeader p;
	ServiceHeader * next_service;
	unsigned call_scheduler;

	if (current == &idle_tcb){
		total_slack_time += MemoryRead(TICK_COUNTER) - last_idle_time;
	}

	call_scheduler = 0;

	if ( status & IRQ_NOC ){
		auxTime = MemoryRead(TICK_COUNTER);
		// puts("Tempo da Interrupção irq: ");puts(itoa(auxTime));puts("\n");
		//printar o tempo do novo tratamento
		if (read_packet(&p) != -1){
			if (MemoryRead(DMNI_SEND_ACTIVE) && (p.service == MESSAGE_REQUEST || p.service == TASK_MIGRATION) ){

				add_pending_service(&p);

			} else {

				call_scheduler = handle_packet(&p);
			}
		}
		else{//failed packet reception
			MemoryWrite(DMNI_TIMEOUT_SIGNAL,0);
		}

	} else if (status & IRQ_PENDING_SERVICE) {

		next_service = get_next_pending_service();
		if (next_service){
			call_scheduler = handle_packet(next_service);
		}
	}

	if (status & IRQ_SLACK_TIME){
		send_slack_time_report();
		total_slack_time = 0;
		MemoryWrite(SLACK_TIME_MONITOR, 0);
	}

	if ( status & IRQ_SCHEDULER ){

		call_scheduler = 1;
	}

	if ( status & IRQ_SEEK ){

			call_scheduler = SeekInterruptHandler();
	}

	if (call_scheduler){

		Scheduler();

	} else if (current == &idle_tcb){

		last_idle_time = MemoryRead(TICK_COUNTER);

		MemoryWrite(SCHEDULING_REPORT, IDLE);

	} else {
		MemoryWrite(SCHEDULING_REPORT, current->id);
	}

	#ifdef SESSION_MANAGER
	timeoutMonitor(Sessions, MemoryRead(TICK_COUNTER));
	#endif
	
    /*runs the scheduled task*/
    ASM_RunScheduledTask(current);
}

/** Clear a interruption mask
 * \param Mask Interruption mask clear
 */
unsigned int OS_InterruptMaskClear(unsigned int Mask) {

    unsigned int mask;

    mask = MemoryRead(IRQ_MASK) & ~Mask;
    MemoryWrite(IRQ_MASK, mask);

    return mask;
}

/** Set a interruption mask
 * \param Mask Interruption mask set
 */
unsigned int OS_InterruptMaskSet(unsigned int Mask) {

    unsigned int mask;

    mask = MemoryRead(IRQ_MASK) | Mask;
    MemoryWrite(IRQ_MASK, mask);

    return mask;
}

/** Idle function
 */
void OS_Idle() {
	for (;;){
		MemoryWrite(CLOCK_HOLD, 1);
	}
}

int main(){
	MemoryWrite(CLOCK_HOLD_WAIT_KERNEL, 1);

	ASM_SetInterruptEnable(FALSE);

	MemoryWrite(WRAPPER_MASK_GO_REGISTER,0XFFFFFFFF);
	MemoryWrite(WRAPPER_MASK_BACK_REGISTER,0XFFFFFFFF);

	#ifdef AES_MODULE
		putsv("Key Size:", KEY_SIZE); 
		putsv("INIT aes key - ", MemoryRead(TICK_COUNTER)); 
		aes_key_setup(&key[0][0], key_schedule, KEY_SIZE);   
		putsv("END aes key - ", MemoryRead(TICK_COUNTER)); 
	#endif

	#ifdef PRESENT_MODULE
		putsv("Key Size:", PRESENT_KEY_SIZE_128); 
		putsv("INIT aes key - ", MemoryRead(TICK_COUNTER)); 
		present_64_80_key_schedule(inputKey, keys);
		putsv("END aes key - ", MemoryRead(TICK_COUNTER)); 
	#endif


	idle_tcb.pc = (unsigned int) &OS_Idle;
	idle_tcb.id = 0;
	idle_tcb.offset = 0;
	//idle_tcb.scheduling_ptr->status = READY;

	total_slack_time = 0;

	last_idle_time = MemoryRead(TICK_COUNTER);

	current = &idle_tcb;

	net_address = MemoryRead(NI_CONFIG);

	set_net_address(net_address);

	puts("Initializing PE: "); puts(itoh(net_address)); puts("\n");

	init_communication();

	// printGray();


	initFTStructs();

	initSessions();

	init_service_header_slots();

	init_task_location();

	init_TCBs();

	initialize_CM_FIFO();

	/*disable interrupts*/
	OS_InterruptMaskClear(0xffffffff);

	//if (get_net_address() == 0x00000202){
	//puts("maooiii: "); puts(itoh(((io_info[0].default_address_x << 8) | io_info[0].default_address_y))); puts("\n");	
	//puts("maooiii: "); puts(itoh(io_info[0].default_port)); puts("\n");	
	//ServiceHeader *p = get_service_header_slot();
//
//	//p->service = MIGRATION_CODE;
//
//	//send_packet_io(p, 0, 0, 9);
//
//
//	//p->service = MIGRATION_CODE;
//
//	//send_packet_io(p, 0, 0, 8);
//
//
	//}


	/*enables timeslice counter and wrapper interrupts*/

	//WARNING: NOT ENABLING this fucking shit of IRQ_SLACK_TIME
	//by Wachter
	OS_InterruptMaskSet(IRQ_SEEK | IRQ_SCHEDULER | IRQ_NOC | IRQ_PENDING_SERVICE);

	/*runs the scheduled task*/
	ASM_RunScheduledTask(current);

	return 0;
}
>>>>>>> upstream/master
