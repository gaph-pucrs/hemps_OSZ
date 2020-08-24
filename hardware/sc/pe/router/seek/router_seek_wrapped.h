#ifndef _SCGENMOD_router_seek_
#define _SCGENMOD_router_seek_

#include "systemc.h"

class router_seek : public sc_foreign_module
{
public:
    sc_in<bool> clock;
    sc_in<bool> reset;
    sc_in<reg_seek_source >           in_source_router_seek[NPORT_SEEK];
    sc_in<reg_seek_target >           in_target_router_seek[NPORT_SEEK];
    sc_in<reg_seek_payload >          in_payload_router_seek[NPORT_SEEK];
    sc_in<reg_seek_service >          in_service_router_seek[NPORT_SEEK];
    sc_in<sc_uint<NPORT_SEEK> >       in_req_router_seek;
    sc_in<sc_uint<NPORT_SEEK> >       in_ack_router_seek;
    sc_in<sc_uint<NPORT_SEEK> >       in_nack_router_seek;
    sc_in<sc_uint<NPORT_SEEK> >       in_fail_router_seek;
    sc_in<sc_uint<NPORT_SEEK> >       in_opmode_router_seek;
    sc_out<sc_uint<NPORT_SEEK> >      out_req_router_seek;
    sc_out<sc_uint<NPORT_SEEK> >      out_ack_router_seek;
    sc_out<sc_uint<NPORT_SEEK> >      out_nack_router_seek;
    sc_out<sc_uint<NPORT_SEEK> >      out_opmode_router_seek;
    sc_out<reg_seek_service >         out_service_router_seek[NPORT_SEEK];
    sc_out<reg_seek_source >          out_source_router_seek[NPORT_SEEK];
    sc_out<reg_seek_target >          out_target_router_seek[NPORT_SEEK];
    sc_out<reg_seek_payload >         out_payload_router_seek[NPORT_SEEK];

    sc_in<sc_uint<2> >								in_sel_reg_backtrack_seek;
    sc_out<sc_uint<32> >							out_reg_backtrack_seek;

    sc_out<bool >                     out_req_send_kernel_seek;
    sc_in<bool >                      in_ack_send_kernel_seek;

    router_seek(sc_module_name nm, const char* hdl_name,
       int num_generics, const char** generic_list)
     : sc_foreign_module(nm),
       clock("clock"),
       reset("reset"),
       in_req_router_seek("in_req_router_seek"),
       in_ack_router_seek("in_ack_router_seek"),
       in_nack_router_seek("in_nack_router_seek"),
       in_fail_router_seek("in_fail_router_seek"),
       in_opmode_router_seek("in_opmode_router_seek"),
       out_req_router_seek("out_req_router_seek"),
       out_ack_router_seek("out_ack_router_seek"),
       out_nack_router_seek("out_nack_router_seek"),
       out_opmode_router_seek("out_opmode_router_seek"),
       in_sel_reg_backtrack_seek("in_sel_reg_backtrack_seek"),
       out_reg_backtrack_seek("out_reg_backtrack_seek"),
       out_req_send_kernel_seek("out_req_send_kernel_seek"),
       in_ack_send_kernel_seek("in_ack_send_kernel_seek")
    {
        elaborate_foreign_module(hdl_name, num_generics, generic_list);
    }
    ~router_seek()
    {}

};

#endif

