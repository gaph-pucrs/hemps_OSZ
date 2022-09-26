
#ifndef _pe_h
#define _pe_h

#include <systemc.h>
#include "../standards.h"
#include "processor/plasma/mlite_cpu.h"
#include "dmni/dmni.h"
#include "dmni/plasma_sender.h"
// #include "router/router_cc.h"
#include "memory/ram.h"


#include "router/RouterCCwrapped2.h"
#include "router/seek/router_seek_wrapped2.h"
#include "fifo_pdn/fifo_pdn.h"
#include "fail_wrapper_module/fail_wrapper_module.h"


SC_MODULE(pe) {
	
	sc_in< bool >		clock;
	sc_in< bool >		reset;
	sc_signal < bool > 	clock_hold;
	sc_signal < bool > 	reset_plasma;
	sc_signal < bool > 	reset_cpu_fail;
	sc_signal < bool > 	reset_plasma_from_dmni;
	sc_signal < bool >	clock_aux;
	sc_signal < bool >	clock_wait_kernel;

	// NoC Interface
	sc_out<bool >		clock_tx[NPORT-1];
	sc_out<bool >		tx[NPORT-1];
	sc_out<regflit >	data_out[NPORT-1];
	sc_in<bool >		credit_i[NPORT-1];
	sc_in<bool >		eop_in[NPORT-1];
	
	sc_in<bool >		clock_rx[NPORT-1];
	sc_in<bool > 		rx[NPORT-1];
	sc_in<regflit >		data_in[NPORT-1];
	sc_out<bool >		credit_o[NPORT-1];
	sc_out<bool >		eop_out[NPORT-1];
	
	//fail signals
	sc_in 		<bool > 						fail_in[NPORT-1];
	sc_out 		<bool > 						fail_out[NPORT-1];
	sc_in 		<bool > 						external_fail_in[NPORT-1];
	sc_in 		<bool >							external_fail_out[NPORT-1];
	sc_signal 	<bool >							router_fail_out[NPORT];
	sc_signal	<bool >							router_fail_in[NPORT];
	//seek interface
	sc_in 	<reg_seek_source > 					in_source_router_seek[NPORT_SEEK-1];
	sc_in 	<reg_seek_target > 					in_target_router_seek[NPORT_SEEK-1];
	sc_in 	<reg_seek_payload >		 			in_payload_router_seek[NPORT_SEEK-1];
	sc_in 	<reg_seek_service >			 		in_service_router_seek[NPORT_SEEK-1];
	sc_in 	<bool > 							in_req_router_seek[NPORT_SEEK-1];
	sc_in 	<bool > 							in_ack_router_seek[NPORT_SEEK-1];
	sc_in 	<bool > 							in_nack_router_seek[NPORT_SEEK-1];
	sc_in 	<bool > 							in_opmode_router_seek[NPORT_SEEK-1];
	sc_out 	<bool > 							out_req_router_seek[NPORT_SEEK-1];
	sc_out 	<bool > 							out_ack_router_seek[NPORT_SEEK-1];
	sc_out 	<bool > 							out_nack_router_seek[NPORT_SEEK-1];
	sc_out 	<bool > 							out_opmode_router_seek[NPORT_SEEK-1];
	sc_out 	<reg_seek_service > 				out_service_router_seek[NPORT_SEEK-1];
	sc_out 	<reg_seek_source > 					out_source_router_seek[NPORT_SEEK-1];
	sc_out 	<reg_seek_target > 					out_target_router_seek[NPORT_SEEK-1];
	sc_out 	<reg_seek_payload > 				out_payload_router_seek[NPORT_SEEK-1];
	sc_signal 	<reg_seek_source > 				in_source_router_seek_local;
	sc_signal 	<reg_seek_target > 				in_target_router_seek_local;
	sc_signal 	<reg_seek_payload > 			in_payload_router_seek_local;
	sc_signal 	<reg_seek_service > 			in_service_router_seek_local;
	sc_signal 	<bool > 						in_req_router_seek_local;
	sc_signal 	<bool > 						in_ack_router_seek_local;
//	sc_signal 	<bool > 						in_nack_router_seek_local;
	sc_signal 	<bool > 						in_opmode_router_seek_local;
	sc_signal 	<bool > 						in_fail_router_seek_local;
	sc_signal   <bool > 						cpu_mask_clear;
	sc_signal   <bool > 						mask_tx;
	sc_signal   <bool > 						result_rx;
	sc_signal 	<bool > 						out_req_router_seek_local;
	 sc_signal 	<bool > 						out_ack_router_seek_local;
	 sc_signal 	<bool > 						out_nack_router_seek_local;
	 sc_signal 	<bool > 						out_opmode_router_seek_local;
	 sc_signal 	<reg_seek_service > 			out_service_router_seek_local;
	 sc_signal 	<reg_seek_source > 				out_source_router_seek_local;
	 sc_signal 	<reg_seek_target > 				out_target_router_seek_local;
	 sc_signal 	<reg_seek_payload > 			out_payload_router_seek_local;

	sc_signal 	<reg_seek_source > 				in_source_wrapper_local;
	sc_signal 	<reg_seek_target > 				in_target_wrapper_local;
	sc_signal 	<reg_seek_payload > 			in_payload_wrapper_local;
	sc_signal 	<reg_seek_service > 			in_service_wrapper_local;
	sc_signal 	<bool > 						in_req_wrapper_local;
	sc_signal 	<bool > 						out_ack_wrapper_local;
	sc_signal 	<bool > 						out_nack_wrapper_local;
	sc_signal 	<bool > 						in_opmode_wrapper_local;
	sc_signal 	<bool > 						in_fail_wrapper_local; 
	sc_signal 	<reg_seek_source > 		in_source_fifopdn_local;
	sc_signal 	<reg_seek_target > 		in_target_fifopdn_local;
	sc_signal 	<reg_seek_payload > 	in_payload_fifopdn_local;
	sc_signal 	<reg_seek_service > 	in_service_fifopdn_local;
	sc_signal 	<bool > 				in_req_fifopdn_local;
	sc_signal 	<bool > 				in_ack_fifopdn_local;
	sc_signal 	<bool > 				in_nack_fifopdn_local;
	sc_signal 	<bool > 				in_opmode_fifopdn_local;
	sc_signal 	<bool > 				in_fail_fifopdn_local;
	sc_signal 	<bool > 				out_req_fifopdn_local;
	sc_signal 	<bool > 				out_ack_fifopdn_local;
	sc_signal 	<bool > 				out_nack_fifopdn_local;
	sc_signal 	<bool > 				out_opmode_fifopdn_local;
	sc_signal 	<reg_seek_service > 	out_service_fifopdn_local;
	sc_signal 	<reg_seek_source > 		out_source_fifopdn_local;
	sc_signal 	<reg_seek_target > 		out_target_fifopdn_local;
	sc_signal 	<reg_seek_payload > 	out_payload_fifopdn_local;
	sc_signal  <sc_uint<2> >               out_sel_reg_backtrack_fifopdn_local;
	sc_signal  <reg_seek_reg_backtrack >   in_reg_backtrack_fifopdn_local;
   	
   	sc_signal<sc_uint<2> >				in_sel_reg_backtrack_seek_local;
	sc_signal<sc_uint<32> >				out_reg_backtrack_seek_local;
		
	sc_signal<bool >					out_req_send_kernel_seek_local;
	sc_signal<bool >					in_ack_send_kernel_seek_local;		

	//signals mem and cpu
	sc_signal < sc_uint <32 > > cpu_mem_address_reg;
	sc_signal < sc_uint <32 > > cpu_mem_data_write_reg;
	sc_signal < sc_uint <4 > > 	cpu_mem_write_byte_enable_reg;
	sc_signal < sc_uint <8 > > 	irq_mask_reg;
	sc_signal < sc_uint <8 > > 	irq_status;
	sc_signal < bool > 			irq;
	sc_signal < sc_uint <32 > > time_slice;
	sc_signal < bool > 			write_enable;
	sc_signal < sc_uint <32 > > tick_counter_local;
	sc_signal < sc_uint <32 > > tick_counter;
	sc_signal < sc_uint <8 > > 	current_page;
	//cpu
	sc_signal < sc_uint <32 > > cpu_mem_address;
	sc_signal < sc_uint <32 > > cpu_mem_data_write;
	sc_signal < sc_uint <32 > > cpu_mem_data_read;
	sc_signal < sc_uint <4 > > 	cpu_mem_write_byte_enable;
	sc_signal < bool > 			cpu_mem_pause;
	sc_signal < bool > 			cpu_enable_ram;
	sc_signal < bool > 			cpu_set_size;
	sc_signal < bool > 			cpu_set_address;
	sc_signal < bool > 			cpu_set_size_2;
	sc_signal < bool > 			cpu_set_address_2;
	sc_signal < bool > 			cpu_set_op;
	sc_signal < bool > 			cpu_start;
	sc_signal < bool > 			cpu_send_kernel;
	sc_signal < bool > 			cpu_wait_kernel;
	sc_signal < bool > 			cpu_fail_kernel;
	sc_signal < bool > 			cpu_ack;

	//ram
	sc_signal < sc_uint <32 > > data_read_ram;
	sc_signal < sc_uint <32 > > mem_data_read;
	sc_signal < sc_uint <32 > > mem_address_service_header_kernel;
	
	//network interface
	sc_signal < bool > 			ni_intr;
	// Plasma Sender/Receive interface
	sc_signal< bool > 			clock_tx_ni;
	sc_signal< bool > 			tx_ni;
	sc_signal< reg32 > 		data_out_ni;//declarou o sinal aux
	sc_signal< bool > 			credit_i_ni;
	sc_signal< bool > 			clock_rx_ni;
	sc_signal< bool > 			rx_ni;
	sc_signal< regflit > 		data_in_ni;
	sc_signal< bool > 			credit_o_ni;
	sc_signal<bool>				eop_out_ni;
	sc_signal<bool>				eop_in_ni;

	//Noc Interface
	//sc_signal< bool > 			clock_tx_sender;
	sc_signal< bool > 			tx_sender;
	sc_signal< regflit > 		data_out_sender;//declarou o sinal aux
	sc_signal< bool > 			credit_i_sender;	
	sc_signal<bool>				eop_out_sender;
	sc_signal<bool>				eop_in_sender;

	//dmni
	sc_signal < sc_uint <32 > > dmni_mem_address;
	sc_signal < sc_uint <32 > > dmni_mem_addr_ddr;
	sc_signal < bool > 			dmni_mem_ddr_read_req;
	sc_signal < bool > 			mem_ddr_access;
	sc_signal < sc_uint <4 > > 	dmni_mem_write_byte_enable;
	sc_signal < sc_uint <32 > > dmni_mem_data_write;
	sc_signal < sc_uint <32 > > dmni_mem_data_read;
	sc_signal < sc_uint <32 > > dmni_mem_address_service_header_kernel;
	sc_signal < sc_uint <32 > > dmni_data_read;
	sc_signal < bool > 			dmni_enable_internal_ram;
	sc_signal < bool > 			dmni_send_active_sig;
	sc_signal < bool > 			dmni_receive_active_sig;
	sc_signal < sc_uint <30 > > address_mux;
	sc_signal < sc_uint <32 > > cpu_mem_address_reg2;
	sc_signal < sc_uint <30 > > addr_a;
	sc_signal < sc_uint <30 > > addr_b;
	sc_signal <	bool> 			cpu_repo_acess;
	sc_signal <	bool> 			dmni_timeout_ni;

	//Access Point
	sc_signal <bool >			pass[NPORT];
	sc_signal <bool >			ap_mask[NPORT]; 
	sc_signal <bool >			unreachable[NPORT];
	sc_signal <	regflit> 		k1;
	sc_signal <	regflit> 		k2;
	sc_signal < reg_seek_target> 	app_reg;
	
	

	//pending service signal
	sc_signal < bool > 			pending_service;

	sc_signal < sc_uint <32 > > end_sim_reg;



	sc_signal < sc_uint <32 > > slack_update_timer;

	sc_signal < bool> 			dummy_tx;
	sc_signal < bool> 			dummy_rx;
	sc_signal< regflit > 		dummy_bus;

	sc_signal<bool>				clock_tx_local0;
	sc_signal<bool>				clock_rx_local0;
	sc_signal<bool>				rx_local0;
	sc_signal<bool>				tx_local0;
	sc_signal<bool>				credit_i_local0;
	// sc_signal<regmetadeflit>			data_in_local0;
	sc_signal<regflit>			data_in_local0;
	sc_signal<bool>				credit_o_local0;
	sc_signal<regflit>			data_out_local0;
	sc_signal<bool>				eop_out_local0;
	sc_signal<bool>				eop_in_local0;
	// sc_signal<regmetadeflit>			data_out_local0;

	sc_signal<reg_seek_target> 				source;
	sc_signal<reg_seek_target> 				target;
	sc_signal<bool> 						w_source_target;
	sc_signal<reg4> 						w_addr;
	sc_signal<regNport >					rot_table[NPORT];
	sc_signal <bool > 						MEM_waiting[NPORT+1];
	sc_signal <reg_seek_source > 			MEM_source[NPORT+1];
	sc_signal <reg_seek_target > 			MEM_target[NPORT+1];
	sc_signal <reg_seek_payload > 			MEM_payload[NPORT+1];
	sc_signal <bool > 						MEM_opmode[NPORT+1];
	sc_signal <sc_uint <32 > > 				MEM_index_forwarded;
	
	sc_signal <bool	>						waiting_seek;
	sc_signal <bool	>						int_seek;
	sc_signal <bool	>						int_dmni_seek;
	sc_signal <reg_seek_service > 			in_cpu_service_seek;
	sc_signal <reg_seek_source > 			in_cpu_source_seek;
	sc_signal <reg_seek_target > 			in_cpu_target_seek;
	sc_signal <reg_seek_payload > 			in_cpu_payload_seek;
	sc_signal <bool > 						in_cpu_opmode_seek;
	sc_signal <bool >						wrapper_reg[NPORT];

	sc_signal <sc_uint <10 > >				wrapper_mask_go_reg;
	sc_signal <sc_uint <10 > >				wrapper_mask_back_reg;

	sc_signal <sc_uint <10 > >				wrapper_mask_router_in;
	sc_signal <sc_uint <10 > >				wrapper_mask_router_out;

	unsigned char shift_mem_page;

	mlite_cpu		*	cpu;
	ram				* 	mem;
	dmni 			*	dm_ni;
	plasma_sender 	*	ser;

	RouterCCwrapped *router;	// wrapper para o roteador principal
	router_seek_wrapped *seek;	// wrapper para o roteador QoS
	fifo_PDN *fifo_pdn;			
	fail_WRAPPER_module *fail_wrapper_module; //wrapper para o modulo de falhas


	unsigned long int log_interaction;
	unsigned long int instant_instructions;
	unsigned long int aux_instant_instructions;
	
	unsigned long int logical_instant_instructions;
	unsigned long int jump_instant_instructions;
	unsigned long int branch_instant_instructions;
	unsigned long int move_instant_instructions;
	unsigned long int other_instant_instructions;
	unsigned long int arith_instant_instructions;
	unsigned long int load_instant_instructions;
	unsigned long int shift_instant_instructions;
	unsigned long int nop_instant_instructions;
	unsigned long int mult_div_instant_instructions;


	char aux[255];
	FILE *fp;

	int i;
	
	void sequential_attr();
	void log_process();
	void comb_assignments();
	void mem_mapped_registers();
	void reset_n_attr();
	void clock_stop();
	void end_of_simulation();

	void seek_access();
	void seek_fault_middle_packet();
	void src_tgt_control();
	void seek_send();
	void seek_receive();
	void waiting_seek_trigger();
	void fail_in_generation();
	void fail_out_generation();
	void wrapper_register_handle();

	
	SC_HAS_PROCESS(pe);
	pe(sc_module_name name_, regaddress address_ = 0x00) : sc_module(name_), router_address(address_) {

		end_sim_reg.write(0x00000001);

		shift_mem_page = (unsigned char) (log10(PAGE_SIZE_BYTES)/log10(2));
	
		cpu = new mlite_cpu("cpu", router_address);
		cpu->clk(clock_hold);
		cpu->reset_in(reset_plasma);
		//cpu->reset_in(reset);
		cpu->intr_in(irq);
		cpu->mem_address(cpu_mem_address);
		cpu->mem_data_w(cpu_mem_data_write);
		cpu->mem_data_r(cpu_mem_data_read);
		cpu->mem_byte_we(cpu_mem_write_byte_enable);
		cpu->mem_pause(cpu_mem_pause);
		cpu->current_page(current_page);
		
		mem = new ram("ram", (unsigned int) router_address);
		mem->clk(clock);
		mem->enable_a(cpu_enable_ram);
		mem->wbe_a(cpu_mem_write_byte_enable);
		mem->address_a(addr_a);
		mem->data_write_a(cpu_mem_data_write);
		mem->data_read_a(data_read_ram);
		mem->enable_b(dmni_enable_internal_ram);
		mem->wbe_b(dmni_mem_write_byte_enable);
		mem->address_b(addr_b);
		mem->data_write_b(dmni_mem_data_write);
		mem->data_read_b(mem_data_read);

		dm_ni = new dmni("dmni", router_address);
		dm_ni->clock(clock);
		dm_ni->reset(reset);
		
		dm_ni->reset_plasma_from_dmni(reset_plasma_from_dmni);

		dm_ni->set_address(cpu_set_address);
		dm_ni->set_address_2(cpu_set_address_2);
		dm_ni->set_size(cpu_set_size);
		dm_ni->set_size_2(cpu_set_size_2);
		dm_ni->send_kernel(cpu_send_kernel);
		dm_ni->wait_kernel(cpu_wait_kernel);
		dm_ni->set_op(cpu_set_op);
		dm_ni->start(cpu_start);

		// SEEK INTERFACE

		dm_ni->in_req_send_kernel_seek(out_req_send_kernel_seek_local);
		dm_ni->out_ack_send_kernel_seek(in_ack_send_kernel_seek_local);
		//dm_ni->in_target_send_kernel_seek(out_target_send_seek_local);
		//

		dm_ni->config_data(dmni_data_read);
		dm_ni->intr(ni_intr);
		dm_ni->send_active(dmni_send_active_sig);
		dm_ni->receive_active(dmni_receive_active_sig);

		dm_ni->mem_address(dmni_mem_address);
		dm_ni->mem_data_write(dmni_mem_data_write);
		dm_ni->mem_data_read(dmni_mem_data_read);
		dm_ni->mem_address_service_header_kernel(cpu_mem_data_write);		
		dm_ni->mem_byte_we(dmni_mem_write_byte_enable);

		dm_ni->clock_tx(clock_tx_ni);
		dm_ni->tx(tx_ni);
		dm_ni->eop_out(eop_out_ni);
		dm_ni->data_out(data_out_ni);//data out da ni vai ser ligado no sinal auxiliar
		dm_ni->credit_i(credit_i_ni);
		dm_ni->clock_rx(clock_rx_ni);
		//dm_ni->rx(rx_ni);
		dm_ni->rx(result_rx);
		dm_ni->eop_in(eop_in_ni);
		dm_ni->data_in(data_in_ni);
		dm_ni->credit_o(credit_o_ni);
		dm_ni->dmni_timeout(dmni_timeout_ni);

		ser = new plasma_sender("plasma_sender");
		ser->clock(clock);
		ser->reset(reset);
		ser->data_in(data_out_ni);
		ser->rx(tx_ni);
		ser->credit_o(credit_i_ni);
		ser->eop_in(eop_out_ni);
		ser->tx(tx_sender);
		ser->data_out(data_out_sender);//data out da ni vai ser ligado no sinal auxiliar
		ser->credit_in(credit_i_sender);
		ser->eop_out(eop_out_sender);	
		
		router = new RouterCCwrapped("RouterCCwrapped",router_address);
		seek = new router_seek_wrapped("router_seek_wrapped", router_address);
		fifo_pdn = new fifo_PDN("fifo_PDN");
		#ifdef SEEK_LOG
		fail_wrapper_module = new fail_WRAPPER_module("fail_WRAPPER_module", router_address);
		#else
		fail_wrapper_module = new fail_WRAPPER_module("fail_WRAPPER_module");
		#endif		

		router->clock(clock);
		router->reset(reset);
		#ifdef DUPLICATED_CHANNEL
			for(i=0;i<NPORT-2;i++){
				router->access_i[i](fail_in[i]);
				router->access_o[i](fail_out[i]);
				router->clock_rx[i](clock_rx[i]);
				router->clock_tx[i](clock_tx[i]);
				router->tx[i](tx[i]);
				router->eop_out[i](eop_out[i]);
				router->rx[i](rx[i]);
				router->eop_in[i](eop_in[i]);
				router->credit_o[i](credit_o[i]);
				router->data_out[i](data_out[i]);
				router->credit_i[i](credit_i[i]);
				router->data_in[i](data_in[i]);
				fail_wrapper_module->eop_out_router_ports[i](eop_out[i]);
				fail_wrapper_module->eop_in_router_ports[i](eop_in[i]);
			}
			router->k1		(k1);
			router->k2		(k2);


			router->access_i				[LOCAL0](router_fail_in[LOCAL0]);
			router->access_i				[LOCAL1](router_fail_in[LOCAL1]);
			router->access_o			[LOCAL0](router_fail_out[LOCAL0]);
			router->access_o			[LOCAL1](router_fail_out[LOCAL1]);

			router->clock_rx 		[LOCAL0](clock);
			router->clock_tx 		[LOCAL0](clock_rx_local0);
			router->tx 				[LOCAL0](rx_local0);
			router->rx 				[LOCAL0](tx_local0);
			router->credit_o 		[LOCAL0](credit_i_local0);
			router->data_out 		[LOCAL0](data_in_local0);
			router->credit_i 		[LOCAL0](credit_o_local0);
			router->data_in 		[LOCAL0](data_out_local0);
			router->eop_out			[LOCAL0](eop_out_local0);
			router->eop_in			[LOCAL0](eop_in_local0);

			// plasma_sender to noc	
			router->clock_rx 		[LOCAL1](clock);
			router->clock_tx 		[LOCAL1](clock_rx_ni);

			router->rx 				[LOCAL1](tx_sender);			
			router->credit_o 		[LOCAL1](credit_i_sender);
			router->data_in 		[LOCAL1](data_out_sender);
			router->eop_in 			[LOCAL1](eop_out_sender);

		
			// Noc to dmni
			router->tx			[LOCAL1](rx_ni);
			router->data_out 		[LOCAL1](data_in_ni);
			router->credit_i 		[LOCAL1](credit_o_ni);
			router->eop_out		[LOCAL1](eop_in_ni);
			
			router->target(target);
			router->source(source);
			router->w_source_target(w_source_target);
			router->w_addr(w_addr);
			fail_wrapper_module->wrapper_mask_go_from_CPU(wrapper_mask_go_reg);
			fail_wrapper_module->wrapper_mask_back_from_CPU(wrapper_mask_back_reg);
			for(i=0;i<NPORT;i++){
				router->rot_table[i](rot_table[i]);
				router->ap[i]		(ap_mask[i]);
				router->sz[i]	(wrapper_reg[i]);
				router->unreachable[i]	(unreachable[i]);
			}
			seek->clock(clock);
			seek->reset(reset);
			for(i=0;i<NPORT_SEEK-1;i++){
				seek->in_source_router_seek[i](in_source_router_seek[i]);
				seek->in_target_router_seek[i](in_target_router_seek[i]);
				seek->in_payload_router_seek[i](in_payload_router_seek[i]);
				seek->in_service_router_seek[i](in_service_router_seek[i]);
				seek->out_service_router_seek[i](out_service_router_seek[i]);
				seek->out_source_router_seek[i](out_source_router_seek[i]);
				seek->out_target_router_seek[i](out_target_router_seek[i]);
				seek->out_payload_router_seek[i](out_payload_router_seek[i]);
				seek->in_req_router_seek[i](in_req_router_seek[i]);
				seek->in_ack_router_seek[i](in_ack_router_seek[i]);
				seek->in_nack_router_seek[i](in_nack_router_seek[i]);
				seek->in_opmode_router_seek[i](in_opmode_router_seek[i]);
				//WARNING MODIFY!!!!!
				seek->in_fail_router_seek[i](fail_in[i*2]);
				seek->out_req_router_seek[i](out_req_router_seek[i]);
				seek->out_ack_router_seek[i](out_ack_router_seek[i]);
				seek->out_nack_router_seek[i](out_nack_router_seek[i]);
				seek->out_opmode_router_seek[i](out_opmode_router_seek[i]);
			}
			// interface cpu->wrapper_local_pdn_down
			fail_wrapper_module->clock(clock);
			fail_wrapper_module->reset(reset);
			fail_wrapper_module->in_source_wrapper_local(in_source_router_seek_local); 
			fail_wrapper_module->in_target_wrapper_local(in_target_router_seek_local);
			fail_wrapper_module->in_payload_wrapper_local(in_payload_router_seek_local);
			fail_wrapper_module->in_service_wrapper_local(in_service_router_seek_local);
			fail_wrapper_module->in_req_wrapper_local(in_req_router_seek_local);
			fail_wrapper_module->in_opmode_wrapper_local(in_opmode_router_seek_local);
			fail_wrapper_module->in_fail_wrapper_local(in_fail_router_seek_local);
			fail_wrapper_module->out_ack_wrapper_local(out_ack_router_seek_local);
			fail_wrapper_module->out_nack_wrapper_local(out_nack_router_seek_local);
			fail_wrapper_module->in_fail_cpu_local(reset_cpu_fail);
			fail_wrapper_module->in_fail_cpu_config(cpu_fail_kernel);
			fail_wrapper_module->mem_address_service_fail_cpu(cpu_mem_data_write);						
			// wrapper_local_pdn_down -> SEEK
			fail_wrapper_module->out_source_wrapper_local(in_source_wrapper_local); 
			fail_wrapper_module->out_target_wrapper_local(in_target_wrapper_local);
			fail_wrapper_module->out_payload_wrapper_local(in_payload_wrapper_local);
			fail_wrapper_module->out_service_wrapper_local(in_service_wrapper_local);
			fail_wrapper_module->out_req_wrapper_local(in_req_wrapper_local);
			fail_wrapper_module->out_opmode_wrapper_local(in_opmode_wrapper_local);
			fail_wrapper_module->out_fail_wrapper_local(in_fail_wrapper_local);
			fail_wrapper_module->in_ack_wrapper_local(out_ack_wrapper_local);
			fail_wrapper_module->in_nack_wrapper_local(out_nack_wrapper_local);
			fail_wrapper_module->cpu_mask_clear(cpu_mask_clear);
			fail_wrapper_module->eop_in_from_router_local(eop_in_ni);
			fail_wrapper_module->clock_rx_from_router_local(clock_rx_ni);
			fail_wrapper_module->rx_from_router_local(rx_ni);
			fail_wrapper_module->data_in_from_router_local(data_in_ni);
			fail_wrapper_module->wrapper_mask_router_in(wrapper_mask_router_in);
			fail_wrapper_module->wrapper_mask_router_out(wrapper_mask_router_out);
			// interface PE->SEEK //fochi
			seek->in_source_router_seek[LOCAL](in_source_wrapper_local); 
			seek->in_target_router_seek[LOCAL](in_target_wrapper_local);
			seek->in_payload_router_seek[LOCAL](in_payload_wrapper_local);
			seek->in_service_router_seek[LOCAL](in_service_wrapper_local);
			seek->in_req_router_seek[LOCAL](in_req_wrapper_local);
			seek->in_opmode_router_seek[LOCAL](in_opmode_wrapper_local);
			seek->in_fail_router_seek[LOCAL](in_fail_wrapper_local);
			seek->out_ack_router_seek[LOCAL](out_ack_wrapper_local);
			seek->out_nack_router_seek[LOCAL](out_nack_wrapper_local);
			// interface SEEK -> FIFO_PDN
			//seek->out_service_router_seek[LOCAL](out_service_router_seek_local);
			seek->out_service_router_seek[LOCAL](in_service_fifopdn_local);
			seek->out_source_router_seek[LOCAL](in_source_fifopdn_local);
			seek->out_target_router_seek[LOCAL](in_target_fifopdn_local);
			seek->out_payload_router_seek[LOCAL](in_payload_fifopdn_local);
			seek->out_opmode_router_seek[LOCAL](in_opmode_fifopdn_local);
			seek->out_req_router_seek[LOCAL](in_req_fifopdn_local);
			seek->in_ack_router_seek[LOCAL](out_ack_fifopdn_local);
			seek->in_nack_router_seek[LOCAL](out_nack_fifopdn_local);
			seek->in_sel_reg_backtrack_seek(out_sel_reg_backtrack_fifopdn_local);
			seek->out_reg_backtrack_seek(in_reg_backtrack_fifopdn_local);
			seek->out_req_send_kernel_seek(out_req_send_kernel_seek_local);
			seek->in_ack_send_kernel_seek(in_ack_send_kernel_seek_local);
			seek->in_AppID_reg(app_reg);
			//seek->out_target_send_seek(out_target_send_seek_local);
			// FIFO_PDN to SEEK
			fifo_pdn->clock(clock);
			fifo_pdn->reset(reset);
			fifo_pdn->in_source_fifo_seek(in_source_fifopdn_local);
			fifo_pdn->in_target_fifo_seek(in_target_fifopdn_local);
			fifo_pdn->in_payload_fifo_seek(in_payload_fifopdn_local);
			fifo_pdn->in_service_fifo_seek(in_service_fifopdn_local);
			fifo_pdn->in_reg_backtrack_seek(in_reg_backtrack_fifopdn_local);
			fifo_pdn->out_sel_reg_backtrack_seek(out_sel_reg_backtrack_fifopdn_local);
						
			fifo_pdn->in_req_fifo_seek(in_req_fifopdn_local);
			fifo_pdn->in_opmode_fifo_seek(in_opmode_fifopdn_local);
			fifo_pdn->out_ack_fifo_seek(out_ack_fifopdn_local);
			fifo_pdn->out_nack_fifo_seek(out_nack_fifopdn_local);				
			//FIFO_PDN TO PE
			fifo_pdn->in_fail_cpu(reset_cpu_fail);
			fifo_pdn->in_ack_fifo_seek(in_ack_router_seek_local);
			fifo_pdn->in_sel_reg_backtrack(in_sel_reg_backtrack_seek_local);
			
			fifo_pdn->out_service_fifo_seek(out_service_router_seek_local);
			fifo_pdn->out_source_fifo_seek(out_source_router_seek_local);
			fifo_pdn->out_target_fifo_seek(out_target_router_seek_local);
			fifo_pdn->out_payload_fifo_seek(out_payload_router_seek_local);
			fifo_pdn->out_reg_backtrack(out_reg_backtrack_seek_local);
			
			fifo_pdn->out_req_pe(out_req_router_seek_local);
			
			fifo_pdn->out_opmode_fifo_seek(out_opmode_router_seek_local);
		#else //single channel
			for(i=0;i<NPORT-1;i++){
				router->clock_rx[i](clock_rx[i]);
				router->clock_tx[i](clock_tx[i]);
				router->tx[i](tx[i]);
				router->rx[i](rx[i]);
				router->credit_o[i](credit_o[i]);
				router->data_out[i](data_out[i]);
				router->credit_i[i](credit_i[i]);
				router->data_in[i](data_in[i]);
			}

			router->clock_rx[LOCAL](clock);
			router->clock_tx[LOCAL](clock_rx_ni);
			router->tx[LOCAL](rx_ni);
			router->rx[LOCAL](tx_sender);
			router->credit_o[LOCAL](credit_i_sender);
			router->data_out[LOCAL](data_in_ni);
			router->credit_i[LOCAL](credit_o_ni);
			router->data_in[LOCAL](data_out_sender);//se for canal unico liga aqui.
		#endif
		router->tick_counter(tick_counter);
		fail_wrapper_module->tick_counter(tick_counter);
		#ifdef SEEK_LOG
			seek->in_tick_counter(tick_counter);
		#endif
		SC_METHOD(sequential_attr);
		sensitive << clock.pos() << reset.pos();
		
		SC_METHOD(log_process);
		sensitive << clock.pos() << reset.pos();
		
		SC_METHOD(comb_assignments);
		sensitive << cpu_mem_address << dmni_mem_address << cpu_mem_address_reg << write_enable;
		sensitive << cpu_mem_data_write_reg << irq_mask_reg << irq_status;
		sensitive << time_slice << tick_counter_local;
		sensitive << dmni_send_active_sig << dmni_receive_active_sig << data_read_ram;
		sensitive << cpu_set_op << cpu_set_size << cpu_set_address << cpu_set_address_2 << cpu_set_size_2 << cpu_send_kernel << cpu_fail_kernel<< cpu_wait_kernel << dmni_enable_internal_ram;
		sensitive << mem_data_read << cpu_enable_ram << cpu_mem_write_byte_enable_reg << dmni_mem_write_byte_enable << mem_address_service_header_kernel;
		sensitive << dmni_mem_data_write << ni_intr << slack_update_timer;
		sensitive << rx_ni;
		
		SC_METHOD(mem_mapped_registers);
		sensitive << cpu_mem_address_reg;
		sensitive << tick_counter_local;
		sensitive << data_read_ram;
		sensitive << time_slice;
		sensitive << irq_status;
		
		SC_METHOD(end_of_simulation);
		sensitive << end_sim_reg;

		SC_METHOD(clock_stop);
		sensitive << clock << reset.pos();	

		SC_METHOD(seek_access);
		sensitive << clock.pos();
		sensitive << reset;
		SC_METHOD(seek_fault_middle_packet);
		// sensitive << clock.pos();
		for(i=0;i<NPORT;i++){
			sensitive << rot_table[i];
			sensitive << router_fail_in[i];
		}
		SC_METHOD(src_tgt_control);
		sensitive << clock.pos();
		// sensitive << w_source_target;
		SC_METHOD(seek_send);
		sensitive << clock.pos();
		sensitive << reset;
		// sensitive << waiting_seek;
		// sensitive << out_ack_router_seek_local;
		// sensitive << w_source_target;
		// sensitive << MEM_waiting[10];
		SC_METHOD(seek_receive);
		sensitive << clock.pos();
		sensitive << reset;
		SC_METHOD(waiting_seek_trigger);
		sensitive << clock.pos();
		// // sensitive << reset;
		// for(i=0;i<NPORT-2;i++){
		// 	sensitive << MEM_waiting[i];
		// 	sensitive << access_i[i];
		// }
		// sensitive << MEM_waiting[10];
		// SC_METHOD(fail_out_generation);
		// for(i=0;i<NPORT-1;i++){
		// 	// sensitive << wrapper_mask_router_out[i];
		// 	sensitive << router_fail_out[i];
		// 	sensitive << wrapper_reg[i];
		// 	sensitive << pass[i];
		// }
		SC_METHOD(fail_in_generation);
		for(i=0;i<NPORT-1;i++){
			sensitive << unreachable[i];
		}
		SC_METHOD(wrapper_register_handle);
		sensitive << clock.pos();
		sensitive << reset;
	}
	
	public:
		regaddress router_address;
};


#endif
