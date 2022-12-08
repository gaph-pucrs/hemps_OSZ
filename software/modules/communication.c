/*!\file communication.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief Implements the PIPE and MessageRequest structures management.
 * This module is only used by slave kernel
 */

#include "communication.h"
#include "../include/plasma.h"
#include "task_location.h"
#include "utils.h"
#include "packet.h"

PipeSlot pipe[PIPE_SIZE];						//!< pipe array

MessageRequest message_request[REQUEST_SIZE];	//!< message request array

unsigned int pipe_free_positions = PIPE_SIZE;	//!< Stores the number of free position in the pipe

msg_requestSlot msg_request[MSG_REQUEST_SIZE];

/** Initializes the message request and the pipe array
 */
void init_communication(){
	for(int i=0; i<PIPE_SIZE; i++){
		pipe[i].status = EMPTY;
	}

	for(int i=0; i<REQUEST_SIZE; i++){
		message_request[i].requested = -1;
		message_request[i].requester = -1;
		message_request[i].requester_proc = -1;
	}
}

/*--------------------------------------------------------------------
 InitFTStructs

 DESCRIPTION:
    Initialize msg_request and lost_acks structures

    parameters: none
    
    return: void functin
--------------------------------------------------------------------*/
void initFTStructs(){
	int i;

	// for(i=0;i<LOST_ACKS_SIZE;i++){
	// 	lost_acks[i].status = EMPTY;/*all status set to empty*/
	// }
	for(i=0;i<MSG_REQUEST_SIZE;i++){
		msg_request[i].status = EMPTY;/*all status set to empty*/
		msg_request[i].last_msg_request_time = 0;  /*all threshold set to zero*/
	}
}

/*--------------------------------------------------------------------
 add_msg_request

 DESCRIPTION:
    adds in the msg_request structure information that a MESSAGE_REQUEST
    packet was sent. This information is necessary if this message is
    lost and should be retransmitted later. 

    parameters: processor: source processor address 
                target_id: task id number of target task
                source_id: task id number of source task
    
    return: 1 if there was a space in the structure or 0 if not
--------------------------------------------------------------------*/

unsigned int add_msg_request(unsigned int processor, unsigned int target_id, unsigned int source_id){
	int i;
	
	for(i=0;i<MSG_REQUEST_SIZE;i++){
		if(msg_request[i].status == EMPTY){
			msg_request[i].status = USED;
			msg_request[i].processor = processor;
			msg_request[i].target_id = target_id;
			msg_request[i].source_id = source_id;
			//set the time which i've sent the msg_request
			msg_request[i].last_msg_request_time = MemoryRead(TICK_COUNTER);
			return 1;
		}
	}
	puts("ERROR: no space in msg_request\n");
	return 0;
}

unsigned int add_msg_request_migration(unsigned int status, unsigned int processor, unsigned int target_id, unsigned int source_id, unsigned int tick_counter){
	int i;
	
	for(i=0;i<MSG_REQUEST_SIZE;i++){
		if(msg_request[i].status == EMPTY){
			msg_request[i].status = status;
			msg_request[i].processor = processor;
			msg_request[i].target_id = target_id;
			msg_request[i].source_id = source_id;
			//puts("add msg request \nproc: ");puts(itoh(processor));puts("\n");
			//puts("target_id: ");puts(itoa(msg_request[i].target_id));puts("\n");
			//puts("source_id: ");puts(itoa(msg_request[i].source_id));puts("\n");
			//set the time which i've sent the msg_request
			msg_request[i].last_msg_request_time = tick_counter;
			return 1;
		}
	}
	puts("ERROR: no space in msg_request\n");
	return 0;
}


void update_msg_request_migration(unsigned int source_id, unsigned int processor){
	int i;
	
	for(i=0;i<MSG_REQUEST_SIZE;i++){
			//puts("update \nproc: ");puts(itoh(processor));
			//puts(" ID: ");puts(itoa(source_id));puts("\n");
			//puts("target_id: ");puts(itoa(msg_request[i].target_id));puts("\n");
			//puts("source_id: ");puts(itoa(msg_request[i].source_id));puts("\n");
			//puts("status: ");puts(itoa(msg_request[i].status));puts("\n");
		if(msg_request[i].status != EMPTY && msg_request[i].source_id == source_id){
			//puts("change requested processor: ");puts(itoh(processor));puts("\n");
			msg_request[i].processor = processor;
		}
	}
}



/*--------------------------------------------------------------------
 remove_msg_request

 DESCRIPTION:
    removes in the msg_request structure information that a MESSAGE_REQUEST
    packet was sent. This information is necessary if this message is
    lost and should be retransmitted later. 

    parameters: processor: target processor address 
                target_id: task id number of target task
                source_id: task id number of source task
    
    return: 1 if message was removed in the structure or 0 if not
--------------------------------------------------------------------*/
unsigned int remove_msg_request(unsigned int processor, unsigned int target_id, unsigned int source_id){
	int i;

	for(i=0;i<MSG_REQUEST_SIZE;i++){
		if(msg_request[i].status    == USED &&
			msg_request[i].processor == processor &&
			msg_request[i].source_id == source_id &&
			msg_request[i].target_id == target_id){
			msg_request[i].status = EMPTY;
			return 1;
		}
	}

	puts("ERROR: msg not rmvd in msg_request time "); puts(itoa(MemoryRead(TICK_COUNTER))); puts("\n"); 
	puts("proc:");puts(itoh(processor));puts("\n");
	puts("target_id:");puts(itoh(target_id));puts("\n");
	puts("source_id:");puts(itoh(source_id));puts("\n");
	//print_msg_req();
	return 0;
}

//unsigned int unfrezzed_request(){//função de debug não é necessaria
//			msg_request[0].status    = USED;
//			msg_request[0].processor = 0x00000302;
//			msg_request[0].source_id = 0x00000004;
//			msg_request[0].target_id = 0x00000000;
//
//	puts("status:");puts(itoh(msg_request[0].status ));puts("\n");
//	puts("proc:");puts(itoh(msg_request[0].processor ));puts("\n");
//	puts("target_id:");puts(itoh(msg_request[0].target_id));puts("\n");
//	puts("source_id:");puts(itoh(msg_request[0].source_id));puts("\n");
//}


void print_msg_req(){
	int i;
	for(i=0;i<MSG_REQUEST_SIZE;i++){
		switch(msg_request[i].status){
			case USED: puts("U"); break;
			case EMPTY: puts("E"); break;
			default: puts("X"); break;
		}
	}
	puts("\n");
}

/** Resend all MESSAGE_REQUEST from a given processor that are in USED status in the msg_request structure
 *  \param processor: target processor address
 *  \return 1 if a message was resend and 0 if there was no message to be retransmitted
 */
unsigned int resend_msg_request(unsigned int processor){
	int i;
	int value = 0;

	for(i=0;i<MSG_REQUEST_SIZE;i++){
		if(msg_request[i].status == USED && msg_request[i].processor == processor){

			//calls send_message_request with flag 0
			send_message_request_(msg_request[i].source_id, msg_request[i].target_id, get_task_location(msg_request[i].source_id), get_net_address(), 0);
			//renews the time which i've sent the msg request
			msg_request[i].last_msg_request_time = MemoryRead(TICK_COUNTER);
			comm_puts("resent message request to: "); comm_puts(itoh(msg_request[i].processor)); comm_puts("\n");
			value = 1;
		}
	}
	return value;
}

void print_pipe_status(char status){
	switch(status){
		case WAITING_ACK: 	puts("W"); break;
		case EMPTY: 		puts("E"); break;
		case USED: 			puts("U"); break;
		case LOCKED: 		puts("L"); break;
		default:			puts("-"); break;
	}
}

/** Resend all messages in WAITING_ACK to a given target processor
 *  \param remote_addr: target processor address
 *  \return 1 if a message was resend and 0 if there was no message to be retransmitted.
 */
unsigned int resend_messages(int remote_addr){
	int i, consumer_proc;
	for(i=0; i<PIPE_SIZE; i++) {
		//gets processor remote address of this pipe slot
		consumer_proc = get_task_location(pipe[i].consumer_task);
		//print_pipe_status(pipe[i].status);
		//comm_puts(itoh(consumer_proc));
		//comm_puts("\n");
		
		if (pipe[i].status == WAITING_ACK && consumer_proc == remote_addr) {
			send_message_delivery(pipe[i].producer_task, pipe[i].consumer_task, remote_addr, &pipe[i].message);
			comm_puts("resent mesage delivery to: "); comm_puts(itoh(consumer_proc)); comm_puts("\n");
			return 1;
		}
	}

	return 0;
}


/** Add a message to the PIPE if it have available space
 *  \param producer_task ID of the producer task
 *  \param consumer_task ID of the consumer task
 *  \param msg Message pointer for the message to be stored
 *  \return 0 if pipe is full, else returns the pointer to the sent message
 */
PipeSlot * add_PIPE(int producer_task, int consumer_task, Message * msg){

	PipeSlot * pipe_ptr;
	unsigned int last_order = 0;
	unsigned char task_pipe_slots = 0;

	if (pipe_free_positions == 0){
		return 0;
	}

	for(int i=0; i<PIPE_SIZE; i++){

		pipe_ptr = &pipe[i];

		if (pipe_ptr->status == USED && pipe_ptr->producer_task == producer_task){

			task_pipe_slots++;

			if (pipe_ptr->consumer_task == consumer_task){

				if (last_order < pipe_ptr->order){
					last_order = pipe_ptr->order;
				}
			}
		}
	}

	if (task_pipe_slots == MAX_TASK_SLOTS){
		return 0;
	}

	pipe_ptr = get_PIPE_free_position();

	if (pipe_ptr == 0){
		return 0;
	}

	pipe_ptr->producer_task = producer_task;

	pipe_ptr->consumer_task = consumer_task;

	pipe_ptr->message.length = msg->length;

	pipe_ptr->status = USED;

	pipe_ptr->order = last_order + 1;

	for (int i=0; i<msg->length; i++){
		pipe_ptr->message.msg[i] = msg->msg[i];
	}

	pipe_free_positions--;

	//Only for debug purposes
	MemoryWrite(ADD_PIPE_DEBUG, (producer_task << 16) | (consumer_task & 0xFFFF));

	return pipe_ptr;
}

/** Tells if the producer task have some message in the pipe
 *  \param producer_task ID of the producer task
 *  \return 0 if it not has, 1 if it has
 */
unsigned int search_PIPE_producer(int producer_task){

	PipeSlot * pipe_ptr;
	unsigned int msg_count=0;

	for(int i=0; i<PIPE_SIZE; i++){

		pipe_ptr = &pipe[i];

		if (pipe_ptr->status == USED && producer_task == pipe_ptr->producer_task){
			msg_count++;
		}
	}

	return msg_count;
}

/** Counts the number of message in the pipe
 *  \return The number of messages in the pipe
 */
unsigned int PIPE_msg_number(){

	PipeSlot * pipe_ptr;
	unsigned int msg_count=0;

	for(int i=0; i<PIPE_SIZE; i++){

		pipe_ptr = &pipe[i];

		if (pipe_ptr->status == USED){
			msg_count++;
		}
	}

	if (msg_count){
		return msg_count;
	}

	return 0;
}

/** Remove the next message from the pipe. The remotion occurs following the order of insertion of the message
 *  \param producer_task ID of the producer task of the message
 *  \param consumer_task ID of the consumer task of the message
 *  \return 0 if it not found any message, or the PipeSlot pointer if the message was successfully removed
 */
PipeSlot * remove_PIPE(int producer_task,  int consumer_task){
	int i;

	PipeSlot * pipe_ptr, * sel_pipe;
	unsigned int min_order = 0xFFFFFFFF; //Max unsigned integer value

	if (pipe_free_positions == PIPE_SIZE){
		return 0;
	}

	sel_pipe = 0;


	for(i=0; i<PIPE_SIZE; i++){
		pipe_ptr = &pipe[i];
		if (pipe_ptr->status == WAITING_ACK && producer_task == pipe_ptr->producer_task && consumer_task == pipe_ptr->consumer_task){
			pipe_ptr->status = EMPTY;
			pipe_free_positions++;
			break;
		}
	}


	for(i=0; i<PIPE_SIZE; i++){
		pipe_ptr = &pipe[i];
		// print_pipe_status(pipe_ptr->status);
		// comm_puts(itoa(pipe_ptr->consumer_task));

		if (pipe_ptr->status == USED && producer_task == pipe_ptr->producer_task && consumer_task == pipe_ptr->consumer_task){

			if(min_order > pipe_ptr->order){
				sel_pipe = pipe_ptr;
				min_order = pipe_ptr->order;
			}
		}
	}
	// comm_puts("\n");

	if (sel_pipe == 0){
		return 0;
	}


	sel_pipe->status = WAITING_ACK;
	

	//Only for debug purposes
	MemoryWrite(REM_PIPE_DEBUG, (producer_task << 16) | (consumer_task & 0xFFFF));

	return sel_pipe;
}





//Ruaro //Fochi

/** Remove the next message from the pipe. The remotion occurs following the order of insertion of the message
 *  \param producer_task ID of the producer task of the message
 *  \return 0 if it not found any message, or the PipeSlot pointer if the message was successfully removed
 */
PipeSlot * remove_PIPE_by_producer(int producer_task){
	int i;

	PipeSlot * pipe_ptr, * sel_pipe;
	unsigned int min_order = 0xFFFFFFFF; //Max unsigned integer value

	if (pipe_free_positions == PIPE_SIZE){
		return 0;
	}

	sel_pipe = 0;

	for(i=0; i<PIPE_SIZE; i++){
		pipe_ptr = &pipe[i];
		if (pipe_ptr->status == WAITING_ACK && producer_task == pipe_ptr->producer_task){
			pipe_ptr->status = EMPTY;
			pipe_free_positions++;
			break;
		}
	}

	for(i=0; i<PIPE_SIZE; i++){
		pipe_ptr = &pipe[i];
		// print_pipe_status(pipe_ptr->status);
		// comm_puts(itoa(pipe_ptr->consumer_task));

		if (pipe_ptr->status == USED && producer_task == pipe_ptr->producer_task){

			if(min_order > pipe_ptr->order){
				sel_pipe = pipe_ptr;
				min_order = pipe_ptr->order;
			}
		}
	}
	// comm_puts("\n");

	if (sel_pipe == 0){
		return 0;
	}

	sel_pipe->status = WAITING_ACK;

	return sel_pipe;
}


//alteracao ruarooooooooooooooooooooooooooooooooooo






/** Gets a pipe free position pointer
 *  \return PipeSlot free position pointer
 */
PipeSlot * get_PIPE_free_position(){

	for(int i=0; i<PIPE_SIZE; i++){
		if (pipe[i].status == EMPTY){
			return &pipe[i];
		}
	}

	return 0;
}

/** Inserts a message request into the message_request array
 *  \param producer_task ID of the producer task of the message
 *  \param consumer_task ID of the consumer task of the message
 *  \param requester_proc Processor of the consumer task
 *  \return 0 if the message_request array is full, 1 if the message was successfully inserted
 */
int insert_message_request(int producer_task, int consumer_task, int requester_proc) {

    int i;

    for (i=0; i<REQUEST_SIZE; i++)
    	if ( message_request[i].requester == -1 ) {
    		message_request[i].requester  = consumer_task;
    		message_request[i].requested  = producer_task;
    		message_request[i].requester_proc = requester_proc;

    		//puts("message_request[i].proc "); puts(itoa(message_request[i].requester_proc));puts("\n");
    		//Only for debug purposes
    		MemoryWrite(ADD_REQUEST_DEBUG, (producer_task << 16) | (consumer_task & 0xFFFF));

    		return 1;
		}

    puts("ERROR - request table if full\n");
	return 0;	/*no space in table*/
}

/** Searches for a message request
 *  \param producer_task ID of the producer task of the message
 *  \param consumer_task ID of the consumer task of the message
 *  \return 0 if the message was not found, 1 if the message was found
 */
int search_message_request(int producer_task, int consumer_task) {

    for(int i=0; i<REQUEST_SIZE; i++) {
        if( message_request[i].requested == producer_task && message_request[i].requester == consumer_task){
            return 1;
        }
    }

    return 0;
}

/** Remove a message request
 *  \param producer_task ID of the producer task of the message
 *  \param consumer_task ID of the consumer task of the message
 *  \return -1 if the message was not found or the requester processor address (processor of the consumer task)
 */
int remove_message_request(int producer_task, int consumer_task) {

    for(int i=0; i<REQUEST_SIZE; i++) {
        if( message_request[i].requested == producer_task && message_request[i].requester == consumer_task){
        	message_request[i].requester = -1;
        	message_request[i].requested = -1;

        	//Only for debug purposes
        	MemoryWrite(REM_REQUEST_DEBUG, (producer_task << 16) | (consumer_task & 0xFFFF));

            return message_request[i].requester_proc;
        }
    }

    return -1;
}


/*--------------------------------------------------------------------
 update_msg_request_table FOCHI

--------------------------------------------------------------------*/
unsigned int update_msg_request_table(unsigned int task_id, unsigned int new_processor){
	int i;

	for(i=0;i<MSG_REQUEST_SIZE;i++){

		//puts("task_id "); puts(itoa(task_id));puts("\n");
		//puts("msg_request[i].target_id "); puts(itoa(msg_request[i].target_id));puts("\n");
		//puts("msg_request[i].source_id "); puts(itoa(msg_request[i].source_id));puts("\n");
		//puts("msg_request[i].processor "); puts(itoh(msg_request[i].processor));puts("\n");

		if(	msg_request[i].source_id == task_id){		
			msg_request[i].processor = new_processor;
			//puts("____ msg_request[i].processor "); puts(itoh(msg_request[i].processor));puts("\n");
			return 1;
		}
	}
	return -1;
}

/**Remove all message request of a requested task ID and copies such messages to the removed_msgs array.
 * This function is used for task migration only, when a task need to be moved to other processor
 *  \param requested_task ID of the requested task
 *  \param removed_msgs array pointer of the removed messages
 *  \return number of removed messages
 */
int remove_prod_requested_msgs(int requested_task, unsigned int * removed_msgs){

	int request_index = 0;
	//puts("PRODUCER requested task "); puts(itoa(requested_task));puts("\n");


	for(int i=0; i<REQUEST_SIZE; i++) {
		if ((message_request[i].requested == requested_task) || (message_request[i].requester == requested_task)){

			//Copies the messages to the array
			removed_msgs[request_index++] = message_request[i].requester;
			removed_msgs[request_index++] = message_request[i].requested;
			removed_msgs[request_index++] = message_request[i].requester_proc;

			//puts("message_request[i].requested "); puts(itoa(message_request[i].requested));puts("\n");
			//puts("message_request[i].requester "); puts(itoa(message_request[i].requester));puts("\n");

        	//Only for debug purposes
			MemoryWrite(REM_REQUEST_DEBUG, (message_request[i].requester << 16) | (message_request[i].requested & 0xFFFF));

			//Removes the message request
			message_request[i].requester = -1;
			message_request[i].requested = -1;
		}
	}

	return request_index;
}


/**Remove all message request of a requested task ID and copies such messages to the removed_msgs array.
 * This function is used for task migration only, when a task need to be moved to other processor
 *  \param requested_task ID of the requested task
 *  \param removed_msgs array pointer of the removed messages
 *  \return number of removed messages
 */
int remove_cons_requested_msgs(int task_ID, unsigned int * removed_msgs, int processor){

	int i, request_index = 0;
	comm_puts("CONSUMER requested task "); comm_puts(itoa(task_ID));comm_puts("\n");

	for(i=0;i<MSG_REQUEST_SIZE;i++){
		//puts("msg_request[i].processor "); puts(itoh(msg_request[i].processor));puts("\n");
		//puts("msg_request[i].source_id "); puts(itoa(msg_request[i].source_id));puts("\n");
		//puts("msg_request[i].target_id "); puts(itoa(msg_request[i].target_id));puts("\n");
		//puts("msg_request[i].status "); puts(itoa(msg_request[i].status));puts("\n");

		if(msg_request[i].status  != EMPTY && msg_request[i].target_id == task_ID){

			removed_msgs[request_index++] = msg_request[i].status;
			removed_msgs[request_index++] = msg_request[i].processor;
			removed_msgs[request_index++] = msg_request[i].source_id;
			removed_msgs[request_index++] = msg_request[i].target_id;
			removed_msgs[request_index++] = msg_request[i].last_msg_request_time;

			msg_request[i].status    = EMPTY;
			//puts("remove message request CONSUMER: ");puts(itoa(msg_request[i].source_id));puts("\n");
		}
	}
	return request_index;
}

/**Search for messages in the pipe of this task with WAITING_ACK
 *  \param taskID ID of the task
 *  \return number of changed messages
 */
unsigned int remove_last_msg_waiting_ack(int taskID){

	PipeSlot * pipe_ptr;
	unsigned int msg_count=0;
	int i;

	for(i=0; i<PIPE_SIZE; i++){
		pipe_ptr = &pipe[i];
		if(pipe_ptr->producer_task == taskID){
			msg_count++;
		//	print_pipe_status(pipe_ptr->status);
		
			switch(pipe_ptr->status){
				case WAITING_ACK: /*puts("W");*/ pipe_ptr->status = EMPTY; break;
				// case USED: puts("U"); break;
				// case EMPTY: puts("E"); break;
				// case LOCKED: puts("L"); break;
				// default: puts("*"); break;
			}
		}
	}
	//puts("\n");

	return msg_count;
}

/** Assembles and sends a MESSAGE_DELIVERY packet to a consumer task located into a slave processor
 *  \param producer_task ID of the task that produce the message (Send())
 *  \param consumer_task ID of the task that consume the message (Receive())
 *  \param msg_ptr Message pointer
 */
void send_message_delivery(int producer_task, int consumer_task, int consumer_PE, Message * msg_ptr){

	volatile ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = get_task_location(consumer_task);

	p->service = MESSAGE_DELIVERY;

	p->producer_task = producer_task;

	p->consumer_task = consumer_task;

	p->msg_lenght = msg_ptr->length;

	p->arrival_time = 0x12345678;

//	puts("producer: "); puts(itoh(producer_task));
//	puts("  length: "); puts(itoh(msg_ptr->length));
//	puts("\n");


	send_packet(p, (unsigned int)msg_ptr->msg, msg_ptr->length);
}

/** Assembles and sends a MESSAGE_REQUEST packet to producer task into a slave processor
 * \param producer_task Producer task ID (Send())
 * \param consumer_task Consumer task ID (Receive())
 * \param producer_PE Processor address of the producer task
 * \param sourcePE Processor address of the consumer task
 */
void send_message_request_(int producer_task, int consumer_task, unsigned int producer_PE, unsigned int sourcePE, unsigned int flag_add_msg_request){

	volatile ServiceHeader *p = get_service_header_slot();

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = get_task_location_FAKE(producer_task);

	p->service = MESSAGE_REQUEST;

	p->requesting_processor = sourcePE;

	p->producer_task = producer_task;

	p->consumer_task = consumer_task;

	if(flag_add_msg_request == 1){
		add_msg_request(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1], consumer_task, producer_task);
	}

	send_packet(p, 0, 0);
}


/** Assembles and sends a IO_DELIVERY packet to a peripheral located into a border router
 *  \param producer_task ID of the task that produce the message (IOSend())
 *  \param consumer_task ID of the peripheral that consume the message 
 *  \param msg_ptr Message pointer
 */
void send_message_io(int producer_task, int peripheral_ID, Message * msg_ptr, int secure){

	volatile ServiceHeader *p = get_service_header_slot();

	//p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = get_task_location(consumer_task);
	
	#ifndef GRAY_AREA
	if(secure){
		open_wrapper_IO_SZ(peripheral_ID, 1);  // IO_service: 0 - request; 1 - delivery
		//puts("atrasando o envio do pacote"); puts("\n");
		//get_net_address();
		//puts("atrasando mais um pouco o envio do pacote"); puts("\n");
	}
	#endif

	p->service = IO_DELIVERY;

	p->task_ID = producer_task;

	p->peripheral_ID = peripheral_ID;

	p->msg_lenght = msg_ptr->length;

	send_packet_io(p, (unsigned int)msg_ptr->msg, msg_ptr->length, peripheral_ID);
}

/** Assembles and sends a IO_REQUEST packet to producer peripheral
 * \param peripheral_ID peripheral ID (Send())
 * \param consumer_task Consumer task ID (Receive())
 * \param sourcePE Processor address of the consumer task
 */
void send_io_request(int peripheral_ID, int consumer_task, unsigned int sourcePE, int secure){

	volatile ServiceHeader *p = get_service_header_slot();

	#ifndef GRAY_AREA
	if(secure){
		open_wrapper_IO_SZ(peripheral_ID, 0);  // IO_service: 0 - request; 1 - delivery
	}
	#endif

	p->service = IO_REQUEST;

	p->requesting_processor = sourcePE;

	p->task_ID = consumer_task;

	p->peripheral_ID = peripheral_ID;

	//add_msg_request(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1], consumer_task, peripheral_ID); //caimi: arrumar header

	send_packet_io(p, 0, 0, peripheral_ID);
}


void send_message_io_key(int producer_task, int peripheral_ID, Message * msg_ptr, int secure, unsigned int f1f2){

	volatile ServiceHeader *p = get_service_header_slot();

	//p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = get_task_location(consumer_task);

	#ifndef GRAY_AREA
	if(secure){
		open_wrapper_IO_SZ(peripheral_ID, 0);  // IO_service: 0 - request; 1 - delivery
	}
	#endif

	p->service = f1f2;

	p->io_service = IO_REQUEST;

	// p->task_ID = producer_task;

	p->peripheral_ID = producer_task;

	p->msg_lenght = msg_ptr->length;

	send_packet_io(p, (unsigned int)msg_ptr->msg, msg_ptr->length, peripheral_ID);
}

void send_io_request_key(int peripheral_ID, int consumer_task, unsigned int sourcePE, int secure, unsigned int f1f2){

	volatile ServiceHeader *p = get_service_header_slot();

	#ifndef GRAY_AREA
	if(secure){
		open_wrapper_IO_SZ(peripheral_ID, 0);  // IO_service: 0 - request; 1 - delivery
	}
	#endif

	p->service = f1f2;

	p->io_service = IO_REQUEST;

	p->requesting_processor = sourcePE;

	// p->task_ID = producer_task;

	p->peripheral_ID = consumer_task;

	//add_msg_request(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1], consumer_task, peripheral_ID); //caimi: arrumar header

	send_packet_io(p, 0, 0, peripheral_ID);
}

void send_peripheral_SR_path(int slot_seek, int peripheral_ID, int secure, int task_ID){
	int i;
	volatile ServiceHeader *p = get_service_header_slot();

	#ifndef GRAY_AREA
	if(secure){
		send_wrapper_open_forward(peripheral_ID, 1);  // IO_service: 0 - request; 1 - delivery
	}
	#endif
	
	// p->service = appID;
	p->service = IO_SR_PATH;

	p->task_ID = task_ID;

	p->k0 = 0;
	// p->k0 = ((K1_REG << 16) | K_REG);


	puts("\nTarget: "); puts(itoh(SR_Table[slot_seek].target));
	puts("\nHeader: \n");
	for (i = 0; i < SR_Table[slot_seek].path_size; i++){
		puts("        "); puts(itoh(SR_Table[slot_seek].path[i])); puts("\n");
	}
	// p->consumer_task = consumer_task;

	//add_msg_request(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1], consumer_task, peripheral_ID); //caimi: arrumar header

	send_packet_io(p, &SR_Table[slot_seek].path[0], SR_Table[slot_seek].path_size, peripheral_ID);
}
