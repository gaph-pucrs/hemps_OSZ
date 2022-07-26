/*!\file cluster_scheduler.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief Selects where to execute a task and application
 * \detailed Cluster scheduler implements the cluster resources management,
 * task mapping, application mapping, and also can implement task migration heuristics.
 * Adittionally it have a function named: SearchCluster, which selects the cluster to send an application. This
 * function in only used in the global master mode
 */


#include "control_messages_fifo.h"
#include "utils.h"

 ControlMessagesFifo CMFifo[CM_FIFO_LENGTH];

 static unsigned int cmfifo_ptr = 0;


void insert_CM_FIFO(volatile ServiceHeader *p, unsigned int initial_address, unsigned int dmni_msg_size){
    int aux;
	switch(p->service){

		// services that uses PIPE
		case MESSAGE_REQUEST:
		case MESSAGE_DELIVERY:
		case IO_OPEN_WRAPPER:
		case IO_SR_PATH:
				return;
		break;

		// services without payload but only one copy in FIFO
		case LOAN_PROCESSOR_REQUEST:
		case INITIALIZE_CLUSTER:
		case IO_INIT:
		case INITIALIZE_SLAVE:
				if( search_Service(p->service) == -1 )
					return; 								// @suppress("No break at end of case")

		// services with payload: save the pointer to data and length
		case IO_DELIVERY:
		case IO_REQUEST:
		case NEW_APP:
		case TASK_ALLOCATION:
		case APP_ALLOCATION_MAP:
		case TASK_RELEASE:
		case TASKS_LOCATION:
		case APP_TERMINATED:
		case MIGRATION_CODE:
		case MIGRATION_TCB: 
		case MIGRATION_TASK_LOCATION: 
		case MIGRATION_PRODUCER_MSG_REQUEST: 
		case MIGRATION_CONSUMER_MSG_REQUEST: 
		case MIGRATION_STACK: 
		case MIGRATION_DATA_BSS: 
		case MIGRATION_PIPE: //ANALISAR FOCHI
			 CMFifo[cmfifo_ptr].ptr_payload    = initial_address;
			 CMFifo[cmfifo_ptr].payload_length = dmni_msg_size;      // @suppress("No break at end of case")

		//  all services copy the service header to CM_FIFO
		case TASK_ALLOCATED:
		case TASK_TERMINATED:
		case TASK_TERMINATED_OTHER_CLUSTER:
		case TASK_MIGRATION:
		case TASK_MIGRATED:
		case UPDATE_TASK_LOCATION:
		case LOAN_PROCESSOR_DELIVERY:
		case LOAN_PROCESSOR_RELEASE:
		case SLACK_TIME_REPORT:
		case RND_VALUE:
		case KE_VALUE:
		case REAL_TIME_CHANGE:
			 for(int i = 0; i < MAX_SOURCE_ROUTING_PATH_SIZE; i++)
			 		CMFifo[cmfifo_ptr].service_header.header[i] = p->header[i];
			 CMFifo[cmfifo_ptr].service_header.payload_size 	= p->payload_size;
			 CMFifo[cmfifo_ptr].service_header.service 			= p->service;
			 CMFifo[cmfifo_ptr].service_header.task_ID 			= p->task_ID;
			 CMFifo[cmfifo_ptr].service_header.cluster_ID 		= p->cluster_ID;
			 CMFifo[cmfifo_ptr].service_header.source_PE 		= p->source_PE;
			 CMFifo[cmfifo_ptr].service_header.timestamp 		= p->timestamp;
			 CMFifo[cmfifo_ptr].service_header.transaction 		= p->transaction;
			 CMFifo[cmfifo_ptr].service_header.msg_lenght 		= p->msg_lenght;
			 CMFifo[cmfifo_ptr].service_header.pkt_size 		= p->pkt_size;
			 CMFifo[cmfifo_ptr].service_header.code_size 		= p->code_size;
			 CMFifo[cmfifo_ptr].service_header.bss_size 		= p->bss_size;
			 CMFifo[cmfifo_ptr].service_header.initial_address  = p->initial_address;

			 CMFifo[cmfifo_ptr].used = NO;
			 //puts("\nIndex: "); puts(itoh(cmfifo_ptr)); 
			 //puts("  Service: "); puts(itoh(CMFifo[cmfifo_ptr].service_header.service)); 
			 //puts("  Target: "); puts(itoh(CMFifo[cmfifo_ptr].service_header.header[MAX_SOURCE_ROUTING_PATH_SIZE-1] & 0xffff)); puts("\n");

			 cmfifo_ptr = (cmfifo_ptr + 1)%CM_FIFO_LENGTH;

			 //print_CM_FIFO();
			 //aux = search_Target(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] & 0xffff);
			 //puts("achou: "); puts(itoh(aux)); puts("\n");

			 //aux = search_Service(p->service);
			 //puts("achou: "); puts(itoh(aux)); puts("\n");

			 //aux = search_Target_Service((p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] & 0xffff), p->service);
			 //puts("achou: "); puts(itoh(aux)); puts("\n");
		break;

		default:
			puts("\nERROR: control message NOT treat in CM_FIFO structure\n");
			//while(1);
			puts(itoh(p->service)); puts("\n");
		break;

	}
}


int search_Service(unsigned int service_code){
	int i;
	//puts("Service: "); puts(itoh(service_code)); puts("\n");
	if(cmfifo_ptr>0)
		i = cmfifo_ptr-1;
	else
		i = CM_FIFO_LENGTH-1;

	for(int ctr = 0; ctr < CM_FIFO_LENGTH; ctr++){
		if(CMFifo[i].service_header.service == service_code)
			return i;
		i = i - 1;
		if(i < 0)
			i = CM_FIFO_LENGTH-1;
	}
	return -1;
}
int get_CM_peripheral_ID(int CM_index){
	return CMFifo[CM_index].service_header.cluster_ID;
}

int get_CM_IO_service(int CM_index){
	if( CMFifo[CM_index].service_header.service == IO_REQUEST )
		return 0;
	else if( CMFifo[CM_index].service_header.service == IO_DELIVERY )
		return 1;
	else{
		puts("ERROR: IO_service not found!!!\n");
		while(1);
	}
}


// int search_Target(unsigned int target){
// 	unsigned int aux_header;
// 	int  i;
	
// 	//puts("Target: "); puts(itoh(target)); puts("\n");
// 	if(cmfifo_ptr>0)
// 		i = cmfifo_ptr-1;
// 	else
// 		i = CM_FIFO_LENGTH-1;

// 	for(int ctr = 0; ctr < CM_FIFO_LENGTH; ctr++){
// 		aux_header = -1;
// 		aux_header = CMFifo[i].service_header.header[MAX_SOURCE_ROUTING_PATH_SIZE-1];
// 		//puts("aux_header: "); puts(itoh(aux_header)); puts("\n");
// 		if(((aux_header & 0xffff) == target) && CMFifo[i].used == NO)
// 				return i;
// 		i = i - 1;
// 		if(i < 0)
// 			i = CM_FIFO_LENGTH-1;
// 	}
// 	return -1;
// }


int search_Target(unsigned int target){
	unsigned int aux_header;
	int  x, i;
	
	// puts("Target: "); puts(itoh(target)); puts("\n");
	if(cmfifo_ptr>0)
		i = cmfifo_ptr-1;
	else
		i = CM_FIFO_LENGTH-1;

	for(int ctr = 0; ctr < CM_FIFO_LENGTH; ctr++){
		//puts("  ctr: "); puts(itoh(ctr)); puts("\n");
		aux_header = -1;
		x = MAX_SOURCE_ROUTING_PATH_SIZE-1;
		while((x >= 0) && aux_header != 0){
		     aux_header = CMFifo[i].service_header.header[x] & 0xffff;
			//  puts("aux_header: "); puts(itoh(aux_header)); puts("\n");
			//  puts("teste: "); puts(itoh((aux_header & 0xffff) == target)); puts("\n");
			 if(aux_header == target ){
			 		// puts("found: "); puts(itoh(target)); puts("\n");
					return i;
			 }
			 x--;
		}
		i = i - 1;
		if(i < 0)
			i = CM_FIFO_LENGTH-1;
	}
	return -1;
}




void initialize_CM_FIFO(){
	for(int i = 0; i < CM_FIFO_LENGTH; i++)
		CMFifo[i].service_header.service = 0;

}

void print_CM_FIFO(){
	puts("\n");
	for(int i = 0; i < CM_FIFO_LENGTH; i++){
		puts("Index: "); puts(itoh(i));
		puts("  service: "); puts(itoh(CMFifo[i].service_header.service));
		puts("  header: "); puts(itoh(CMFifo[i].service_header.header[MAX_SOURCE_ROUTING_PATH_SIZE-1]));
		puts("\n");

	}
}


int resend_control_message(unsigned int backtrack, unsigned int backtrack1, unsigned int backtrack2, unsigned int target){
	int CMFifo_index;

	// print_CM_FIFO();
	CMFifo_index = search_Target(target);
	puts("CMFifo_index: "); puts(itoh(CMFifo_index)); puts("\n");
	if(CMFifo_index != -1){
		if((CMFifo[CMFifo_index].service_header.service != IO_DELIVERY) && (CMFifo[CMFifo_index].service_header.service != IO_REQUEST)){
			//puts("\nSR control message\n");
			send_packet(&CMFifo[CMFifo_index].service_header, CMFifo[CMFifo_index].ptr_payload , CMFifo[CMFifo_index].payload_length);
			CMFifo[CMFifo_index].used = YES;
			return 1;
		}
		else{ // ajustar backtrack para o IO
			puts("SR IO message\n");
			// puts("target: "); puts(itoh(SR_Table[slot_seek].target)); puts("\n");			
			adjust_backtrack_IO(backtrack, backtrack1, backtrack2, target);
			// service_header.cluster_ID contains the peripheral_ID; service_header.task_ID contains the io_service;
			#ifndef GRAY_AREA
			open_wrapper_IO_SZ(CMFifo[CMFifo_index].service_header.cluster_ID, CMFifo[CMFifo_index].service_header.task_ID);
			#endif 

			send_packet(&CMFifo[CMFifo_index].service_header, CMFifo[CMFifo_index].ptr_payload , CMFifo[CMFifo_index].payload_length);
			CMFifo[CMFifo_index].used = YES;
			//puts("\nenviou message\n");
			return 1;
		}
	}
	else{
		puts("\nERROR: control message NOT found!!!");
		return 0;
	}

}
