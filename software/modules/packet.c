/*!\file packet.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * This module implements function relative to programming the DMNI to send and receibe a packet.
 * \detailed
 * It is a abstraction from the NoC to the software components.
 * This module is used by both manager and slave kernel
 */

#include "packet.h"
#include "../include/plasma.h"
#include "control_messages_fifo.h"


#ifdef AES_MODULE
#include "aes.h"
#endif 

#ifdef PRESENT_MODULE
#include "present.h"
#endif 


ServiceHeaderSlot sh_slot1, sh_slot2;	//!<Slots to prevent memory writing while is sending a packet

unsigned int global_inst = 0;			//!<Global CPU instructions counter


#ifdef AES_MODULE
	unsigned int key_schedule[60];
	unsigned int enc_buf[128];
	unsigned int input_text[16]; 
	unsigned int key[1][32] = {
		{0x60,0x3d,0xeb,0x10,0x15,0xca,0x71,0xbe,0x2b,0x73,0xae,0xf0,0x85,0x7d,0x77,0x81,0x1f,0x35,0x2c,0x07,0x3b,0x61,0x08,0xd7,0x2d,0x98,0x10,0xa3,0x09,0x14,0xdf,0xf4}
	};
#endif 

#ifdef PRESENT_MODULE
	u8 inputKey[10] = {0x2f};
	u8 keys[PRESENT_KEY_SIZE_128/8*(PRESENT_ROUNDS+1)];
	u8 plainText[] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
#endif 


/**Searches for a free ServiceHeaderSlot (sh_slot1 or sh_slot2) pointer.
 * A free slot is the one which is not being used by DMNI. This function prevents that
 * a given memory space be changed while its is not completely transmitted by DMNI.
 * \return A pointer to a free ServiceHeadeSlot
 */
volatile ServiceHeader* get_service_header_slot() {

	if ( sh_slot1.status ) {

		sh_slot1.status = 0;
		sh_slot2.status = 1;
		return &sh_slot1.service_header;

	} else {

		sh_slot2.status = 0;
		sh_slot1.status = 1;
		return &sh_slot2.service_header;
	}
}

/**Initializes the service slots
 */
void init_service_header_slots(){
	sh_slot1.status = 1;
	sh_slot2.status = 1;
}

/**Function that abstracts the DMNI programming for read data from NoC and copy to memory
 * \param initial_address Initial memory address to copy the received data
 * \param dmni_msg_size Data size, is represented in memory word of 32 bits
 * \return 1 if the read was sucessfull and -1 if not
 */
int DMNI_read_data(unsigned int initial_address, unsigned int dmni_msg_size){

	MemoryWrite(DMNI_SIZE, dmni_msg_size);
	MemoryWrite(DMNI_OP, WRITE);
	MemoryWrite(DMNI_ADDRESS, initial_address);
	MemoryWrite(DMNI_START, 1);

	while (MemoryRead(DMNI_RECEIVE_ACTIVE)){
		if(MemoryRead(DMNI_TIMEOUT_SIGNAL) == 1){
			puts("failed payload reception\n");
			return -1;
		}
	}

	return 1;
}

/**Function that abstracts the DMNI programming for send data from memory to NoC
 * \param initial_address Initial memory address that will be transmitted to NoC
 * \param dmni_msg_size Data size, is represented in memory word of 32 bits
 */
void DMNI_send_data(unsigned int initial_address, unsigned int dmni_msg_size){

	while (MemoryRead(DMNI_SEND_ACTIVE));

	MemoryWrite(DMNI_SIZE, dmni_msg_size);
	MemoryWrite(DMNI_OP, READ);
	MemoryWrite(DMNI_ADDRESS, initial_address);
	MemoryWrite(DMNI_START, 1);
}

/**Function that abstracts the process to send a generic packet to NoC by programming the DMNI
 * \param p Packet pointer
 * \param initial_address Initial memory address of the packet payload (payload, not service header)
 * \return dmni_msg_size Packet payload size represented in memory words of 32 bits
 */
void send_packet(ServiceHeader *p, unsigned int initial_address, unsigned int dmni_msg_size){

		unsigned int slot;
		int i;
		enum {DISTRIBUTED_ROUTING, SOURCE_ROUTING} packet_type;


	#ifdef AES_MODULE
	unsigned int num_aes_packets, x;
    
    if(p->service == MESSAGE_DELIVERY){
    	putsv("Start Encrypt - ", MemoryRead(TICK_COUNTER)); 		
    	num_aes_packets = ((int) dmni_msg_size / 16) + (dmni_msg_size%16?1:0);
		for(x = 0; x < num_aes_packets; x++ ){
			puts("E \n");
			aes_encrypt(input_text, enc_buf, key_schedule, KEY_SIZE);	
		}
		putsv("End Encrypt - ", MemoryRead(TICK_COUNTER)); 		
	}
	#endif	

	#ifdef PRESENT_MODULE
	unsigned int num_aes_packets, x;
    
    if(p->service == MESSAGE_DELIVERY){
    	putsv("Start Encrypt - ", MemoryRead(TICK_COUNTER)); 		
    	num_aes_packets = ((int) dmni_msg_size / 8) + (dmni_msg_size%8?1:0);
		for(x = 0; x < num_aes_packets; x++ ){
			puts("E \n");
			present_encrypt(plainText, keys);	
		}
		putsv("End Encrypt - ", MemoryRead(TICK_COUNTER)); 		
	}
	#endif	

//	if(p->service == MIGRATION_DATA_BSS){
//		puts("send data bss \n");
//	}

	//NEW
	p->payload_size = (CONSTANT_PKT_SIZE - 2) + dmni_msg_size;
	//NEW/

	p->transaction = 0x1234;

	p->source_PE = get_net_address();
	
	// puts("original:");
	// puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1]));
	// puts("\n");
	

		//get slot
		slot = SearchSourceRoutingDestination(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1]&0xffff);
		//verify if path is a source routing destination
		if(slot != -1){

			//move XY header to before SR header
			p->header[MAX_SOURCE_ROUTING_PATH_SIZE-SR_Table[slot].path_size-1] = ((((p->source_PE & 0x3F00) >> 2) | (p->source_PE & 0x003F)) << 16) | p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1];

			//if it is stored, must fulfill header with SR path
			for(i=0;i<SR_Table[slot].path_size;i++){
				p->header[MAX_SOURCE_ROUTING_PATH_SIZE-SR_Table[slot].path_size+i] = SR_Table[slot].path[i];
				// puts("p->header:");puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-SR_Table[slot].path_size+i]));puts("\n");
			}
			packet_type = SOURCE_ROUTING;
		}
		else{
			
			//NEW
			p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = ((((p->source_PE & 0x3F00) >> 2) | (p->source_PE & 0x003F)) << 16) | p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1];

			//NEW
			// p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2];
			p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = ((((p->source_PE & 0x3F00) >> 2) | (p->source_PE & 0x003F)) << 16) | p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1];

			packet_type = DISTRIBUTED_ROUTING;
		}


		//Waits the DMNI send process be released
		while (MemoryRead(DMNI_SEND_ACTIVE));

		p->timestamp = MemoryRead(TICK_COUNTER);


		if(packet_type == SOURCE_ROUTING){
			MemoryWrite(DMNI_SIZE, CONSTANT_PKT_SIZE + SR_Table[slot].path_size-1);
			// puts("sizehPKT:");puts(itoh(SR_Table[slot].path_size));puts("\n");
			MemoryWrite(DMNI_ADDRESS, (unsigned int) &p->header[MAX_SOURCE_ROUTING_PATH_SIZE-SR_Table[slot].path_size-1]);
		}else{
			MemoryWrite(DMNI_SIZE, CONSTANT_PKT_SIZE);
			//NEW
			// MemoryWrite(DMNI_ADDRESS, (unsigned int) &p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1]);
			MemoryWrite(DMNI_ADDRESS, (unsigned int) &p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2]);
			//NEW/
		}

		if (dmni_msg_size > 0){
			MemoryWrite(DMNI_SIZE_2, dmni_msg_size);
			MemoryWrite(DMNI_ADDRESS_2, initial_address);
		}

		MemoryWrite(DMNI_OP, READ);
		MemoryWrite(DMNI_START, 1);

		insert_CM_FIFO(p, initial_address, dmni_msg_size);
}

int get_last_hop(unsigned int addX, unsigned int addY){
	int x;
    //puts("X: "); puts(itoa(addX)); puts(" Y: "); puts(itoa(addY)); puts("\n");
	for(x = 0; x < IO_NUMBER; x++){
		if((io_info[x].default_address_x == addX) && (io_info[x].default_address_y == addY)){
			switch(io_info[x].default_port){
				case OUT_EAST:  return 0; break;
				case OUT_WEST:  return 1; break;
				case OUT_NORTH: return 2; break;
				case OUT_SOUTH: return 3; break;
			}
		}
	}
    //puts("saiu last hop\n");
	return -1;
}


int find_io_peripheral(unsigned int address){
	int i;
    for(i = 0; i < IO_NUMBER; i++){
        if((io_info[i].default_address_x == ((address & 0xFF00) >> 8)) && (io_info[i].default_address_y == (address & 0x00FF))){
        	return io_info[i].peripheral_id;
        }
    }
    return 0;
}

int find_peripheral_at_line_column(unsigned int ll_address){
    int i, X_LL, Y_LL;

    X_LL = ll_address >> 8;
    Y_LL = ll_address & 0xFF;

    for(i = 0; i < IO_NUMBER; i++){
        if( (X_LL == io_info[i].default_address_x ) && (Y_LL <= io_info[i].default_address_y) || 
            (Y_LL == io_info[i].default_address_y ) && (X_LL <= io_info[i].default_address_x) ){
                return 1;
        }
    }
    return 0;
}

int peripheral_connected_to_PE(int X_addr, int Y_addr){
    int i;
    for(i = 0; i < IO_NUMBER; i++){
        if( (X_addr == io_info[i].default_address_x ) && (Y_addr == io_info[i].default_address_y ) ){
                return 1;
        }
    }
    return 0;
}



/**Function that abstracts the process to send a IO packet to NoC by programming the DMNI
 * \param p Packet pointer
 * \param initial_address Initial memory address of the packet payload (payload, not service header)
 * \peripheral ID 
 * \return dmni_msg_size Packet payload size represented in memory words of 32 bits
 */
void send_packet_io(ServiceHeader *p, unsigned int initial_address, unsigned int dmni_msg_size, int peripheral_id){

	unsigned int slot;
	int i, port_io;

    char SepKey[16] = {0,1,2,3,4,5,6,7,8,9,0xa,0xb,0xc,0xd,0xe,0xf};

	port_io = -1;
	for(i = 0; i < IO_NUMBER; i++){
		if(io_info[i].peripheral_id == peripheral_id){
			//if(io_info[i].active_connection == 0){
				p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = ((io_info[i].default_address_x << 8) | io_info[i].default_address_y);
				port_io = io_info[i].default_port;
			//}
			//else{
			//	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = ((io_info[i].alternative_address_x << 8) | io_info[i].alternative_address_y);
			//	port_io = io_info[i].alternative_port;
			//}
			break;
		}
	}

	if (port_io == -1) {
		puts(" peripheral_id not found!\n");
		while(1){
			
		};
	}

	p->payload_size = (CONSTANT_PKT_SIZE - 2) + dmni_msg_size;

	p->transaction = 0;

	p->source_PE = get_net_address();
	

	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = ((port_io & 0xF)<<28)|((((p->source_PE & 0x3F00) >> 2) | (p->source_PE & 0x003F)) << 16) | p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1];
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = ((port_io & 0xF)<<28)|((((p->source_PE & 0x3F00) >> 2) | (p->source_PE & 0x003F)) << 16) | p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1];


    //putsv("length - ", 14*4); 
    //putsv("Init header MAC - ", MemoryRead(TICK_COUNTER)); 
    //siphash24((void *)p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2], 14*4, SepKey);
    //putsv("End header MAC - ", MemoryRead(TICK_COUNTER)); 


        //Waits the DMNI send process be released
    while (MemoryRead(DMNI_SEND_ACTIVE));
    
	p->timestamp = MemoryRead(TICK_COUNTER);


	MemoryWrite(DMNI_SIZE, CONSTANT_PKT_SIZE);
	MemoryWrite(DMNI_ADDRESS, (unsigned int) &p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2]);

	if (dmni_msg_size > 0){
		MemoryWrite(DMNI_SIZE_2, dmni_msg_size);
		MemoryWrite(DMNI_ADDRESS_2, initial_address);
	}

	MemoryWrite(DMNI_OP, READ);
	MemoryWrite(DMNI_START, 1);

	insert_CM_FIFO(p, initial_address, dmni_msg_size);
}

/**Function that abstracts the process to read a generic packet from NoC by programming the DMNI
 * \param p Packet pointer
 * \return 1 if the read was sucessfull and -1 if not
 */
int read_packet(ServiceHeader *p){

	#ifdef AES_MODULE
	unsigned int num_aes_packets, x;
	#endif

	#ifdef PRESENT_MODULE
	unsigned int num_aes_packets, x;
	#endif	

	MemoryWrite(DMNI_SIZE, CONSTANT_PKT_SIZE);
	MemoryWrite(DMNI_OP, WRITE);

	// for source routing packets, it receiveis always a SR header with 1 flit
	MemoryWrite(DMNI_ADDRESS, (unsigned int) &p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2]);

	MemoryWrite(DMNI_START, 1);
	

	while (MemoryRead(DMNI_RECEIVE_ACTIVE)){
		if(MemoryRead(DMNI_TIMEOUT_SIGNAL) == 1){
			//NEW
			puts(itoh(p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2]));
			puts(" failed header reception\n");
			return -1;
		}
	}


	#ifdef AES_MODULE  
	if(p->service == MESSAGE_DELIVERY){
		putsv("Start Decrypt - ", MemoryRead(TICK_COUNTER)); 		
    	num_aes_packets = ((int) p->msg_lenght / 16) + (p->msg_lenght%16?1:0);
		for(x = 0; x < num_aes_packets; x++ ){
			puts("D \n");
			aes_decrypt(input_text, enc_buf, key_schedule, KEY_SIZE);	
		}
		putsv("End Decrypt - ", MemoryRead(TICK_COUNTER)); 	
	}
	#endif	

	#ifdef PRESENT_MODULE  
	if(p->service == MESSAGE_DELIVERY){
		putsv("Start Decrypt - ", MemoryRead(TICK_COUNTER)); 		
    	num_aes_packets = ((int) p->msg_lenght / 8) + (p->msg_lenght%8?1:0);
		for(x = 0; x < num_aes_packets; x++ ){
			puts("D \n");
			present_decrypt(plainText, keys);	
		}
		putsv("End Decrypt - ", MemoryRead(TICK_COUNTER)); 	
	}
	#endif		

	return 1;
}
