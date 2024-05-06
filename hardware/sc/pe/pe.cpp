//------------------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  September 2013
//
//  Source name:  plasma_slave.cpp
//
//  Brief description:  This source manipulates the memory mapped registers.
//
//------------------------------------------------------------------------------------------------

#include "pe.h"


void pe::mem_mapped_registers(){
	
	sc_uint <32 > l_cpu_mem_address_reg = cpu_mem_address_reg.read();
	sc_uint<NPORT > l_ap_mask;

	if(l_cpu_mem_address_reg.range(30,28 ) == 1){

		in_sel_reg_backtrack_fifoPDN.write(0);

	} else{

		switch(l_cpu_mem_address_reg){
			case IRQ_MASK:
				cpu_mem_data_read.write(irq_mask_reg.read());
			break;
			case IRQ_STATUS_ADDR:
				cpu_mem_data_read.write(irq_status.read());
			break;
			case TIME_SLICE_ADDR:
				cpu_mem_data_read.write(time_slice.read());
			break;
			case TIMEOUT_REG_ADDR:
				cpu_mem_data_read.write(timeout_cont.read());
			break;
			case NET_ADDRESS:
				cpu_mem_data_read.write(router_address);
			break;
			case TICK_COUNTER_ADDR:
				cpu_mem_data_read.write(tick_counter.read());
			break;
			case REQ_APP_REG:
				cout << "warning: req_app signal disable" << endl;
			break;
			case DMA_SEND_ACTIVE:
				cpu_mem_data_read.write(dmni_send_active_sig.read());
			break;
			case DMA_RECEIVE_ACTIVE:
				cpu_mem_data_read.write(dmni_receive_active_sig.read());
			break;
			case SEEK_SERVICE_REGISTER:
				cpu_mem_data_read.write(in_cpu_service_seek.read());
			break;
			case SEEK_TARGET_REGISTER:
				cpu_mem_data_read.write(in_cpu_target_seek.read());
				//sets seek interruption to 0
				int_seek.write(0);
				int_dmni_seek.write(0);
				if(cpu_mem_write_byte_enable_reg.read() == 0){
					in_ack_fifopdn.write(1);
				}
			break;
			case SEEK_SOURCE_REGISTER:
				cpu_mem_data_read.write(in_cpu_source_seek.read());
				// in_sel_reg_backtrack_seek_local.write(0);
			break;
			case SEEK_PAYLOAD_REGISTER:
				cpu_mem_data_read.write(in_cpu_payload_seek.read());
			break;
			case SEEK_OPMODE_REGISTER:
				cpu_mem_data_read.write(in_cpu_opmode_seek.read());
			break;
			case SEEK_BACKTRACK:
				cpu_mem_data_read.write(out_reg_backtrack_fifoPDN.read());
				// in_sel_reg_backtrack_seek_local.write(0);
			break;
			case APP_ID_REG:
				cpu_mem_data_read.write(app_reg.read());
			break;
			case AP_THRESHOLD:
				cpu_mem_data_read.write(apThreshold.read());
			break;
			case AP_STATUS:
				cpu_mem_data_read.write(AP_status.read());
			break;
			case AP_MASK:
				cpu_mem_data_read.write(ap_mask.read());
			break;
			case K1_REG:
				cpu_mem_data_read.write(k1.read());
			break;
			// case SEEK_BACKTRACK1:
			// 	cpu_mem_data_read.write(out_reg_backtrack_seek_local.read());
			// 	// in_sel_reg_backtrack_seek_local.write(2);
			// break;
			// case SEEK_BACKTRACK0:
			// 	cpu_mem_data_read.write(out_reg_backtrack_seek_local.read());
				// in_sel_reg_backtrack_seek_local.write(1);
			// break;
			// case SEEK_CAM_READ: // log artur - seek CAM
			// 	cpu_mem_data_read.write(0xffffffff); //ler nada só para teste
			// 	// in_sel_reg_backtrack_seek_local.write(0);
			// break;
			case DMNI_TIMEOUT_SIGNAL:
				cpu_mem_data_read.write(dmni_timeout_ni.read());
			break;
			default:
				cpu_mem_data_read.write(data_read_ram.read());
			break;
		}
	}
}


void pe::comb_assignments(){
	sc_uint<8 > l_irq_status;
	sc_uint <32 > new_mem_address;

	new_mem_address = cpu_mem_address.read();

	//Esse IF faz com que seja editado o valor de endereço de memoria usado pela CPU. Inserindo na parte
	//alta do endereco o valor correto de referencia a pagina. Este valor esta presente em current_page
	//que deve ser inserido na parte alta do endereco de memoria.
	//Esse IF faz com que a mascara 0xF000..(FFF..32-shift_mem_page) seja colocada no endereco para a memoria
	//Isso porque a migracao de tarefas a pilha acaba guardando informacao de offset da pagina origem, o que corrompe o retorno de fucoes
	if (current_page.read() && ((0xFFFFFFFF << shift_mem_page) & new_mem_address)){
		new_mem_address &= (0xF0000000 | (0xFFFFFFFF >> (32-shift_mem_page)));
		new_mem_address |= current_page.read() * PAGE_SIZE_BYTES;//OFFSET
	}

	addr_a.write(new_mem_address.range(31, 2));
	addr_b.write(dmni_mem_address.read()(31,2));
	
	cpu_mem_pause.write(cpu_repo_acess.read());
	irq.write((((irq_status.read() & irq_mask_reg.read()) != 0x00)) ? 1  : 0 );
	cpu_set_size.write((((cpu_mem_address_reg.read() == DMA_SIZE) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_set_address.write((((cpu_mem_address_reg.read() == DMA_ADDR) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_set_size_2.write((((cpu_mem_address_reg.read() == DMA_SIZE_2) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_send_kernel.write((((cpu_mem_address_reg.read() == DMA_SEND_KERNEL) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_wait_kernel.write((((cpu_mem_address_reg.read() == DMA_WAIT_KERNEL) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_fail_kernel.write((((cpu_mem_address_reg.read() == DMA_FAIL_KERNEL) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_set_address_2.write((((cpu_mem_address_reg.read() == DMA_ADDR_2) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_set_op.write((((cpu_mem_address_reg.read() == DMA_OP) && (write_enable.read() == 1))) ? 1  : 0 );
	cpu_start.write((((cpu_mem_address_reg.read() == START_DMA) && (write_enable.read() == 1))) ? 1  : 0 );
	clock_wait_kernel.write((((cpu_mem_address_reg.read() == CLOCK_HOLD_WAIT_KERNEL) && (write_enable.read() == 1))) ? cpu_mem_data_write.read()(0,0)  : clock_wait_kernel.read() );
	//clock_wait_kernel.write(((cpu_mem_address_reg.read() == CLOCK_HOLD_WAIT_KERNEL)) ? cpu_mem_data_write.read()(0,0)  : clock_wait_kernel.read() );

	reset_plasma = reset || reset_plasma_from_dmni || reset_cpu_fail;

	if (reset_cpu_fail.read() == 1){
		in_ack_router_seek_local.write(1);
	}

	//warning using same signal to read and write
	dmni_timeout_ni.write((((cpu_mem_address_reg.read() == DMNI_TIMEOUT_SIGNAL) && (write_enable.read() == 1))) ? 0  : dmni_timeout_ni.read() );

	in_sel_reg_backtrack_fifoPDN.write((((cpu_mem_address_reg.read() == SEEK_BACKTRACK_REG_SEL) && (write_enable.read() == 1))) ? cpu_mem_data_write.read()(1,0) : in_sel_reg_backtrack_fifoPDN.read() );
	
	dmni_data_read.write( cpu_mem_data_write_reg.read());
	//dmni_mem_data_read.write( (dmni_enable_internal_ram.read() == 1) ? mem_data_read.read()  : data_read.read() );
	dmni_mem_data_read.write( (dmni_enable_internal_ram.read() == 1) ? mem_data_read.read()  : mem_data_read.read() );
	write_enable.write(((cpu_mem_write_byte_enable_reg.read() != 0)) ? 1  : 0 );
	cpu_enable_ram.write(((cpu_mem_address.read()(30,28 ) == 0)) ? 1  : 0 );
	dmni_enable_internal_ram.write(((dmni_mem_address.read()(30,28 ) == 0)) ? 1  : 0 );
	end_sim_reg.write((((cpu_mem_address_reg.read() == END_SIM) && (write_enable.read() == 1))) ? 0x00000000 : 0x00000001);	


	l_irq_status[7] = int_seek.read();
	l_irq_status[6] = intAP.read();
	l_irq_status[5] = ni_intr.read();
	// l_irq_status[4] = 0;
	l_irq_status[4] = (timeout_cont.read() == 1) ? 1  : 0;
	l_irq_status[3] = (time_slice.read() == 1) ? 1  : 0;
	l_irq_status[2] = 0;
	l_irq_status[1] = (!dmni_send_active_sig.read() && slack_update_timer.read() == SLACK_MONITOR_WINDOW) ? 1  : 0;
	l_irq_status[0] = (!dmni_send_active_sig.read() && pending_service.read());
	
	irq_status.write(l_irq_status);
}

void pe::sequential_attr(){

	char string_out[100];
	FILE *fp;
	char c, end;

	if (reset.read() == 1) {
		reset_cpu_fail.write(0);
		cpu_mem_address_reg.write(0);
		cpu_mem_data_write_reg.write(0);
		cpu_mem_write_byte_enable_reg.write(0);
		irq_mask_reg.write(0);
		time_slice.write(0);
		timeout_cont.write(0);
		tick_counter.write(0);
		pending_service.write(0);
		slack_update_timer.write(0);
		app_reg.write(0);
		apThreshold.write(0);
	} else {

		if(cpu_mem_pause.read() == 0) {
			cpu_mem_address_reg.write(cpu_mem_address.read());
			
			cpu_mem_data_write_reg.write(cpu_mem_data_write.read());
			
			cpu_mem_write_byte_enable_reg.write(cpu_mem_write_byte_enable.read());
			
			if(cpu_mem_address_reg.read()==IRQ_MASK && write_enable.read()==1){
				irq_mask_reg.write(cpu_mem_data_write_reg.read()(7,0));
			}

			if (time_slice.read() > 1) {
				time_slice.write(time_slice.read() - 1);
			}

			if (timeout_cont.read() > 1) {
				timeout_cont.write(timeout_cont.read() - 1);
			}

			//************** pending service implementation *******************
			if (cpu_mem_address_reg.read() == PENDING_SERVICE_INTR && write_enable.read() == 1){
				if (cpu_mem_data_write_reg.read() == 0){
					pending_service.write(0);
				} else {
					pending_service.write(1);
				}
			}
			//*********************************************************************

		}

		//****************** slack time monitoring **********************************
		if (cpu_mem_address_reg.read() == SLACK_TIME_MONITOR && write_enable.read() == 1){
			slack_update_timer.write(cpu_mem_data_write_reg.read());
		} else if (slack_update_timer.read() < SLACK_MONITOR_WINDOW){
			slack_update_timer.write(slack_update_timer.read() + 1);
		}
		//*********************************************************************

		// //************** simluation-time debug implementation *******************
		// if (cpu_mem_address_reg.read() == DEBUG && write_enable.read() == 1){
		// 	sprintf(aux, "log/log%dx%d.txt", (unsigned int) router_address.range(15,8), (unsigned int) router_address.range(7,0));
		// 	fp = fopen (aux, "a");

		// 	end = 0;
		// 	for(int i=0;i<4;i++) {
		// 		c = cpu_mem_data_write_reg.read().range(31-i*8,24-i*8);

		// 		//Writes a string in the line
		// 		if(c != 10 && c != 0 && !end){
		// 			fprintf(fp,"%c",c);
		// 		}
		// 		//Detects the string end
		// 		else if(c == 0){
		// 			end = true;
		// 		}
		// 		//Line feed detected. Writes the line in the file
		// 		else if(c == 10){
		// 			fprintf(fp,"%c",c);
		// 		}
		// 	}

		// 	fclose (fp);
				//************** simluation-time debug implementation *******************
		if (cpu_mem_address_reg.read() == DEBUG && write_enable.read() == 1){
			sprintf(aux, "log/log%dx%d.txt", (unsigned int) router_address.range(15,8), (unsigned int) router_address.range(7,0));
			fp = fopen (aux, "a");

			end = 0;
			uint32_t address = cpu_mem_data_write_reg.read()/4;
			while(!end){
				unsigned long word = mem->ram_data[address++];
				word = __builtin_bswap32(word);
				char str[5] = {};
				memcpy(str, &word, 4);

				fprintf(fp, "%s", str);

				for(int i = 0; i < 4; i++){
					if(str[i] == 0){
						end = 1;
						break;
					}
				}
			}

			fclose (fp);
		}

		//************ NEW DEBBUG AND REPORT logs - they are used by HeMPS Debbuger Tool********
		if (write_enable.read()==1){

			//************** Scheduling report implementation *******************
			if (cpu_mem_address_reg.read() == SCHEDULING_REPORT) {
				sprintf(aux, "debug/scheduling_report.txt");
				fp = fopen (aux, "a");
				sprintf(aux, "%d\t%d\t%d\n", (unsigned int)router_address, (unsigned int)cpu_mem_data_write_reg.read(), (unsigned int)tick_counter.read());
				fprintf(fp,"%s",aux);
				fclose (fp);
			}
			//**********************************************************************

			//************** PIPE and request debug implementation *******************
			if (cpu_mem_address_reg.read() == ADD_PIPE_DEBUG ) {
				sprintf(aux, "debug/pipe/%d.txt", (unsigned int)router_address);
				fp = fopen (aux, "a");
				sprintf(aux, "add\t%d\t%d\t%d\n", (unsigned int)(cpu_mem_data_write_reg.read() >> 16), (unsigned int)(cpu_mem_data_write_reg.read() & 0xFFFF), (unsigned int)tick_counter.read());
				fprintf(fp,"%s",aux);
				fclose (fp);

			} else if (cpu_mem_address_reg.read() == REM_PIPE_DEBUG ) {
				sprintf(aux, "debug/pipe/%d.txt", (unsigned int)router_address);
				fp = fopen (aux, "a");
				sprintf(aux, "rem\t%d\t%d\t%d\n", (unsigned int)(cpu_mem_data_write_reg.read() >> 16), (unsigned int)(cpu_mem_data_write_reg.read() & 0xFFFF), (unsigned int)tick_counter.read());
				fprintf(fp,"%s",aux);
				fclose (fp);
			} else if (cpu_mem_address_reg.read() == ADD_REQUEST_DEBUG ) {
				sprintf(aux, "debug/request/%d.txt", (unsigned int)router_address);
				fp = fopen (aux, "a");
				sprintf(aux, "add\t%d\t%d\t%d\n", (unsigned int)(cpu_mem_data_write_reg.read() >> 16), (unsigned int)(cpu_mem_data_write_reg.read() & 0xFFFF), (unsigned int)tick_counter.read());
				fprintf(fp,"%s",aux);
				fclose (fp);

			} else if (cpu_mem_address_reg.read() == REM_REQUEST_DEBUG ) {
				sprintf(aux, "debug/request/%d.txt", (unsigned int)router_address);
				fp = fopen (aux, "a");
				sprintf(aux, "rem\t%d\t%d\t%d\n", (unsigned int)(cpu_mem_data_write_reg.read() >> 16), (unsigned int)(cpu_mem_data_write_reg.read() & 0xFFFF), (unsigned int)tick_counter.read());
				fprintf(fp,"%s",aux);
				fclose (fp);
			}
		}
		//**********************************************************************


		if ((cpu_mem_address_reg.read() == TIME_SLICE_ADDR) and (write_enable.read()==1) ) {
			time_slice.write(cpu_mem_data_write_reg.read());
  		}

		if ((cpu_mem_address_reg.read() == TIMEOUT_REG_ADDR) and (write_enable.read()==1) ) {
			timeout_cont.write(cpu_mem_data_write_reg.read());
  		}
  		
  		tick_counter.write((tick_counter.read() + 1) );

	}
}

void pe::end_of_simulation(){
    if (end_sim_reg.read() == 0x00000000){
		// Breakpoint of END_SIMULATION on the traffic_router.txt
		sprintf(aux, "debug/traffic_router.txt");
		fp = fopen (aux, "a");
		sprintf(aux, "END %d", tick_counter.read());
		
        cout << "END OF ALL APPLICATIONS!!!" << endl;
        cout << "Simulation time: " << (float) ((tick_counter.read() * 10.0f) / 1000.0f / 1000.0f) << "ms" << endl;
        sc_stop();
    }
}

void pe::log_process(){
	if (reset.read() == 1) {
		log_interaction=1;
		instant_instructions = 0;		
		aux_instant_instructions = 0;

		logical_instant_instructions = 0;
		jump_instant_instructions = 0;
		branch_instant_instructions = 0;
		move_instant_instructions = 0;
		other_instant_instructions = 0;
		arith_instant_instructions = 0;
		load_instant_instructions = 0;
		shift_instant_instructions = 0;
		nop_instant_instructions = 0;
		mult_div_instant_instructions = 0;

	} else {

		if(tick_counter.read() == 100000*log_interaction) {
			

			fp = fopen ("log_tasks.txt", "a+");
			
			aux_instant_instructions = cpu->global_inst - instant_instructions;

			sprintf(aux, "%d,%lu,%lu,%lu\n",  (int)router_address,cpu->global_inst,aux_instant_instructions,100000*log_interaction);

			instant_instructions = cpu->global_inst;

		
			fprintf(fp,"%s",aux);
		
			fclose(fp); 
			fp = NULL;


			fp = fopen ("log_tasks_full.txt", "a+");


			fprintf(fp,"%d ",(int)router_address);

			aux_instant_instructions = cpu->logical_inst - logical_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);
			
			logical_instant_instructions = cpu->logical_inst;

			aux_instant_instructions = cpu->jump_inst - jump_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			jump_instant_instructions = cpu->jump_inst;

			aux_instant_instructions = cpu->branch_inst - branch_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			branch_instant_instructions = cpu->branch_inst;

			aux_instant_instructions = cpu->move_inst - move_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			move_instant_instructions = cpu->move_inst;

			aux_instant_instructions = cpu->other_inst - other_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			other_instant_instructions = cpu->other_inst;

			aux_instant_instructions = cpu->arith_inst - arith_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			arith_instant_instructions = cpu->arith_inst;

			aux_instant_instructions = cpu->load_inst - load_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			load_instant_instructions = cpu->load_inst;

			aux_instant_instructions = cpu->shift_inst - shift_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			shift_instant_instructions = cpu->shift_inst;

			aux_instant_instructions = cpu->nop_inst - nop_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);

			nop_instant_instructions = cpu->nop_inst;

			aux_instant_instructions = cpu->mult_div_inst - mult_div_instant_instructions;

			fprintf(fp,"%lu ",aux_instant_instructions);
			
			mult_div_instant_instructions = cpu->mult_div_inst;

			fprintf(fp,"%lu",100000*log_interaction);
			fprintf(fp,"\n");
		
		
			fclose(fp); 
			fp = NULL;


			log_interaction++;
		}
	}
}

void pe::access_point_reg(){
	sc_uint<NPORT > l_wrapper_reg;
 	sc_uint<NPORT > l_ap_mask;

	if ((cpu_mem_address_reg.read() == WRAPPER_REGISTER) and (write_enable.read()==1) ) {
		l_wrapper_reg = cpu_mem_data_write_reg.read();
		for(i=0;i<NPORT;i++){
			wrapper_reg[i].write(l_wrapper_reg[i]);
		}
	}
	if ((cpu_mem_address_reg.read() == K1_REG) and (write_enable.read()==1) ) {
		k1 = cpu_mem_data_write_reg.read();
	}
	if ((cpu_mem_address_reg.read() == K2_REG) and (write_enable.read()==1) ) {
		k2 = cpu_mem_data_write_reg.read();
	}
	if ((cpu_mem_address_reg.read() == AP_MASK) and (write_enable.read()==1) ) {
		ap_mask = cpu_mem_data_write_reg.read();
	}
	if ((cpu_mem_address_reg.read() == APP_ID_REG) and (write_enable.read()==1) ) {
		app_reg = cpu_mem_data_write_reg.read();
	}
	if ((cpu_mem_address_reg.read() == AP_THRESHOLD) and (write_enable.read()==1) ) {
		apThreshold = cpu_mem_data_write_reg.read();
	}

}

void pe::seek_access(){
	//triggers SEEK MODULE with
	if ((cpu_mem_address_reg.read() == SEEK_SERVICE_REGISTER) and (write_enable.read()==1) ) {
		in_service_seek_slc.write(cpu_mem_data_write_reg.read());
	}
	if ((cpu_mem_address_reg.read() == SEEK_SOURCE_REGISTER) and (write_enable.read()==1) ) {
		MEM_source[10].write(cpu_mem_data_write_reg.read());
	}
	if ((cpu_mem_address_reg.read() == SEEK_PAYLOAD_REGISTER) and (write_enable.read()==1) ) {
		MEM_payload[10].write(cpu_mem_data_write_reg.read());
	}
	if ((cpu_mem_address_reg.read() == SEEK_OPMODE_REGISTER) and (write_enable.read()==1) ) {
		MEM_opmode[10].write(cpu_mem_data_write_reg.read());
	}		
 	if ((cpu_mem_address_reg.read() == SEEK_TARGET_REGISTER) and (write_enable.read()==1) ) {
		MEM_target[10].write(cpu_mem_data_write_reg.read());
		//up the req
		MEM_waiting[10].write(1);
		waiting_seek.write(1);
	}
}

void pe::seek_send(){
	int i;
	//down the req
	if ((out_ack_seek_slc.read() == 1)) {
		in_req_seek_slc.write(0);
		MEM_waiting[MEM_index_forwarded.read()].write(0);
	}
	if ((out_nack_seek_slc.read() == 1)) {
		in_req_seek_slc.write(0);
		MEM_waiting[10].write(1);
	}
	else{
		if(waiting_seek.read() == 1){
			//triggers the seek from the local port - implicit priority on choosing local port
			if(MEM_waiting[10].read() == 1){
				if( out_req_router_seek_local.read() == 1 ){
					cout << "WARNING: ";
					cout << hex << router_address;
					cout << " MUST wait req down to send to " << MEM_source[10].read() << endl;
				}	
				// in_service_router_seek_local.write(MEM_source[10].read());
				in_target_seek_slc.write(MEM_target[10].read());
				in_source_seek_slc.write(MEM_source[10].read());
				in_payload_seek_slc.write(MEM_payload[10].read());
				in_opmode_seek_slc.write(MEM_opmode[10].read());
				in_req_seek_slc.write(1);
				MEM_waiting[10].write(0);	
			}
			// else{//checks all other ports
			// 	//seek unreachable
			// 	for (i=0;i<9; i++){
			// 		// 	if(w_addr.read() == i){
			// 			if(MEM_waiting[i].read() == 1){
			// 				in_service_seek_slc.write(2);//2 is the TARGET_UNREACHABLE_SERVICE
			// 				in_source_seek_slc.write((MEM_target[i].read() << 16) | MEM_source[i].read());
			// 				in_target_seek_slc.write(MEM_source[i].read());
			// 				MEM_index_forwarded.write(i);
			// 				in_payload_seek_slc.write((MEM_target[i].read()(11,8) << 4) | MEM_target[i].read()(3,0));
			// 				in_opmode_seek_slc.write(MEM_opmode[10].read());
			// 				in_req_seek_slc.write(1);
			// 				break;
			// 			}
			// 	}
			// }
		}
	}
}

//this process triggers int_seek to 1
void pe::seek_receive(){
	if(reset.read()==1){
		int_seek.write(0);
		int_dmni_seek.write(0);
		in_ack_fifopdn.write(0);
		in_cpu_service_seek.write(0);
		in_cpu_source_seek.write(0);
		in_cpu_target_seek.write(0);
		in_cpu_payload_seek.write(0);
		in_cpu_opmode_seek.write(0);
	}
	else{
		if (out_req_fifopdn.read() == 1){
			if (in_ack_fifopdn.read() == 0 && int_seek.read()==0 && int_dmni_seek.read() == 0){
				cout << "router ";
				cout << hex << router_address;
				cout << ": received service ";
				in_cpu_service_seek.write(out_service_fifopdn.read());
				in_cpu_source_seek.write(out_source_fifopdn.read());
				in_cpu_target_seek.write(out_target_fifopdn.read());
				in_cpu_payload_seek.write(out_payload_fifopdn.read());
				in_cpu_opmode_seek.write(out_opmode_fifopdn.read());
				switch (out_service_fifopdn.read()){
					case 0X1:
						cout << "START APP SERVICE";
						int_seek.write(1);
					break;	
					case 0x2:
						cout << "UNREACHABLE";
						int_seek.write(1);
					break;
					case 0x3:
						cout << "CLEAR SERVICE";
						int_seek.write(1); // Provisório: Caso um Clear entre na memória
					break;
					case 0x4:
						cout << "BACKTRACK";
						int_seek.write(1);
					break;
					case 0x5:
						cout << "SEARCHPATH_SERVICE";
					break;
					case 0x6:
						cout << "END TASK SERVICE";
						cout << " Id ";
						cout << hex << out_payload_fifopdn.read();
						cout << " from ";
						cout << hex << out_service_fifopdn.read();
						int_seek.write(1);
					break;
					case 0x7:
						cout << "SET_SECURE_ZONE";
						int_seek.write(1);
					break;
					case 0x8:
						cout << "SET_AP_SERVICE";
						int_seek.write(1);
					break;
					case 0x9:
						cout << "WARD SERVICE";
						int_seek.write(1);
					break;	
					case 0xA:
						cout << "OPEN SECURE ZONE SERVICE";
						int_seek.write(1);
					break;
					case 0xB:
						cout << "SECURE ZONE CLOSED SERVICE";
						int_seek.write(1);
					break;
					case 0xC:
						cout << "SECURE ZONE OPENED SERVICE";
						int_seek.write(1);
					break;
					case 0xD:
						cout << "FREEZE_TASK_SERVICE";
						int_seek.write(1);
					break;
					case 0xE:
						cout << "UNFREEZE_TASK_SERVICE";
						int_seek.write(1);
					break;
					case 0xF:
						cout << "MASTER_CANDIDATE_SERVICE";
						int_seek.write(1);
					break;
					case 0x10:
						cout << "TASK_ALLOCATED_SERVICE";
						int_seek.write(1);
					break;						
					case 0x11:
						cout << "INITIALIZE_SLAVE_SERVICE";
						int_seek.write(1);
					break;
					case 0x12:
						cout << "INITIALIZE_CLUSTER_SERVICE";
						int_seek.write(1);
					break;							
					case 0x13:
						cout << "LOAN_PROCESSOR_REQUEST_SERVICE";
						int_seek.write(1);
					break;
					case 0x14:
						cout << "LOAN_PROCESSOR_RELEASE_SERVICE";
						int_seek.write(1);
					break;
					case 0x15:
						cout << "END_TASK_OTHER_CLUSTER_SERVICE";
						int_seek.write(1);
					break;	
					case 0x16:
						cout << "WAIT_KERNEL_SERVICE";
						int_seek.write(1);
					break;
					case 0x17:
						cout << "SEND_KERNEL_SERVICE";
						int_dmni_seek.write(1);
					break;
					case 0x18:
						cout << "WAIT_KERNEL_SERVICE_ACK";
						int_seek.write(1);
					break;
					case 0x19:
						cout << "FAIL_KERNEL_SERVICE";
						int_seek.write(1);
					break;
					case 0x1A:
						cout << "NEW_APP_SERVICE";
						int_seek.write(1);
					break;
					case 0x1B:
						cout << "NEW_APP_ACK_SERVICE";
						int_seek.write(1);
					break;
					case 0x1C:
						cout << "GMV_READY_SERVICE";
						int_seek.write(1);
					break;						
					case 0x1D:
						cout << "SET_SZ_RECEIVED_SERVICE";
						int_seek.write(1);
					break;
					case 0x1E:
						cout << "SET_EXCESS_SZ_SERVICE";
						int_seek.write(1);
					break;
					case 0x1F:
						cout << "RCV_FREEZE_TASK_SERVICE";
						int_seek.write(1);
					break;
					case 0x20:
						cout << "BR_TO_APP";
						int_seek.write(1);
					break;		
					case 0x21:
						cout << "SET_AP_SERVICE";
						int_seek.write(1);
					break;
					case 0x22:
						cout << "MSG_DELIVERY_CONTROL";
						int_seek.write(1);
					break;	
					case 0x23:
						cout << "MSG_REQUEST_CONTROL";
						int_seek.write(1);
					break;	
					case 0x24:
						cout << "RENEW_KEY";
						int_seek.write(1);
					break;	
					case 0x25:
						cout << "KEY_ACK";
						int_seek.write(1);
					break;		
					case 0x26:
						cout << "REQUEST_SNIP_RENEWAL";
						int_seek.write(1);
					break;
					case 0x27:
						cout << "LC_NOTIFICATION";
						int_seek.write(1);
					break;
					case 0x28:
						cout << "AP_NOTIFICATION";
						int_seek.write(1);
					break;
					case 0x29:
						cout << "UNEXPECTED_DATA";
						int_seek.write(1);
					break;
					case 0x2A:
						cout << "MISSING_PACKET";
						int_seek.write(1);
					break;
					case 0x2B:
						cout << "PROBE_REQUEST";
						int_seek.write(1);
					break;
					case 0x2C:
						cout << "PROBE_PATH";
						int_seek.write(1);
					break;
					case 0x2D:
						cout << "PROBE_CONTROL";
						int_seek.write(1);
					break;
					case 0x2E:
						cout << "PROBE_RESULT";
						int_seek.write(1);
					break;
					default:
						cout << out_service_fifopdn.read() << " unknown --- ERROR! " ;
						in_ack_fifopdn.write(1);
					break;
				}
				cout << " time:" << sc_time_stamp() << endl;
			}
		}
		else{
			if (in_ack_fifopdn.read() == 1){
				in_ack_fifopdn.write(0);
			}
		}
	}
}

void pe::clock_stop(){

	if (reset.read() == 1 || reset_plasma_from_dmni.read() == 1) {
		tick_counter_local.write(0);
		clock_aux.write(true);
		clock_wait_kernel.write(1);
	}

	if((cpu_mem_address_reg.read() == CLOCK_HOLD) && (write_enable.read() == 1)){
		clock_aux.write(false);
	} else if(ni_intr.read() == 1 || time_slice.read() == 1 || irq_status.read().range(1,1) || int_seek.read() == 1 || int_dmni_seek.read() == 1 || intAP.read() == 1){
		clock_aux.write(true);
	}

	if((clock.read() && clock_aux.read() && clock_wait_kernel.read()) == true){
		tick_counter_local.write((tick_counter_local.read() + 1) );
	}

	clock_hold.write(clock.read() & clock_aux.read() & clock_wait_kernel.read());

}

