//------------------------------------------------------------------------------------------------
//
//  HEMPS  - version 6.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  September 2015
//
//  Source name:  dmni.cpp
//  Modificated: Fochi / Caimi - july 2016
//
//  Brief description:  Implements a DMA and NI module.
//
//
//			 -------------------------
//			|						  |<--- data_in / 16
//			|						  |<--- eop_in
//			|		    			  |<--- rx
//			|			DMNI		  |---> credit_out
//			|	   		   -----------
//			|			  |	  --------
//			|			  |32|		  |---> data_out /16
//			|			  |--| Sender |---> eop_out
//			|			  |--|		  |---> tx
//			|			  |--|		  |<--- credit_in
//			 -------------    --------
//
//
//------------------------------------------------------------------------------------------------

#include "dmni.h"

#define ABORTED_PACKET_SIZE 3

void dmni::arbiter(){
	if (reset.read() == 1){
		write_enable.write(0);
		read_enable.write(0);
		timer.write(0);
		prio.write(0);
		ARB.write(ROUND);


	} else {

		switch (ARB.read()) {
			case ROUND:

				if (prio.read() == 0){
					if (DMNI_Receive.read() == COPY_TO_MEM) {
						ARB.write(RECEIVE);
						write_enable.write(1);
					} else if (send_active.read() == 1){
						ARB.write(SEND);
						read_enable.write(1);
					}
				} else {
					if (send_active.read() == 1){
						ARB.write(SEND);
						read_enable.write(1);
					} else if (DMNI_Receive.read() == COPY_TO_MEM || DMNI_Receive_Kernel.read() == COPY_TO_MEM) {
						ARB.write(RECEIVE);
						write_enable.write(1);
					}
				}
			break;

			case SEND:

				if (DMNI_Send.read() == END || (timer.read() >= DMNI_TIMER && receive_active.read() == 1)){
					timer.write(0);
					ARB.write(ROUND);
					read_enable.write(0);
					prio.write(!prio.read());
				} else {
					timer.write(timer.read() + 1);
				}
			break;

			case RECEIVE:

				if (DMNI_Receive.read() == END || DMNI_Receive_Kernel.read() == END ||(timer.read() >= DMNI_TIMER && send_active.read() == 1)){
					timer.write(0);
					ARB.write(ROUND);
					write_enable.write(0);
					prio.write(!prio.read());
				} else {
					timer.write(timer.read() + 1);
				}
			break;
		}
	}
}

void dmni::config(){

	if (set_address.read() == 1){
		address.write(config_data.read());
		address_2.write(0);
	} else if (set_address_2.read() == 1){
		address_2.write(config_data.read());
	} else if (set_size.read() == 1) {
		size.write(config_data.read());
		size_2.write(0);
	} else if (set_size_2.read() == 1){
		size_2.write(config_data.read());
	} else if (set_op.read() == 1){
		operation.write(config_data.read()(0,0));
	} else if (send_kernel.read() == 1){
		address_svc_header_RAM.write(mem_address_service_header_kernel.read());
	}

}

void dmni::mem_address_update(){
	if (read_enable.read() == 1){
		mem_address.write(send_address.read());
	} else {
		mem_address.write(recv_address.read());
	}
}

void dmni::credit_o_update() {
	credit_o.write((slot_available.read() || reg_interrupt_received.read()) && (receive_flit_timeout.read() == 0));
}

void dmni::buffer_control(){

	//Buffer full
	if ( ( first.read() == last.read() ) && add_buffer.read() == 1){
		slot_available.write(0);
	} else {
		slot_available.write(1);
	}

	//Buffer empty
	if ( ( first.read() == last.read() ) && add_buffer.read() == 0){
		read_av.write(0);
	} else {
		read_av.write(1);
	}
}

void dmni::receive(){

	sc_uint<16 > data_in_int;
	sc_uint<4> intr_counter_temp;
	int pig_counter;

	if (reset.read() == 1){
		flag_middle_eop = 0;
		cont.write(0);
		first.write(0);
		last.write(0);
		dmni_timeout.write(0);
		payload_size.write(0);
		SR.write(HEADER);
		add_buffer.write(0);
		receive_active.write(0);
		DMNI_Receive.write(WAIT);
		intr_count.write(0);
		tick_counter.write(0);
		flit_location.write(0);
		pig_signal.write(0);

		for(int i=0; i<BUFFER_SIZE; i++){ //in vhdl replace by OTHERS=>'0'
			is_header[i] = 0;
		}
	}
	else{	
	
		if (reg_interrupt_received_wait.read() == 0 && reg_interrupt_received.read() == 0){


			intr_counter_temp = intr_count.read();
			if(flag_middle_eop.read() == 1 && intr_counter_temp > 0){ // Received a packet cut by AP
				intr_counter_temp = intr_counter_temp - 1; // Removing interruption
				flag_middle_eop.write(0);
				// cout << "ROUTER:" << hex << address_router << ": flag_middle_eop";
				// cout << " time:" << sc_time_stamp() << endl;
				// Clearing the buffer f
				add_buffer.write(0); 
				last.write(last.read() - ABORTED_PACKET_SIZE);
				cont.write(0);
				SR.write(HEADER);
			}
	
			if (cont.read() == 0) {//32 bits high flit
			
			//incoming flit timeout (special case: timeout before interrupting the kernel)
			if(receive_flit_timeout.read() == 1 && (SR.read() == HEADER || SR.read() == DROP_PACKET)) {
				cont.write(0);
				SR.write(HEADER);

			//incoming flit timeout (general case: after interrupting the kernel)
			} else if(receive_flit_timeout.read() == 1 && DMNI_Receive.read() == FAILED_RECEPTION) {
				cont.write(0);
				SR.write(HEADER);
			
			//Read from NoC
			} else if (rx.read() == 1 && slot_available.read() == 1){
				
				//doesnt actually write the flit during DROP_PACKET
				if(SR.read() != DROP_PACKET) {
					buffer_high.write(data_in.read());
					cont.write(1);
				}

				//verifying if first flit it is source_routing
				if(data_in.read()(15,12) == SOURCE_ROUTING_TYPE && SR.read() == HEADER2){
					SR.write(SOURCE_ROUTING_HEADER);
				}

				//check if the eop is received in high flit
				//if received, indicates that there was a fault in middle of a transmittion
				//and the whole packet shall be discarded, then we mark it with a eop
				if(eop_in.read() == 1){

					if(SR.read() == DROP_PACKET) {
						cont.write(0);
						SR.write(HEADER);
					}
					else {
					// 	cout << "ROUTER:" << hex << address_router << ": EOP 2";
					// 	cout << " time:" << sc_time_stamp() << endl;
						buffer[last.read()].write((buffer_high.read(),data_in.read()));
						buffer_eop[last.read()].write(eop_in.read());
						add_buffer.write(0);
						// last.write(last.read() - 2);
						cont.write(0);
						SR.write(HEADER);
						flag_middle_eop.write(1);
					}
				}
			}
		}
		
		if (cont.read() == 1) {//32 bits low flit

			//incoming flit timeout
			if(receive_flit_timeout.read()==1 && DMNI_Receive.read()==FAILED_RECEPTION) {
				cont.write(0);
				SR.write(HEADER);

			//in this state, there is always a write in buffer and buffer_eop
			//Read from NoC low
			} else if (rx.read() == 1 && slot_available.read() == 1){
				
				bool is_beginning_of_packet = (SR.read() == HEADER) && (data_in.read() == address_router);
				
				//DO NOT write on buffer is the packet header fails verification (is not the beginning of a packet)
				if((SR.read() != HEADER) || is_beginning_of_packet) {
					buffer[last.read()].write((buffer_high.read(),data_in.read()));
					buffer_eop[last.read()].write(eop_in.read());
					add_buffer.write(1);
					last.write(last.read() + 1);
				}
			
				switch (SR.read()) {
					case SOURCE_ROUTING_HEADER:
						if(data_in.read()(15,12) != SOURCE_ROUTING_TYPE){//verifying if second flit is source_routing
							buffer_high.write(data_in.read());
							cont.write(1);
						}
						else{
							cont.write(0);
						}
						
						// intr_counter_temp = intr_counter_temp + 1;
						// if(address_router == 0){
						// 	cout<<"Master receiving msg "<<endl;}
						is_header[last.read()] = 1;
						SR.write(PAYLOAD_SIZE);
					break;
					case HEADER:
						if(is_beginning_of_packet) {
							cont.write(0);
							intr_counter_temp = intr_counter_temp + 1; // original
							// if(address_router == 0){
							// 	cout<<"Master receiving msg "<<endl;}
							is_header[last.read()] = 1;
							SR.write(HEADER2);
						}
						else {
							cont.write(0);
							SR.write(DROP_PACKET);
						}
					break;
				
					case HEADER2://payload size
						cont.write(0);

						is_header[last.read()] = 1;
						SR.write(PAYLOAD_SIZE);
						pig_signal.write(0);
					break;
				
					case PAYLOAD_SIZE://payload size
						cont.write(0);
						// intr_counter_temp = intr_counter_temp + 1; // atraso na DMNI

						is_header[last.read()] = 0;					
						payload_size.write(data_in.read() - 1);
						SR.write(DATA);
					break;
				
					case DATA://payload
						is_header[last.read()] = 0;
						cont.write(0);

						pig_signal.write(pig_signal.read()+1);
						
						if (payload_size.read() == 0 || eop_in.read() == 1){ // MELHORAR AQUI
							if (eop_in.read() == 1 && payload_size.read() > 5){ // Did not interrupt, but the buffer is empty? overwritten?
								flag_middle_eop.write(1);
								cout << "Packet incomplete (from AP):" << hex << address_router;
								cout << " time:" << sc_time_stamp() << endl;
							}
							SR.write(HEADER);
						} 
						else{
							payload_size.write(payload_size.read() - 1);
						}
					break;

					case DROP_PACKET:
						//DROP_PACKET state is handled entirely in the HI-flit reading, this 'case' should never happen
					break;
				}		
			}
			// if (SR.read() == DATA && pig_counter == 10)			
				intr_count.write(intr_counter_temp);
		}
	
	switch (DMNI_Receive.read()) {
			
				case WAIT:
				if (reg_interrupt_received_wait.read() == 0){
					if (start.read() == 1 && operation.read() == 1)  {
						recv_address.write(address.read() - WORD_SIZE);
						recv_size.write(size.read() - 1);
						
						if (is_header[first.read()] == 1 && intr_counter_temp > 0){
							intr_counter_temp = intr_counter_temp - 1;
						}
						receive_active.write(1);
						DMNI_Receive.write(COPY_TO_MEM);
					}
				}
				break;
			
				case COPY_TO_MEM:
			
					if(receive_flit_timeout.read()==1 && read_av.read()==0) {
						dmni_timeout.write(1);
						DMNI_Receive.write(FAILED_RECEPTION);
					
					} else if (write_enable.read() == 1 && read_av.read() == 1){
						mem_byte_we.write(0xF);
						flit_location.write((flit_location.read() + 1));

						// mem_data_write.write(buffer[first.read()].read());

						if (flit_location.read() == 8){
							mem_data_write.write(tick_counter.read());
						}else{
							mem_data_write.write(buffer[first.read()].read());
						}

						first.write(first.read() + 1);
						add_buffer.write(0);
						recv_address.write(recv_address.read() + WORD_SIZE);
						recv_size.write(recv_size.read() - 1);
						
						//if size == 0 OR the eop signal is set, the reception ended
						// if (recv_size.read() == 0){
						if (recv_size.read() == 0){
							DMNI_Receive.write(END);
							if(buffer_eop[first.read()] == 1){
								flit_location.write(0);
							}
						}
						else{
							if(buffer_eop[first.read()] == 1){
								if(recv_size.read() != 0){//WARNING 2 is the difference between the original size and the receiving size in SR
									cout << "ROUTER:" << hex << address_router << ": failed reception in middle of a packet";
									cout << " COUNT:" <<  recv_size.read() ;
									cout << " time:" << sc_time_stamp() << endl;
									dmni_timeout.write(1);
									DMNI_Receive.write(FAILED_RECEPTION);
								}
								else{//normal reception
									DMNI_Receive.write(END);
									flit_location.write(0);
								}
							}
						}
					} else {
						if(buffer_eop[first.read()] == 1){
							DMNI_Receive.write(END);
							flit_location.write(0);
						}
						mem_byte_we.write(0);
					}
					
				break;
				case END:
					receive_active.write(0);
					mem_byte_we.write(0);
					recv_address.write(0);
					recv_size.write(0);
					DMNI_Receive.write(WAIT);
				break;
				case FAILED_RECEPTION:
					// cout << "ROUTER:" << hex << address_router << ": failed reception in middle of a packet";
					// cout << " time:" << sc_time_stamp() << endl;
					if(dmni_timeout.read() == 0){
						DMNI_Receive.write(END);
						flit_location.write(0);
					}
					else{
						DMNI_Receive.write(FAILED_RECEPTION);
					}
				break;
		}
		//Interruption management
		if (reg_interrupt_received_wait.read() == 0){
			if (intr_counter_temp > 0){
				if (pig_signal.read() > 0)
					intr.write(1);
			} else {
				intr.write(0);
			}
		}	
							
				intr_count.write(intr_counter_temp);

		} //end if  if (reg_interrupt_received_wait.read() == 0){	
	} //end else

	tick_counter.write((tick_counter.read() + 1) );
}


void dmni::send(){

	if (reset.read() == 1){
		DMNI_Send.write(WAIT);
		send_active.write(0);
		tx.write(0);
		eop_out.write(0);
	} else {

		switch (DMNI_Send.read()) {
			case WAIT:
				if (start.read() == 1 && operation.read() == 0 && reg_interrupt_received.read() == 0 && reg_interrupt_received_wait.read() == 0 ){
					send_address.write(address.read());
					send_address_2.write(address_2.read());
					send_size.write(size.read());
					send_size_2.write(size_2.read());
					send_active.write(1);
					DMNI_Send.write(LOAD);
					// if(address_router == 0){
					// 	cout<<"Master sending msg "<<endl;
					// }
				}
			break;

			case LOAD:

				if (credit_i.read() == 1 && read_enable.read() == 1){
					send_address.write(send_address.read() + WORD_SIZE);
					DMNI_Send.write(COPY_FROM_MEM);
				}
			break;

			case COPY_FROM_MEM:

				if (credit_i.read() == 1 && read_enable.read() == 1){

					if (send_size.read() > 0){

						tx.write(1);
						data_out.write(mem_data_read.read());
						send_address.write(send_address.read() + WORD_SIZE);
						send_size.write(send_size.read() - 1);

						if(send_size_2.read() == 0 && send_size.read() == 1){
							eop_out.write(1);
						}
						else{
							eop_out.write(0);
						}

					} else if (send_size_2.read() > 0) {

						send_size.write(send_size_2.read());
						send_size_2.write(0);
						tx.write(0);
						if (send_address_2.read()(30,28) == 0){
							send_address.write(send_address_2.read());
						} else {
							send_address.write(send_address_2.read() - WORD_SIZE);
						}
						DMNI_Send.write(LOAD);

					} else {
						tx.write(0);
						eop_out.write(0);
						DMNI_Send.write(END);
					}
				} else {
					eop_out.write(0);
					if (credit_i.read() == 0){
						send_size.write(send_size.read() + 1);
						send_address.write(send_address.read() - (WORD_SIZE + WORD_SIZE)); // endereco volta 2 posicoes
					} else {
						send_address.write(send_address.read() - WORD_SIZE);  // endereco volta 1 posicoes
					}
					tx.write(0);
					DMNI_Send.write(LOAD);
				}

			break;

			case END:
				send_active.write(0);
				send_address.write(0);
				send_address_2.write(0);
				send_size.write(0);
				send_size_2.write(0);
				DMNI_Send.write(WAIT);
			break;

			default:
				break;
		}
	}

}

void dmni::send_master_kernel(){

	if (reset.read() == 1){
		DMNI_Send_Kernel.write(WAIT);
		send_active.write(0);
		tx.write(0);
		eop_out.write(0);
		reg_interrupt_received.write(0);
	} else {

		switch (DMNI_Send_Kernel.read()) {
			case WAIT:

				if (in_req_send_kernel_seek.read() == 1 || reg_interrupt_received.read() == 1){
					send_address.write(address_svc_header_RAM.read());
					send_size.write(size.read());
					reg_interrupt_received.write(1);
					out_ack_send_kernel_seek.write(1);
					//send_size_2.write(32768); //for kernel 32k
					send_size_2.write(65536); //for kernel 64k
					send_active.write(1);
					DMNI_Send_Kernel.write(LOAD);
					cout<<"DMNI sending kernel from "<< address_router <<endl;
				}
			break;

			case LOAD:

				if (credit_i.read() == 1 && read_enable.read() == 1){
					send_address.write(send_address.read() + WORD_SIZE);
					DMNI_Send_Kernel.write(COPY_FROM_MEM);
				}
			break;

			case COPY_FROM_MEM:

				if (credit_i.read() == 1 && read_enable.read() == 1){

					if (send_size.read() > 0){

						tx.write(1);
						data_out.write(mem_data_read.read());
						send_address.write(send_address.read() + WORD_SIZE);
						send_size.write(send_size.read() - 1);

					if(send_size_2.read() == 0 && send_size.read() == 1){
							eop_out.write(1);
						}
						else{
							eop_out.write(0);
						}	

					} else if (send_size_2.read() > 0) {

						send_size.write(send_size_2.read());
						send_size_2.write(0);
						
						tx.write(0);
						send_address.write(0);

					} else {
						tx.write(0);
						eop_out.write(0);
						DMNI_Send_Kernel.write(END);
					}
				} else {
					eop_out.write(0);
					if (credit_i.read() == 0){
						send_size.write(send_size.read() + 1);
						send_address.write(send_address.read() - (WORD_SIZE + WORD_SIZE)); // endereco volta 2 posicoes
					} else {
						send_address.write(send_address.read() - WORD_SIZE);  // endereco volta 1 posicoes
					}
					tx.write(0);
					DMNI_Send_Kernel.write(LOAD);
				}

			break;

			case END:
				send_active.write(0);
				send_address.write(0);
				send_address_2.write(0);
				send_size.write(0);
				send_size_2.write(0);
			break;

			default:
				break;
		}
	}

}


void dmni::receive_master_kernel(){

	if (wait_kernel.read() == 1){
		reg_interrupt_received_wait.write(1);
		for(int i=0; i<BUFFER_SIZE; i++){ //in vhdl replace by OTHERS=>'0'
			buffer_eop[i].write(0);
		}
	}

	sc_uint<16 > data_in_int;
	sc_uint<4> intr_counter_temp;
	
	if (reset.read() == 1){
		cont.write(0);
		first.write(0);
		reset_plasma_from_dmni.write(0);
		last.write(0);
		start_copy_kernel.write(0);
		dmni_timeout.write(0);
		payload_size.write(0);
		SR_Kernel.write(HEADER);
		add_buffer.write(0);
		receive_active.write(0);
		flag_wait_kernel.write(0);
		DMNI_Receive_Kernel.write(WAIT);
		reg_interrupt_received_wait.write(0);
		intr_count.write(0);
		reset_counter.write(0);
		for(int i=0; i<BUFFER_SIZE; i++){ //in vhdl replace by OTHERS=>'0'
			is_header[i] = 0;
		}
	}
	else{	
		
		if (reg_interrupt_received_wait.read() == 1){
			intr_counter_temp = intr_count.read();

		if (cont.read() == 0) {//32 bits high flit
			//Read from NoC
			if (rx.read() == 1 && slot_available.read() == 1){
				if (flag_wait_kernel.read() == 0){
					cont.write(1);
					//buffer_aux.write(data_in.read());
				}
				else{
					buffer_high.write(data_in.read());
					cont.write(1);
				}

				if (SR_Kernel.read() == PAYLOAD_SIZE){
					buffer_high.write(data_in.read());
				}

				//check if the eop is received in high flit
				//if received, indicates that there was a fault in middle of a transmittion
				//and the whole packet shall be discarded, then we mark it with a eop
				if(eop_in.read() == 1){
					buffer[last.read()].write((buffer_high.read(),data_in.read()));
					buffer_eop[last.read()].write(eop_in.read());
					add_buffer.write(1);
					last.write(last.read() + 1);
					cont.write(0);
					SR_Kernel.write(HEADER);
				}
			}
		}
		
		if (cont.read() == 1) {//32 bits low flit
			//in this state, there is always a write in buffer and buffer_eop
			//Read from NoC low
			if (rx.read() == 1 && slot_available.read() == 1){
				if (flag_wait_kernel.read() == 0){
				//	buffer_aux.write(data_in.read());
				}
				else{
					buffer[last.read()].write((buffer_high.read(),data_in.read()));
					buffer_eop[last.read()].write(eop_in.read());
					add_buffer.write(1);
					last.write(last.read() + 1);
				}
				switch (SR_Kernel.read()) {
					case HEADER:
						cont.write(0);
						first.write(0);
						last.write(0);											
						SR_Kernel.write(HEADER2);						
					break;

					case HEADER2://payload size	
						cont.write(0);
						//first.write(0);
						//last.write(0);						
						SR_Kernel.write(PAYLOAD_SIZE);
					break;
				
					case PAYLOAD_SIZE://payload size
						cont.write(0);
						payload_size.write((buffer_high.read(),data_in.read()) - 1);						
						SR_Kernel.write(DATA);
					break;
				
					case DATA://payload
						is_header[last.read()] = 0;
						cont.write(0);						
						if (flag_wait_kernel.read() == 0){
							buffer_aux.write((buffer_high.read(),data_in.read() ));
							flag_wait_kernel.write(1);							
							start_copy_kernel.write(1);
						}

						if (payload_size.read() == 0 || eop_in.read() == 1){
							SR_Kernel.write(HEADER);
						} 
						else{
							payload_size.write(payload_size.read() - 1);
						}
					break;
				}		
			}			
			intr_count.write(intr_counter_temp);
		}
	
	switch (DMNI_Receive_Kernel.read()) {
			
				case WAIT:
					if (start_copy_kernel.read() == 1 && payload_size.read()== 0xFFFC)  {
						recv_size.write(0x10000);
						recv_address.write(-4);
						first.write(0xA);
						receive_active.write(1);
						DMNI_Receive_Kernel.write(COPY_TO_MEM);
					}
				
				break;
			
				case COPY_TO_MEM:
			
					if (start_copy_kernel.read() == 1 && read_av.read() == 1 )  {
						mem_byte_we.write(0xF);
			
						mem_data_write.write(buffer[first.read()].read());
						first.write(first.read() + 1);
						add_buffer.write(0);
						recv_address.write(recv_address.read() + WORD_SIZE);
						recv_size.write(recv_size.read() - 1);
						

						if(payload_size.read() == 0 ){
							DMNI_Receive_Kernel.write(END);	
							reset_plasma_from_dmni.write(1);						
							mem_byte_we.write(0);
						}
					} else {
						if(buffer_eop[first.read()] == 1){
							DMNI_Receive_Kernel.write(END);
						}
						mem_byte_we.write(0);
					}
					
				break;
				case END:

					if (reset_counter.read() == 10){
						cout << "Terminou de receber o kernel" << endl;

						cont.write(0);
						first.write(0);
						reset_plasma_from_dmni.write(0);
						last.write(0);
						start_copy_kernel.write(0);
						dmni_timeout.write(0);
						payload_size.write(0);
						SR_Kernel.write(HEADER);
						add_buffer.write(0);
						receive_active.write(0);
						flag_wait_kernel.write(0);
						DMNI_Receive_Kernel.write(WAIT);
						reg_interrupt_received_wait.write(0);
						intr_count.write(0);
						reset_counter.write(0);
						for(int i=0; i<BUFFER_SIZE; i++){ //in vhdl replace by OTHERS=>'0'
							is_header[i] = 0;
						}	

						DMNI_Send.write(WAIT);
						send_active.write(0);
						tx.write(0);
						eop_out.write(0);


						write_enable.write(0);
						read_enable.write(0);
						timer.write(0);
						ARB.write(ROUND);
						write_enable.write(0);
						prio.write(!prio.read());
					}
					reset_counter.write(reset_counter.read() + 1);

				break;
				case FAILED_RECEPTION:
					cout << "ROUTER:" << hex << address_router << ": handling failed reception";
					cout << " time:" << sc_time_stamp() << endl;
					DMNI_Receive_Kernel.write(END);
				break;
			}
	
			//Interruption management
			
				if (intr_counter_temp > 0){
					intr.write(1);
				} else {
					intr.write(0);
				}
				
				
			intr_count.write(intr_counter_temp);
	
		} //end if  if (reg_interrupt_received_wait.read() == 0){	
	} //////////////// 
}

void dmni::receive_timeout() {

	const unsigned int timeout_threshold = 30;

	if(reset.read()==1) {
		counter_receive_timeout.write(0);
		receive_flit_timeout.write(0);
		return;
	}

	if(SR.read()==HEADER && cont.read()==0) {
		counter_receive_timeout.write(0);
	} else {

		if(rx.read()==1 && slot_available.read()==1)
			counter_receive_timeout.write(0);
		else if(rx.read()==0 && slot_available.read()==1)
			if(counter_receive_timeout.read() < timeout_threshold)
				counter_receive_timeout.write(counter_receive_timeout.read() + 1);

	}

	receive_flit_timeout.write(counter_receive_timeout.read() == timeout_threshold);
}
