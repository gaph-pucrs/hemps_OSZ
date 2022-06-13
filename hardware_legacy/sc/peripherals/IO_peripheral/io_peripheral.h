//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Date:  March 2018
//
//  Source name:  IO_peripheral.h
//
//  Brief description: Methods of process control queue occupancy
//
//---------------------------------------------------------------------------------------

#ifndef _IO_peripheral_h
#define _IO_peripheral_h

#include <systemc.h>
#include "../../standards.h"

SC_MODULE(io_peripheral){
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
    

  int i;


  enum FSM_in{S_INIT_IN, S_RECEIVE, S_WAIT, S_SERVICE, S_PAYLOAD};
  sc_signal<FSM_in > EA_in;

  enum FSM_out{S_WAIT_REQ, S_SR_PREVIOUS_REQ, S_SR_PREVIOUS_ACK, S_SR_REQ, S_SR_ACK, S_XY_REQ, S_XY_ACK, S_SEND_HEADER, S_SEND_PAYLOAD, S_WAIT_CREDIT_PAYLOAD, S_WAIT_CREDIT_HEADER, S_SEND_EOP, S_WAIT_RX_OF_EOP, S_WAIT_CREDIT_EOP};
  sc_signal<FSM_out > EA_out;

  enum FSM_sr_path{S_WAIT_ORDER, S_VERIFY_TARGET, S_NEW_TARGET, S_TARGET_FOUND, S_COPY};
  sc_signal<FSM_sr_path > EA_sr_path;

  regflit               buffer_in_flit[BUFFER_IN_PERIPHERAL];
  regflit               buffer_out_flit[BUFFER_OUT_PERIPHERAL];

  regflit                 reg_header;
  regflit                 reg_msg_size;
  regflit                 reg_service;
  regflit                 reg_peripheral_ID;
  regflit                 reg_task_ID;
  regflit                 reg_source_PE;
  //regflit                 reg_target_PE;

  sc_uint<1>              IO_request;
  sc_uint<1>              IO_SR_request;
  sc_uint<1>              IO_ack;
  sc_uint<1>              IO_SR_ack;
  sc_uint<1>              IO_SR;
  sc_uint<1>              SR_found;
  reg8                    flit_in_counter;
  reg8                    flit_out_counter;
  reg8                    header_size;
  reg32                   payload_size;


  regflit               SR_target[IO_SR_PATHS];
  regflit               SR_size[IO_SR_PATHS];
  regflit               SR_path[IO_SR_PATHS][10];
  sc_uint<1>            SR_used[IO_SR_PATHS];
  sc_uint<3>            SR_index, SR_PATH_index;

  sc_uint<2>            previous_message_sent[IO_SR_PATHS]; // 0 - Ack; 1 - Request; 2 - Empty
  regflit               previous_target[IO_SR_PATHS];
  regflit               previous_task_ID[IO_SR_PATHS];
  sc_uint<3>            previous_index;





  void in_proc_FSM();
  void out_proc_FSM();
  void SR_path_FSM();
  void seek_ack();

  SC_HAS_PROCESS(io_peripheral);
  io_peripheral(sc_module_name name_, int io_id_ = 0) :
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

    SC_METHOD(SR_path_FSM);
     sensitive << reset;
     sensitive << clock.pos();


  }
private:
    int io_id;

};

#endif
