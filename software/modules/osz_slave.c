/*!\file osz.h
 * HEMPS VERSION - 8.5 - support for OSZ
 *
 * Distribution:  August 2020
 *
 * Created by: Luciano Caimi - contact: lcaimi@gmail.com
 *             Rafael Faccenda - contact: faccendarafael@gmail.com
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief This module implements functions to open and close Opaque Secure Zones
 *
 */

#include "utils.h"
#include "define_pairs.h"
#include "seek.h" 
#include "packet.h"
#include "osz_slave.h"


int wrapper_value = 0;

unsigned int address_go, address_back;
unsigned int port_go, port_back;  // 0-EAST; 1 - WEST ; 2 - NORTH; 3 - SOUTH

extern int LOCAL_left_low_corner;
extern int LOCAL_right_high_corner;


#ifdef GRAY_AREA
extern GrayArea ga;
#endif

//////////////////////////////////////////////////////////////////////////////////////
void Set_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE){
	unsigned int my_X_addr, my_Y_addr;

	unsigned int RH_X_addr, RH_Y_addr;
	unsigned int LL_X_addr, LL_Y_addr;
	int isolated_ports = 0;

	my_X_addr = (get_net_address() & 0xF00) >> 8;
	my_Y_addr = get_net_address() & 0x00F;

	RH_X_addr = (right_high_corner & 0xF0) >> 4;
	RH_Y_addr = right_high_corner & 0x0F;

	LL_X_addr = (left_low_corner & 0xF0) >> 4;
	LL_Y_addr = left_low_corner & 0x0F;

	if((my_X_addr == RH_X_addr) && (my_Y_addr == RH_Y_addr)){
		Seek(CLEAR_SERVICE, master_PE, master_PE, 0);
	}

  if ((my_X_addr > RH_X_addr) || (my_Y_addr > RH_Y_addr))
    return;
  if ((my_X_addr < LL_X_addr) || (my_Y_addr < LL_Y_addr))
    return;
  
  LOCAL_left_low_corner = left_low_corner;
	LOCAL_right_high_corner = right_high_corner;

	// puts("X");puts(itoh(my_X_addr));puts(" ");
	// puts("Y");puts(itoh(my_Y_addr));puts("\n");

	// puts("LL_X");puts(itoh(LL_X_addr));puts(" ");
	// puts("LL_Y");puts(itoh(LL_Y_addr));puts("\n");

	// puts("RH_X");puts(itoh(RH_X_addr));puts(" ");
	// puts("RH_Y");puts(itoh(RH_Y_addr));puts("\n");

	//WEST or EAST test
	if(my_Y_addr <= RH_Y_addr && my_Y_addr >= LL_Y_addr ){
		if(my_X_addr == RH_X_addr){//EAST
			// puts("E border\n");
			isolated_ports = 0x3;
		}
		if(my_X_addr == LL_X_addr){//WEST
			// puts("W border\n");
			isolated_ports = 0xC + isolated_ports;
		}
	}
  // S  N  W  E
  // 11 11 11 11
  // 

	//NORTH or SOUTH test
	if(my_X_addr >= LL_X_addr && my_X_addr <= RH_X_addr){
		if(my_Y_addr == RH_Y_addr){//NORTH
			// puts("N border\n");
			isolated_ports = 0x30 + isolated_ports;
		}
		if(my_Y_addr == LL_Y_addr){//SOUTH
			// puts("S border\n");
			isolated_ports = 0xC0 + isolated_ports;
		}
	}
  puts("write wrapper: ");puts(itoh(isolated_ports));puts("\n");
	if(isolated_ports != 0){
		wrapper_value = isolated_ports;
		//MemoryWrite(WRAPPER_REGISTER,isolated_ports);
    seek_puts("[Set Secure Zone] LOCAL_right_high_corner = "); seek_puts(itoa(LOCAL_right_high_corner)); puts("\n");
		if((my_X_addr == RH_X_addr) && (my_Y_addr == RH_Y_addr)){
			Seek(SET_SZ_RECEIVED_SERVICE, get_net_address(), master_PE, right_high_corner);
			seek_puts("SET SZ RH: ");seek_puts(itoh(LOCAL_right_high_corner));seek_puts("\n");	
		}
		seek_puts("wrapper: ");seek_puts(itoh(isolated_ports));seek_puts("\n");
	}
}


//////////////////////////////////////////////////////////////////////////////////////
void Unset_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE){
  //cut - LLcut, RHcut, master
	//NoCut - RHsz, RHsz, master
  unsigned int my_X_addr, my_Y_addr, master_X_addr, master_Y_addr;

  unsigned int RH_X_addr, RH_Y_addr, LOCAL_RH_X_addr, LOCAL_RH_Y_addr;
  unsigned int LL_X_addr, LL_Y_addr, LOCAL_LL_X_addr, LOCAL_LL_Y_addr;
  int isolated_ports, previous_isolated;

  my_X_addr = (get_net_address() & 0xF00) >> 8;
  my_Y_addr = get_net_address() & 0x00F;

  master_X_addr = (master_PE & 0xF0) >> 4;
  master_Y_addr = master_PE & 0x00F;

  LOCAL_RH_X_addr = (LOCAL_right_high_corner & 0xF0) >> 4;
  LOCAL_RH_Y_addr = LOCAL_right_high_corner & 0x0F;

  LOCAL_LL_X_addr = (LOCAL_left_low_corner & 0xF0) >> 4;
  LOCAL_LL_Y_addr = LOCAL_left_low_corner & 0x0F;

  RH_X_addr = (right_high_corner & 0xF0) >> 4;
  RH_Y_addr = right_high_corner & 0x0F;

  LL_X_addr = (left_low_corner & 0xF0) >> 4;
  LL_Y_addr = left_low_corner & 0x0F;

  int myOSZ = 0;
  int noCut = 0;

  if ((right_high_corner == left_low_corner) && (LOCAL_right_high_corner == right_high_corner)){
    noCut = 1;
    // puts("Não tem corte\n");
  }

  if (noCut){ //Caso não precise de CUT
    if((my_X_addr == LOCAL_RH_X_addr) && (my_Y_addr == LOCAL_RH_Y_addr)){ //Se eu for RH local
      if((my_X_addr == RH_X_addr) && (my_Y_addr == RH_Y_addr)){     //Se veio o indice do meu RH local na mensagem de CUT
        myOSZ = 1;
        Seek(CLEAR_SERVICE, master_PE, master_PE, 0);
        // puts("Não tem corte e é minha zona segura\n");
      }
    }
  }else{    //Caso precise de CUT
    if((my_X_addr == LOCAL_RH_X_addr) && (my_Y_addr == LOCAL_RH_Y_addr)){ //Se eu for RH local
      if((LL_X_addr == LOCAL_LL_X_addr) && (LL_Y_addr == LOCAL_LL_Y_addr)){ //Se for no meu LL
        myOSZ = 1;
        Seek(CLEAR_SERVICE, master_PE, master_PE, 0);
        // puts("Tem corte e é minha zona segura\n");
      }
    }
  }

  // send 
  // if((my_X_addr == LOCAL_RH_X_addr) && (my_Y_addr == LOCAL_RH_Y_addr)){
  //   Seek(CLEAR_SERVICE, master_PE, master_PE, 0);
  // }


  // puts("X");puts(itoh(my_X_addr));puts(" ");
  // puts("Y");puts(itoh(my_Y_addr));puts("\n");

  // puts("LL_X");puts(itoh(LL_X_addr));puts(" ");
  // puts("LL_Y");puts(itoh(LL_Y_addr));puts("\n");

  // puts("RH_X");puts(itoh(RH_X_addr));puts(" ");
  // puts("RH_Y");puts(itoh(RH_Y_addr));puts("\n");

  // read actual wrapper value
  isolated_ports = wrapper_value;
  previous_isolated = wrapper_value;


  //seek_puts("previous wrapper: "); seek_puts(itoh(wrapper_value)); seek_puts("\n");
  if(wrapper_value == 0)
  	return;

  // if (noCut && myOSZ){
  // //if((my_X_addr == LOCAL_RH_X_addr) && (my_Y_addr == LOCAL_RH_Y_addr)){   
  //     	  right_high_corner = ((get_net_address() >> 4)& 0XF0) | (get_net_address() &  0X0F);
  //         Seek(SECURE_ZONE_CLOSED_SERVICE, get_net_address(), master_PE, LOCAL_right_high_corner);
  //         //puts("ENDSZ RH:");puts(itoh(LOCAL_right_high_corner));puts("\n"); 
  // }

// This is to uncut at RH position
//  // set wrapper port EAST
//  if( (my_X_addr == LL_X_addr - 1) && (my_Y_addr >=  LL_Y_addr) &&  (my_Y_addr <=  RH_Y_addr) )
//      isolated_ports = isolated_ports + 0x3;
//
//  // set wrapper port NORTH
//  if( (my_Y_addr == LL_Y_addr - 1) && (my_X_addr == LL_X_addr ))
//      isolated_ports = isolated_ports + 0x30;
//
//// UNSET wrapper port EAST
//  if( (my_X_addr == LL_X_addr) && (my_Y_addr >=  LL_Y_addr) &&  (my_Y_addr <=  RH_Y_addr) )
//      isolated_ports = isolated_ports - 0x3;
//
//  // UNSET wrapper port NORTH
//  if( (my_Y_addr == RH_Y_addr) && (my_X_addr == RH_X_addr ))
//      isolated_ports = isolated_ports - 0x30;    


if(!noCut){
// This is to uncut at LL position
// set wrapper port WEST
  if( (my_X_addr == LL_X_addr + 1) && (my_Y_addr >=  LL_Y_addr) &&  (my_Y_addr <=  RH_Y_addr) )
      isolated_ports = isolated_ports + 0x0C;

  // set wrapper port SOUTH
  if( (my_Y_addr == RH_Y_addr + 1) && (my_X_addr == RH_X_addr))
      isolated_ports = isolated_ports + 0xC0;

// UNSET wrapper port WEST
  if( (my_X_addr == LL_X_addr) && (my_Y_addr >=  LL_Y_addr) &&  (my_Y_addr <=  RH_Y_addr) )
      isolated_ports = isolated_ports - 0x0C;

  // UNSET wrapper port SOUTH
  if( (my_Y_addr == LL_Y_addr) && (my_X_addr == LL_X_addr ))
      isolated_ports = isolated_ports - 0xC0;    
}

  //if(isolated_ports != previous_isolated){
  	puts("write wrapper: ");puts(itoh(isolated_ports));puts("\n");
    MemoryWrite(WRAPPER_REGISTER,isolated_ports);
    if(myOSZ){
    //if((my_X_addr == LOCAL_RH_X_addr) && (my_Y_addr == LOCAL_RH_Y_addr)){
      Seek(SECURE_ZONE_CLOSED_SERVICE, get_net_address(), master_PE, LOCAL_right_high_corner);
      #ifdef GRAY_AREA
      puts("ENDSZ RH:");puts(itoh(LOCAL_right_high_corner));puts("\n"); 
      config_AP_SZ();
      #endif
  }
    //seek_puts("wrapper:");seek_puts(itoh(isolated_ports));seek_puts("\n");
  wrapper_value = isolated_ports;
  seek_puts("RH address: ");seek_puts(itoh(right_high_corner));seek_puts("\n");
  seek_puts("LOCAL RH address: ");seek_puts(itoh(LOCAL_right_high_corner));seek_puts("\n");
}


//////////////////// Session Functions ////////////////////

/*--------------------------------------------------------------------
* findBlankSession
*
* DESCRIPTION:
*    Searches the session array structure for a free space
*
*    parameters: *sessions - array of the system sessions
*    
*    return: the position or -1 if there is no free position
*--------------------------------------------------------------------*/
int findBlankSession(Session* sessions){
  for (int i = 0; i < MAX_SESSIONS; i++)
  {
    if (sessions[i].status == BLANK)
      return i;
  }
  puts("ERROR: No free Session structure");
  return -1;
}

/*--------------------------------------------------------------------
* checkSession
*
* DESCRIPTION:
*    Searches the session array structure for a running session of Prod and Cons
*
*    parameters:  *sessions - array of the system sessions
*                  prod - producer task ID
*                  cons - consumer task ID               
*    
*    return: the position or -1 if there is no free position
*--------------------------------------------------------------------*/
int checkSession(Session* sessions, unsigned int prod, unsigned int cons){
  for (int i = 0; i < MAX_SESSIONS; i++)
  {
    if ((sessions[i].producer == prod) && (sessions[i].consumer == cons)){     
	    return i;
    }
  }
  return -1;
}


/*--------------------------------------------------------------------
* checkSessionCode
*
* DESCRIPTION:
*    Searches the session array structure for a running session by CODE
*
*    parameters:  *sessions - array of the system sessions
*                  code - session code
*    
*    return:  the position if there is a match
*             END_SESSION if the code is 0xFFFF
*             START_SESSION if there is no running session with that code
*--------------------------------------------------------------------*/
int checkSessionCode(Session* sessions, unsigned int code){
  if (code == 0xFFFF)   // 0xFFFF is the signature for ending a session
    return END_SESSION;
  
  for (int i = 0; i < MAX_SESSIONS; i++) //Checking every session on the array
  {
    if ((sessions[i].code == code))
      return i;
  }

  return START_SESSION; // No session is found, so this is a new Session request
}

/*--------------------------------------------------------------------
* clearSession
*
* DESCRIPTION:
*    Clears the slot of the Session array
*
*    parameters:  *sessions - array of the system sessions
*                  index - the index of the session in the array
*    
*    return:  none
*--------------------------------------------------------------------*/
int clearSession(Session* sessions, int index){
  sessions[index].producer = -1; 
  sessions[index].consumer = -1;
  sessions[index].time = 0;
  sessions[index].status = BLANK;
  sessions[index].sent = 0;
  sessions[index].requested = 0;
  sessions[index].code = 0;
  sessions[index].msg->length = -1;
  sessions[index].pairIndex = -1;

}

/*--------------------------------------------------------------------
* initSessions
*
* DESCRIPTION:
*    Initializes the structures utilized by the Sessions Protocol
*
*    parameters:  none
*    
*    return:  none
*--------------------------------------------------------------------*/
void initSessions(){
  for (int i = 0; i < WAITING_MSG_QUEUE; i++){
    waitingMessages[i].length = -1;
    waitingServices[i].service = BLANK;
  }
  for (int i = 0; i < MAX_SESSIONS; i++){
    clearSession(Sessions, i);
  }
}

/*--------------------------------------------------------------------
* getMessageSlot
*
* DESCRIPTION:
*    Searches for a free space to put a Delivery Message
*
*    parameters:  none
*    
*    return:  pointer to the Message Slot
*--------------------------------------------------------------------*/
Message* getMessageSlot(){
  for (int i = 0; i < WAITING_MSG_QUEUE; i++)
  {
    if (waitingMessages[i].length == -1){
      return &waitingMessages[i];
    }
  }
  
  puts("ERROR: No free MessageSlots");
  return -1;
}

/*--------------------------------------------------------------------
* clearMessageSlot
*
* DESCRIPTION:
*    Clears an specific Message Slot
*
*    parameters:  *m - slot to be cleared
*    
*    return:  none
*--------------------------------------------------------------------*/
void clearMessageSlot(Message* m){
  m->length = -1;
}

/*--------------------------------------------------------------------
* getServiceSlot
*
* DESCRIPTION:
*    Searches for a free space to put a Request Message Service
*
*    parameters:  none
*    
*    return:  pointer to the Service Slot
*--------------------------------------------------------------------*/
ServiceHeader* getServiceSlot(){
  for (int i = 0; i < WAITING_MSG_QUEUE; i++)
  {
    if (waitingServices[i].service == BLANK){
      return &waitingServices[i];
    }
  }

  puts("ERROR: No free ServiceSlots");
  return -1;
}

/*--------------------------------------------------------------------
* clearMessageSlot
*
* DESCRIPTION:
*    Clears an specific Message Slot
*
*    parameters:  *m - slot to be cleared
*    
*    return:  none
*--------------------------------------------------------------------*/
void clearServiceSlot(ServiceHeader* slot){
  slot->service = BLANK;
}


/*--------------------------------------------------------------------
* createSession
*
* DESCRIPTION:
*    Creates a Session in the system
*
*    parameters:  *sessions - array of the system sessions
*                  code - session code
*                  prod - producer task ID
*                  cons - consumer task ID     
*    
*    return:  the index of the created Session in the Session Structure
*--------------------------------------------------------------------*/
int createSession(Session* sessions, unsigned int prod, unsigned int cons, int code){
  int auxIndex = findBlankSession(sessions); // Get a free space

  if (auxIndex == -1){
    puts("No slot available for new Sessions\n");
    return -1;
  }
  
  // Filling initial values
  sessions[auxIndex].status = WAITING_ANY;
  sessions[auxIndex].code = code & 0xFFC0;
  sessions[auxIndex].consumer = cons;
	sessions[auxIndex].producer = prod;
  sessions[auxIndex].pairIndex = code & 0x3F; // Three last bits of the code are the Index

  return auxIndex;
}

/*--------------------------------------------------------------------
* printSessions
*
* DESCRIPTION:
*    Prints the running sessions on the system
*
*    parameters:  *sessions - array of the system sessions    
*    
*    return: none
*--------------------------------------------------------------------*/
void printSessions(Session* sessions){

  for (int i = 0; i < MAX_SESSIONS; i++)
  {
    if (sessions[i].status != BLANK){
        puts("Session ------ Code: ");puts(itoh(Sessions[i].code));puts("\n");
        puts("  Consumer: ");puts(itoh(Sessions[i].consumer));puts("\n");
        puts("  Producer: ");puts(itoh(Sessions[i].producer));puts("\n");
    }
  }
}

/*--------------------------------------------------------------------
* printSessionStatus
*
* DESCRIPTION:
*    Prints the main parameters of a specific session
*
*    parameters:  *sessions - array of the system sessions 
*                  index - position of the Session to be printed   
*    
*    return: none
*--------------------------------------------------------------------*/
void printSessionStatus(Session* sessions, unsigned int index){
  puts("Session ------ Code: ");puts(itoh(Sessions[index].code));puts("\n");
  puts("  Consumer: ");puts(itoh(Sessions[index].consumer));puts("\n");
  puts("  Producer: ");puts(itoh(Sessions[index].producer));puts("\n");
  puts("  PairIndex: ");puts(itoh(Sessions[index].pairIndex));puts("\n");
  puts("  MyIndex: ");puts(itoh(index));puts("\n");
  // puts("  Recieved: ");puts(itoa(Sessions[index].requested));puts("\n");
  // puts("  Sent: ");puts(itoa(Sessions[index].sent));puts("\n");
}

/*--------------------------------------------------------------------
* checkRunningSession
*
* DESCRIPTION:
*   Searches the running sessions to find if there is an open session with
* a specific task
*
*    parameters:  *sessions - array of the system sessions 
*                  task - task to be searched in sessions   
*    
*    return:  the index of the found Session
*             -1 if not found
*--------------------------------------------------------------------*/
int checkRunningSession(Session* sessions, unsigned int task){
  for (int i = 0; i < MAX_SESSIONS; i++)
  {
    if ((sessions[i].status != BLANK)){
      if ((sessions[i].producer == task) || (sessions[i].consumer == task)){
        return i;
      }
    }
  }
  return -1;
}

/*--------------------------------------------------------------------
* copyService
*
* DESCRIPTION:
*   Copies one Service Header into another slot
*
*    parameters:  *SHsource - Service Heaader Slot Source 
*                 *SHtarget - Service Heaader Slot Target   
*    
*    return: none
*--------------------------------------------------------------------*/
void copyService(ServiceHeader* SHsource, ServiceHeader* SHtarget){
  SHtarget->header[MAX_SOURCE_ROUTING_PATH_SIZE] = SHsource->header[MAX_SOURCE_ROUTING_PATH_SIZE];
  SHtarget->payload_size = SHsource->payload_size;
  SHtarget->service = SHsource->service;
  SHtarget->producer_task = SHsource->producer_task;
  SHtarget->consumer_task = SHsource->consumer_task;
  SHtarget->source_PE = SHsource->source_PE;
  SHtarget->timestamp = SHsource->timestamp;
  SHtarget->transaction = SHsource->transaction;
  SHtarget->requesting_processor = SHsource->requesting_processor;
  SHtarget->pkt_size = SHsource->pkt_size;
  SHtarget->code_size = SHsource->code_size;
  SHtarget->cpu_slack_time = SHsource->cpu_slack_time;
  SHtarget->initial_address = SHsource->initial_address;
}

/*--------------------------------------------------------------------
* checkWaitingServices
*
* DESCRIPTION:
*   Searches the waiting services array to find if there is an specific service
* with correspondent consumer and producer waiting to be handled
*
*    parameters:  *serviceQueue - array of the waiting Service Headers 
*                  sProd - producer task to be searched  
*                  sCons - consumer task to be searched    
*                  serv - service task to be searched in sessions   
*    
*    return:  pointer to the found Service slot
*             -1 if not found
*--------------------------------------------------------------------*/
ServiceHeader* checkWaitingServices(ServiceHeader* serviceQueue, int sProd, int sCons, int serv){
  for (int i = 0; i < WAITING_MSG_QUEUE; i++)
  {
    if ((serviceQueue[i].producer_task == sProd) && (serviceQueue[i].consumer_task == sCons) && (serviceQueue[i].service == serv)){
      return &serviceQueue[i];
    }
  }
  return -1;
}

/*--------------------------------------------------------------------
* send_message_delivery_control
*
* DESCRIPTION:
*   Sends the MESSAGE_DELIVERY_CONTROL of the Sessions Protocol
*
*    parameters:  *sessions - array of the system sessions 
*                  prod - producer task of the Session
*                  cons - consumer task of the Session
*                  target - NoC address of the PE to send the Message  
*    
*    return:  none
*--------------------------------------------------------------------*/
void send_message_delivery_control(Session * sessions,unsigned int prod, unsigned int cons, unsigned int target){
  int index;
  index = checkSession(sessions, prod, cons); // Search for the Session
  if (index < 0)
    puts("ERRO: não achou sessão no MDR\n"); 
  sessions[index].sent += 1; // Increase the number of sent Messages
	Seek(MSG_DELIVERY_CONTROL, (sessions[index].code <<16) | (sessions[index].pairIndex << 16) | sessions[index].sent , target, index);
}

/*--------------------------------------------------------------------
* send_message_request_control
*
* DESCRIPTION:
*   Sends the MESSAGE_REQUEST_CONTROL of the Sessions Protocol
*
*    parameters:  *sessions - array of the system sessions 
*                  prod - producer task of the Session
*                  cons - consumer task of the Session
*                  target - NoC address of the PE to send the Message  
*    
*    return:  none
*--------------------------------------------------------------------*/
void send_message_request_control(Session* sessions, unsigned int prod, unsigned int cons, unsigned int target){
  int index, code;
  index  = checkSession(sessions, prod, cons); 
  if(index < 0){ // Case not found, create a new Session
    do{code = (MemoryRead(TICK_COUNTER)*get_net_address()) & 0xFFC0;}while(code == 0xFFC0); // Code cannot be 0xFFC0
    index = createSession(sessions, prod, cons, (code | 0x3F));
    sessions[index].requested += 1; // Increase the number of requested Messages
    // The first MSG_REQUEST_CTRL is the Start Session step, sendig the Producer, Consumer, Code and Index
    Seek(MSG_REQUEST_CONTROL, ((sessions[index].code <<16) | (index << 16) | (prod <<8 & 0xFF00) | (cons & 0xFF)), target, ((cons >> 8) & 0xFF));
  }else{
    sessions[index].requested += 1;
   // The others MSG_REQUEST_CTRL are default, sending the Code, Index and Number of requested packets to check the order
    Seek(MSG_REQUEST_CONTROL, ((sessions[index].code <<16) | (sessions[index].pairIndex << 16) | sessions[index].requested), target, 0);
  }
}

/*--------------------------------------------------------------------
* timeoutMonitor
*
* DESCRIPTION:
*   Funtion that monitors the time inbetween the receiving of a Data and Control.
*  Case it is more than the Threshold, triggers the recovery protocol
*
*    parameters:  *sessions - array of the system sessions 
*                  time - current time  
*    
*    return:  none
*--------------------------------------------------------------------*/
void timeoutMonitor(Session* sessions, int time){
	int TUStarget =0;
	int TUSsource = get_net_address();

  // if (MemoryRead(TICK_COUNTER) < TIMEOUT_SLEEP)
  //   return;

  for (int i = 0; i < MAX_SESSIONS; i++)
  {
    if (sessions[i].status == WAITING_DATA){
      if (time - sessions[i].time > LAT_THRESHOLD){
        // puts("WARNING: THRESHOLD VIOLATION ON SESSION "); puts(itoa(i)); puts("\n");
        // puts("TIME NOW "); puts(itoa(time)); puts("\n");
        // puts("ARRIVAL TIME "); puts(itoa(sessions[i].time)); puts("\n");
        // puts("PROD "); puts(itoh(sessions[i].producer)); puts("\n");
        // puts("CONS "); puts(itoh(sessions[i].consumer)); puts("\n");
        // puts("SOURCE "); puts(itoh(TUSsource)); puts("\n");
        sessions[i].status = SUSPICIOUS;
        if (TUSsource == get_task_location(Sessions[i].producer))
          TUStarget = get_task_location(Sessions[i].consumer);
        else
          TUStarget = get_task_location(Sessions[i].producer);
        
        // puts("TARGET "); puts(itoh(TUStarget)); puts("\n");
        // Seek(TARGET_UNREACHABLE_SERVICE, (TUSsource<<16) | (TUStarget & 0xFFFF), TUStarget, 0);
        return;
      }
    }
  }
  return;
}

int find_SZ_position_and_direction_to_IO(int peripheral_id){
    unsigned int my_X_addr, my_Y_addr;
    unsigned int PER_X_addr, PER_Y_addr, port_io, i;
    unsigned int RH_X_addr, RH_Y_addr;
    unsigned int LL_X_addr, LL_Y_addr;


    RH_X_addr = (LOCAL_right_high_corner & 0xF0) >> 4;
    RH_Y_addr = LOCAL_right_high_corner & 0x0F;

    LL_X_addr = (LOCAL_left_low_corner & 0xF0) >> 4;
    LL_Y_addr = LOCAL_left_low_corner & 0x0F;

    my_X_addr = (get_net_address() & 0xF00) >> 8;
    my_Y_addr = get_net_address() & 0x00F;

    port_io = -1;
    for(i = 0; i < IO_NUMBER; i++){
        if(io_info[i].peripheral_id == peripheral_id){
                PER_X_addr = io_info[i].default_address_x ;
                PER_Y_addr = io_info[i].default_address_y;
                port_io = io_info[i].default_port;
            break;
        }
    }
    if (port_io == -1) {
        puts("[OSZ2]ERROR: peripheral_id not found!\n");
        return -1;
        //while(1){};

    }

    if (port_io == OUT_NORTH){
        if(PER_X_addr < LL_X_addr){    
            address_go   = ( LL_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | RH_Y_addr;
            port_go = 1;
            port_back = 2;
        }
        else if(PER_X_addr > RH_X_addr){
            address_go   = ( RH_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | RH_Y_addr;
            port_go = 0;
            port_back = 2;            
        }
        else{
            address_go   = ( PER_X_addr << 8 ) | RH_Y_addr;
            address_back = ( my_X_addr  << 8 ) | RH_Y_addr;    
            port_go = 2;
            port_back = 2;                     
        }
    }
    else if(port_io == OUT_SOUTH){
        if(PER_X_addr < LL_X_addr){
            address_go   = ( LL_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | LL_Y_addr;
            port_go = 1;
            port_back = 3;            
        }
        else if(PER_X_addr > RH_X_addr){
            address_go   = ( RH_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | LL_Y_addr;
            port_go = 0;
            port_back = 3;
        }
        else{
            address_go   = ( PER_X_addr << 8 ) | LL_Y_addr;
            address_back = ( my_X_addr  << 8 ) | LL_Y_addr;         
            port_go = 3;
            port_back = 3;
        }
    }
    if (port_io == OUT_WEST){
        if(PER_Y_addr < LL_Y_addr){    
            address_go   = ( LL_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | LL_Y_addr;
            port_go = 1;
            port_back = 3;            
        }
        else if(PER_Y_addr > RH_Y_addr){
            address_go   = ( LL_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | RH_Y_addr;
            port_go = 1;
            port_back = 2;            
        }
        else{
            address_go   = ( LL_X_addr << 8 ) | my_Y_addr;
            address_back = ( LL_X_addr  << 8 ) | PER_Y_addr;
            port_go = 1;
            port_back = 1;            
        }
    }
    else if(port_io == OUT_EAST){
        if(PER_Y_addr < LL_Y_addr){    
            address_go   = ( RH_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | LL_Y_addr;
            port_go = 0;
            port_back = 3;                 
        }
        else if(PER_Y_addr > RH_Y_addr){
            address_go   = ( RH_X_addr << 8 ) | my_Y_addr;
            address_back = ( my_X_addr << 8 ) | RH_Y_addr;
            port_go = 0;
            port_back = 2;                 
        }
        else{
            address_go   = ( RH_X_addr << 8 ) | my_Y_addr;
            address_back = ( RH_X_addr << 8 ) | PER_Y_addr;
            port_go = 0;
            port_back = 0;                 
        }
    }
    // puts("address_go: ");puts(itoa(address_go));puts("\n");
    // puts("address_back: ");puts(itoa(address_back));puts("\n");
    // puts("port_go: ");puts(itoa(port_go));puts("\n");
    // puts("port_back: ");puts(itoa(port_back));puts("\n");  
    return 1;
}
#ifdef GRAY_AREA
int find_AccessPoint(){
    unsigned int my_X_addr, my_Y_addr;
    unsigned int PER_X_addr, PER_Y_addr, port_io, i;
    unsigned int RH_X_addr, RH_Y_addr;
    unsigned int LL_X_addr, LL_Y_addr;
    unsigned int medium_X;


    RH_X_addr = (LOCAL_right_high_corner & 0xF0) >> 4;
    RH_Y_addr = LOCAL_right_high_corner & 0x0F;

    LL_X_addr = (LOCAL_left_low_corner & 0xF0) >> 4;
    LL_Y_addr = LOCAL_left_low_corner & 0x0F;

    my_X_addr = (get_net_address() & 0xF00) >> 8;
    my_Y_addr = get_net_address() & 0x00F;

    if (ga.rows[0]-1 == RH_Y_addr)
    {
      puts("Colocando AP no topo\n");
      medium_X = LL_X_addr + ((RH_X_addr - LL_X_addr)/2);
      address_go   = ( medium_X << 8 ) | RH_Y_addr;
      address_back = ( medium_X << 8 ) | RH_Y_addr;
      port_go = NORTH;
      port_back = NORTH;
    } else if(ga.cols[MAX_GRAY_COLS-1] < LL_X_addr){        
      puts("--Gray Area a esquerda\n");
      address_go   = ( LL_X_addr << 8 ) | RH_Y_addr;
      address_back = ( LL_X_addr << 8 ) | RH_Y_addr;
      port_go = WEST;
      port_back = WEST;
    }
    else if(ga.cols[0] > RH_X_addr){
      puts("--Gray Area a direita\n");
      address_go   = ( RH_X_addr << 8 ) | RH_Y_addr;
      address_back = ( RH_X_addr << 8 ) | RH_Y_addr;
      port_go = EAST;
      port_back = EAST;            
    }
    else{
      puts("--Gray Area nao encontrada\n");
    }
    return 1;
}

void config_AP_SZ(){ // io_service: 0 - request; 1 - delivery
	int aux;

	ServiceHeader *p = get_service_header_slot();

  aux =find_AccessPoint();

	if(aux == -1)
		return;

    puts("AP address: "); puts(itoh(address_go)); puts("\n");

    //-----------------------------------------------------------------------------
    //OUT_WRAPPER
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | (KE_OSZ << 16) | address_go;
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | (KE_OSZ << 16) | address_go;

	p->payload_size = (CONSTANT_PKT_SIZE - 2);

	p->service = IO_OPEN_WRAPPER;

	p->source_PE = get_net_address();

	p->io_port = port_go;

	p->io_direction = OUTPUT_DIRECTION;

  send_packet(p, 0, 0); //!

    //------------------------------------------------------------------------------
    //IN_WRAPPER
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | (KE_OSZ << 16)| address_back;
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | (KE_OSZ << 16)| address_back;

	p->io_port = port_back;
	p->io_direction = INPUT_DIRECTION;

	send_packet(p, 0, 0); //!

}
#else

void open_wrapper_IO_SZ(int peripheral_id, int io_service){ // io_service: 0 - request; 1 - delivery
	int aux;

	ServiceHeader *p = get_service_header_slot();

	aux = find_SZ_position_and_direction_to_IO(peripheral_id);

	if(aux == -1)
		return;

    //puts("forward OPEN WRAPPER: "); puts(itoh(address_go)); puts("\n");

    //-----------------------------------------------------------------------------
    //OUT_WRAPPER
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;

	p->payload_size = (CONSTANT_PKT_SIZE - 2);

	p->service = IO_OPEN_WRAPPER;

	p->source_PE = get_net_address();

	p->io_port = port_go;

	p->io_direction = OUTPUT_DIRECTION;

	if(io_service == 0)  //io_service: 0 - REQUEST   1 - DELIVERY
		p->io_service = IO_REQUEST;
	else
		p->io_service = IO_DELIVERY;

	send_packet(p, 0, 0);

    //------------------------------------------------------------------------------
    //IN_WRAPPER
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | ((0X3F00 & address_back) << 14)| ((0X003F & address_back) << 16)| address_back;
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | ((0X3F00 & address_back) << 14)| ((0X003F & address_back) << 16)| address_back;

	p->io_port = port_back;
	p->io_direction = INPUT_DIRECTION;

	if(io_service == 0)  //io_service: 0 - REQUEST   1 - DELIVERY
		p->io_service = IO_DELIVERY;
	else
		p->io_service = IO_ACK;

	send_packet(p, 0, 0);

}

void send_wrapper_close_back__open_forward(int CM_index){ //Tentar inverter a ordem que isso é feito
	int peripheral_ID, io_service, aux;

	ServiceHeader *p = get_service_header_slot();

	// puts("\nCM_index: "); puts(itoa(CM_index)); puts("\n");

	peripheral_ID = get_CM_peripheral_ID(CM_index);
	io_service = get_CM_IO_service(CM_index); // 0 - REQUEST; 1 - DELIVERY

	aux = find_SZ_position_and_direction_to_IO(peripheral_ID);

	if(aux == -1)
		return;

  // puts("peripheral_ID: "); puts(itoa(peripheral_ID)); puts("\n");
  // puts("io_service: "); puts(itoa(io_service)); puts("\n");

  //-----------------------------------------------------------------------------
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;

	p->payload_size = (CONSTANT_PKT_SIZE - 2);

	p->service = IO_OPEN_WRAPPER;

	p->source_PE = get_net_address();

	p->io_port = port_go;

	p->io_direction = INPUT_DIRECTION;

	if(io_service == 0)  //io_service: 0 - REQUEST   1 - DELIVERY
		p->io_service = IO_REQUEST;
	else
		p->io_service = IO_DELIVERY;

	send_packet(p, 0, 0);

    //---------------------------------------------------------------------------------
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | ((0X3F00 & address_back) << 14)| ((0X003F & address_back) << 16)| address_back;
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | ((0X3F00 & address_back) << 14)| ((0X003F & address_back) << 16)| address_back;

	p->io_port = port_go;

	p->io_direction = CLEAR_INPUT_DIRECTION;

	if(io_service == 0)  //io_service: 0 - REQUEST   1 - DELIVERY
		p->io_service = IO_DELIVERY;
	else
		p->io_service = IO_ACK;

	send_packet(p, 0, 0);

}

void send_wrapper_close_forward(int CM_index){
    int peripheral_ID, io_service, aux;

    ServiceHeader *p = get_service_header_slot();

    //puts("CM_index: "); puts(itoa(CM_index)); puts("\n");

    peripheral_ID = get_CM_peripheral_ID(CM_index);
    io_service = get_CM_IO_service(CM_index); // 0 - REQUEST; 1 - DELIVERY

	  aux = find_SZ_position_and_direction_to_IO(peripheral_ID);

    if(aux == -1)
        return;

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;
    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;

    p->payload_size = (CONSTANT_PKT_SIZE - 2);

    p->service = IO_OPEN_WRAPPER;

    p->source_PE = get_net_address();

    p->io_port = port_go;

    p->io_direction = CLEAR_INPUT_DIRECTION;

    if(io_service == 0)  //io_service: 0 - REQUEST   1 - DELIVERY
        p->io_service = IO_REQUEST;
    else
        p->io_service = IO_DELIVERY;

    //if(p->source_PE != address_go)
        send_packet(p, 0, 0);
    //else
    //    adjust_wrapper(p->io_direction, p->io_port);

}

void send_wrapper_open_forward(int peripheral_ID, int io_service){
    int aux;

    ServiceHeader *p = get_service_header_slot();

    //puts("CM_index: "); puts(itoa(CM_index)); puts("\n");

	  aux = find_SZ_position_and_direction_to_IO(peripheral_ID);


	if(aux == -1)
    return;
  //-----------------------------------------------------------------------------
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-2] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;
	p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = (0x1 << 28) | ((0X3F00 & address_go) << 14) | ((0X003F & address_go) << 16)| address_go;

	p->payload_size = (CONSTANT_PKT_SIZE - 2);

	p->service = IO_OPEN_WRAPPER;

	p->source_PE = get_net_address();

	p->io_port = port_go;

	p->io_direction = OUTPUT_DIRECTION;

	if(io_service == 0)  //io_service: 0 - REQUEST   1 - DELIVERY
		p->io_service = IO_REQUEST;
	else
		p->io_service = IO_DELIVERY;

	// send_packet(p, 0, 0);


}
#endif

// int configureNewIO(int peripheral_id){
//   unsigned int i, slotSR;
//   unsigned long int auxBT;
//   for(i = 0; i < IO_NUMBER; i++){
//     if(io_info[i].peripheral_id == arg1){
//       PER_X_addr = io_info[i].default_address_x ;
//       PER_Y_addr = io_info[i].default_address_y;
//       auxSlot = SearchSourceRoutingDestination((PER_X_addr << 8) | PER_Y_addr);
//       if (auxSlot = -1){
//         auxBT = pathToIO(arg1);
//         slotSR = GetFreeSlotSourceRouting((PER_X_addr << 8) | PER_Y_addr);
//         SR_Table[slotSR].target = (PER_X_addr << 8) | PER_Y_addr;
//           SR_Table[slotSR].tableSlotStatus = SR_USADO;
//         adjust_backtrack_IO(
//           auxBT & 0xffffFFFF,
//             auxBT >> 32 & 0xffffFFFF,
//             auxBT >> 64 & 0xffffFFFF,
//           (PER_X_addr << 8) | PER_Y_addr);

//         auxBT = pathFromIO(auxBT);
//         slotSR = GetFreeSlotSourceRouting(get_net_address());
//         SR_Table[slotSR].target = get_net_address();
//         SR_Table[slotSR].tableSlotStatus = SR_USADO;
//         ProcessTurns(
//           auxBT & 0xffffFFFF,
//           auxBT >> 32 & 0xffffFFFF,
//           auxBT >> 64 & 0xffffFFFF);
//         send_peripheral_SR_path(slotSR, arg1, current->secure);
//         ClearSlotSourceRouting(get_net_address());
//       }
//     break;
//     }
//   }
// }
