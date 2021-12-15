//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Date:  March 2018
//
//  Source name:  IO_peripheral.cpp
//
//  Brief description: 
//
//---------------------------------------------------------------------------------------

#include "io_peripheral.h"
#define KE_OSZ 0x021 // Reg mapeado em memória


void io_peripheral::SR_path_FSM(){
    int i;
    if(reset.read() == true){
        EA_sr_path.write(S_WAIT_ORDER);
        for(i = 0; i < IO_SR_PATHS; i++){
            SR_used[0] = 0;
        }
    }
    else{   
        switch(EA_sr_path.read()){
            case S_WAIT_ORDER:
                SR_index = 7;
                if(IO_SR == 1)
                    EA_sr_path.write(S_VERIFY_TARGET);
            break;

            case S_VERIFY_TARGET:    
                IO_SR = 0;          
                for(i = 0; i < IO_SR_PATHS; i++){
                    if((reg_task_ID == SR_target[i]) && (SR_used[i] == 1)){
                        SR_index = i;
                    }
                }

                if(SR_index == 7)
                    EA_sr_path.write(S_NEW_TARGET);
                else
                    EA_sr_path.write(S_COPY);
            break;

            case S_NEW_TARGET:
                for(i = 0; i < IO_SR_PATHS; i++){
                    if(SR_used[i] == 0){
                        SR_index = i;
                        break;
                    }
                }
                EA_sr_path.write(S_COPY);
            break;

            case S_COPY:
                    SR_target[SR_index] = reg_task_ID;
                    // if (reg_msg_size % 2 == 1)
                    //     SR_size[SR_index]  = reg_msg_size - 9;
                    // else
                        SR_size[SR_index]  = reg_msg_size - 10;
                    SR_used[SR_index]   = 1;
                    for(i = 0; i < SR_size[SR_index]; i++){
                        SR_path[SR_index][i]  = buffer_in_flit[i];
                    }

                    for(i = 0; i < IO_SR_PATHS; i++){
                        if((previous_target[i] == reg_task_ID )&&(previous_message_sent[i] != 2)){
                            if(previous_message_sent[i] == 0)
                                IO_SR_ack = 1;
                            else 
                                IO_SR_request = 1;

                            reg_source_PE = reg_task_ID;
                            reg_task_ID = previous_task_ID[i];

                            break;
                        }
                    }

                    EA_sr_path.write(S_WAIT_ORDER);
            break;            

        }
    }
}



void io_peripheral::in_proc_FSM(){
		
	if(reset.read() == true){
		EA_in.write(S_INIT_IN);
		flit_in_counter = 0;
        SR_found = 0;
		IO_request = 0;
		IO_ack = 0;
		for(int i=0;i<BUFFER_IN_PERIPHERAL;i++) {
			buffer_in_flit[i]		=	0;
		}		
		credit_o_primary.write(1);
		
	}
	else{	
		switch(EA_in.read()){
			case S_INIT_IN:			
				if(rx_primary.read() == true){
						buffer_in_flit[flit_in_counter] = data_in_primary.read();
						flit_in_counter = flit_in_counter + 1;

						EA_in.write(S_RECEIVE);
				}

			break;

			case S_RECEIVE:
				if(rx_primary.read() == true){
					buffer_in_flit[flit_in_counter] =  data_in_primary.read();
                    			if((flit_in_counter == 2) && ( ( data_in_primary.read() >> 12) == 7))
                        			SR_found = 1;

                   			if((SR_found == 1) && (data_in_primary.read() == 0)){
                        			flit_in_counter = 5;
                        		SR_found = 0;
                    			}
                    		else{
                       			flit_in_counter = flit_in_counter + 1;
                    		}
                    

					if(flit_in_counter == 14){
						reg_header	 		= buffer_in_flit[1];
						reg_msg_size 		= buffer_in_flit[5];
						reg_service 		= buffer_in_flit[7];
						reg_task_ID 		= buffer_in_flit[9];
						reg_peripheral_ID 	= buffer_in_flit[11];
						reg_source_PE 		= buffer_in_flit[13];
					}
					if(flit_in_counter == 26 && reg_msg_size > 0X0B){
						EA_in.write(S_PAYLOAD);
						flit_in_counter = 0;
					}
					if(eop_in_primary.read()== true){
						EA_in.write(S_SERVICE);
						flit_in_counter = 0;
					}
					
				}
				else{
					EA_in.write(S_WAIT);
				}
			break;			
			
			case S_WAIT:
				if(rx_primary.read() == true){
					buffer_in_flit[flit_in_counter] =  data_in_primary.read();
					flit_in_counter = flit_in_counter + 1;						
					EA_in.write(S_RECEIVE);
				}
			break;

			case S_SERVICE:
				flit_in_counter = 0;
				
				if(reg_service == 0x15){  //  IO_REQUEST		
					IO_request = 1;
				}
				else if(reg_service == 0x25){  //  IO_DELIVERY		
					IO_ack = 1;
				}
                else if(reg_service == 0x300){  //  IO_SR     
                    IO_SR = 1;
                }                

				EA_in.write(S_INIT_IN);
			break;
			  
			case S_PAYLOAD:
				if(rx_primary.read() == true){
						buffer_in_flit[flit_in_counter] = data_in_primary.read();
				}
				flit_in_counter = (flit_in_counter + 1) % BUFFER_IN_PERIPHERAL;
				if(eop_in_primary.read()== true){
					EA_in.write(S_SERVICE);
					flit_in_counter = 0;
				}	
			break;	

		}
	}
}


///////////////////////////////////////////////////

void io_peripheral::out_proc_FSM(){
    int i;
    if(reset.read()==true){
        tx_primary.write(false);
        flit_out_counter = 0;
        EA_out.write(S_WAIT_REQ);
        for(i = 0;i<BUFFER_OUT_PERIPHERAL;i++) {
            if(i<26)
                buffer_out_flit[i]      =   0;
            else
                buffer_out_flit[i]      =   i;
        }
        for(i = 0; i < IO_SR_PATHS; i++){
            previous_message_sent[i] = 2;
        }
    }
    else{
        switch(EA_out.read()){

			case S_WAIT_REQ:

                //////////////////////////////////////////////////
                // verifica se tem SR para este target
                // caso sim entao SR_PATH_index é diferente de 7
                SR_PATH_index = 7;              
                //if(IO_request || IO_ack){
                    for(i = 0; i < IO_SR_PATHS; i++){
                        if((reg_source_PE == SR_target[i]) && (SR_used[i] == 1)){
                            SR_PATH_index = i;
                            break;
                        }
                    }
                //}
                //////////////////////////////////////////////////
                // procura indice para salvar informações sobre a
                // mensagem a ser enviada, de acordo com o target
                for(i = 0; i < IO_SR_PATHS; i++){
                    if(previous_message_sent[i] == 2){
                        previous_index = i;
                        break;
                    }
                }
                for(i = 0; i < IO_SR_PATHS; i++){
                    if((previous_target[i] == reg_source_PE) && (previous_message_sent[i] != 2)){
                        previous_index = i;
                        break;
                    }
                }
                //////////////////////////////////////////////////                              

                
                if(IO_SR_request == 1)
                    EA_out.write(S_SR_PREVIOUS_REQ);

                else if(IO_SR_ack == 1)
                    EA_out.write(S_SR_PREVIOUS_ACK);

                else if((SR_PATH_index == 7) && (IO_request == 1))
                    EA_out.write(S_XY_REQ);

                else if((SR_PATH_index == 7) && (IO_ack == 1))
                    EA_out.write(S_XY_ACK);

                else if((SR_PATH_index != 7) && (IO_request == 1))
                    EA_out.write(S_SR_REQ);

                else if((SR_PATH_index != 7) && (IO_ack == 1))
                    EA_out.write(S_SR_ACK);                


            break;


            case S_XY_REQ:
                    IO_request = 0;
                    previous_message_sent[previous_index] = 1; //REQUEST
                    previous_target[previous_index] = reg_source_PE;
                    previous_task_ID[previous_index] = reg_task_ID;

                    payload_size = 2;
                    header_size = 26;

                    // buffer_out_flit[0] = ( 0x6 << 12) | ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
                    buffer_out_flit[0] = ( 0x6 << 12) | (KE_OSZ)  ; //header
                    buffer_out_flit[1] =  reg_source_PE;                                            //header
                    // buffer_out_flit[2] = ( 0x6 << 12) | ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
                    buffer_out_flit[2] = ( 0x6 << 12) | (KE_OSZ); //header
                    buffer_out_flit[3] = reg_source_PE;                         
	                buffer_out_flit[4] = 0;                     //size
	                buffer_out_flit[5] = (11+payload_size);                //header size + 2 de"payload"
	                buffer_out_flit[6] = 0;                     //service
	                buffer_out_flit[7] = 0X25;                  //service: IO_DELIVERY
	                buffer_out_flit[8] = 0;                     //consumer ID
	                buffer_out_flit[9] = reg_peripheral_ID;           //consumer ID
	                buffer_out_flit[10] = 0;                    //producer ID
	                buffer_out_flit[11] = reg_task_ID;          //producer ID
	                buffer_out_flit[12] = 0;                    //source_PE
	                buffer_out_flit[13] = reg_header;           //source_PE
	                buffer_out_flit[18] = 0;                    //msg_lenght
	                buffer_out_flit[19] = payload_size;         //msg_lenght (32 bits)


	                data_out_primary.write(buffer_out_flit[0]);
                	tx_primary.write(true);
                	if(credit_i_primary.read() == true){
                	    EA_out.write(S_SEND_HEADER);
                	    flit_out_counter = flit_out_counter + 1;        
                	}
            break; 

            case S_XY_ACK:
                    IO_ack = 0;

                    previous_message_sent[previous_index] = 0; //ACK
                    previous_target[previous_index] = reg_source_PE;
                    previous_task_ID[previous_index] = reg_task_ID;

                    payload_size = 0;
                    header_size = 26;

                    // buffer_out_flit[0] = ( 0x6 << 12) | ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
                    buffer_out_flit[0] = ( 0x6 << 12) | (KE_OSZ)  ; //header
                    buffer_out_flit[1] =  reg_source_PE;                                            //header
                    // buffer_out_flit[2] = ( 0x6 << 12) | ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
                    buffer_out_flit[2] = ( 0x6 << 12) | (KE_OSZ); //header
                    buffer_out_flit[3] =  reg_source_PE;          //header
                    buffer_out_flit[4] = 0;                     //size
                    buffer_out_flit[5] = 11;                    //header size + 2 de"payload"
                    buffer_out_flit[6] = 0;                     //service
                    buffer_out_flit[7] = 0X26;                  //service: IO_ACK
                    buffer_out_flit[8] = 0;                     //consumer ID
                    buffer_out_flit[9] = reg_task_ID;           //consumer ID
                    buffer_out_flit[10] = 0;                    //producer ID
                    buffer_out_flit[11] = reg_peripheral_ID;    //producer ID
                    buffer_out_flit[12] = 0;                    //source_PE
                    buffer_out_flit[13] = reg_header;           //source_PE
                    buffer_out_flit[18] = 0;                    //msg_lenght
                    buffer_out_flit[19] = 0;                    //msg_lenght (32 bits)

                    data_out_primary.write(buffer_out_flit[0]);
                    tx_primary.write(true);
                    if(credit_i_primary.read() == true){
                        EA_out.write(S_SEND_HEADER);
                        flit_out_counter = flit_out_counter + 1;        
                    }
            break;

            case S_SR_REQ:
            case S_SR_PREVIOUS_REQ:
                    IO_request = 0;
                    IO_SR_request = 0;

                    previous_message_sent[previous_index] = 1; //REQUEST
                    previous_target[previous_index] = reg_source_PE;
                    previous_task_ID[previous_index] = reg_task_ID;

                    payload_size = 2;
                    header_size = 24+SR_size[SR_PATH_index];

                    //buffer_out_flit[0] = ( 0x6 << 12) | ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
                    buffer_out_flit[0] = ( 0x6 << 12) | (KE_OSZ); //header
                    buffer_out_flit[1] = reg_source_PE;                                            //header
                    for(i = 0; i < SR_size[SR_PATH_index]; i++){
                         buffer_out_flit[i+2] = SR_path[SR_PATH_index][i];
                    }    
                    buffer_out_flit[i+2] = 0;                     //size
                    buffer_out_flit[i+3] = 11 + (SR_size[SR_PATH_index] -2) + payload_size;                //header size + 2 de"payload"
                    buffer_out_flit[i+4] = 0;                     //service
                    buffer_out_flit[i+5] = 0X25;                  //service
                    buffer_out_flit[i+6] = 0;                     //consumer ID
                    buffer_out_flit[i+7] = reg_peripheral_ID;           //consumer ID
                    buffer_out_flit[i+8] = 0;                    //producer ID
                    buffer_out_flit[i+9] = reg_task_ID;    //producer ID
                    buffer_out_flit[i+10] = 0;                    //source_PE
                    buffer_out_flit[i+11] = reg_header;           //source_PE
                    buffer_out_flit[i+16] = 0;                    //msg_lenght
                    buffer_out_flit[i+17] = payload_size;                    //msg_lenght (32 bits)

                    data_out_primary.write(buffer_out_flit[0]);
                    tx_primary.write(true);
                    if(credit_i_primary.read() == true){
                        EA_out.write(S_SEND_HEADER);
                        flit_out_counter = flit_out_counter + 1;        
                    }
                
            break;

            case S_SR_ACK:
            case S_SR_PREVIOUS_ACK:
                    IO_ack = 0;
                    IO_SR_ack = 0;

                    previous_message_sent[previous_index] = 0; //ACK
                    previous_target[previous_index] = reg_source_PE;
                    previous_task_ID[previous_index] = reg_task_ID;

                    payload_size = 0;
                    header_size = 24+SR_size[SR_PATH_index];

                    // buffer_out_flit[0] = ( 0x6 << 12) | ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
                    buffer_out_flit[0] = ( 0x6 << 12) | (KE_OSZ); //header
                    buffer_out_flit[1] = reg_source_PE; 
                    for(i = 0; i < SR_size[SR_PATH_index]; i++){
                         buffer_out_flit[i+2] = SR_path[SR_PATH_index][i];
                    }                    
                    buffer_out_flit[i+2] = 0;                         //size
                    buffer_out_flit[i+3] = 11 + (SR_size[SR_PATH_index] -2) + payload_size;                //header size + 0 de"payload"
                    buffer_out_flit[i+4] = 0;                     //service
                    buffer_out_flit[i+5] = 0X26;                  //service
                    buffer_out_flit[i+6] = 0;                     //consumer ID
                    buffer_out_flit[i+7] = reg_task_ID;           //consumer ID
                    buffer_out_flit[i+8] = 0;                    //producer ID
                    buffer_out_flit[i+9] = reg_peripheral_ID;    //producer ID
                    buffer_out_flit[i+10] = 0;                    //source_PE
                    buffer_out_flit[i+11] = reg_header;           //source_PE
                    buffer_out_flit[i+16] = 0;                    //msg_lenght
                    buffer_out_flit[i+17] = payload_size;                    //msg_lenght (32 bits)

                    data_out_primary.write(buffer_out_flit[0]);
                    tx_primary.write(true);
                    if(credit_i_primary.read() == true){
                        EA_out.write(S_SEND_HEADER);
                        flit_out_counter = flit_out_counter + 1;        
                    }
			break;

			
			case S_SEND_HEADER:
					if(credit_i_primary.read() == true){
						data_out_primary.write(buffer_out_flit[flit_out_counter]);
						flit_out_counter = flit_out_counter + 1; 
						//if(flit_out_counter == 26){
                        if(flit_out_counter == header_size){
							if(payload_size == 0){  
								EA_out.write(S_SEND_EOP);
								eop_out_primary.write(true);
							}
							else{
								EA_out.write(S_SEND_PAYLOAD);
								flit_out_counter = 0;	
							}
						}						
					}
					else{
						EA_out.write(S_WAIT_CREDIT_HEADER);
						tx_primary.write(false);
					}

			break;

            case S_SEND_PAYLOAD:                                
                    if(credit_i_primary.read() == true){
                        data_out_primary.write(buffer_out_flit[flit_out_counter+26]);
                        flit_out_counter = flit_out_counter + 1; 
                        if(flit_out_counter == (payload_size*2)){
                            EA_out.write(S_SEND_EOP);
                            eop_out_primary.write(true);
                            flit_out_counter = 0;   
                        }                       
                    }
                    else{
                        EA_out.write(S_WAIT_CREDIT_PAYLOAD);
                        tx_primary.write(false);
                    }
            break;

            case S_WAIT_CREDIT_HEADER:              
                if(credit_i_primary.read() == true){
                    flit_out_counter = flit_out_counter -3;
                    data_out_primary.write(buffer_out_flit[flit_out_counter]);
                    tx_primary.write(true);
                    EA_out.write(S_SEND_HEADER);    
                    flit_out_counter = flit_out_counter+1;              
                }

            break;

            case S_WAIT_CREDIT_PAYLOAD:
                if(credit_i_primary.read() == true){
                    flit_out_counter = flit_out_counter-3 ;
                    data_out_primary.write(buffer_out_flit[flit_out_counter]);
                    tx_primary.write(true);
                    if(flit_out_counter == (payload_size*2)-1){
                        EA_out.write(S_SEND_EOP);
                        eop_out_primary.write(true);
                    }
                    else{
                        flit_out_counter = flit_out_counter+1 ;
                        EA_out.write(S_SEND_PAYLOAD);
                    }
                }	
            break;	

			case S_SEND_EOP: //FAZER O ESTADO WAIT EOP ACK DOWN
				tx_primary.write(false);
				eop_out_primary.write(false);
				flit_out_counter = 0;
				EA_out.write(S_WAIT_REQ);
			break;			
			  
		}
	}
}


void io_peripheral::seek_ack(){
	out_ack_router_seek_primary.write(1);//send ack always (ignore seek messages)	
}
