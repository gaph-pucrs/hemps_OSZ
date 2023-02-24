//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  September 2013
//
//  Source name:  queue.h
//
//  Brief description: Methods of process control queue occupancy
//
//---------------------------------------------------------------------------------------

#ifndef _fifo_pdn_h
#define _fifo_pdn_h

#include <systemc.h>
#include "../../standards.h"

SC_MODULE(fifo_PDN){
  sc_in< bool >   clock;
  sc_in< bool >   reset;

  sc_in   <reg_seek_source >          in_source_fifo_seek;
  sc_in   <reg_seek_target >          in_target_fifo_seek;
  sc_in   <reg_seek_payload >         in_payload_fifo_seek;
  sc_in   <reg_seek_service >         in_service_fifo_seek;
  sc_in   <bool >                     in_opmode_fifo_seek;
  sc_in   <bool >                     in_req_fifo_seek;
  sc_out  <bool >                     out_ack_fifo_seek;
  sc_out  <bool >                     out_nack_fifo_seek;

  sc_out  <sc_uint<2> >               out_sel_reg_backtrack_seek;
  sc_in   <reg_seek_reg_backtrack >   in_reg_backtrack_seek;

  sc_out  <reg_seek_service >         out_service_fifo_seek;
  sc_out  <reg_seek_source >          out_source_fifo_seek;
  sc_out  <reg_seek_target >          out_target_fifo_seek;
  sc_out  <reg_seek_payload >         out_payload_fifo_seek;
  sc_out  <bool >                     out_opmode_fifo_seek;
  sc_out  <bool >                     out_req_pe;
  sc_in   <bool >                     in_ack_fifo_seek;

  sc_in   <sc_uint<2> >               in_sel_reg_backtrack; 
  sc_out  <reg_seek_reg_backtrack >   out_reg_backtrack;
/////////////////////////////////////////////////////////////////////
    
  sc_signal<bool >              out_req_send_kernel_seek_local;
  sc_signal<bool >              in_ack_send_kernel_seek_local;

  enum fila_in{S_INIT_IN, S_COPY_DATA, S_COPY_DATA1, S_COPY_DATA2, S_ACK, S_NACK, S_WAIT_REQ_DOWN, S_WAIT_SPACE};
  sc_signal<fila_in > EA_in;

  enum fila_out{S_INIT_OUT, S_OUT_REQ, S_WAIT_ACK,  S_WAIT_ACK_DOWN};
  sc_signal<fila_out > EA_out;


  reg_seek_source         buffer_source[BUFFER_TAM_FIFO_PDN];
  reg_seek_target         buffer_target[BUFFER_TAM_FIFO_PDN];
  reg_seek_payload        buffer_payload[BUFFER_TAM_FIFO_PDN];
  reg_seek_service        buffer_service[BUFFER_TAM_FIFO_PDN];
  reg_seek_opmode         buffer_opmode[BUFFER_TAM_FIFO_PDN];
  reg_seek_reg_backtrack  buffer_backtrack1[BUFFER_TAM_FIFO_PDN];
  reg_seek_reg_backtrack  buffer_backtrack2[BUFFER_TAM_FIFO_PDN];
  reg_seek_reg_backtrack  buffer_backtrack3[BUFFER_TAM_FIFO_PDN];


  sc_signal<sc_uint<4> >  first,last;
  sc_signal<bool > tem_espaco_na_fila;

  void in_proc_FSM();
  void in_proc_updPtr();
  void out_backtrack();
  void out_proc_FSM();

  void change_state_sequ();
  void change_state_comb();

  SC_CTOR(fifo_PDN){
    SC_METHOD(in_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

    SC_METHOD(out_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

    SC_METHOD(out_backtrack);
    sensitive << clock.pos();
    //sensitive << in_sel_reg_backtrack;


    SC_METHOD(in_proc_updPtr);
    sensitive << reset;
    sensitive << clock.neg();
  }

};

#endif
