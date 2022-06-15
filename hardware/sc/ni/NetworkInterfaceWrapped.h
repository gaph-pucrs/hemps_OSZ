#ifndef _SCGENMOD_NetworkInterface_
#define _SCGENMOD_NetworkInterface_

#include "systemc.h"

#define ROUTER_VHD

class NetworkInterface : public sc_foreign_module
{
    public:

        sc_in<bool>                 clock;
        sc_in<bool>                 reset;

        /* Hermes Interface */

        sc_out<bool>                hermes_primary_tx;
        sc_out<bool>                hermes_primary_tx_clk;
        sc_out<regflit>             hermes_primary_data_out;
        sc_out<bool>                hermes_primary_eop_out;
        sc_in<bool>                 hermes_primary_credit_in;

        sc_in<bool>                 hermes_primary_rx;
        sc_in<bool>                 hermes_primary_rx_clk;
        sc_in<regflit>              hermes_primary_data_in;
        sc_in<bool>                 hermes_primary_eop_in;
        sc_out<bool>                hermes_primary_credit_out;

        /* BrNoC Interface */

        sc_in<reg_seek_source>      brnoc_primary_source_in;
        sc_in<reg_seek_target>      brnoc_primary_target_in;
        sc_in<reg_seek_service>     brnoc_primary_service_in;
        sc_in<reg_seek_payload>     brnoc_primary_payload_in;
        sc_in<bool>                 brnoc_primary_req_in;
        sc_in<bool>                 brnoc_primary_opmode_in;
        sc_out<bool>                brnoc_primary_ack_out;
        
        sc_out<reg_seek_source>     brnoc_primary_source_out;
        sc_out<reg_seek_target>     brnoc_primary_target_out;
        sc_out<reg_seek_service>    brnoc_primary_service_out;
        sc_out<reg_seek_payload>    brnoc_primary_payload_out;
        sc_out<bool>                brnoc_primary_req_out;
        sc_out<bool>                brnoc_primary_opmode_out;
        sc_in<bool>                 brnoc_primary_ack_in;

        // NetworkInterface(sc_module_name nm, const char* hdl_name, int num_generics, const char** generic_list) :
        NetworkInterface(sc_module_name nm, const char* hdl_name) :
            sc_foreign_module(nm),

			clock("clock"),
			reset("reset"),

            hermes_primary_tx("hermes_primary_tx"),
            hermes_primary_tx_clk("hermes_primary_tx_clk"),
            hermes_primary_data_out("hermes_primary_data_out"),
            hermes_primary_eop_out("hermes_primary_eop_out"),
            hermes_primary_credit_in("hermes_primary_credit_in"),

            hermes_primary_rx("hermes_primary_rx"),
            hermes_primary_rx_clk("hermes_primary_rx_clk"),
            hermes_primary_data_in("hermes_primary_data_in"),
            hermes_primary_eop_in("hermes_primary_eop_in"),
            hermes_primary_credit_out("hermes_primary_credit_out"),

            brnoc_primary_source_in("brnoc_primary_source_in"),
            brnoc_primary_target_in("brnoc_primary_target_in"),
            brnoc_primary_service_in("brnoc_primary_service_in"),
            brnoc_primary_payload_in("brnoc_primary_payload_in"),
            brnoc_primary_req_in("brnoc_primary_req_in"),
            brnoc_primary_opmode_in("brnoc_primary_opmode_in"),
            brnoc_primary_ack_out("brnoc_primary_ack_out"),

            brnoc_primary_source_out("brnoc_primary_source_out"),
            brnoc_primary_target_out("brnoc_primary_target_out"),
            brnoc_primary_service_out("brnoc_primary_service_out"),
            brnoc_primary_payload_out("brnoc_primary_payload_out"),
            brnoc_primary_req_out("brnoc_primary_req_out"),
            brnoc_primary_opmode_out("brnoc_primary_opmode_out"),
            brnoc_primary_ack_in("brnoc_primary_ack_in")
		{
			elaborate_foreign_module(hdl_name, num_generics, generic_list);
		}

		~NetworkInterface(){}
};

#endif
