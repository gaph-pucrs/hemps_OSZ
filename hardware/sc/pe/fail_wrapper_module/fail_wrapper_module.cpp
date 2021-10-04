//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  Novembeer 2017
//
//  Source name:  fail_wrapper_module.h
//
//  Brief description: Control process queue occupancy
//
//---------------------------------------------------------------------------------------

#include "fail_wrapper_module.h"

//-- PDN services
//#define	SET_SECURE_ZONE_SERVICE		0b00111
//#define	OPEN_SECURE_ZONE_SERVICE	0b01010
//#define	SECURE_ZONE_CLOSED_SERVICE	0b01011
//#define	SECURE_ZONE_OPENED_SERVICE	0b01100
//#define	SET_SZ_RECEIVED_SERVICE		0b11101
//#define	SET_EXCESS_SZ_SERVICE		0b11110
//

//PROCESSO DE CONTROLE PARA PDN
void fail_WRAPPER_module::in_proc_FSM(){
	#ifdef BRLOG
	char aux[255]; 
	FILE *fp;
	reg_seek_service auxService;
	#endif


	if(reset.read() == true){
		out_ack_wrapper_local.write(false);
		out_nack_wrapper_local.write(false);
		EA_in.write(S_INIT_IN);
		in_target_router.write(0);
	}	
	else{

		if (in_fail_cpu_config.read() == 1){
			in_target_router.write(mem_address_service_fail_cpu.read());
			//puts("SAVE DMA_FAIL_KERNEL to "); puts(itoh(in_target_router.read())); puts("\n");
			cout<<"DMA_FAIL_KERNEL "<< hex << mem_address_service_fail_cpu.read() <<endl;
		}

		if (in_fail_cpu_local.read() == false){ //if fail is false to nothing
			//cpu to wrapper
			in_source_router.write(in_source_wrapper_local.read());
			out_source_wrapper_local.write(in_source_wrapper_local.read());
			out_target_wrapper_local.write(in_target_wrapper_local.read());
			out_payload_wrapper_local.write(in_payload_wrapper_local.read());
			out_service_wrapper_local.write(in_service_wrapper_local.read());         
			out_req_wrapper_local.write(in_req_wrapper_local.read());
			out_opmode_wrapper_local.write(in_opmode_wrapper_local.read());
			out_fail_wrapper_local.write(in_fail_wrapper_local.read());
			out_ack_wrapper_local.write(in_ack_wrapper_local.read());
			out_nack_wrapper_local.write(in_nack_wrapper_local.read());
		}
		else{

			switch(EA_in.read()){
			
				case S_INIT_IN:

					out_req_wrapper_local.write(1);
					out_source_wrapper_local.write(in_source_router.read());
					out_target_wrapper_local.write(in_target_router.read());
					out_payload_wrapper_local.write(0);
					out_service_wrapper_local.write(FAIL_KERNEL_SERVICE);
					out_opmode_wrapper_local.write(1);
					if (in_ack_wrapper_local.read() == true){				 
					 	EA_in.write(S_END);
					 	cout<<"SEND_FAIL_SERVICE " << endl;
					}
	
					break;	
	
				case S_END:
						out_req_wrapper_local.write(0);		
				break;		
			}
		}
	}	
}

//PROCESSO DE CONTROLE PARA PDN
void fail_WRAPPER_module::brNoC_monitor(){
	char aux[255]; 
	FILE *fp;
	reg_seek_service auxService;
	//Store in aux the C's string way
	sprintf(aux, "debug/traffic_brnoc.txt");


	if(reset.read() == true){
		//prevService = 0;
	}else{
		// Open a file called "aux" deferred on append mode
		fp = fopen (aux, "a");
		auxService = in_service_wrapper_local.read();

		//if (auxService != prevService && (auxService == SET_SECURE_ZONE_SERVICE || auxService == OPEN_SECURE_ZONE_SERVICE || auxService == SECURE_ZONE_CLOSED_SERVICE || auxService == SECURE_ZONE_OPENED_SERVICE || auxService == SET_SZ_RECEIVED_SERVICE || auxService == SET_EXCESS_SZ_SERVICE)){
		if (auxService == SET_SECURE_ZONE_SERVICE || auxService == OPEN_SECURE_ZONE_SERVICE || auxService == SECURE_ZONE_CLOSED_SERVICE || auxService == SECURE_ZONE_OPENED_SERVICE || auxService == SET_SZ_RECEIVED_SERVICE || auxService == SET_EXCESS_SZ_SERVICE || auxService == END_TASK_SERVICE){
			sprintf(aux, "%d\t%X\t%X\t%X\t%d\n", (unsigned int)tick_counter.read(), (unsigned int) (in_source_wrapper_local.read()), (unsigned int)in_target_wrapper_local.read(), (unsigned int) in_payload_wrapper_local.read(), (unsigned int) auxService);
			fprintf(fp,"%s",aux);
			//prevService = auxService;
		} 
		/*else {			

		}*/
		fclose (fp);
	}
}

void fail_WRAPPER_module::write_mask(){
	if(reset){
		aux_wrapper_mask_go = 0X3FF;
		aux_wrapper_mask_back = 0X3FF;
		aux_CPU_mask = 0X3FF;
		
		wrapper_mask_router_in = 0x3FF;
		wrapper_mask_router_out = 0x3FF;
		
		//mask_tx_out = 1;
		count_delay = 0;
		cpu_mask_done = 0;
		cpu_mask_clear = 0;
	}
	else{
		int i;
// EOP out received -- UNSET MASK  -- ACTIVE WRAPPER
		if((eop_out_router_ports[0] == 1) | (eop_out_router_ports[1] == 1)){
			if((aux_wrapper_mask_go & 0x03) == 0){
				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X003;
				count_delay = 0;
			}
		}
		if((eop_out_router_ports[2] == 1) | (eop_out_router_ports[3] == 1)){
			if((aux_wrapper_mask_go & 0x0C) == 0){
				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X00C;
				count_delay = 0;
			}
		}
		if((eop_out_router_ports[4] == 1) | (eop_out_router_ports[5] == 1)){
			if((aux_wrapper_mask_go & 0x30) == 0){
				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X030;
				count_delay = 0;
			}
		}
		if((eop_out_router_ports[6] == 1) | (eop_out_router_ports[7] == 1)){
			if((aux_wrapper_mask_go & 0xC0) == 0){
				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X0C0;
				count_delay = 0;
			}
		}		
	
//		if(((eop_out_router_ports[0] == 1) & (io_packet_mask[0] == 0)) | ((eop_out_router_ports[1] == 1) & (io_packet_mask[1] == 0))) {
//			if((aux_wrapper_mask_go & 0x03) == 0){
//				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X003;
//				count_delay = 0;
//			}
//		}
//		if(((eop_out_router_ports[2] == 1) & (io_packet_mask[2] == 0)) | ((eop_out_router_ports[3] == 1) & (io_packet_mask[3] == 0))) {
//			if((aux_wrapper_mask_go & 0x0C) == 0){
//				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X00C;
//				count_delay = 0;
//			}
//		}
//		if(((eop_out_router_ports[4] == 1) & (io_packet_mask[4] == 0)) | ((eop_out_router_ports[5] == 1) & (io_packet_mask[5] == 0))) {
//			if((aux_wrapper_mask_go & 0x30) == 0){
//				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X030;
//				count_delay = 0;
//			}
//		}
//		if(((eop_out_router_ports[6] == 1) & (io_packet_mask[6] == 0)) | ((eop_out_router_ports[7] == 1) & (io_packet_mask[7] == 0))) {
//			if((aux_wrapper_mask_go & 0xC0) == 0){
//				aux_wrapper_mask_go = aux_wrapper_mask_go | 0X0C0;
//				count_delay = 0;
//			}
//		}
//

// EOP in received -- UNSET MASK  -- ACTIVE WRAPPER
		if(((eop_in_router_ports[0] == 1) & (io_packet_mask[0] == 0)) | ((eop_in_router_ports[1] == 1) & (io_packet_mask[1] == 0))) {		
		//if((eop_in_router_ports[0]) == 1 | (eop_in_router_ports[1] == 1)){
			if((aux_wrapper_mask_back & 0x03) == 0){
				aux_wrapper_mask_back = aux_wrapper_mask_back | 0X003;
				count_delay = 0;
			}
		}
		if(((eop_in_router_ports[2] == 1) & (io_packet_mask[2] == 0)) | ((eop_in_router_ports[3] == 1) & (io_packet_mask[3] == 0))) {
		//if((eop_in_router_ports[2]) == 1 | (eop_in_router_ports[3] == 1)){
			if((aux_wrapper_mask_back & 0x0C) == 0){
				aux_wrapper_mask_back = aux_wrapper_mask_back | 0X00C;
				count_delay = 0;
			}
		}
		if(((eop_in_router_ports[4] == 1) & (io_packet_mask[4] == 0)) | ((eop_in_router_ports[5] == 1) & (io_packet_mask[5] == 0))) {
		//if((eop_in_router_ports[4]) == 1 | (eop_in_router_ports[5] == 1)){
			if((aux_wrapper_mask_back & 0x30) == 0){
				aux_wrapper_mask_back = aux_wrapper_mask_back | 0X030;
				count_delay = 0;
			}
		}
		if(((eop_in_router_ports[6] == 1) & (io_packet_mask[6] == 0)) | ((eop_in_router_ports[7] == 1) & (io_packet_mask[7] == 0))) {
		//if((eop_in_router_ports[6]) == 1 | (eop_in_router_ports[7] == 1)){
			if((aux_wrapper_mask_back & 0xC0) == 0){
				aux_wrapper_mask_back = aux_wrapper_mask_back | 0X0C0;
				count_delay = 0;
			}
		}

//////  IO_WRAPPER_MESSAGE RECEIVED	
		if(change_mask == 1 && reg_direction == 1){
			if(reg_io_port == 0){
				aux_wrapper_mask_go = aux_wrapper_mask_go & 0X3FC;
			}
			else if (reg_io_port == 1)
			{
				aux_wrapper_mask_go = aux_wrapper_mask_go & 0x3F3;
			}
			else if (reg_io_port == 2)
			{
				aux_wrapper_mask_go = aux_wrapper_mask_go & 0x3CF;
			}
			else{
				aux_wrapper_mask_go = aux_wrapper_mask_go & 0x33F;
			}
			mask_done = 1;
		}
		else if(change_mask == 1 && reg_direction == 0){
			if(reg_io_port == 0){
				aux_wrapper_mask_back = aux_wrapper_mask_back & 0X3FC;
			}
			else if (reg_io_port == 1)
			{
				aux_wrapper_mask_back = aux_wrapper_mask_back & 0x3F3;
			}
			else if (reg_io_port == 2)
			{
				aux_wrapper_mask_back = aux_wrapper_mask_back & 0x3CF;
			}
			else{
				aux_wrapper_mask_back = aux_wrapper_mask_back & 0x33F;
			}
			mask_done = 1;
		}	
		else if(change_mask == 1 && reg_direction == 2){ //UNSET MASK: reg_direction == 2
			aux_wrapper_mask_back = 0X3FF;
//			if(reg_io_port == 0){
//				//if((aux_wrapper_mask_back & 0x03) == 0)
//					//aux_wrapper_mask_back = aux_wrapper_mask_back | 0X003;
//					aux_wrapper_mask_back = 0X3FC;
//			}
//			else if (reg_io_port == 1)
//			{
//				//if((aux_wrapper_mask_back & 0x0C) == 0)
//					//aux_wrapper_mask_back = aux_wrapper_mask_back | 0X00C;
//					aux_wrapper_mask_back = 0X3F3;
//			}
//			else if (reg_io_port == 2)
//			{
//				//if((aux_wrapper_mask_back & 0x30) == 0)
//				//	aux_wrapper_mask_back = aux_wrapper_mask_back | 0X030;
//					aux_wrapper_mask_back = 0X3CF;
//			}
//			else{
//				//if((aux_wrapper_mask_back & 0xC0) == 0)
//				//	aux_wrapper_mask_back = aux_wrapper_mask_back | 0X0C0;
//					aux_wrapper_mask_back = 0X33F;
//			}
			mask_done = 1;
		}
		else
			mask_done = 0;


////// wrapper_mask_from_CPU
		if((wrapper_mask_go_from_CPU.read() != 0x3FF) && (wrapper_mask_go_from_CPU.read() != 0x000) && (cpu_mask_done == 0)){
			aux_wrapper_mask_go = aux_wrapper_mask_go & wrapper_mask_go_from_CPU.read();
			count_delay = 0;
			cpu_mask_done = 1;
		}
		else if((wrapper_mask_back_from_CPU.read() != 0x3FF) && (wrapper_mask_back_from_CPU.read() != 0x000) && (cpu_mask_done == 0)){
			aux_wrapper_mask_back = aux_wrapper_mask_back & wrapper_mask_back_from_CPU.read();
			count_delay = 0;
			cpu_mask_done = 1;
		}
		else
			cpu_mask_clear = 0;
		
		if((wrapper_mask_go_from_CPU.read() == 0x3FF) && (wrapper_mask_back_from_CPU.read() == 0x3FF))
			cpu_mask_done = 0;


//////
//		if (mask_tx_from_router_local == 1)
//			mask_tx_out = 0;
//		else if(eop_in_from_router_local == 1)
//			aux_delay = 1;
//		else if(aux_delay == 1){
//			mask_tx_out = 1;
//			aux_delay = 0;
//		}


// update wrapper_mask signal with 4 clock cycles delay to avoid unreacheble generation
		if(count_delay == 4){
			//wrapper_mask = aux_wrapper_mask_go;
			wrapper_mask_router_in = aux_wrapper_mask_go;
			wrapper_mask_router_out = aux_wrapper_mask_back;
			count_delay = 0;
			cpu_mask_clear = 1;
		}
		count_delay = count_delay + 1;

	}

}

void fail_WRAPPER_module::in_dataNOC_FSM(){

	if(reset.read() == true){
		EA_dataNOC.write(S_INIT);
		flit_in_counter = 0;
		change_mask = 0;
		for(int i=0;i<BUFFER_IN_WRAPPER;i++) {
			buffer_in_flit[i]		=	0;
		}		
		
	}
	else{	
		switch(EA_dataNOC.read()){
			case S_INIT:			
				if(rx_from_router_local.read() == true){
						buffer_in_flit[flit_in_counter] = data_in_from_router_local.read();
						flit_in_counter = flit_in_counter + 1;

						EA_dataNOC.write(S_RECEIVE);
				}
				if(mask_done == 1)
					change_mask = 0;

			break;

			case S_RECEIVE:
				if(rx_from_router_local.read() == true){
					buffer_in_flit[flit_in_counter] =  data_in_from_router_local.read();
					flit_in_counter = flit_in_counter + 1;

					if(flit_in_counter == 22){
						reg_header	 		= buffer_in_flit[3];
						reg_msg_size 		= buffer_in_flit[5];
						reg_service 		= buffer_in_flit[7];
						reg_io_service 		= buffer_in_flit[9];
						reg_io_port 		= buffer_in_flit[11];
						reg_direction 		= buffer_in_flit[19];

					}
					if(flit_in_counter == 26 && reg_msg_size > 0X0B){
						EA_dataNOC.write(S_PAYLOAD);
						flit_in_counter = 0;
					}
					if(eop_in_from_router_local.read() == true){
						EA_dataNOC.write(S_SERVICE);
						flit_in_counter = 0;
					}
					
				}
				else{
					EA_dataNOC.write(S_WAIT);
				}
			break;			
			
			case S_WAIT:
				if(rx_from_router_local.read() == true){
					buffer_in_flit[flit_in_counter] =  data_in_from_router_local.read();
					flit_in_counter = flit_in_counter + 1;						
					EA_dataNOC.write(S_RECEIVE);
				}
			break;

			case S_SERVICE:
				flit_in_counter = 0;
				if(reg_service == 0x00000295){  //  IO_OPEN_WRAPPER	
					change_mask = 1;
				}

				EA_dataNOC.write(S_INIT);
			break;
			  
			case S_PAYLOAD:
				//if(rx_primary.read() == true){
				//		buffer_in_flit[flit_in_counter] = data_in_from_router_local.read();
				//}
				//flit_in_counter = (flit_in_counter + 1) % BUFFER_IN_WRAPPER_MASK;
				if(eop_in_from_router_local.read()== true){
					EA_dataNOC.write(S_SERVICE);
					flit_in_counter = 0;
				}	
			break;	

		}
	}
}



