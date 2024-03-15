//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Date:  March 2018
//
//  Source name:  repository.h
//
//  Brief description: 
//
//---------------------------------------------------------------------------------------

#ifndef _repository_h
#define _repository_h

#include <systemc.h>
#include <iostream>
#include <fstream>
#include <string>
#include "../../standards.h"
//#include "../../hemps.h"

using namespace std;

typedef struct {
  int  id;                    //!< Stores the task id
  int  code_size;                 //!< Stores the task code size - loaded from repository
  int  initial_address;             //!< Stores the initial address of task into repository - loaded from repository
  int  allocated_proc;              //!< Stores the allocated processor address of the task
  int  status;
} Task_info;

#define REPO_SIZE TOTAL_REPO_SIZE_BYTES/4
#define APPSTART_SIZE (APP_NUMBER*2)+1
#define INITIAL             0
#define GM_FOUND            1
#define INIT_ALLOCATION     2
#define INIT_ALLOCATION_ACK     3
#define WAITING_MAP   4
#define SENDING_TASKS 5
#define ALLOCATED             6
#define WAITING_ALLOCATION_ACK     7

#define TASK_DESCRIPTOR_SIZE  26

SC_MODULE(injector){
  sc_in< bool >   clock;
  sc_in< bool >   reset;

  // brnoc interface

  sc_in   <reg_seek_source >          in_source_router_seek_primary;
  sc_in   <reg_seek_target >          in_target_router_seek_primary;
  sc_in   <reg_seek_payload >         in_payload_router_seek_primary;
  sc_in   <reg_seek_service >         in_service_router_seek_primary;
  sc_in   <bool >                     in_req_router_seek_primary;
  sc_in   <bool >                     in_ack_router_seek_primary;
  sc_in   <bool >                     in_nack_router_seek_primary;
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
  sc_out<bool >   clock_tx_primary;
  sc_out<bool >   tx_primary;
  sc_out<regflit >  data_out_primary;
  sc_in<bool >    credit_i_primary;
  sc_in<bool >    eop_in_primary;

  sc_in<bool >    clock_rx_primary;
  sc_in<bool >    rx_primary;
  sc_in<regflit >   data_in_primary;
  sc_out<bool >   credit_o_primary;
  sc_out<bool >   eop_out_primary;

   // brnoc interface

  sc_in   <reg_seek_source >          in_source_router_seek_secondary;
  sc_in   <reg_seek_target >          in_target_router_seek_secondary;
  sc_in   <reg_seek_payload >         in_payload_router_seek_secondary;
  sc_in   <reg_seek_service >         in_service_router_seek_secondary;
  sc_in   <bool >                     in_req_router_seek_secondary;
  sc_in   <bool >                     in_ack_router_seek_secondary;
  sc_in   <bool >                     in_opmode_router_seek_secondary;
  
  sc_out  <reg_seek_service >         out_service_router_seek_secondary;
  sc_out  <reg_seek_source >          out_source_router_seek_secondary;
  sc_out  <reg_seek_target >          out_target_router_seek_secondary;
  sc_out  <reg_seek_payload >         out_payload_router_seek_secondary;
  sc_out  <bool >                     out_ack_router_seek_secondary;
  sc_out  <bool >                     out_req_router_seek_secondary;
  sc_out  <bool >                     out_nack_router_seek_secondary;
  sc_out  <bool >                     out_opmode_router_seek_secondary;

  // NoC Interface
  sc_out<bool >   clock_tx_secondary;
  sc_out<bool >   tx_secondary;
  sc_out<regflit >  data_out_secondary;
  sc_in<bool >    credit_i_secondary;
  sc_in<bool >    eop_in_secondary;
  sc_in<bool >    clock_rx_secondary;
  sc_in<bool >    rx_secondary;
  sc_in<regflit >   data_in_secondary;
  sc_out<bool >   credit_o_secondary;
  sc_out<bool >   eop_out_secondary;

  

  enum FSM_in_datanoc{S_INIT_IN, S_RECEIVE_HEADER,S_PAYLOAD,S_SERVICE,S_WAIT};
  sc_signal<FSM_in_datanoc > EA_in_datanoc;

  enum FSM_out_datanoc{S_INIT_DATANOC, S_SEND_HEADER,S_SEND_PAYLOAD_HIGH,S_SEND_PAYLOAD_LOW,S_WAIT_CREDIT_HEADER,S_WAIT_CREDIT_PAYLOAD_LOW, S_WAIT_CREDIT_PAYLOAD_HIGH,S_SEND_EOP,S_SEND_DESCRIPTOR,S_SEND_TASK, S_END_SEND_TASK };
  sc_signal<FSM_out_datanoc > EA_out_datanoc;

  enum FSM_in_brnoc{S_INIT,S_GMV_RECEIVE, S_ACK_NEW_APP_RECEIVE, S_ACK, S_WAIT_REQ_DOWN};
  sc_signal<FSM_in_brnoc > EA_in_brnoc;

  enum FSM_out_brnoc{S_WAIT_INIT,S_WAIT_ACK, S_ACK_DOWN, S_CLEAR, S_NEW_APP};
  sc_signal<FSM_out_brnoc > EA_out_brnoc;

  enum FSM_manager{S_WAITING_GM_READY, S_WAIT_LMP_LOCATION ,S_INIT_MANAGER, S_WAITING_GM, S_WAITING_MAP, S_SENDING_TASKS, S_WAIT_SEND_DESCRIPTOR};
  sc_signal<FSM_manager > EA_manager;

  regflit               buffer_in_flit[BUFFER_IN_PERIPHERAL];
  regflit               buffer_out_flit[BUFFER_OUT_PERIPHERAL];

  regflit                 reg_header;
  regflit                 reg_msg_size;
  regflit                 reg_service;
  regflit                 reg_peripheral_ID;
  regflit                 reg_task_ID;
  regflit                 reg_source_PE;
  regflit                 reg_mapped_tasks;

  sc_uint<1>              IO_request;
  reg32                   flit_in_counter;
  
  Task_info app_tasks[MAX_TASKS_APP];
  unsigned long repository_txt[REPO_SIZE];
  unsigned long appstart[APPSTART_SIZE];
  int task_number, packet_size, tasks_sent, tasks_map_received, flag_map_received;


  unsigned int current_time;
  int app_i, app_count, app_index, repo_address,aux;
  //sc_signal<sc_uint<16> >    flit_out_counter;
  int    flit_out_counter,i,need_to_clear, global_master_location, id_io;

  
  unsigned int buf_task_info[TASK_DESCRIPTOR_SIZE*4];

  reg32  app_start_time[APP_NUMBER];
  reg32  app_initial_address[APP_NUMBER];
  reg32  app_number_of_tasks[APP_NUMBER];
  reg32  app_status[APP_NUMBER];
  reg32  app_master_location[APP_NUMBER];
  reg32  app_ID[APP_NUMBER];
  
  reg32 address_to_clear;

  //reg32 allocated_proc_list[APP_NUMBER];

  void datanoc_in_proc_FSM();
  void datanoc_out_proc_FSM();
  void datanoc_out_comb_tx();

  void brnoc_in_proc_FSM();
  void brnoc_out_proc_FSM();

  void change_state_sequ();
  void change_state_comb();
  void load_appstart_repository();
  void new_app();
  void current_time_inc();


  SC_HAS_PROCESS(injector);
  injector(sc_module_name name_, int io_id_ = 0) :
    sc_module(name_), io_id(io_id_)
    {

    SC_METHOD(datanoc_in_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

    SC_METHOD(datanoc_out_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

    SC_METHOD(datanoc_out_comb_tx);
    sensitive << EA_out_datanoc;
    sensitive << credit_i_primary;

    SC_METHOD(brnoc_in_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

    SC_METHOD(brnoc_out_proc_FSM);
    sensitive << reset;
    sensitive << clock.pos();

   SC_METHOD(current_time_inc);
    sensitive << reset;
    sensitive << clock.pos();

   SC_METHOD(new_app);
    sensitive << reset;
    sensitive << clock.pos();    

   SC_METHOD(load_appstart_repository);
    sensitive << reset;

  }
  public:
    int io_id;
};

#endif
