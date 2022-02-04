//------------------------------------------------------------------------------------------------
//
//	 plasma_sender.cpp
//
//	 Created on: May 18, 2016
//	 Author: mruaro
//	 Modificated: Fochi / Caimi - july 13, 2016
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
#ifndef PLASMA_SENDER_H
#define PLASMA_SENDER_H

#include <systemc.h>
#include "../../standards.h"

SC_MODULE(plasma_sender){

	sc_in<bool >		clock;
	sc_in<bool >		reset;

// Interface com a DMNI
	sc_in<reg32 >		 data_in;		// dado lido direto da DMNI /32 bits
	sc_in<bool >			rx;				 // é o TX da DMNI informando que o dado está valido
	sc_out<bool >		 credit_o;	 // não tenho mais espaço para receber da dmni
	sc_in<bool >			eop_in;		 // End of packet que vem da dmni

	sc_out<regflit >	data_out;	 // data_out para a NoC /16 bits
	sc_out <bool >		tx;				 // TX para a NoC
	sc_in<bool >			credit_in;	// credit_in da NoC
	sc_out<bool >		 eop_out;		// End of packet que vai para a NoC
	

	reg32 buffer_in[BUFFER_TAM_SENDER];
	sc_signal<bool >	eop_buffer[BUFFER_TAM_SENDER];


	enum fila_out{S_INIT, SEND_HIGH, SEND_LOW, SEND_LAST_FLIT};
	sc_signal<fila_out > EA;

	sc_signal<sc_uint<4> >	first,last;
	sc_signal<bool > tem_espaco_na_fila;
	sc_signal<sc_uint<1> > data_avail;
	
	void in_proc_FSM();
	void in_proc_updPtr();

	void out_proc_FSM();
	void combinational();
	
	SC_CTOR(plasma_sender){
	
		SC_METHOD(combinational);
		sensitive << credit_in;
		sensitive << data_avail;

		SC_METHOD(in_proc_FSM);
		sensitive << reset;
		sensitive << clock.pos();

		SC_METHOD(out_proc_FSM);
		sensitive << reset;
		sensitive << clock.pos();

		SC_METHOD(in_proc_updPtr);
		sensitive << reset;
		sensitive << clock.neg();
		// sensitive << clock.pos();
		// sensitive << reset;
		// sensitive << tem_espaco_na_fila;
		// sensitive << rx;
		// sensitive << last;
		// sensitive << eop_in;
		// sensitive << data_in;


	}
};

#endif
