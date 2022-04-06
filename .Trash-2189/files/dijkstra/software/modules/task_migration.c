/*!\file task_migration.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * This module implements function relative to task migration. This module is used by slave kernel
 *
 */
#include "task_migration.h"

#include "../../include/kernel_pkg.h"
#include "../include/services.h"
#include "../include/plasma.h"
#include "task_location.h"
#include "local_scheduler.h"
#include "communication.h"
#include "utils.h"

//#define TASK_MIGRATION_DEBUG  1	//!<When enable shows puts related to task migration

void print_locations(){
	for( int i=0; i<MAX_TASKS_APP; i++ ){

		int location_t = get_task_location( i);
		//if (location_t != -1 && location_t != net_address){
		//migration_puts("\nlocation_t :"); migration_puts(itoa(location_t)); migration_puts("\n");
		//migration_puts("\nget_net_address :"); migration_puts(itoa(get_net_address())); migration_puts("\n");
		//if (location_t != -1 && location_t != get_net_address()){
			migration_puts("task "); migration_puts(itoa((i))); migration_puts(" located at "); migration_puts(itoh(location_t)); migration_puts("\n");
		//}
	}
}


/**Assembles and sends a TASK_MIGRATED packet to the master kernel
 * \param migrated_task Migrated task ID
 * \param old_proc Old processor address of task
 * \param master_address Master address of the task
 */
void send_task_migrated(int migrated_task, int old_proc, unsigned int master_address){

	ServiceHeader * p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = master_address; 

	p->service = TASK_MIGRATED;

	p->task_ID = migrated_task;

	p->released_proc = old_proc;

	send_packet(p, 0, 0);
	//migration_puts("send_task_migrated master_address:");migration_puts(itoh(processor));migration_puts("\n");
}


/** Assembles and sends a UPDATE_TASK_LOCATION packet to a slave processor. Useful because task migration
* \param target_proc Target slave processor which the packet will be sent
* \param task_id Task ID that have its location updated
* \param new_task_location New location (slave processor address) of the task
*/
void send_update_task_location(unsigned int target_proc, unsigned int task_id, unsigned int new_task_location){

	ServiceHeader *p = get_service_header_slot();

	migration_puts(itoh(p)); migration_puts("\n");

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1]  = target_proc;

	p->service = UPDATE_TASK_LOCATION;

	p->task_ID = task_id;

	p->allocated_processor = new_task_location;

	send_packet(p, 0, 0);
}

/**This function os the core of task migration.
 * It is called by the source processor (the older processor)
 * Its job is to migrate to the new processor the dynamic data section that can change during task execution.
 * \param tcb_aux The TCB pointer of the task to be migrated
 */
void migrate_dynamic_memory(TCB * tcb_aux){//FOCHI ANALISAR

	unsigned int _stack_pointer,stack_lenght,processor,request_msg[REQUEST_SIZE*3],app_id,request_array_size;
	volatile unsigned int tcb_registers[30];
	volatile unsigned int task_location_array[MAX_TASKS_APP];
	PipeSlot * pipe_ptr;
	Message *msg_ptr;
	ServiceHeader * p;

#if TASK_MIGRATION_DEBUG
	migration_puts("\nMigrate dynamic memory of task: "); migration_puts(itoa(tcb_aux->id));migration_puts("\n");
	migration_puts("----> computing stack pointer size ....\n");
#endif

	processor = tcb_aux->proc_to_migrate;

	tcb_aux->proc_to_migrate = -1;

	_stack_pointer = tcb_aux->reg[25]; //plus one because the stack is initialized PAGE_SIZE - 1

#if TASK_MIGRATION_DEBUG
	migration_puts("\tstack pointer antes: "); migration_puts(itoa(_stack_pointer));migration_puts("\n");
#endif

	while((PAGE_SIZE - _stack_pointer) % 4)
		_stack_pointer--;

#if TASK_MIGRATION_DEBUG
	migration_puts("\tstack pointer depois: "); migration_puts(itoa(_stack_pointer));migration_puts("\n");
#endif

	stack_lenght = (PAGE_SIZE - _stack_pointer) / 4;

	_stack_pointer = tcb_aux->reg[25];

#if TASK_MIGRATION_DEBUG
	migration_puts("\tstack lenght"); migration_puts(itoa(stack_lenght));migration_puts("\n");
	migration_puts("\tstack address: "); migration_puts(itoa(_stack_pointer));migration_puts("\n");
	migration_puts("end computing stack pointer\n----> migrating TCB....\n");
#endif

	//------ tcb ------
	//migration_puts("\n--- tcb ----\n");
	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = processor;

	p->service = MIGRATION_TCB;

	p->task_ID = tcb_aux->id;

	p->hops = tcb_aux->scheduling_ptr->last_status; 

	p->program_counter = tcb_aux->pc - tcb_aux->offset;

	for (int i=0; i<30; i++){
		if (i == 27)
			tcb_registers[i] = tcb_aux->reg[i] - tcb_aux->offset;
		else
			tcb_registers[i] = tcb_aux->reg[i];
	}

	send_packet(p, (unsigned int) &tcb_registers, 30);
	// ------- end tcb ------

#if TASK_MIGRATION_DEBUG
	migration_puts("TCB migrated\n----> migrating task location....\n");
#endif

	// ----- task location ------
	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = processor;

	p->task_ID = tcb_aux->id;

	p->service = MIGRATION_TASK_LOCATION;

	app_id = tcb_aux->id & 0xFF00;

	//Update task location
	remove_task_location(tcb_aux->id);
	add_task_location(tcb_aux->id, processor);

	
	for( int i=0; i<MAX_TASKS_APP; i++ ){
		task_location_array[i] = get_task_location(app_id | i);
		if (task_location_array[i] != -1)
			remove_task_location((app_id | i)); // Depois de salvas no array, limpar estrutura para próxima app
		
	#if TASK_MIGRATION_DEBUG
		migration_puts("Location task "); migration_puts(itoa(app_id | i)); 
		migration_puts(" : "); migration_puts(itoh(task_location_array[i])); migration_puts("\n");
	#endif
	}

	send_packet(p, (unsigned int) &task_location_array, MAX_TASKS_APP);
	// ----- end task location ------

#if TASK_MIGRATION_DEBUG
	migration_puts("task location migrated\n----> migrating task request....\n");
#endif

	// ----- producer task request -----
	request_array_size = remove_prod_requested_msgs(tcb_aux->id, request_msg);

	if (request_array_size > 0){

		p = get_service_header_slot();

		p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = processor;

		p->service = MIGRATION_PRODUCER_MSG_REQUEST;

		p->task_ID = tcb_aux->id;

		p->request_size = request_array_size;

		send_packet(p, (unsigned int) &request_msg, request_array_size);

#if TASK_MIGRATION_DEBUG
		for(int i=0; i<request_array_size; i++){
			migration_puts("PRODUCER request["); migration_puts(itoa(i));
			migration_puts("]: "); migration_puts(itoa(request_msg[i]));
			migration_puts("\n");			
		}
#endif

	}
	// ----- end producer task request -----

	
#if TASK_MIGRATION_DEBUG
	migration_puts("PRODUCER request migrated\n----> CONSUMER request....\n");
#endif

	// ----- CONSUMER task request -----
	request_array_size = remove_cons_requested_msgs(tcb_aux->id, request_msg, processor);

	if (request_array_size > 0){

		p = get_service_header_slot();

		p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = processor;

		p->service = MIGRATION_CONSUMER_MSG_REQUEST;

		p->task_ID = tcb_aux->id;

		p->request_size = request_array_size;

		send_packet(p, (unsigned int) &request_msg, request_array_size);

#if TASK_MIGRATION_DEBUG
		for(int i=0; i<request_array_size; i++){
			migration_puts("CONSUMER request["); migration_puts(itoa(i));
			migration_puts("]: "); migration_puts(itoa(request_msg[i]));
			migration_puts("\n");	
		}
#endif

	}
	// ----- end CONSUMER task request -----
	
#if TASK_MIGRATION_DEBUG
	migration_puts("CONSUMER request migrated\n----> migrating stack....\n");
#endif

	// ----- stack -----
	p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = processor;

	p->service = MIGRATION_STACK;

	p->task_ID = tcb_aux->id;

	p->stack_size = stack_lenght;

	send_packet(p, (tcb_aux->offset + _stack_pointer), stack_lenght);
	// ----- end stack -----

#if TASK_MIGRATION_DEBUG
	migration_puts("stack migrated\n");
#endif

	// ------ task's PIPE -----

#if TASK_MIGRATION_DEBUG
	migration_puts("Start migrate PIPE\n");
#endif

	pipe_ptr = remove_PIPE_by_producer(tcb_aux->id);

	while( pipe_ptr ){

		msg_ptr = &pipe_ptr->message.length;

		p = get_service_header_slot();

		p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = processor;

		p->service = MIGRATION_PIPE;

		p->task_ID = tcb_aux->id;

		p->producer_task = pipe_ptr->producer_task;

		p->consumer_task = pipe_ptr->consumer_task;

		p->msg_lenght = msg_ptr->length;

#if TASK_MIGRATION_DEBUG
		migration_puts("Send PIPE\n\tProducer = "); migration_puts(itoa(p->producer_task));
		migration_puts("\n\tConsumer = "); migration_puts(itoa(p->consumer_task));
		migration_puts("\n\tLength = "); migration_puts(itoa(p->msg_lenght)); migration_puts("\n");	
#endif

		send_packet(p, msg_ptr->msg, (unsigned int)msg_ptr->length);

		pipe_ptr = remove_PIPE_by_producer(tcb_aux->id);
	}

#if TASK_MIGRATION_DEBUG
	migration_puts("Finish migrate PIPE\n");
#endif
	// ------ end task's PIPE-----

	// ------ data and bss -----
#if TASK_MIGRATION_DEBUG
	migration_puts("Migrating DATA and BSS\n");
#endif
	p = get_service_header_slot();

	//migration_puts("Slot p\n");

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = processor;

	p->service = MIGRATION_DATA_BSS;

	p->task_ID = tcb_aux->id;

	p->data_size = tcb_aux->data_lenght;

	p->bss_size = tcb_aux->bss_lenght;

	send_packet(p, tcb_aux->offset + (tcb_aux->text_lenght * 4) ,  (tcb_aux->data_lenght + tcb_aux->bss_lenght) );
	// ----- end data and bss -----


	//clear_app_tasks_locations(app_id >> 8);
	clear_scheduling(tcb_aux->scheduling_ptr);
	tcb_aux->pc = 0;
	tcb_aux->id = -1;
	tcb_aux->proc_to_migrate = -1;

#if TASK_MIGRATION_DEBUG
	puts("##### Migration FINISH, clearing task structures....\n");
	puts("Task ID: ");// migration_puts(itoa(tcb_aux->id)); migration_puts("\nMigrated to processor: "); migration_puts(itoh(processor));
#endif
}

/**Migrate the code data to the new processor.
 * It is called by the source processor (the older processor)
 * The code is static because corresponds the the task instructions loaded
 * when the task is allocated in a given processor
 * \param tcb_migration The TCB pointer of the task to be migrated
 */
void migrate_CODE(TCB* tcb_migration){

	ServiceHeader * p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = tcb_migration->proc_to_migrate;

	p->service = MIGRATION_CODE;

	p->master_ID = tcb_migration->master_address;

	p->task_ID = tcb_migration->id;

	p->code_size = tcb_migration->text_lenght;

	send_packet(p, tcb_migration->offset, tcb_migration->text_lenght);

#if TASK_MIGRATION_DEBUG
	migration_puts("\tCODE migrated with size  "); migration_puts(itoa(p->code_size)); migration_puts("\n");	
#endif
}

/**Handle the migration code, coping the code to a free page.
 * It is called by the target processor (the new processor)
 * \param p ServiceHeader pointer of the packet with the task code
 * \param migrate_tcb The TCB pointer of the task to be migrated
 */
void handle_migration_code(volatile ServiceHeader * p, TCB * migrate_tcb){

	migrate_tcb->scheduling_ptr->status = MIGRATING;

	migrate_tcb->id = p->task_ID;

	migrate_tcb->master_address = p->master_ID;

	migrate_tcb->text_lenght = p->code_size;

	DMNI_read_data(migrate_tcb->offset, migrate_tcb->text_lenght);
	//printTaskInformations(allocatingTCB, 1, 0, 0);

#if TASK_MIGRATION_DEBUG
	puts("##### Receiving Task Migration\n");
	puts("      Task ID: "); puts(itoa(p->task_ID)); puts("\n");
	migration_puts("\tCODE received with size "); migration_puts(itoa(p->code_size)); 
	migration_puts(" the task offset is: "); migration_puts(itoa(migrate_tcb->offset)); migration_puts("\n");	
#endif


}

/**Handles the migration of the task TCB information
 * It is called by the target processor (the new processor)
 * \param p ServiceHeader pointer of the packet with the TCB data
 * \param migrate_tcb The TCB pointer of the task to be migrated
 */
void handle_migration_TCB(volatile ServiceHeader * p, TCB * migrate_tcb){

	volatile unsigned int tcb_registers[30];

	migrate_tcb->pc = p->program_counter + migrate_tcb->offset;

	migrate_tcb->scheduling_ptr->last_status = p->hops;

	DMNI_read_data((unsigned int) &tcb_registers, 30);

	for (int i=0; i<30; i++){
		if (i == 27)
			migrate_tcb->reg[i] = tcb_registers[i] + migrate_tcb->offset;
		else
			migrate_tcb->reg[i] = tcb_registers[i];
	}

#if TASK_MIGRATION_DEBUG
	migration_puts("\tTCB received\n");
#endif
}

/**Handles the migration of the task task location data
 * It is called by the target processor (the new processor)
 * \param p ServiceHeader pointer of the packet with the task location data
 * \param migrate_tcb The TCB pointer of the task to be migrated
 */
void handle_migration_task_location(volatile ServiceHeader * p, TCB * migrate_tcb){

	volatile unsigned int task_location_array[MAX_TASKS_APP];
	unsigned int location, app_id, task_id;

	DMNI_read_data( (unsigned int) &task_location_array, MAX_TASKS_APP);

	app_id = migrate_tcb->id & 0xFF00;

	migration_puts("\tReceiveing task location....\n");
	for( int i=0; i<MAX_TASKS_APP; i++ ){

		location = task_location_array[i];
		task_id = (app_id | i);

		migration_puts("Location task "); migration_puts(itoa(task_id)); migration_puts(" : "); migration_puts(itoh(location)); migration_puts("\n");
		migration_puts("get_task_location(task_id) "); migration_puts(itoh(get_task_location(task_id) ) ); migration_puts("\n");

		if ( location != -1 && get_task_location(task_id) == -1){
			migration_puts("updated\n");
			add_task_location(task_id, location);
		}		
	}
	migration_puts("\ttask location received\n");
}

/**Handles the migration of the task message request data
 * It is called by the target processor (the new processor)
 * \param p ServiceHeader pointer of the packet with the message request data
 * \param migrate_tcb The TCB pointer of the task to be migrated
 */
void handle_producer_migration_request_msg(volatile ServiceHeader * p, TCB * migrate_tcb){

	volatile unsigned int request_msg[p->request_size];
	int requested, requester, requester_proc;
	unsigned int request_index, iterations;

	DMNI_read_data( (unsigned int) &request_msg, p->request_size);

	request_index = 0;

	iterations = p->request_size / 3;

	migration_puts("\treceiving PRODUCER task request....\n");
	migration_puts("number of request: "); migration_puts(itoa(iterations) ); migration_puts("\n");

	for( int i=0; i<iterations; i++ ) {
		requester = request_msg[request_index++];
		requested = request_msg[request_index++];
		requester_proc = request_msg[request_index++];

		if ( requested == migrate_tcb->id) {
			migration_puts("requester"); migration_puts(itoa(requester) );
			migration_puts("requested: "); migration_puts(itoa(requested) ); migration_puts("\n");

			insert_message_request(requested, requester, requester_proc);
		}
	}
	migration_puts("\tPRODUCER task request received\n");
}


/**Handles the migration of the task message request data
 * It is called by the target processor (the new processor)
 * \param p ServiceHeader pointer of the packet with the message request data
 * \param migrate_tcb The TCB pointer of the task to be migrated
 */
void handle_consumer_migration_request_msg(volatile ServiceHeader * p, TCB * migrate_tcb){

	volatile unsigned int request_msg[p->request_size];
	unsigned int status, sourceID, targetID, requester_proc, tick_counter;
	unsigned int request_index, iterations;

	DMNI_read_data( (unsigned int) &request_msg, p->request_size);

	request_index = 0;

	iterations = p->request_size / 5;

	migration_puts("\treceiveing CONSUMER task request....\n");
	migration_puts("number of request: "); migration_puts(itoh(iterations) ); migration_puts("\n");

	for( int i=0; i<iterations; i++ ) {
		status = request_msg[request_index++];
		requester_proc = request_msg[request_index++];
		sourceID = request_msg[request_index++];
		targetID = request_msg[request_index++];
		tick_counter = request_msg[request_index++];

		if ( targetID == migrate_tcb->id) {
			migration_puts("---processor:"); migration_puts(itoa(requester_proc) ); 
			migration_puts(" tick: "); migration_puts(itoa(tick_counter) ); migration_puts("\n");
			add_msg_request_migration(status, requester_proc, targetID, sourceID, tick_counter);
		}
	}
	migration_puts("\tCONSUMER task request received\n");
}

/**Handles the migration of the task stack data
 * It is called by the target processor (the new processor)
 * \param p ServiceHeader pointer of the packet with the task stack data
 * \param migrate_tcb The TCB pointer of the task to be migrated
 */
void handle_migration_stack(volatile ServiceHeader * p, TCB * migrate_tcb){

	if (p->stack_size > 0){
		DMNI_read_data(migrate_tcb->offset + migrate_tcb->reg[25], p->stack_size);
	}
	migration_puts("\tSTACK received\n");
}

/**Handles the migration of the task DATA and BSS data sections
 * It is called by the target processor (the new processor)
 * \param p ServiceHeader pointer of the packet with the task DATA and BSS data sections
 * \param migrate_tcb The TCB pointer of the task to be migrated
 */
void handle_migration_DATA_BSS(volatile ServiceHeader * p, TCB * migrate_tcb, unsigned int master_address){

	migrate_tcb->data_lenght = p->data_size;

	migrate_tcb->bss_lenght = p->bss_size;

	if ((migrate_tcb->bss_lenght + migrate_tcb->data_lenght) > 0){

		DMNI_read_data(migrate_tcb->offset + (migrate_tcb->text_lenght*4), (migrate_tcb->bss_lenght + migrate_tcb->data_lenght));
	}

	migrate_tcb->scheduling_ptr->status = BLOCKED;

	migrate_tcb->proc_to_migrate = -1;

	migrate_tcb->scheduling_ptr->remaining_exec_time = MAX_TIME_SLICE;

	send_task_migrated(migrate_tcb->id, p->source_PE, master_address);

	//printTaskInformations(migrate_tcb, 1, 1, 1);

	migration_puts("\tDATA and BSS received");

#if TASK_MIGRATION_DEBUG
	puts("##### Migration FINISH - task READY TO EXECUTE\n");
	puts("Task id: "); migration_puts(itoa(migrate_tcb->id)); migration_puts(" allocated by task migration at time "); 
	puts(itoa(MemoryRead(TICK_COUNTER))); migration_puts(" from processor "); 
	puts(itoh(p->source_PE)); migration_puts("\n");
#endif	
}



void handle_migration_PIPE(volatile ServiceHeader * p, TCB * migrate_tcb){

	Message migrated_message;

	migrated_message.length = p->msg_lenght;

	DMNI_read_data(&migrated_message.msg, migrated_message.length);

	add_PIPE(p->producer_task, p->consumer_task, &migrated_message);
}

/**Handles a task migration order from the kernel master
 * This function is called by the source processor (the old processor)
 * \param p ServiceHeader pointer of the packet with task migration order
 * \param tcb_ptr TCB pointer of the task to be migrated
 */
int handle_task_migration(volatile ServiceHeader * p, TCB * tcb_ptr){

	migration_puts("##### Sending Task migration\n      task id: "); migration_puts(itoa(p->task_ID) );
	migration_puts("\n      to processor: "); migration_puts(itoh(p->allocated_processor) ); migration_puts("\n");

	if (tcb_ptr && tcb_ptr->proc_to_migrate == -1){

		tcb_ptr->proc_to_migrate = p->allocated_processor;
		migrate_CODE(tcb_ptr);

		migration_puts("\ttask status: "); migration_puts(itoa(tcb_ptr->scheduling_ptr->status) ); migration_puts("\n");

		if (tcb_ptr->scheduling_ptr->status == WAITING || tcb_ptr->scheduling_ptr->status == READY || tcb_ptr->scheduling_ptr->status == RUNNING || tcb_ptr->scheduling_ptr->status == BLOCKED){

			migration_puts("\tMigrou de primeira\n");
			migrate_dynamic_memory(tcb_ptr);
			return 1;
		}
	} else {
		migration_puts ("ERROR: task not found or proc_to_migrated already assigned\n");
		//while(1);
	}
	migration_puts("\tWARNING: only code migrated\n");
	return 0;
}

/**Handles all task migration packets, calling the appropriated sub-function.
 * \param p ServiceHeader pointer of the packet a generic task migration packet
 * \param master_address Address of the kernel master of the slave processor
 * \return The necessity of call the scheduler, 1 - need scheduler, 0 not need scheduler
 */
int handle_migration(volatile ServiceHeader * p, unsigned int master_address){

	int need_scheduling = 0;

	TCB * migrate_tcb;

	if (p->service == MIGRATION_CODE){
		migrate_tcb = search_free_TCB();
	} else {
		migrate_tcb = searchTCB(p->task_ID);
	}

	migration_puts("service: "); migration_puts(itoh(p->service)); migration_puts("\n");

	switch(p->service){

		case TASK_MIGRATION:

			need_scheduling = handle_task_migration(p, migrate_tcb);

			break;

		case MIGRATION_CODE:

			handle_migration_code(p, migrate_tcb);

			break;

		case MIGRATION_TCB:

			handle_migration_TCB(p, migrate_tcb);

			break;

		case MIGRATION_TASK_LOCATION:

			handle_migration_task_location(p, migrate_tcb);

			break;

		case MIGRATION_PRODUCER_MSG_REQUEST:

			handle_producer_migration_request_msg(p, migrate_tcb);

			break;

		case MIGRATION_CONSUMER_MSG_REQUEST:

			handle_consumer_migration_request_msg(p, migrate_tcb);

			break;			

		case MIGRATION_STACK:

			handle_migration_stack(p, migrate_tcb);

			break;

		case MIGRATION_DATA_BSS:
			
			handle_migration_DATA_BSS(p, migrate_tcb, master_address);

			need_scheduling = 1;

			break;

		case MIGRATION_PIPE:

			handle_migration_PIPE(p, migrate_tcb);

			break;

		default:
			migration_puts("ERROR - Task Migration service unknown\n");
			break;
		}

	return need_scheduling;

}
