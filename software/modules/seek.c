#include "seek.h"
//#include "communication.h"

SourceRoutingTableSlot SR_Table[MAX_SOURCE_ROUTING_DESTINATIONS];

int net_addr;
extern unsigned int 	net_address;

// GrayArea ga = {
// 	{3}, {0,1}, 2
// };
//int LOCAL_left_low_corner = -1;
//int LOCAL_right_high_corner = -1;
//int wrapper_value = 0;

/*--------------------------------------------------------------------
* initSRstructs
*
* DESCRIPTION:
*    Initialize structures for executing source routing (SR_Table)
*
*    parameters: none
*    
*    return: 1
*--------------------------------------------------------------------*/
int initSRstructs(){
	int i;

	net_addr = MemoryRead(NI_CONFIG);

	// puts("\ninitSRstructs");
	for (i=0; i<MAX_SOURCE_ROUTING_DESTINATIONS; i++){
		SR_Table[i].tableSlotStatus = SR_LIVRE;
		// puts("\n:tableSlotStatus:");puts(itoh(SR_Table[i].tableSlotStatus));
	}
	return 1;
}

/*--------------------------------------------------------------------
* GetFreeSlotSourceRouting
*
* DESCRIPTION:
*    Searches SR_Table structure for a free space (SR_LIVRE status)
*
*    parameters: none
*    
*    return: the position or -1 if there is no free position
*--------------------------------------------------------------------*/
int GetFreeSlotSourceRouting(int target){
	int i;
	for (i=0; i<MAX_TASK_COMMUNICATION; i++){
		if(target == SR_Table[i].target && SR_Table[i].tableSlotStatus == SR_USADO){
			return -1;
		}
	}
	for (i=0; i<MAX_SOURCE_ROUTING_DESTINATIONS; i++){
		if(SR_Table[i].tableSlotStatus == SR_LIVRE){
			return i;
		}
	}
	puts("There is no space for storing Source Routing destination\n");
	return -1;
}




/*--------------------------------------------------------------------
* SearchSourceRoutingDestination
*
* DESCRIPTION:
*    Searches PE target in SR_Table (SR_USE status)
*	 If it is stored, then it should use the stored Source Routing
*
*    parameters: target PE address
*    
*    return: the position of the SR_Table or -1 if target is not Source
*	 Routing
*--------------------------------------------------------------------*/
int SearchSourceRoutingDestination(int target){
	int i;
	for (i=0; i<MAX_TASK_COMMUNICATION; i++){
		if(target == SR_Table[i].target && SR_Table[i].tableSlotStatus == SR_USADO){
			return i;
		}
	}
	return -1;	
}

/*--------------------------------------------------------------------
* ClearSlotSourceRouting
*
* DESCRIPTION:
*    Searches PE target in SR_Table (SR_USE status)
*	 If it is stored, then it clear setting to SR_LIVRE
*
*    parameters: target PE address
*    
*    return: the position of the SR_Table or -1 if target is not Source
*	 Routing
*--------------------------------------------------------------------*/
int ClearSlotSourceRouting(int target){
	int i;
	for (i=0; i<MAX_TASK_COMMUNICATION; i++){
		if(target == SR_Table[i].target && SR_Table[i].tableSlotStatus == SR_USADO){
			SR_Table[i].tableSlotStatus = SR_LIVRE;
			//puts("Clear\n");
			return i;
		}
	}
	return -1;	
}


/*--------------------------------------------------------------------
* ClearAllSourceRouting
*
* DESCRIPTION:
*    clear SR_Table (SR_USE status) setting to SR_LIVRE
*
*--------------------------------------------------------------------*/
void ClearAllSourceRouting(){
	int i;
	for (i=0; i<MAX_TASK_COMMUNICATION; i++){
		if(SR_Table[i].tableSlotStatus == SR_USADO){
			SR_Table[i].tableSlotStatus = SR_LIVRE;
		}
	}
}

void print_SR_Table(slot_seek){
	//SR_Table[i].path
	int i;
	puts("\nHeader: \n");
	for (i = 0; i < SR_Table[slot_seek].path_size; i++){
		puts("        "); puts(itoh(SR_Table[slot_seek].path[i])); puts("\n");
	}
}	


void print_port(unsigned int port){
	switch(port){
		case 0x0: puts("E0"); break;	//0000
		case 0x4: puts("E1"); break;	//0100	
		case 0x1: puts("W0"); break;	//0001
		case 0x5: puts("W1"); break;	//0101
		case 0x2: puts("N0"); break;	//0010
		case 0x6: puts("N1"); break;	//0110
		case 0x3: puts("S0"); break;	//0011
		case 0x7: puts("S1"); break;	//0111
		default: puts("-"); break;
	}
}



void Seek(unsigned int service, unsigned int source, unsigned int target, unsigned int payload){
		MemoryWrite(SEEK_SERVICE_REGISTER,service);
		MemoryWrite(SEEK_SOURCE_REGISTER,source);
		MemoryWrite(SEEK_PAYLOAD_REGISTER, payload);
		switch(service){
			case PACKET_RESEND_SERVICE:
			case CLEAR_SERVICE:
			case END_TASK_SERVICE:
			case END_TASK_OTHER_CLUSTER_SERVICE:
			case START_APP_SERVICE:
			case TASK_ALLOCATED_SERVICE:
			case SET_SECURE_ZONE_SERVICE:
			case SET_SZ_RECEIVED_SERVICE:
			case SET_EXCESS_SZ_SERVICE:
			case OPEN_SECURE_ZONE_SERVICE:
			case SECURE_ZONE_CLOSED_SERVICE:
			case SECURE_ZONE_OPENED_SERVICE:
			case UNFREEZE_TASK_SERVICE:
			case FREEZE_TASK_SERVICE:
			case RCV_FREEZE_TASK_SERVICE:
			// case LOAN_PROCESSOR_REQUEST_SERVICE:
			// case LOAN_PROCESSOR_RELEASE_SERVICE:
			case INITIALIZE_SLAVE_SERVICE:
			case INITIALIZE_CLUSTER_SERVICE:
			case GMV_READY_SERVICE:
				 MemoryWrite(SEEK_OPMODE_REGISTER,GLOBAL_MODE);
			break;

			case TARGET_UNREACHABLE_SERVICE:
			case BACKTRACK_SERVICE:
			case SEARCHPATH_SERVICE:
			case WARD_SERVICE:
			case MSG_DELIVERY_CONTROL:
			case MSG_REQUEST_CONTROL:
				 MemoryWrite(SEEK_OPMODE_REGISTER,RESTRICT_MODE);
			break;

			default:
				 MemoryWrite(SEEK_OPMODE_REGISTER,GLOBAL_MODE);

			break;
		}
		// Must be last value written because target value fires the seek_send function

		MemoryWrite(SEEK_TARGET_REGISTER,target);  

		//puts("\nTask id: "); puts(itoa(current->id)); putsv(" seek service: ", service);
}

	/**Processes the information of the path from seek router and stores
	 * the resultant Source Routing path in SR_Table indexed by slot_seek.
	 * \param slot_seek position
	 * \return void function
	 */
int ProcessTurns(unsigned int backtrack, unsigned int backtrack1, unsigned int backtrack2){
	int i,j;
	int slot_seek;
	// unsigned int backtrack, backtrack1, backtrack2;
	unsigned int next_port;
	unsigned int port[MAX_SOURCE_ROUTING_DESTINATIONS];//used for storing hops
	unsigned char algorithm;
	unsigned int shift;
	int addrX, addrY;
	addrX=0;
	addrY=0;
	j=0;//variable j is used to index the final path
	i=0;//variable i is used to index the number of ports (2 bits) read
	//this loop reads the flits and puts each port in each position of table.port[i]
	do {
		port[i] = backtrack & 0x3;
		next_port = (backtrack >> 2) & 0x3;
		backtrack >>= 2;
		i++;
		if(i==16){
			backtrack = backtrack1;
		}
		else if(i==32){
			backtrack = backtrack2;
		}
	}while( !( (port[i-1] == EAST  && next_port == WEST) ||//if the path is EW WE SN NS then we should stop here
			  (port[i-1] == WEST  && next_port == EAST)  ||
			  (port[i-1] == NORTH && next_port == SOUTH) ||
			  (port[i-1] == SOUTH && next_port == NORTH) ) );
	port[i] = next_port;
	//calculates target destination
	for(j=0;j<i;j++){
		switch(port[j]){
			case EAST: addrX++; break;
			case WEST: addrX--; break;
			case NORTH: addrY++; break;
			case SOUTH: addrY--; break;
		}
	}
	//gets target address
	seek_puts("Target: ");seek_puts(itoh((((net_address>>8) + addrX)<<8) | ((net_address + addrY)&0xff)));seek_puts("\n");

	//gets index in SR_Table
	slot_seek = SearchSourceRoutingDestination( (((net_address>>8) + addrX)<<8) | ((net_address + addrY)&0xff) );
	if (slot_seek == -1){
		puts("Calculando pro IO\n");
		slot_seek = SearchSourceRoutingDestination( (((net_address>>8))<<8) | ((net_address)&0xff) );
	}
	// seek_puts("PATH to ");
	// seek_puts(itoh(SR_Table[slot_seek].target));seek_puts(" = ");
	//SR_Table[slot_seek].path_size = ((i)/7)+1;//path size per hop(32 bits) = 7
	SR_Table[slot_seek].path_size = ((i)/6)+1;//path size per hop(16 bits) = 6
	// seek_puts("SR_Table[slot_seek].path_size:");seek_puts(itoh(SR_Table[slot_seek].path_size));seek_puts("\n");
	// seek_puts("i:");seek_puts(itoh(i));seek_puts("\n");
	//in number of hops
	algorithm = EAST_FIRST;//initialize with west first
	for(j=0;j<i;j++){//calculate the channel to comply with the routing algorithm
		if(algorithm == WEST_FIRST){
			if((port[j] == SOUTH || port[j] == NORTH) && port[j+1] == WEST){//turns prohibited by WEST FIRST :SW and NW
				algorithm = EAST_FIRST;
			}
		}
		else{
			if((port[j] == SOUTH || port[j] == NORTH) && port[j+1] == EAST){//turns prohibited by WEST FIRST :SE and NE
				algorithm = WEST_FIRST;
			}
			port[j] = port[j]+4;
		}
	}
	//for (j=0; j<=i; j++){
	//	print_port(port[j]);
	//}
	//seek_puts("\n");
	//writes the path as an header of source routing
	shift=24;
	//16 bits flit
	SR_Table[slot_seek].path[0] = 0x70007000;
	for(i=0;i<=j;i++){
		SR_Table[slot_seek].path[i/6] = SR_Table[slot_seek].path[i/6]|((port[i]&0x0f) << shift);

		switch(shift){
			case 16:
				shift = 8;
			break;
			case 0:
				shift = 24;
				SR_Table[slot_seek].path[i/6+1] = 0x70007000;
			break;
			default:
				shift = shift - 4;
			break;
		}
	}
	// print_SR_Table(slot_seek);
	return slot_seek;
}
int adjust_backtrack_IO(unsigned int backtrack, unsigned int backtrack1, unsigned int backtrack2, unsigned int target){
	unsigned int next_port;
	unsigned int port[MAX_SOURCE_ROUTING_DESTINATIONS];//used for storing hops
	unsigned char algorithm;
	unsigned int shift;
	int addrX, addrY, x, j, i = 0, slot_seek = 0;
	int last_hop;


	do {
		port[i] = backtrack & 0x3;
		next_port = (backtrack >> 2) & 0x3;
		backtrack >>= 2;
		i++;
		if(i==16){
			backtrack = backtrack1;
		}
		else if(i==32){
			backtrack = backtrack2;
		}
	}while( !( (port[i-1] == EAST  && next_port == WEST) ||//if the path is EW WE SN NS then we should stop here
			  (port[i-1] == WEST  && next_port == EAST)  ||
			  (port[i-1] == NORTH && next_port == SOUTH) ||
			  (port[i-1] == SOUTH && next_port == NORTH) ) );

	port[i] = next_port;

//	addrX=1;
//	addrY=0;

	last_hop = get_last_hop((target >> 8), target & 0XFF);
	if(last_hop == -1){
		puts("ERROR: target not found!!!");
	}

	//puts("last hop: "); puts(itoa(last_hop)); puts("\n");

	slot_seek = SearchSourceRoutingDestination( target );

	port[i++] = last_hop;
	if(port[i-1] == EAST)
		port[ i] = WEST;
	else if(port[i-1] == WEST)
		port[i] = EAST;
	else if(port[i-1] == NORTH)
		port[ i] = SOUTH;
	else if(port[i-1] == SOUTH)
	 	port[ i] = NORTH;


	SR_Table[slot_seek].path_size = ((i)/6)+1;

	algorithm = EAST_FIRST;//initialize with west first
	for(j=0;j<i;j++){//calculate the channel to comply with the routing algorithm
		if(algorithm == WEST_FIRST){
			if((port[j] == SOUTH || port[j] == NORTH) && port[j+1] == WEST){//turns prohibited by WEST FIRST :SW and NW
				algorithm = EAST_FIRST;
			}
		}
		else{
			if((port[j] == SOUTH || port[j] == NORTH) && port[j+1] == EAST){//turns prohibited by WEST FIRST :SE and NE
				algorithm = WEST_FIRST;
			}
			port[j] = port[j]+4;
		}
	}

	// puts("Backtrack Montado:");
	// for (j=0; j<=i; j++){
	// 	print_port(port[j]);
	// }
	// puts("\n");

	port[i-1] = port[i-1] & 0x3;

	shift=24;

	if(slot_seek < 0)
		slot_seek = 0;
	SR_Table[slot_seek].path[0] = 0x70007000;

	for(i=0;i<=j;i++){
		SR_Table[slot_seek].path[i/6] = SR_Table[slot_seek].path[i/6]|((port[i]&0x0f) << shift);
		switch(shift){
			case 16:
				shift = 8;
			break;
			case 0:
				shift = 24;
				SR_Table[slot_seek].path[i/6+1] = 0x70007000;
			break;
			default:
				shift = shift - 4;
			break;
		}
	}

	return slot_seek;
}





/*
void adjust_wrapper(int io_direction, int io_port){
	//seek_puts("direction: "); seek_puts(itoa(io_direction)); seek_puts("\n");
	//seek_puts("     port: "); seek_puts(itoa(io_port)); seek_puts("\n");
	if(io_direction == 1){ //1 -> OUTPUT_DIRECTION
		switch (io_port) {
			case 0:
				mask_wrapper_go_value = mask_wrapper_go_value & 0XFFFFFFFC;
			break;
	
			case 1:
				mask_wrapper_go_value = mask_wrapper_go_value & 0XFFFFFFF3;
			break;
	
			case 2:
				mask_wrapper_go_value = mask_wrapper_go_value & 0XFFFFFFCF;
			break;
	
			case 3:
				mask_wrapper_go_value = mask_wrapper_go_value & 0XFFFFFF3F;
			break;
			default:
				seek_puts("ERROR: invalid port number\n");
		}
		//seek_puts("wrapper mask GO 1: "); seek_puts(itoh(mask_wrapper_go_value)); seek_puts("\n");
		MemoryWrite(WRAPPER_MASK_GO_REGISTER,mask_wrapper_go_value);
	}
	if(io_direction == 0){ //0 -> INPUT_DIRECTION
		switch (io_port) {
			case 0:
				mask_wrapper_back_value = mask_wrapper_back_value & 0XFFFFFFFC;
			break;
	
			case 1:
				mask_wrapper_back_value = mask_wrapper_back_value & 0XFFFFFFF3;
			break;
	
			case 2:
				mask_wrapper_back_value = mask_wrapper_back_value & 0XFFFFFFCF;
			break;
	
			case 3:
				mask_wrapper_back_value = mask_wrapper_back_value & 0XFFFFFF3F;
			break;
			default:
				seek_puts("ERROR: invalid port number\n");
		}
		//seek_puts("wrapper mask BACK 0: "); seek_puts(itoh(mask_wrapper_back_value)); seek_puts("\n");
		MemoryWrite(WRAPPER_MASK_BACK_REGISTER,mask_wrapper_back_value);
	}
	if(io_direction == 2){ //2 -> CLEAR_INPUT_DIRECTION
		switch (io_port) {
			case 0:
				mask_wrapper_back_value =  0X3FC;
			break;
	
			case 1:
				mask_wrapper_back_value =  0X3F3;
			break;
	
			case 2:
				mask_wrapper_back_value =  0X3CF;
			break;
	
			case 3:
				mask_wrapper_back_value =  0X33F;
			break;
			default:
				seek_puts("ERROR: invalid port number\n");
		}
		//seek_puts("wrapper mask BACK 2: "); seek_puts(itoh(mask_wrapper_back_value)); seek_puts("\n");
		MemoryWrite(WRAPPER_MASK_BACK_REGISTER,mask_wrapper_back_value);
	}
}
*/

void printGray(){
	// puts("Rows:");
	// for (int i = 0; i < MAX_GRAY_ROWS; i++){
	// 	puts(itoa(ga.rows[i]));
	// }
	// puts("\n Cols:");
	// for (int j = 0; j < MAX_GRAY_COLS; j++)
	// {
	// 	puts(itoa(ga.cols[j]));	puts("--");
	// }
	return;
}

