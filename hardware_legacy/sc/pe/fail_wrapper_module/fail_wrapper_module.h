//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  November 2017
//
//  Source name:  fail_wrapper_module.h
//
//  Brief description: Methods of process control queue occupancy
//
//---------------------------------------------------------------------------------------

#ifndef _fail_wrapper_module
#define _fail_wrapper_module

#include <systemc.h>
#include "../../standards.h"


SC_MODULE(fail_WRAPPER_module){
	sc_in< bool >   				clock;
	sc_in< bool >   				reset;
	sc_in< bool >					in_fail_cpu_local;//sinal da falha
	sc_in< bool >					in_fail_cpu_config;//sinal para configurar o target
	sc_in 	<sc_uint<32> >	  	 	mem_address_service_fail_cpu;  //target

	//cpu to wrapper
	sc_in   <reg_seek_source >    	in_source_wrapper_local;         
	sc_in   <reg_seek_target >    	in_target_wrapper_local;         
	sc_in   <reg_seek_payload >   	in_payload_wrapper_local;        
	sc_in   <reg_seek_service >   	in_service_wrapper_local;
	sc_in   <bool >					in_req_wrapper_local;
	sc_in   <bool >					in_opmode_wrapper_local;
	sc_in   <bool >					in_fail_wrapper_local;
	sc_out   <bool > 				out_ack_wrapper_local;
	sc_out   <bool > 				out_nack_wrapper_local;
	
	
	//wrapper to pdn
	sc_out   <reg_seek_source >    	out_source_wrapper_local;         
	sc_out   <reg_seek_target >    	out_target_wrapper_local;         
	sc_out   <reg_seek_payload >   	out_payload_wrapper_local;        
	sc_out   <reg_seek_service >   	out_service_wrapper_local;         
	sc_out   <bool >				out_req_wrapper_local;
	sc_out   <bool >				out_opmode_wrapper_local;
	sc_out   <bool >				out_fail_wrapper_local;
	sc_in   <bool > 				in_ack_wrapper_local;
	sc_in   <bool > 				in_nack_wrapper_local;
	
	sc_signal 	<reg_seek_source > 				in_source_router;
	sc_signal 	<reg_seek_target > 				in_target_router;
	
	enum fila_in{S_INIT_IN, S_END};
	sc_signal<fila_in > EA_in;
	
	void in_proc_FSM();

	sc_in<sc_uint<32 > > tick_counter;
	void brNoC_monitor();

/////////////////////////////////////////////////////////////////
// modulo para mascarar falha a partir do serviço IO_OPEN_WRAPPER

  enum FSM_in{S_INIT, S_RECEIVE, S_WAIT, S_SERVICE, S_PAYLOAD};
  sc_signal<FSM_in > EA_dataNOC;

  //sc_out<bool >    		mask_tx_out;
  //sc_in<bool >    		mask_tx_from_router_local;

  sc_in<bool >    		eop_in_from_router_local;
  sc_in<bool >    		clock_rx_from_router_local;
  sc_in<bool >    		rx_from_router_local;
  sc_in<regflit > 		data_in_from_router_local;
  sc_in<bool >			eop_out_router_ports[NPORT-2];
  sc_in<bool >			eop_in_router_ports[NPORT-2];
  sc_in<bool >			io_packet_mask[NPORT-2];

  sc_in<sc_uint<10> >	wrapper_mask_go_from_CPU;
  sc_in<sc_uint<10> >	wrapper_mask_back_from_CPU;

  sc_out <sc_uint<10> >	wrapper_mask_router_in;
  sc_out <sc_uint<10> >	wrapper_mask_router_out;

  sc_out<bool > 		cpu_mask_clear;

  regflit               buffer_in_flit[BUFFER_IN_WRAPPER];
  sc_signal<bool > 		cpu_mask_done;

  regflit				mask_done;
  regflit				change_mask;
  regflit				aux_wrapper_mask_go;
  regflit				aux_wrapper_mask_back;
  regflit				aux_CPU_mask;

  regflit               reg_header;
  regflit               reg_msg_size;
  regflit               reg_service;
  regflit               reg_io_service;
  regflit               reg_io_port;
  regflit               reg_direction;

  reg8                  flit_in_counter;
  reg8                  count_delay;
  reg8                  aux_delay;
///////////////////////////////////////////////////////////////////


   	void in_dataNOC_FSM();
	// void in_proc_FSM();
	void write_mask();

	SC_CTOR(fail_WRAPPER_module){
    	SC_METHOD(in_proc_FSM);
    		sensitive << reset;
    		sensitive << clock.pos();

		SC_METHOD(brNoC_monitor);
		sensitive << reset;
    	//sensitive << clock.pos();
		sensitive << out_req_wrapper_local.pos();
	    SC_METHOD(in_dataNOC_FSM);
	    	sensitive << reset;
	    	sensitive << clock.pos();


		SC_METHOD(write_mask);
	    	sensitive << reset;
	    	sensitive << clock.pos();


	}

};

#endif