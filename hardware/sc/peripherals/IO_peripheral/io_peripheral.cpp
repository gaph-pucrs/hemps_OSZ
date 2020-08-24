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


void io_peripheral::in_proc_FSM(){
		
	if(reset.read() == true){
		EA_in.write(S_INIT_IN);
		flit_in_counter = 0;
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
					flit_in_counter = flit_in_counter + 1;

					if(flit_in_counter == 14){
						reg_header	 		= buffer_in_flit[3];
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
				//if(reg_service == IO_REQUEST){
				if(reg_service == 0x15){  //  IO_REQUEST		
					IO_request = 1;
				}
				else if(reg_service == 0x25){  //  IO_DELIVERY		
					IO_ack = 1;
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
    
    if(reset.read()==true){
        tx_primary.write(false);
        flit_out_counter = 0;
        EA_out.write(S_WAIT_REQ);
        for(int i=0;i<BUFFER_OUT_PERIPHERAL;i++) {
            if(i<26)
                buffer_out_flit[i]      =   0;
            else
                buffer_out_flit[i]      =   i;
        }
    }
    else{
        switch(EA_out.read()){

			case S_WAIT_REQ:
				if (IO_request == 1){
                    IO_request = 0;
	                buffer_out_flit[0] = ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
	                buffer_out_flit[1] =  reg_source_PE;                                            //header
	                buffer_out_flit[2] = ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
	                buffer_out_flit[3] =  reg_source_PE;                                            //header
	                buffer_out_flit[4] = 0;                     //size
	                buffer_out_flit[5] = (11+2);                //header size + 2 de"payload"
	                buffer_out_flit[6] = 0;                     //service
	                buffer_out_flit[7] = 0X25;                  //service
	                buffer_out_flit[8] = 0;                     //consumer ID
	                buffer_out_flit[9] = reg_task_ID;           //consumer ID
	                buffer_out_flit[10] = 0;                    //producer ID
	                buffer_out_flit[11] = reg_peripheral_ID;    //producer ID
	                buffer_out_flit[12] = 0;                    //source_PE
	                buffer_out_flit[13] = reg_header;           //source_PE
	                buffer_out_flit[18] = 0;                    //msg_lenght
	                buffer_out_flit[19] = 2;                    //msg_lenght (32 bits)
	                packet_size = buffer_out_flit[19];

	                data_out_primary.write(buffer_out_flit[0]);
                	tx_primary.write(true);
                	if(credit_i_primary.read() == true){
                	    EA_out.write(S_SEND_HEADER);
                	    flit_out_counter = flit_out_counter + 1;        
                	}
				}	

				if(IO_ack == 1){
					IO_ack = 0;
	                buffer_out_flit[0] = ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
	                buffer_out_flit[1] =  reg_source_PE;                                            //header
	                buffer_out_flit[2] = ((reg_header  & 0XFF00) >> 2) | ((reg_header  & 0XFF) )  ; //header
	                buffer_out_flit[3] =  reg_source_PE;                                            //header
	                buffer_out_flit[4] = 0;                     //size
	                buffer_out_flit[5] = 11;                	//header size + 2 de"payload"
	                buffer_out_flit[6] = 0;                     //service
	                buffer_out_flit[7] = 0X26;                  //service
	                buffer_out_flit[8] = 0;                     //consumer ID
	                buffer_out_flit[9] = reg_task_ID;           //consumer ID
	                buffer_out_flit[10] = 0;                    //producer ID
	                buffer_out_flit[11] = reg_peripheral_ID;    //producer ID
	                buffer_out_flit[12] = 0;                    //source_PE
	                buffer_out_flit[13] = reg_header;           //source_PE
	                buffer_out_flit[18] = 0;                    //msg_lenght
	                buffer_out_flit[19] = 0;                    //msg_lenght (32 bits)
	                packet_size = 0;

	                data_out_primary.write(buffer_out_flit[0]);
					tx_primary.write(true);
					if(credit_i_primary.read() == true){
					    EA_out.write(S_SEND_HEADER);
					    flit_out_counter = flit_out_counter + 1;        
					}
				}	
		
			break;

			
			case S_SEND_HEADER:
					if(credit_i_primary.read() == true){
						data_out_primary.write(buffer_out_flit[flit_out_counter]);
						flit_out_counter = flit_out_counter + 1; 
						if(flit_out_counter == 26){
							if(packet_size == 0){  
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
                        if(flit_out_counter == (packet_size*2)-1){
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
                    if(flit_out_counter == (packet_size*2)-1){
                        EA_out.write(S_SEND_EOP);
                        eop_out_primary.write(true);
                    }
                    else{
                        flit_out_counter = flit_out_counter+1 ;
                        EA_out.write(S_SEND_PAYLOAD);
                    }
                }		

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