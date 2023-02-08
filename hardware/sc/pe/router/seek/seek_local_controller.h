#ifndef _SCGENMOD_seek_local_controller_
#define _SCGENMOD_seek_local_controller_

#include <systemc.h>

class seek_local_controller : public sc_foreign_module
{
public:
		sc_in<bool> clock;
		sc_in<bool> reset;

		// PE interface
		sc_in<reg_seek_target >		pe_target;
		sc_in<reg_seek_source >		pe_source;
		sc_in<reg_seek_service >	pe_service;
		sc_in<reg_seek_payload >	pe_payload;
		sc_in<bool>					pe_opmode;
		sc_in<bool>					pe_req;
		sc_out<bool>				pe_ack;
		sc_out<bool>				pe_nack;

		// LC signals
		sc_in<reg_seek_target >		unr_target;
		sc_in<reg_seek_target >		unr_source;
		sc_in<regNport >			unr_service;

		//brNoC interface
		sc_out<reg_seek_target >	seek_target;
		sc_out<reg_seek_source >	seek_source;
		sc_out<reg_seek_service >	seek_service;
		sc_out<reg_seek_payload >	seek_payload;
		sc_out<bool>				seek_opmode;
		sc_out<bool>				seek_req;
		sc_in<bool>					seek_ack;
		sc_in<bool>					seek_nack;

		seek_local_controller(sc_module_name nm, const char* hdl_name)
		 : sc_foreign_module(nm, hdl_name),
			clock("clock"),
			reset("reset"),
		 	pe_target("pe_target"),
			pe_source("pe_source"),
			pe_service("pe_service"),
			pe_payload("pe_payload"),
			pe_opmode("pe_opmode"),
			pe_req("pe_req"),
			pe_ack("pe_ack"),
			pe_nack("pe_nack"),
			unr_target("unr_target"),
			unr_source("unr_source"),
			unr_service("unr_service"),
			seek_target("seek_target"),
			seek_source("seek_source"),
			seek_service("seek_service"),
			seek_payload("seek_payload"),
			seek_opmode("seek_opmode"),
			seek_req("seek_req"),
			seek_ack("seek_ack"),
			seek_nack("seek_nack")
		{
			// elaborate_foreign_module(hdl_name);
		}
		~seek_local_controller()
		{}

};

#endif

