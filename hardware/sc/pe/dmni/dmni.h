//------------------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  September 2013
//
//  Source name:  dmni.h
//
//  Brief description:  Implements a DMNI used by NI module.
//
//------------------------------------------------------------------------------------------------

#ifndef _DMNI_h
#define _DMNI_h

#include <systemc.h>
#include "../../standards.h"

/*
 * send - read from memory and write to noc
 * recv - read from noc and write to memory
 */
#define BUFFER_SIZE 64 //Alterar o tamanho implica em mudar o numero de bits de firs e last
#define DMNI_TIMER 16
#define WORD_SIZE	4
#define FAIL_RECEPTION_TIMEOUT 0x0400

SC_MODULE(dmni){
	sc_in<bool>					clock;
	sc_in<bool>					reset;

	//Plasma configuration interface
	sc_in<bool>					set_address;
	sc_in<bool>					set_address_2;
	sc_in<bool>					set_size;
	sc_in<bool>					set_size_2;
	sc_in<bool>					set_op;
	sc_in<bool>					start;
	sc_in<bool>					send_kernel;
	sc_in<bool>					wait_kernel;
	sc_in<sc_uint<32> >			config_data;

	//Status Outputs
	sc_out<bool>				intr;
	sc_out<bool>				send_active;
	sc_out<bool>				receive_active;

	//Internal mem interface
	sc_out<sc_uint<32> >		mem_address;
	sc_out<sc_uint<32> >		mem_data_write;
	sc_in<sc_uint<32> >			mem_data_read;
	sc_in<sc_uint<32> >			mem_address_service_header_kernel;
	sc_out<sc_uint<4> >			mem_byte_we;

	// 16 bits signals
	sc_signal<sc_uint<32> >		data_out_32; 
	sc_signal<sc_uint<16> >		data_out_16; 
	
	// Seek Interface 
	sc_in<bool>						in_req_send_kernel_seek;
	sc_out<bool>					out_ack_send_kernel_seek;
	// NoC Interface (Local port)
	
	sc_out<bool > 				tx;
	sc_out<reg32 > 			data_out; //22/01
	sc_in<bool > 				credit_i;
	sc_out<bool > 				clock_tx;
	sc_in<bool > 				eop_in;
	sc_in<bool > 				rx;
	//sc_in<reg32 >				data_in;//22/01
	sc_in<regflit >				data_in;//22/01
	sc_out<bool > 				credit_o;
	sc_in<bool > 				clock_rx;
	sc_out<bool > 				eop_out;
	sc_out<bool > 				reset_plasma_from_dmni;
	
	sc_out<bool > 				dmni_timeout;


	enum dmni_state				{WAIT, LOAD, COPY_FROM_MEM, COPY_TO_MEM, END, FAILED_RECEPTION};
	sc_signal<dmni_state >		DMNI_Send, DMNI_Receive, DMNI_Receive_Kernel, DMNI_Send_Kernel;

	enum state_noc 				{HEADER, HEADER2, PAYLOAD_SIZE, DATA, SOURCE_ROUTING_HEADER};
	sc_signal<state_noc>		SR, SR_Kernel;

	enum arbiter_state			{ROUND, SEND, RECEIVE};
	sc_signal<arbiter_state>	ARB;

	sc_signal<sc_uint<32> >		buffer[BUFFER_SIZE];
	sc_signal<bool >			buffer_eop[BUFFER_SIZE];
	
	sc_signal<sc_uint<16> >		buffer_high;
	sc_signal<sc_uint<32> >		buffer_aux;
	sc_signal<sc_uint<16> >		buffer_low;
	
	sc_signal<bool >			is_header[BUFFER_SIZE];
	sc_signal<sc_uint<4> >		intr_count;

	sc_signal<sc_uint<6> > 		first, last;
	sc_signal<bool >           add_buffer;

	//32 bits
	sc_signal<sc_uint<32> > 	payload_size;


	sc_signal<sc_uint<5> >		timer;
	sc_signal<sc_uint<32 > > 	address;
	sc_signal<sc_uint<32 > > 	address_2;
	sc_signal<sc_uint<32 > > 	size;
	sc_signal<sc_uint<32 > > 	size_2;
	sc_signal<sc_uint<32 > >	send_address;
	sc_signal<sc_uint<32 > >	send_address_2;
	sc_signal<sc_uint<32 > >	send_size;
	sc_signal<sc_uint<32 > >	send_size_2;
	sc_signal<sc_uint<32 > >	recv_address;
	sc_signal<sc_uint<32 > >	recv_size;
	sc_signal<sc_uint<32 > >	address_svc_header_RAM;

	sc_signal<bool >			prio;
	sc_signal<bool >			operation;
	sc_signal<bool >            read_av;
	sc_signal<bool >            slot_available;
	sc_signal<bool >            read_enable;
	sc_signal<bool >            write_enable;

	sc_signal<bool>				cont;
	sc_signal<bool>				start_copy_kernel;
	sc_signal<sc_uint<4 > >		flag_high;
	sc_signal<sc_uint<4 > >		reset_counter;
	sc_signal<sc_uint<4 > > 	cont_size;
	sc_signal<sc_uint<16 > > 	data_in_aux;
	sc_signal<bool>				flag_size;
	sc_signal<bool>				flag_wait_kernel;
	sc_signal<bool>				reg_interrupt_received;
	sc_signal<bool>				reg_interrupt_received_wait;

	void config();
	void receive();
	void send();
	void send_master_kernel();
	void receive_master_kernel();
	void buffer_control();
	void arbiter();
	void credit_o_update();
	void mem_address_update();
	
	SC_HAS_PROCESS(dmni);
	dmni(sc_module_name name_, regaddress address_router_ = 0) :
		sc_module(name_), address_router(address_router_)
		{
	
		SC_METHOD(arbiter);
		sensitive << clock.pos();
		sensitive << reset;

		SC_METHOD(config);
		sensitive << clock.pos();

		SC_METHOD(receive);
		sensitive << clock.pos();
		sensitive << reset;

		SC_METHOD(send);
		sensitive << clock.pos();
		sensitive << reset;

		SC_METHOD(send_master_kernel);
		sensitive << clock.pos();
		sensitive << reset;

		SC_METHOD(receive_master_kernel);
		sensitive << clock.pos();
		sensitive << reset;

		SC_METHOD(buffer_control);
		sensitive << add_buffer;
		sensitive << first;
		sensitive << last;

		SC_METHOD(credit_o_update);
		sensitive << slot_available;

		SC_METHOD(mem_address_update);
		sensitive << write_enable;
		sensitive << read_enable;
		sensitive << recv_address;
		sensitive << send_address;

	}
		private:
			regaddress address_router;
};

#endif

