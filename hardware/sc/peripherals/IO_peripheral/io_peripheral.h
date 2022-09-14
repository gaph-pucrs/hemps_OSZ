#ifndef _SCGENMOD_NetworkInterfaceWrapped_
#define _SCGENMOD_NetworkInterfaceWrapped_

#include "systemc.h"

#include "../../standards.h"
#include "nisec_foreign.h"

/* SECURE NETWORK INTERFACE - RENAMED TO FACILITATE BUILDING */

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

    NetworkInterface *network_interface;

    SC_HAS_PROCESS(io_peripheral); //TODO: What does this line do? Can I remove it?

	io_peripheral(sc_module_name name_, int io_id = 0) : sc_module(name_)
	{
        const char* generic_list[1];
        generic_list[0] = strdup("NI_ID=x\"AAAA\"");
        sprintf((char*) generic_list[0], "NI_ID=x\"%.4x\"", io_id);

		network_interface = new NetworkInterface("network_interface", "network_interface", 1, generic_list);
        
        network_interface->clock(clock);
        network_interface->reset(reset);

        network_interface->hermes_primary_tx(tx_primary);
        network_interface->hermes_primary_tx_clk(clock_tx_primary);
        network_interface->hermes_primary_data_out(data_out_primary);
        network_interface->hermes_primary_eop_out(eop_out_primary);
        network_interface->hermes_primary_credit_in(credit_i_primary);

        network_interface->hermes_primary_rx(rx_primary);
        network_interface->hermes_primary_rx_clk(clock_rx_primary);
        network_interface->hermes_primary_data_in(data_in_primary);
        network_interface->hermes_primary_eop_in(eop_in_primary);
        network_interface->hermes_primary_credit_out(credit_o_primary);

        network_interface->brnoc_primary_source_in(in_source_router_seek_primary);
        network_interface->brnoc_primary_target_in(in_target_router_seek_primary);
        network_interface->brnoc_primary_service_in(in_service_router_seek_primary);
        network_interface->brnoc_primary_payload_in(in_payload_router_seek_primary);
        network_interface->brnoc_primary_req_in(in_req_router_seek_primary);
        network_interface->brnoc_primary_opmode_in(in_opmode_router_seek_primary);
        network_interface->brnoc_primary_ack_out(out_ack_router_seek_primary);
        
        network_interface->brnoc_primary_source_out(out_source_router_seek_primary);
        network_interface->brnoc_primary_target_out(out_target_router_seek_primary);
        network_interface->brnoc_primary_service_out(out_service_router_seek_primary);
        network_interface->brnoc_primary_payload_out(out_payload_router_seek_primary);
        network_interface->brnoc_primary_req_out(out_req_router_seek_primary);
        network_interface->brnoc_primary_opmode_out(out_opmode_router_seek_primary);
        network_interface->brnoc_primary_ack_in(in_ack_router_seek_primary);
    }

    ~io_peripheral(){}
};

#endif
