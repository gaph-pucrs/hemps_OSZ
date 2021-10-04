/*!\file communication.h
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief Defines the PipeSlot and MessageRequest structures.
 *
 * \detailed
 * PipeSlot stores the user's messages produced by not consumed yet.
 * MessageRequest stores the requested messages send to the consumer task by not produced yet
 */


#ifndef SOFTWARE_INCLUDE_COMMUNICATION_COMMUNICATION_H_
#define SOFTWARE_INCLUDE_COMMUNICATION_COMMUNICATION_H_

#include "../../include/kernel_pkg.h"
#include "../include/api.h"


#define PIPE_SIZE        MAX_LOCAL_TASKS*(MAX_TASKS_APP-1) //MAX_LOCAL_TASKS * 12 //6 //3 //24				//!< Size of the pipe array in fucntion of the maximum number of local task
#define REQUEST_SIZE	 MAX_LOCAL_TASKS*(MAX_TASKS_APP) //50	//!< Size of the message request array in fucntion of the maximum number of local task and max task per app
#define MAX_TASK_SLOTS	 PIPE_SIZE/MAX_LOCAL_TASKS				//!< Maximum number of pipe slots that a task have

/**
 * \brief This enum stores the pipe status
 */
enum PipeSlotStatus {EMPTY, LOCKED, USED, WAITING_ACK};

/**
 * \brief This structure store a task message (Message) in a kernel memory area called PIPE
 */
typedef struct {
	int producer_task;			//!< Stores producer task id (task that performs the Send() API )
	int consumer_task;			//!< Stores consumer task id (task that performs the Receive() API )
	Message message;			//!< Stores the message itself - Message is a structure defined into api.h
	char status;				//!< Stores pipe status
	unsigned int order;		//!< Stores pipe message order, useful to sort the messages stored in the pipe
} PipeSlot;


/**
 * \brief This structure stores the message requests used to implement the blocking Receive MPI
 */
typedef struct {
    int requester;             	//!< Store the requested task id ( task that performs the Receive() API )
    int requested;             	//!< Stores the requested task id ( task that performs the Send() API )
    int requester_proc;			//!< Stores the requester processor address
} MessageRequest;


//#####WARNING, ASSUMING 2*MAXLOCALTASKS as maximum size
	#define MSG_REQUEST_SIZE  2*MAX_LOCAL_TASKS
	typedef struct {
		char status;
		unsigned int processor;
		unsigned int source_id;
		unsigned int target_id;
		unsigned int last_msg_request_time;
	} msg_requestSlot;


// #define send_message_request_without_add_msg_req(producer_task, consumer_task, sourcePE) send_message_request_(producer_task, consumer_task, sourcePE, 0)


void init_communication();

PipeSlot * add_PIPE(int, int, Message *);

unsigned int search_PIPE_producer(int);

unsigned int PIPE_msg_number();

PipeSlot * remove_PIPE(int,  int);

PipeSlot * get_PIPE_free_position();

int insert_message_request(int, int, int);

int search_message_request(int, int);

int remove_message_request(int, int);

int remove_prod_requested_msgs(int, unsigned int *);

int remove_cons_requested_msgs(int, unsigned int *, int);

void update_msg_request_migration(unsigned int , unsigned int );

void initFTStructs();

unsigned int add_msg_request(unsigned int processor, unsigned int target_id, unsigned int source_id);

unsigned int remove_msg_request(unsigned int processor, unsigned int target_id, unsigned int source_id);

void print_msg_req();

unsigned int resend_msg_request(unsigned int processor);

unsigned int resend_messages(int remote_addr);

void send_message_delivery(int, int, int, Message *);
 
void send_message_request_(int, int, unsigned int, unsigned int,  unsigned int);

void send_message_io(int, int, Message *, int);

void send_io_request(int, int, unsigned int, int);

void send_peripheral_SR_path(int, int, int);

#define send_message_request(producer_task, consumer_task, producer_PE, sourcePE) send_message_request_(producer_task, consumer_task, producer_PE, sourcePE, 1)
	
unsigned int remove_last_msg_waiting_ack(int taskID);

//#define comm_puts(argument) puts(argument)
#define comm_puts(argument) 

#endif /* SOFTWARE_INCLUDE_COMMUNICATION_COMMUNICATION_H_ */
