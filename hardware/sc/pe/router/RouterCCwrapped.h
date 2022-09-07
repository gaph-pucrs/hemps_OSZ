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

    sc_out< sc_uint<12> > 		ke;
    sc_in<regNport > sz;
    sc_in<regNport > ap;
    sc_out<regNport > unreachable;

    
    sc_out<regflit>                 source;
    sc_out<regflit>                 target;
    sc_out<bool>                    w_source_target;
    sc_out<reg4>                    w_addr;
    sc_out<regNport >               rot_table[NPORT];

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
       ke("ke"),
       sz("sz"),
       ap("ap"),
       unreachable("unreachable"),
       target("target"),
       source("source"),
       w_source_target("w_source_target"),
       w_addr("w_addr")

    { 
        elaborate_foreign_module(hdl_name, num_generics, generic_list);
    }
    ~RouterCC()
    {}

  // public:
  //   regaddress address;
};

#endif

