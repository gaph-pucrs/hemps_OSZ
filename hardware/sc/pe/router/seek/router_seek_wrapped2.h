#ifndef _SCGENMOD_router_seek_wrapped_
#define _SCGENMOD_router_seek_wrapped_

#include "systemc.h"

#include "../../../standards.h"
#include "router_seek_wrapped.h"

SC_MODULE(router_seek_wrapped) {
		sc_in	<bool> clock;
		sc_in	<bool> reset;
		sc_in	<reg_seek_source > 			in_source_router_seek[NPORT_SEEK];//reg_seek_source_target
		sc_in	<reg_seek_target > 			in_target_router_seek[NPORT_SEEK];
		sc_in	<reg_seek_payload > 		in_payload_router_seek[NPORT_SEEK];
		sc_in	<reg_seek_service > 		in_service_router_seek[NPORT_SEEK];
		sc_in	<bool > 					in_req_router_seek[NPORT_SEEK];
		sc_in	<bool > 					in_ack_router_seek[NPORT_SEEK];
		sc_in	<bool > 					in_nack_router_seek[NPORT_SEEK];
		sc_in	<bool > 					in_fail_router_seek[NPORT_SEEK];
		sc_in	<bool > 					in_opmode_router_seek[NPORT_SEEK];
		sc_out	<bool > 					out_req_router_seek[NPORT_SEEK];
		sc_out	<bool > 					out_ack_router_seek[NPORT_SEEK];
		sc_out	<bool > 					out_nack_router_seek[NPORT_SEEK];
		sc_out	<bool > 					out_opmode_router_seek[NPORT_SEEK];
		sc_out	<reg_seek_service > 		out_service_router_seek[NPORT_SEEK];
		sc_out	<reg_seek_source > 			out_source_router_seek[NPORT_SEEK];
		sc_out	<reg_seek_target > 			out_target_router_seek[NPORT_SEEK];
		sc_out	<reg_seek_payload > 		out_payload_router_seek[NPORT_SEEK];

		sc_in<sc_uint<2> >					in_sel_reg_backtrack_seek;
		sc_out<sc_uint<32> >				out_reg_backtrack_seek;
		
		sc_out<bool >						out_req_send_kernel_seek;
		sc_in <bool >						in_ack_send_kernel_seek;
		

		//signals to bind in wrapped module
		sc_signal<sc_uint<NPORT_SEEK> >  in_req_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  in_ack_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  in_nack_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  in_fail_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  in_opmode_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  out_req_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  out_ack_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  out_nack_router_seek_internal;
		sc_signal<sc_uint<NPORT_SEEK> >  out_opmode_router_seek_internal;

		router_seek *seek;

		void upd_in_req_router_seek();
		void upd_in_ack_router_seek();
		void upd_in_nack_router_seek();
		void upd_in_fail_router_seek();
		void upd_in_opmode_router_seek();
		void upd_out_req_router_seek();
		void upd_out_ack_router_seek();
		void upd_out_nack_router_seek();
		void upd_out_opmode_router_seek();

		int i;

		SC_HAS_PROCESS(router_seek_wrapped);
		router_seek_wrapped(sc_module_name name_, regaddress address_ = 0x0000) :
		sc_module(name_), address(address_)
		{
			 
			const char* generic_list[1];
			generic_list[0] = strdup("router_address=x\"AAAA\"");
			sprintf((char*) generic_list[0],"router_address=x\"%x\"",(int)address);

			seek = new router_seek("router_seek", "router_seek", 1, generic_list);
			
			////////////////////////////////////////////////////
			//coment

				seek->clock(clock);
				seek->reset(reset);

				seek->in_source_router_seek[EAST](in_source_router_seek[EAST]);
				seek->in_source_router_seek[WEST](in_source_router_seek[WEST]);
				seek->in_source_router_seek[NORTH](in_source_router_seek[NORTH]);
				seek->in_source_router_seek[SOUTH](in_source_router_seek[SOUTH]);
				seek->in_source_router_seek[LOCAL](in_source_router_seek[LOCAL]);

				seek->in_target_router_seek[EAST](in_target_router_seek[EAST]);
				seek->in_target_router_seek[WEST](in_target_router_seek[WEST]);
				seek->in_target_router_seek[NORTH](in_target_router_seek[NORTH]);
				seek->in_target_router_seek[SOUTH](in_target_router_seek[SOUTH]);
				seek->in_target_router_seek[LOCAL](in_target_router_seek[LOCAL]);
				
				seek->in_payload_router_seek[EAST](in_payload_router_seek[EAST]);
				seek->in_payload_router_seek[WEST](in_payload_router_seek[WEST]);
				seek->in_payload_router_seek[NORTH](in_payload_router_seek[NORTH]);
				seek->in_payload_router_seek[SOUTH](in_payload_router_seek[SOUTH]);
				seek->in_payload_router_seek[LOCAL](in_payload_router_seek[LOCAL]);

				seek->in_service_router_seek[EAST](in_service_router_seek[LOCAL]);		 //[LOCAL]		[EAST]
				seek->in_service_router_seek[WEST](in_service_router_seek[SOUTH]);		 //[SOUTH]		[WEST]
				seek->in_service_router_seek[NORTH](in_service_router_seek[NORTH]);		 //[NORTH]		[NORTH]
				seek->in_service_router_seek[SOUTH](in_service_router_seek[WEST]);		 //[WEST]		[SOUTH]
				seek->in_service_router_seek[LOCAL](in_service_router_seek[EAST]);		 //[EAST]		[LOCAL]

				seek->out_service_router_seek[EAST](out_service_router_seek[EAST]);
				seek->out_service_router_seek[WEST](out_service_router_seek[WEST]);
				seek->out_service_router_seek[NORTH](out_service_router_seek[NORTH]);
				seek->out_service_router_seek[SOUTH](out_service_router_seek[SOUTH]);
				seek->out_service_router_seek[LOCAL](out_service_router_seek[LOCAL]);

				seek->out_source_router_seek[EAST](out_source_router_seek[EAST]);
				seek->out_source_router_seek[WEST](out_source_router_seek[WEST]);
				seek->out_source_router_seek[NORTH](out_source_router_seek[NORTH]);
				seek->out_source_router_seek[SOUTH](out_source_router_seek[SOUTH]);
				seek->out_source_router_seek[LOCAL](out_source_router_seek[LOCAL]);

				seek->out_target_router_seek[EAST](out_target_router_seek[EAST]);
				seek->out_target_router_seek[WEST](out_target_router_seek[WEST]);
				seek->out_target_router_seek[NORTH](out_target_router_seek[NORTH]);
				seek->out_target_router_seek[SOUTH](out_target_router_seek[SOUTH]);
				seek->out_target_router_seek[LOCAL](out_target_router_seek[LOCAL]);

				seek->out_payload_router_seek[EAST](out_payload_router_seek[EAST]);
				seek->out_payload_router_seek[WEST](out_payload_router_seek[WEST]);
				seek->out_payload_router_seek[NORTH](out_payload_router_seek[NORTH]);
				seek->out_payload_router_seek[SOUTH](out_payload_router_seek[SOUTH]);
				seek->out_payload_router_seek[LOCAL](out_payload_router_seek[LOCAL]);

				seek->in_sel_reg_backtrack_seek(in_sel_reg_backtrack_seek);
				seek->out_reg_backtrack_seek(out_reg_backtrack_seek);
				
				seek->out_req_send_kernel_seek(out_req_send_kernel_seek);
				seek->in_ack_send_kernel_seek(in_ack_send_kernel_seek);

				seek->in_req_router_seek(in_req_router_seek_internal);
				seek->in_ack_router_seek(in_ack_router_seek_internal);
				seek->in_nack_router_seek(in_nack_router_seek_internal);
				seek->in_opmode_router_seek(in_opmode_router_seek_internal);
				seek->in_fail_router_seek(in_fail_router_seek_internal);
				seek->out_req_router_seek(out_req_router_seek_internal);
				seek->out_ack_router_seek(out_ack_router_seek_internal);
				seek->out_nack_router_seek(out_nack_router_seek_internal);
				seek->out_opmode_router_seek(out_opmode_router_seek_internal);
			//end coment

		
			SC_METHOD(upd_in_req_router_seek);
			for (i = 0; i < NPORT_SEEK; i++){
				sensitive << in_req_router_seek[i];
			}

			SC_METHOD(upd_in_ack_router_seek);
			for (i = 0; i < NPORT_SEEK; i++){
				sensitive << in_ack_router_seek[i];
			}

			SC_METHOD(upd_in_nack_router_seek);
			for (i = 0; i < NPORT_SEEK; i++){
				sensitive << in_nack_router_seek[i];
			}

			SC_METHOD(upd_in_fail_router_seek);
			for (i = 0; i < NPORT_SEEK; i++){
				sensitive << in_fail_router_seek[i];
			}

			SC_METHOD(upd_in_opmode_router_seek);
			for (i = 0; i < NPORT_SEEK; i++){
				sensitive << in_opmode_router_seek[i];
			}

			SC_METHOD(upd_out_req_router_seek);
			sensitive << out_req_router_seek_internal;

			SC_METHOD(upd_out_ack_router_seek);
			sensitive << out_ack_router_seek_internal;

			SC_METHOD(upd_out_nack_router_seek);
			sensitive << out_nack_router_seek_internal;

			SC_METHOD(upd_out_opmode_router_seek);
			sensitive << out_opmode_router_seek_internal;


		}
		~router_seek_wrapped()
		{}

	public:
		regaddress address;

};

#endif

