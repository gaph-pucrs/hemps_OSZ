//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 8.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Date:  July 2018
//
//  Source name:  sabotage.cpp
//
//  Brief description: 
//
//---------------------------------------------------------------------------------------

#include "sabotage.h"
#include "sabotage_param.h"

///////////////////////////////////////////////////


void sabotage::in_proc_FSM(){
        
    if(reset.read() == true){
        EA_in.write(S_INIT_IN);
        flit_in_counter = 0;
        for(int i=0;i<BUFFER_IN_PERIPHERAL;i++) {
            buffer_in_flit[i]       =   0;
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
                        reg_header          = buffer_in_flit[3];
                        reg_msg_size        = buffer_in_flit[5];
                        reg_service         = buffer_in_flit[7];
                        reg_task_ID         = buffer_in_flit[9];
                        reg_peripheral_ID   = buffer_in_flit[11];
                        reg_source_PE       = buffer_in_flit[13];
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
                //if(reg_service == IO_SR_PATH){
                if(reg_service == 0x300){  //  IO_SR_PATH        
                    IO_request = 1;
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

void sabotage::out_proc_FSM(){
    
    if(reset.read()==true){
        tx_primary.write(false);
        flit_out_counter = 0;
        aux_cont = 0;
        aux_cont_p = PERIOD;
        last_cont = 0;
        EA_out.write(S_WAIT_REQ);
        for(int i=0;i<BUFFER_OUT_PERIPHERAL;i++) {
            if(i<26)
                buffer_out_flit[i]      =   0;
            else
                buffer_out_flit[i]      =   i;
        }
    }
    else{
        aux_cont = aux_cont  + 1;
        if (aux_cont_p > 0){
            aux_cont_p = aux_cont_p -1;
        }
        switch(EA_out.read()){
			case S_WAIT_REQ:
                if((aux_cont > T_START) && (aux_cont < T_END)){
                    if (aux_cont_p == 0){
                        header_size = 26;

                        buffer_out_flit[0] = HEADER_FIX_HI; 
                        buffer_out_flit[1] = HEADER_FIX_LO; 
                        buffer_out_flit[2] = HEADER_ROUT_HI; 
                        buffer_out_flit[3] = HEADER_ROUT_LO; 
                        buffer_out_flit[4] = 0;                     //size (hi)
                        buffer_out_flit[5] = (11+2);                //size (lo) = header size + 2 de "payload"
                        buffer_out_flit[6] = F1_FLIT;
                        buffer_out_flit[7] = F2_FLIT;
                        buffer_out_flit[8] = 0;                     //service (hi)
                        buffer_out_flit[9] = SERVICE_FLIT;
                        buffer_out_flit[10] = 0;                    //producer ID
                        buffer_out_flit[11] = reg_peripheral_ID;    //producer ID
                        buffer_out_flit[12] = 0;                    //source_PE
                        buffer_out_flit[13] = SOURCE_FLIT;          //source_PE
                        buffer_out_flit[18] = 0;                    //msg_lenght
                        buffer_out_flit[19] = 2;                    //msg_lenght (32 bits)
                        packet_size = buffer_out_flit[19];

                        data_out_primary.write(buffer_out_flit[0]);
                        tx_primary.write(true);
                        if(credit_i_primary.read() == true){
                            EA_out.write(S_SEND_HEADER);
                            aux_cont_p = PERIOD;
                            flit_out_counter = flit_out_counter + 1;        
                        }
                    }
				}	
		
			break;

			
			case S_SEND_HEADER:
					if(credit_i_primary.read() == true){
						data_out_primary.write(buffer_out_flit[flit_out_counter]);
						flit_out_counter = flit_out_counter + 1; 
                        if(flit_out_counter == header_size){
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
                        if(flit_out_counter == (packet_size*2)){
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
            break;

			case S_SEND_EOP: //FAZER O ESTADO WAIT EOP ACK DOWN
				tx_primary.write(false);
				eop_out_primary.write(false);
				flit_out_counter = 0;
                if(last_cont == 30){
				    EA_out.write(S_WAIT_REQ);
                    last_cont = 0;
                }
                last_cont = last_cont  + 1;
			break;			
			  
		}
	}
}


void sabotage::seek_ack(){
	out_ack_router_seek_primary.write(1);//send ack always (ignore seek messages)	
}