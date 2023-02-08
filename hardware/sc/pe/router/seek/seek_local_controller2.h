#ifndef _SCGENMOD_seek_local_controller_
#define _SCGENMOD_seek_local_controller_

#include <systemc.h>

#include "../../../standards.h"
#include "seek_local_controller.h"

SC_MODULE(seek_local_controller) {
		sc_in<bool> clock;
		sc_in<bool> reset;

		// PE interface
		sc_in<reg_seek_source >		pe_target;
		sc_in<reg_seek_target >		pe_source;
		sc_in<reg_seek_payload >	pe_service;
		sc_in<reg_seek_service >	pe_payload;
		sc_in<bool>					pe_opmode;
		sc_in<bool>					pe_req;
		sc_out<bool>				pe_ack;
		sc_out<bool>				pe_nack;

		// LC signals
		sc_in<reg_seek_source >		unr_target;
		sc_in<reg_seek_target >		unr_source;
		sc_in<bool >				unr_service;

		//brNoC interface
		sc_out<reg_seek_source >	seek_target;
		sc_out<reg_seek_target >	seek_source;
		sc_out<reg_seek_payload >	seek_service;
		sc_out<reg_seek_service >	seek_payload;
		sc_out<bool>				seek_opmode;
		sc_out<bool>				seek_req;
		sc_in<bool>					seek_ack;
		sc_in<bool>					seek_nack;



};

#endif

