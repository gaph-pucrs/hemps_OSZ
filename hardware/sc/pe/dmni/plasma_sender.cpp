//------------------------------------------------------------------------------------------------
//
//   plasma_sender.cpp
//
//   Created on: May 18, 2016
//   Author: mruaro
//   Modificated: Fochi / Caimi - july 13, 2016
//
//			 -------------------------
//			|						  |<--- data_in / 16
//			|						  |<--- eop_in
//			|						  |<--- bop_in
//			|		    			  |<--- rx
//			|			DMNI		  |---> credit_out
//			|	   		   -----------
//			|			  |	  --------
//			|			  |32|		  |---> data_out /16
//			|			  |--| Sender |---> eop_out
//			|			  |--|		  |---> bop_out
//			|			  |--|		  |---> tx
//			|			  |--|		  |<--- credit_in
//			 -------------    --------
//
//
//------------------------------------------------------------------------------------------------
#include "plasma_sender.h"


// PROCESSO DE CONTROLE DA OCUPACAO DA FILA
// SE FILA HA ESPACOS LIVRES NA FILA
//   TEM_ESPACO_NA_FILA = TRUE
// DO CONTRARIO
//   TEM_ESPACO_NA_FILA = FALSE
void plasma_sender::in_proc_FSM(){
	sc_uint<4> local_first, local_last;
	
	local_first = first.read();
	local_last = last.read();
	
	if(reset.read() == true){
		tem_espaco_na_fila.write(true);
			credit_o.write(true);
	}
	else{
		//if (((local_first==0) && (local_last==(BUFFER_TAM_SENDER-2))) || (local_first==(local_last+2)) || (local_first==(local_last+1))){
		if (((local_first==0) && (local_last==(BUFFER_TAM_SENDER-1))) || (local_first==(local_last+1))){
			tem_espaco_na_fila.write(false);
			credit_o.write(false);
		}
		else if(((local_last - local_first) == 2) || ((local_first - local_last) == BUFFER_TAM_SENDER-2)){
			tem_espaco_na_fila.write(true);
			credit_o.write(true);
		}
	}
}

// O ponteiro last é inicializado com o valor zero quando o reset é ativado.
// Quando o sinal rx é ativado indicando que existe um flit na porta de entrada é
// verificado se existe espaço na fila para armazená-lo. Se existir espaço na fila o
// flit recebido é armazenado na posição apontada pelo ponteiro last e o mesmo é
// incrementado. Quando last atingir o tamanho da fila, ele recebe zero.
void plasma_sender::in_proc_updPtr(){
	if(reset.read()==true){
		last.write(0);
		for(int i=0;i<BUFFER_TAM_SENDER;i++){
			buffer_in[i]=0;	
			eop_buffer[i]=0;
			bop_buffer[i]=0;
		} 
	}
	else{
		if((tem_espaco_na_fila.read()==true) && (rx.read()==true)){
			buffer_in[last.read()] = data_in.read();
			eop_buffer[last.read()] = eop_in.read();
			bop_buffer[last.read()] = bop_in.read();
			//incrementa o last
			if(last.read()==(BUFFER_TAM_SENDER - 1))
				last.write(0);
			else
				last.write((last.read() + 1));
		}
	}
}

void plasma_sender::out_proc_FSM(){
	
	sc_uint<1> last_send;
	sc_uint<4> local_first;
	sc_uint<4> local_last;
	
	
	
	if(reset.read()==true){
		first.write(0);
		data_avail.write(0);
		//tx.write(0);
		eop_out.write(0);
		last_send = 0;
		EA.write(S_INIT);
	}
	else{
		local_first = first.read();
		local_last = last.read();

		switch(EA.read()){
			case S_INIT:
				//tx.write(0);
				data_avail.write(0);
				eop_out.write(0);
				bop_out.write(0);
				if(local_first != local_last){ // detectou dado na fila
					EA.write(SEND_HIGH);
				}
				else{
					EA.write(S_INIT);
				}
			break;
			
			case SEND_HIGH:
				if(credit_in.read() == 1){
					EA.write(SEND_LOW);      // depois de rotear envia o pacote	
					data_out.write(buffer_in[local_first](31, 16));
					bop_out.write(bop_buffer[local_first].read());
					eop_out.write(0);
					data_avail.write(1);
					//tx.write(1);
					last_send = 1;									
				}
				//else{
				//	if (last_send == 0 ){
				//	//tx.write(0);
				//	EA.write(SEND_LOW);
				//		if(first.read()== 0)
				//			first.write(BUFFER_TAM_SENDER - 1);
				//		else
				//			first.write((first.read() - 1));
				//		}
				//	else{
				//		//tx.write(0);
				//		EA.write(SEND_HIGH);
				//	}
				//}
			break;

			case SEND_LOW:
				if(credit_in.read() == 1){
					data_out.write(buffer_in[local_first](15, 0));
					eop_out.write(eop_buffer[local_first].read());
					bop_out.write(0);
					//tx.write(1);
					last_send = 0;
					// logica de próximo estado
					//if (eop_buffer[local_first].read()){
					if ( (local_first+1 == local_last) || ((local_first == BUFFER_TAM_SENDER-1) && (local_last == 0)) ){	
						EA.write(SEND_LAST_FLIT);
						//tx.write(0);
					}									
					else{
						EA.write(SEND_HIGH);
					}
					// logica de atualização do ponteiro first
					if(first.read()==(BUFFER_TAM_SENDER - 1))
						first.write(0);
					else
						first.write((first.read() + 1));
				}	
				else{
					if (last_send == 0 ){
						//tx.write(0);
						EA.write(SEND_LOW);
					}	
					else{
						//tx.write(0);
						EA.write(SEND_HIGH);
						cout<<"trocou de low para high para reenviar :-() "<<endl;
					}
				}
			break;
			case SEND_LAST_FLIT:
				if(credit_in.read()==1){
					EA.write(S_INIT);
					data_avail.write(0);
					eop_out.write(0);
					bop_out.write(0);
				}
			break;
		}
	}
}


void plasma_sender::combinational(){
	//credit_o.write( full[0].read() & full[1].read() );
	
	// tx.write( credit_in.read() &  data_avail.read() );
	tx.write( credit_in.read() &  data_avail.read() );


	
}