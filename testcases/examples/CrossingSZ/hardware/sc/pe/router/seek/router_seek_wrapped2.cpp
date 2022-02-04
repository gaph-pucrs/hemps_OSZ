//------------------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS -  5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  November 2015
//
//  Source name:  router_seek_wrapped2.cpp
//
//  Brief description: wrapper for the seek module described in VHDL
//
//------------------------------------------------------------------------------------------------

#include "router_seek_wrapped2.h"

void router_seek_wrapped::upd_in_req_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_in_req_router_seek_internal;

   for(i=0;i<NPORT_SEEK;i++){
     l_in_req_router_seek_internal[i] = in_req_router_seek[i].read();
   }

   in_req_router_seek_internal.write(l_in_req_router_seek_internal);
}

void router_seek_wrapped::upd_in_ack_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_in_ack_router_seek_internal;

   for(i=0;i<NPORT_SEEK;i++){
     l_in_ack_router_seek_internal[i] = in_ack_router_seek[i].read();
   }

   in_ack_router_seek_internal.write(l_in_ack_router_seek_internal);
}

void router_seek_wrapped::upd_in_nack_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_in_nack_router_seek_internal;

   for(i=0;i<NPORT_SEEK;i++){
     l_in_nack_router_seek_internal[i] = in_nack_router_seek[i].read();
   }

   in_nack_router_seek_internal.write(l_in_nack_router_seek_internal);
}

void router_seek_wrapped::upd_in_opmode_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_in_opmode_router_seek_internal;

   for(i=0;i<NPORT_SEEK;i++){
     l_in_opmode_router_seek_internal[i] = in_opmode_router_seek[i].read();
   }

   in_opmode_router_seek_internal.write(l_in_opmode_router_seek_internal);
}

void router_seek_wrapped::upd_in_fail_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_in_fail_router_seek_internal;

   for(i=0;i<NPORT_SEEK;i++){
     l_in_fail_router_seek_internal[i] = in_fail_router_seek[i].read();
   }

   in_fail_router_seek_internal.write(l_in_fail_router_seek_internal);
}

void router_seek_wrapped::upd_out_req_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_out_req_router_seek_internal;

  l_out_req_router_seek_internal = out_req_router_seek_internal.read();

  for(i=0;i<NPORT_SEEK;i++){
    out_req_router_seek[i].write(l_out_req_router_seek_internal[i]);
  }
}

void router_seek_wrapped::upd_out_ack_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_out_ack_router_seek_internal;

  l_out_ack_router_seek_internal = out_ack_router_seek_internal.read();

  for(i=0;i<NPORT_SEEK;i++){
    out_ack_router_seek[i].write(l_out_ack_router_seek_internal[i]);
  }
}

void router_seek_wrapped::upd_out_nack_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_out_nack_router_seek_internal;

  l_out_nack_router_seek_internal = out_nack_router_seek_internal.read();

  for(i=0;i<NPORT_SEEK;i++){
    out_nack_router_seek[i].write(l_out_nack_router_seek_internal[i]);
  }
}

void router_seek_wrapped::upd_out_opmode_router_seek(){
  int i;
  sc_uint<NPORT_SEEK > l_out_opmode_router_seek_internal;

  l_out_opmode_router_seek_internal = out_opmode_router_seek_internal.read();

  for(i=0;i<NPORT_SEEK;i++){
    out_opmode_router_seek[i].write(l_out_opmode_router_seek_internal[i]);
  }
}