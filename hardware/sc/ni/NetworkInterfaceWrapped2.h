#ifndef _SCGENMOD_NetworkInterfaceWrapped_
#define _SCGENMOD_NetworkInterfaceWrapped_

#include "systemc.h"

#include "../standards.h"
#include "NetworkInterfaceWrapped.h"

SC_MODULE(NetworkInterfaceWrapped)
{
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

    NetworkInterface *network_interface;

    SC_HAS_PROCESS(NetworkInterfaceWrapped); //TODO: What does this line do? Can I remove it?

	NetworkInterfaceWrapped(sc_module_name name_, regaddress address_ = 0x0000) : sc_module(name_), address(address_)
	{	 
        //TODO: Pra que serve 'generic_list'? Mantenho? Troco 'router_address' por 'ni_address'? 
        
        //const char* generic_list[1];
		//generic_list[0] = strdup("router_address=x\"AAAA\"");
		//sprintf((char*) generic_list[0],"router_address=x\"%.4x\"",(int)address);

		// network_interface = new NetworkInterface("NetworkInterface", "NetworkInterface", 0, generic_list);
		network_interface = new NetworkInterface("NetworkInterface", "NetworkInterface");
        
        network_interface->clock(clock);
        network_interface->reset(reset);

        network_interface->hermes_primary_tx(hermes_primary_tx);
        network_interface->hermes_primary_tx_clk(hermes_primary_tx_clk);
        network_interface->hermes_primary_data_out(hermes_primary_data_out);
        network_interface->hermes_primary_eop_out(hermes_primary_eop_out);
        network_interface->hermes_primary_credit_in(hermes_primary_credit_in);

        network_interface->hermes_primary_rx(hermes_primary_rx);
        network_interface->hermes_primary_rx_clk(hermes_primary_rx_clk);
        network_interface->hermes_primary_data_in(hermes_primary_data_in);
        network_interface->hermes_primary_eop_in(hermes_primary_eop_in);
        network_interface->hermes_primary_credit_out(hermes_primary_credit_out);

        network_interface->brnoc_primary_source_in(brnoc_primary_source_in);
        network_interface->brnoc_primary_target_in(brnoc_primary_target_in);
        network_interface->brnoc_primary_service_in(brnoc_primary_service_in);
        network_interface->brnoc_primary_payload_in(brnoc_primary_payload_in);
        network_interface->brnoc_primary_req_in(brnoc_primary_req_in);
        network_interface->brnoc_primary_opmode_in(brnoc_primary_opmode_in);
        network_interface->brnoc_primary_ack_out(brnoc_primary_ack_out);
        
        network_interface->brnoc_primary_source_out(brnoc_primary_source_out);
        network_interface->brnoc_primary_target_out(brnoc_primary_target_out);
        network_interface->brnoc_primary_service_out(brnoc_primary_service_out);
        network_interface->brnoc_primary_payload_out(brnoc_primary_payload_out);
        network_interface->brnoc_primary_req_out(brnoc_primary_req_out);
        network_interface->brnoc_primary_opmode_out(brnoc_primary_opmode_out);
        network_interface->brnoc_primary_ack_in(brnoc_primary_ack_in);
    }

    ~NetworkInterfaceWrapped(){}

	public:
		regaddress address;

};

#endif
