#ifndef _SCGENMOD_SNIP_Wrapped_
#define _SCGENMOD_SNIP_Wrapped_

#include "systemc.h"

#include "../../standards.h"
#include "snip_foreign.h"

/* SECURE NETWORK INTERFACE WITH PERIPHERALS - RENAMED TO FACILITATE BUILDING */

SC_MODULE(io_peripheral)
{
    sc_in<bool>                 clock;
    sc_in<bool>                 reset;

    /* Hermes Interface */

    sc_out<bool>                tx_primary;
    sc_out<bool>                clock_tx_primary;
    sc_out<regflit>             data_out_primary;
    sc_out<bool>                eop_out_primary;
    sc_in<bool>                 credit_i_primary;

    sc_in<bool>                 rx_primary;
    sc_in<bool>                 clock_rx_primary;
    sc_in<regflit>              data_in_primary;
    sc_in<bool>                 eop_in_primary;
    sc_out<bool>                credit_o_primary;

    /* BrNoC Interface */

    sc_in<reg_seek_source>      in_source_router_seek_primary;
    sc_in<reg_seek_target>      in_target_router_seek_primary;
    sc_in<reg_seek_service>     in_service_router_seek_primary;
    sc_in<reg_seek_payload>     in_payload_router_seek_primary;
    sc_in<bool>                 in_req_router_seek_primary;
    sc_in<bool>                 in_opmode_router_seek_primary;
    sc_out<bool>                out_ack_router_seek_primary;
    sc_out<bool>                out_nack_router_seek_primary;
    
    sc_out<reg_seek_source>     out_source_router_seek_primary;
    sc_out<reg_seek_target>     out_target_router_seek_primary;
    sc_out<reg_seek_service>    out_service_router_seek_primary;
    sc_out<reg_seek_payload>    out_payload_router_seek_primary;
    sc_out<bool>                out_req_router_seek_primary;
    sc_out<bool>                out_opmode_router_seek_primary;
    sc_in<bool>                 in_ack_router_seek_primary;

    SNIP_Foreign *snip;

    SC_HAS_PROCESS(io_peripheral);

	io_peripheral(sc_module_name name_, int io_id = 0) : sc_module(name_)
	{
        const char* generic_list[1];
        generic_list[0] = strdup("SNIP_ID=x\"AAAA\"");
        sprintf((char*) generic_list[0], "SNIP_ID=x\"%.4x\"", io_id);

		snip = new SNIP_Foreign("snip", "snip", 1, generic_list);
        
        snip->clock(clock);
        snip->reset(reset);

        snip->hermes_primary_tx(tx_primary);
        snip->hermes_primary_tx_clk(clock_tx_primary);
        snip->hermes_primary_data_out(data_out_primary);
        snip->hermes_primary_eop_out(eop_out_primary);
        snip->hermes_primary_credit_in(credit_i_primary);

        snip->hermes_primary_rx(rx_primary);
        snip->hermes_primary_rx_clk(clock_rx_primary);
        snip->hermes_primary_data_in(data_in_primary);
        snip->hermes_primary_eop_in(eop_in_primary);
        snip->hermes_primary_credit_out(credit_o_primary);

        snip->brnoc_primary_source_in(in_source_router_seek_primary);
        snip->brnoc_primary_target_in(in_target_router_seek_primary);
        snip->brnoc_primary_service_in(in_service_router_seek_primary);
        snip->brnoc_primary_payload_in(in_payload_router_seek_primary);
        snip->brnoc_primary_req_in(in_req_router_seek_primary);
        snip->brnoc_primary_opmode_in(in_opmode_router_seek_primary);
        snip->brnoc_primary_ack_out(out_ack_router_seek_primary);
        
        snip->brnoc_primary_source_out(out_source_router_seek_primary);
        snip->brnoc_primary_target_out(out_target_router_seek_primary);
        snip->brnoc_primary_service_out(out_service_router_seek_primary);
        snip->brnoc_primary_payload_out(out_payload_router_seek_primary);
        snip->brnoc_primary_req_out(out_req_router_seek_primary);
        snip->brnoc_primary_opmode_out(out_opmode_router_seek_primary);
        snip->brnoc_primary_ack_in(in_ack_router_seek_primary);
    }

    ~io_peripheral(){}
};

#endif
