//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 8.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Date:  July 2018
//
//  Source name:  sabotage.h
//
//  Brief description: Methods of process control
//
//---------------------------------------------------------------------------------------

#ifndef _sabotage_h
#define _sabotage_h

#include <systemc.h>
#include "../../standards.h"

SC_MODULE(sabotage){
  sc_in< bool >   clock;
  sc_in< bool >   reset;

  // brnoc interface
  sc_in   <reg_seek_source >          in_source_router_seek_primary;
  sc_in   <reg_seek_target >          in_target_router_seek_primary;
  sc_in   <reg_seek_payload >         in_payload_router_seek_primary;
  sc_in   <reg_seek_service >         in_service_router_seek_primary;
  sc_in   <bool >                     in_req_router_seek_primary;
  sc_in   <bool >                     in_ack_router_seek_primary;
  sc_in   <bool >                     in_opmode_router_seek_primary;
  
  sc_out  <reg_seek_service >         out_service_router_seek_primary;
  sc_out  <reg_seek_source >          out_source_router_seek_primary;
  sc_out  <reg_seek_target >          out_target_router_seek_primary;
  sc_out  <reg_seek_payload >         out_payload_router_seek_primary;
  sc_out  <bool >                     out_ack_router_seek_primary;
  sc_out  <bool >                     out_req_router_seek_primary;
  sc_out  <bool >                     out_nack_router_seek_primary;
  sc_out  <bool >                     out_opmode_router_seek_primary;

  // NoC Interface
  sc_out<bool >     clock_tx_primary;
  sc_out<bool >     tx_primary;
  sc_out<regflit >  data_out_primary;
  sc_in<bool >      credit_i_primary;
  sc_in<bool >      eop_in_primary;

  sc_in<bool >      clock_rx_primary;
  sc_in<bool >      rx_primary;
  sc_in<regflit >   data_in_primary;
  sc_out<bool >     credit_o_primary;
  sc_out<bool >     eop_out_primary;
    

  enum FSM_in{S_INIT_IN, S_RECEIVE, S_WAIT, S_SERVICE, S_PAYLOAD};
  sc_signal<FSM_in > EA_in;

  enum FSM_out{S_WAIT_REQ, S_SEND_HEADER, S_SEND_PAYLOAD, S_WAIT_CREDIT_PAYLOAD, S_WAIT_CREDIT_HEADER, S_SEND_EOP};
  sc_signal<FSM_out > EA_out;

  reg32                 aux_cont;
  reg32                 last_cont;

  regflit               buffer_in_flit[BUFFER_IN_PERIPHERAL];
  regflit               buffer_out_flit[BUFFER_OUT_PERIPHERAL];

  regflit                 reg_header;
  regflit                 reg_msg_size;
  regflit                 reg_service;
  regflit                 reg_peripheral_ID;
  regflit                 reg_task_ID;
  regflit                 reg_source_PE;

  sc_uint<1>              IO_request;
  sc_uint<1>              IO_ack;
  reg8                    flit_in_counter;
  reg8                    flit_out_counter;
  reg32                   packet_size;

  void out_proc_FSM();
  void in_proc_FSM();

  void change_state_sequ();
  void change_state_comb();
  void seek_ack();

  SC_HAS_PROCESS(sabotage);
  sabotage(sc_module_name name_, int io_id_ = 0) :
    sc_module(name_), io_id(io_id_)
    {  

    SC_METHOD(in_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

    SC_METHOD(out_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

   SC_METHOD(seek_ack);
   sensitive << clock.pos();
  }
private:
    int io_id;

};

#endif
