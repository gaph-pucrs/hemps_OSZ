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
	sc_in<bool>						in_fail_cpu_config;//sinal para configurar o target
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

	#ifdef SEEK_LOG
	SC_HAS_PROCESS(fail_WRAPPER_module);
	fail_WRAPPER_module(sc_module_name name_, regaddress address_ = 0x0000) :
	sc_module(name_), address(address_)
	#else
	SC_CTOR(fail_WRAPPER_module)
	#endif
	{
    	SC_METHOD(in_proc_FSM);
    	sensitive << reset;
    	sensitive << clock.pos();

		SC_METHOD(brNoC_monitor);
		sensitive << reset;
    	//sensitive << clock.pos();
		sensitive << out_req_wrapper_local.pos();
	}
	public:
	regaddress address;
};

#endif