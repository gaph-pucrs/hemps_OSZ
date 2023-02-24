//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  September 2013
//
//  Source name:  queue.cpp
//
//  Brief description: Control process queue occupancy
//
//---------------------------------------------------------------------------------------

#include "fifo_pdn.h"


// PROCESSO DE CONTROLE DA OCUPACAO DA FILA
// SE FILA HA ESPACOS LIVRES NA FILA
//   TEM_ESPACO_NA_FILA = TRUE
// DO CONTRARIO
//   TEM_ESPACO_NA_FILA = FALSE
void fifo_PDN::in_proc_FSM(){
	sc_uint<4> local_first, local_last;
	
	local_first = first.read();
	local_last = last.read();
	
	if(reset.read() == true){
		tem_espaco_na_fila.write(true);
		out_nack_fifo_seek.write(false);
		out_ack_fifo_seek.write(false);
		out_req_pe.write(false);
		out_sel_reg_backtrack_seek.write(0);
		EA_in.write(S_INIT_IN);
		for(int i=0;i<BUFFER_TAM_FIFO_PDN;i++) {
			buffer_source[i]		=	0;
			buffer_target[i]		=	0;
			buffer_payload[i]		=	0;
			buffer_service[i]		=	0;
			buffer_backtrack1[i]	=	0;
			buffer_backtrack2[i]	=	0;
			buffer_backtrack3[i]	=	0;
		}		
	}
	else{	
		switch(EA_in.read()){
			case S_INIT_IN:
				out_nack_fifo_seek.write(false);
				out_ack_fifo_seek.write(false);
				out_sel_reg_backtrack_seek.write(0);
				if(in_req_fifo_seek.read() == true){
				//	if(tem_espaco_na_fila.read() == true){		
						EA_in.write(S_COPY_DATA);
				//	}
				//	else{
				//		EA_in.write(S_NACK);
				//	}				
				}
			break;

			case S_NACK:
				out_nack_fifo_seek.write(true);
				EA_in.write(S_WAIT_REQ_DOWN);
			break;			
			
			case S_COPY_DATA:
				buffer_source[local_last]		=	in_source_fifo_seek.read();
				buffer_target[local_last]		=	in_target_fifo_seek.read();
				buffer_payload[local_last]		=	in_payload_fifo_seek.read();
				buffer_service[local_last]		=	in_service_fifo_seek.read();
				buffer_backtrack1[local_last]	=	in_reg_backtrack_seek.read();	
				buffer_opmode[local_last]		=	in_opmode_fifo_seek.read();	

				if(in_service_fifo_seek.read() == BACKTRACK_SERVICE){
					EA_in.write(S_COPY_DATA1); 
					out_sel_reg_backtrack_seek.write(true);   
				}
				else{
					EA_in.write(S_ACK);
				}
			break;

			case S_COPY_DATA1:
				buffer_backtrack2[local_last]	=	in_reg_backtrack_seek.read();
				out_sel_reg_backtrack_seek.write(2);  
				EA_in.write(S_COPY_DATA2); 
			break;
			  
			case S_COPY_DATA2:
				buffer_backtrack3[local_last]	=	in_reg_backtrack_seek.read();
				out_sel_reg_backtrack_seek.write(0);  
				EA_in.write(S_ACK);
			break;	

			case S_ACK:
				out_ack_fifo_seek.write(true);
				EA_in.write(S_WAIT_REQ_DOWN);
			break;			

			case S_WAIT_REQ_DOWN:
				if(in_req_fifo_seek.read() == 0){
					if(tem_espaco_na_fila.read() == true){
						if(local_last==(BUFFER_TAM_FIFO_PDN - 1))
							last.write(0);
						else
							last.write((last.read() + 1));
						EA_in.write(S_INIT_IN);
					}
					else{
						EA_in.write(S_WAIT_SPACE);	
						out_ack_fifo_seek.write(false);
						out_nack_fifo_seek.write(true);
					}
				}
			break;
			case S_WAIT_SPACE:
					if(tem_espaco_na_fila.read() == true){
						EA_in.write(S_INIT_IN);
						if(local_last==(BUFFER_TAM_FIFO_PDN - 1))
							last.write(0);
						else
							last.write((last.read() + 1));
					}
			break;

		}
	}
}


void fifo_PDN::in_proc_updPtr(){
	sc_uint<4> local_first;
	sc_uint<4> local_last;
	if(reset.read()==true){
		last.write(0);
		first.write(0);
	}
	else{
		local_first = first.read();
		local_last = last.read();


		// if (((local_first==0) && (local_last==(BUFFER_TAM_FIFO_PDN-2))) || (local_first==(local_last+2)) || (local_first==(local_last+1))){
		if (((local_first==0) && (local_last==(BUFFER_TAM_FIFO_PDN-1))) || (local_first==(local_last+1))){
			tem_espaco_na_fila.write(false);
		}
		//else if(((local_last - local_first) == 2) || ((local_first - local_last) == BUFFER_TAM_FIFO_PDN-2)){
		else //if(((local_last - local_first) == 2) || ((local_first - local_last) == BUFFER_TAM_FIFO_PDN-2)){
			tem_espaco_na_fila.write(true);
		//}	
	} 
}


///////////////////////////////////////////////////

void fifo_PDN::out_proc_FSM(){
	sc_uint<4> local_first;
	sc_uint<4> local_last;

	
	if(reset.read()==true){
		out_req_pe.write(false);
		EA_out.write(S_INIT_OUT);
	}
	else{
		local_first = first.read();
		local_last = last.read();
				
		switch(EA_out.read()){
			case S_INIT_OUT:
				if(local_first != local_last){ // detectou dado na fila
					EA_out.write(S_OUT_REQ);
				}
			break;
			
			case S_OUT_REQ:
				out_req_pe.write(true);
				out_service_fifo_seek.write(buffer_service[local_first]);

				out_source_fifo_seek.write(buffer_source[local_first]);

				out_target_fifo_seek.write(buffer_target[local_first]);

				out_payload_fifo_seek.write(buffer_payload[local_first]);

				out_opmode_fifo_seek.write(buffer_opmode[local_first]);
				EA_out.write(S_WAIT_ACK);
			break;

			case S_WAIT_ACK:
				if(in_ack_fifo_seek.read()==true){//confirma��o do envio do header
					EA_out.write(S_WAIT_ACK_DOWN);
					out_req_pe.write(false);
				}
			break;
			  
			case S_WAIT_ACK_DOWN:
				if(in_ack_fifo_seek.read()==false){//confirma��o do envio de um dado que n�o � o tail
					EA_out.write(S_INIT_OUT);
					
					if(local_first==(BUFFER_TAM_FIFO_PDN - 1))
							first.write(0);
					else
							first.write((first.read() + 1));
				}
			break;	
		}
	}
}


void fifo_PDN::out_backtrack(){
	switch(in_sel_reg_backtrack.read()){
		case 0:
			out_reg_backtrack.write(buffer_backtrack1[first.read()]);
		break;
		case 1:
			out_reg_backtrack.write(buffer_backtrack2[first.read()]);
		break;
		default:
			out_reg_backtrack.write(buffer_backtrack3[first.read()]);
		break;
	} 
}