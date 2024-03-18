#ifndef _SCGENMOD_RouterCC_
#define _SCGENMOD_RouterCC_

#include <systemc.h>

#include "../../standards.h"
#define ROUTER_VHD

class RouterCC : public sc_foreign_module
{
public:
    sc_in<bool> clock;
    sc_in<bool> reset;
    sc_in<regNport > clock_rx;
    sc_in<regNport > rx;
    sc_in<regNport > eop_in;
    sc_in<regflit > data_in[NPORT];
    
    sc_in<regNport >  access_i;
    sc_out<regNport >  access_o;

    sc_out<regNport > credit_o;
    sc_out<regNport > clock_tx;
    sc_out<regNport > tx;
    sc_out<regNport > eop_out;
    sc_out<regflit > data_out[NPORT];
    sc_in<regNport > credit_i;

    sc_in<regflit >  k1;
    sc_in<regflit >  k2;
    sc_in<regNport > sz;
    sc_in<regNport > ap;
    sc_out<regNport > link_control_message;
    sc_out<bool > link_control_internal;

	  sc_in < sc_uint <8 > >  	apThreshold;
    sc_out<bool>              intAP;
   	sc_out < sc_uint <3 > >  	AP_status;  
    
    sc_out<regflit>                 source;
    sc_out<regflit>                 target;

    // RouterCC(sc_module_name nm)
    // : sc_foreign_module(nm,"RouterCC", num_generics, generic_list),
    RouterCC(sc_module_name nm, const char* hdl_name,int num_generics, const char** generic_list)
     : sc_foreign_module(nm),
       clock("clock"),
       reset("reset"),
       clock_rx("clock_rx"),
       rx("rx"),
       //data_in
       credit_o("credit_o"),
       eop_in("eop_in"),
       access_i("access_i"),
       access_o("access_o"),
       clock_tx("clock_tx"),
       tx("tx"),
       //data_out
       credit_i("credit_i"),
       eop_out("eop_out"),
       k1("k1"),
       k2("k2"),
       sz("sz"),
       ap("ap"),
       apThreshold("apThreshold"),
       intAP("intAP"),
       AP_status("AP_status"),
       link_control_message("link_control_message"),
       link_control_internal("link_control_internal"),
       target("target"),
       source("source")
    { 
        elaborate_foreign_module(hdl_name, num_generics, generic_list);
    }
    ~RouterCC()
    {}

  // public:
  //   regaddress address;
};

#endif

