@0;moduleinfo.sc;6;21;0;gnuc;7;4;0

F29;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/hemps.cpp
F28;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/hemps.h
F27;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/test_bench.cpp
F26;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/test_bench.h
F25;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/pe.cpp
F24;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/pe.h
F23;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/dmni/dmni.cpp
F22;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/dmni/dmni.h
F21;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/dmni/plasma_sender.cpp
F20;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/dmni/plasma_sender.h
F19;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/fail_wrapper_module/fail_wrapper_module.cpp
F18;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/fail_wrapper_module/fail_wrapper_module.h
F17;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/fifo_pdn/fifo_pdn.cpp
F16;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/fifo_pdn/fifo_pdn.h
F15;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/memory/ram.cpp
F14;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/memory/ram.h
F13;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/processor/plasma/mlite_cpu.cpp
F12;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/processor/plasma/mlite_cpu.h
F11;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/router/RouterCCwrapped.h
F10;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/router/RouterCCwrapped2.cpp
F9;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/router/RouterCCwrapped2.h
F8;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/router/seek/router_seek_wrapped.h
F7;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/router/seek/router_seek_wrapped2.cpp
F6;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/pe/router/seek/router_seek_wrapped2.h
F5;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/peripherals/IO_peripheral/injector.cpp
F4;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/./peripherals/IO_peripheral/injector.h
F3;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/peripherals/IO_peripheral/io_peripheral.cpp
F2;/sim/faccenda/hemps_OSZ/testcases/examples/CrossingSZ/hardware/sc/peripherals/IO_peripheral/io_peripheral.h
F1;/soft64/mentor/ferramentas/modelsim/2021/include/systemc/ptrarray.h
F0;/soft64/mentor/ferramentas/modelsim/2021/include/systemc/sc_foreign_module.h


T144;<ignored>;23;0;0;0;0;0;<NONE>

T143;<pointer>;11;0;8;8;0;0;<NONE>

M142;RouterCC;19;12288;11256;11256;0;0;test_bench.dbs;F11;L9
B0;sc_core::sc_foreign_module;256;0;test_bench.dbs;T101;F0;L0
P0;clock;12;304;test_bench.dbs;T137;F11;L12
P0;reset;12;552;test_bench.dbs;T137;F11;L13
P0;clock_rx;12;800;test_bench.dbs;T31;F11;L14
P0;rx;12;1032;test_bench.dbs;T31;F11;L15
P0;eop_in;12;1264;test_bench.dbs;T31;F11;L16
P0;data_in;12;1496;test_bench.dbs;T95;F11;L17
P0;fail_in;12;3816;test_bench.dbs;T31;F11;L19
P0;fail_out;20;4048;test_bench.dbs;T31;F11;L20
P0;credit_o;20;4288;test_bench.dbs;T31;F11;L22
P0;clock_tx;20;4528;test_bench.dbs;T31;F11;L23
P0;tx;20;4768;test_bench.dbs;T31;F11;L24
P0;eop_out;20;5008;test_bench.dbs;T31;F11;L25
P0;data_out;20;5248;test_bench.dbs;T75;F11;L26
P0;credit_i;12;7648;test_bench.dbs;T31;F11;L27
P0;source;20;7880;test_bench.dbs;T30;F11;L29
P0;target;20;8120;test_bench.dbs;T30;F11;L30
P0;w_source_target;20;8360;test_bench.dbs;T137;F11;L31
P0;w_addr;20;8616;test_bench.dbs;T18;F11;L32
P0;rot_table;20;8856;test_bench.dbs;T76;F11;L33
N0;~RouterCC;();test_bench.dbs;F11;L60
N0;RouterCC;(sc_core::sc_module_name<unnamed>,<unnamed>,<unnamed>,);test_bench.dbs;F11;L56

M141;RouterCCwrapped;19;13312;38640;38640;0;0;test_bench.dbs;F9;L9
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F9;L10
P0;reset;12;536;test_bench.dbs;T137;F9;L11
P0;clock_rx;12;784;test_bench.dbs;T100;F9;L12
P0;rx;12;3264;test_bench.dbs;T100;F9;L13
P0;eop_in;12;5744;test_bench.dbs;T100;F9;L14
P0;data_in;12;8224;test_bench.dbs;T95;F9;L15
P0;credit_o;20;10544;test_bench.dbs;T81;F9;L16
P0;clock_tx;20;13104;test_bench.dbs;T81;F9;L17
P0;tx;20;15664;test_bench.dbs;T81;F9;L18
P0;eop_out;20;18224;test_bench.dbs;T81;F9;L19
P0;data_out;20;20784;test_bench.dbs;T75;F9;L20
P0;credit_i;12;23184;test_bench.dbs;T100;F9;L21
P0;fail_in;12;25664;test_bench.dbs;T100;F9;L22
P0;fail_out;20;28144;test_bench.dbs;T81;F9;L23
P0;source;20;30704;test_bench.dbs;T30;F9;L25
P0;target;20;30944;test_bench.dbs;T30;F9;L26
P0;w_source_target;20;31184;test_bench.dbs;T137;F9;L27
P0;rot_table;20;31440;test_bench.dbs;T76;F9;L28
P0;w_addr;20;33840;test_bench.dbs;T18;F9;L29
S0;clock_rx_internal;2;34080;test_bench.dbs;T31;F9;L33
S0;rx_internal;2;34472;test_bench.dbs;T31;F9;L34
S0;eop_in_internal;2;34864;test_bench.dbs;T31;F9;L35
S0;credit_o_internal;2;35256;test_bench.dbs;T31;F9;L36
S0;clock_tx_internal;2;35648;test_bench.dbs;T31;F9;L37
S0;tx_internal;2;36040;test_bench.dbs;T31;F9;L38
S0;eop_out_internal;2;36432;test_bench.dbs;T31;F9;L39
S0;credit_i_internal;2;36824;test_bench.dbs;T31;F9;L40
S0;fail_in_internal;2;37216;test_bench.dbs;T31;F9;L41
S0;fail_out_internal;2;37608;test_bench.dbs;T31;F9;L42
C0;router;33;38000;test_bench.dbs;M142;F9;L44
P0;tick_counter;12;38008;test_bench.dbs;T22;F9;L58
V0;SM_traffic_monitor;0;38240;test_bench.dbs;T11;F9;L59
V0;target_router;0;38252;test_bench.dbs;T8;F9;L60
V0;header_time;0;38292;test_bench.dbs;T8;F9;L61
V0;bandwidth_allocation;0;38332;test_bench.dbs;T0;F9;L62
V0;payload;0;38352;test_bench.dbs;T0;F9;L63
V0;payload_counter;0;38372;test_bench.dbs;T0;F9;L64
V0;service;0;38392;test_bench.dbs;T8;F9;L65
V0;task_id;0;38432;test_bench.dbs;T8;F9;L66
V0;counter_target;0;38472;test_bench.dbs;T8;F9;L67
V0;consumer_id;0;38512;test_bench.dbs;T8;F9;L68
V0;SR_found;0;38552;test_bench.dbs;T8;F9;L69
V0;i;0;38592;test_bench.dbs;T116;F9;L72
V0;address;0;38600;test_bench.dbs;T30;F9;L226
N0;~RouterCCwrapped;();test_bench.dbs;F9;L223
N0;RouterCCwrapped;(sc_core::sc_module_nameregaddress,);test_bench.dbs;F9;L78
N0;traffic_monitor;();RouterCCwrapped2.dbs;F10;L139
N0;upd_fail_out;();RouterCCwrapped2.dbs;F10;L80
N0;upd_fail_in;();RouterCCwrapped2.dbs;F10;L20
N0;upd_credit_i;();RouterCCwrapped2.dbs;F10;L64
N0;upd_eop_out;();RouterCCwrapped2.dbs;F10;L126
N0;upd_tx;();RouterCCwrapped2.dbs;F10;L114
N0;upd_clock_tx;();RouterCCwrapped2.dbs;F10;L103
N0;upd_credit_o;();RouterCCwrapped2.dbs;F10;L91
N0;upd_eop_in;();RouterCCwrapped2.dbs;F10;L42
N0;upd_rx;();RouterCCwrapped2.dbs;F10;L53
N0;upd_clock_rx;();RouterCCwrapped2.dbs;F10;L31

T140;State;0;0;296;296;0;0;test_bench.dbs;F12;L26
V0;r;0;0;test_bench.dbs;T110;F12;L27
V0;pc;0;256;test_bench.dbs;T7;F12;L28
V0;epc;0;264;test_bench.dbs;T7;F12;L28
V0;global_inst_reg;0;272;test_bench.dbs;T7;F12;L28
V0;hi;0;280;test_bench.dbs;T111;F12;L29
V0;lo;0;288;test_bench.dbs;T111;F12;L30

T139;Task_info;0;0;20;20;0;0;test_bench.dbs;F4;L27
V0;id;0;0;test_bench.dbs;T116;F4;L28
V0;code_size;0;4;test_bench.dbs;T116;F4;L29
V0;initial_address;0;8;test_bench.dbs;T116;F4;L30
V0;allocated_proc;0;12;test_bench.dbs;T116;F4;L31
V0;status;0;16;test_bench.dbs;T116;F4;L32

T138;Task_info[2];20;0;20;40;2;0;<NONE>;T139

T137;bool;12;0;1;1;0;0;<NONE>

T136;char;3;0;1;1;0;0;<NONE>

T135;char[20];20;0;1;20;20;0;<NONE>;T136

T134;char[255];20;0;1;255;255;0;<NONE>;T136

M133;dmni;19;13312;39792;39792;0;0;test_bench.dbs;F22;L30
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F22;L31
P0;reset;12;536;test_bench.dbs;T137;F22;L32
P0;set_address;12;784;test_bench.dbs;T137;F22;L35
P0;set_address_2;12;1032;test_bench.dbs;T137;F22;L36
P0;set_size;12;1280;test_bench.dbs;T137;F22;L37
P0;set_size_2;12;1528;test_bench.dbs;T137;F22;L38
P0;set_op;12;1776;test_bench.dbs;T137;F22;L39
P0;start;12;2024;test_bench.dbs;T137;F22;L40
P0;send_kernel;12;2272;test_bench.dbs;T137;F22;L41
P0;wait_kernel;12;2520;test_bench.dbs;T137;F22;L42
P0;config_data;12;2768;test_bench.dbs;T22;F22;L43
P0;intr;20;3000;test_bench.dbs;T137;F22;L46
P0;send_active;20;3256;test_bench.dbs;T137;F22;L47
P0;receive_active;20;3512;test_bench.dbs;T137;F22;L48
P0;mem_address;20;3768;test_bench.dbs;T22;F22;L51
P0;mem_data_write;20;4008;test_bench.dbs;T22;F22;L52
P0;mem_data_read;12;4248;test_bench.dbs;T22;F22;L53
P0;mem_address_service_header_kernel;12;4480;test_bench.dbs;T22;F22;L54
P0;mem_byte_we;20;4712;test_bench.dbs;T18;F22;L55
S0;data_out_32;2;4952;test_bench.dbs;T22;F22;L58
S0;data_out_16;2;5344;test_bench.dbs;T30;F22;L59
P0;in_req_send_kernel_seek;12;5736;test_bench.dbs;T137;F22;L62
P0;out_ack_send_kernel_seek;20;5984;test_bench.dbs;T137;F22;L63
P0;tx;20;6240;test_bench.dbs;T137;F22;L66
P0;data_out;20;6496;test_bench.dbs;T22;F22;L67
P0;credit_i;12;6736;test_bench.dbs;T137;F22;L68
P0;clock_tx;20;6984;test_bench.dbs;T137;F22;L69
P0;eop_in;12;7240;test_bench.dbs;T137;F22;L70
P0;rx;12;7488;test_bench.dbs;T137;F22;L71
P0;data_in;12;7736;test_bench.dbs;T30;F22;L73
P0;credit_o;20;7968;test_bench.dbs;T137;F22;L74
P0;clock_rx;12;8224;test_bench.dbs;T137;F22;L75
P0;eop_out;20;8472;test_bench.dbs;T137;F22;L76
P0;reset_plasma_from_dmni;20;8728;test_bench.dbs;T137;F22;L77
P0;dmni_timeout;20;8984;test_bench.dbs;T137;F22;L79
S0;DMNI_Send;2;9240;test_bench.dbs;T131;F22;L83
S0;DMNI_Receive;2;9512;test_bench.dbs;T131;F22;L83
S0;DMNI_Receive_Kernel;2;9784;test_bench.dbs;T131;F22;L83
S0;DMNI_Send_Kernel;2;10056;test_bench.dbs;T131;F22;L83
S0;SR;2;10328;test_bench.dbs;T130;F22;L86
S0;SR_Kernel;2;10600;test_bench.dbs;T130;F22;L86
S0;ARB;2;10872;test_bench.dbs;T132;F22;L89
S0;buffer;2;11144;test_bench.dbs;T44;F22;L91
S0;buffer_eop;2;17416;test_bench.dbs;T59;F22;L92
S0;buffer_high;2;22152;test_bench.dbs;T30;F22;L94
S0;buffer_aux;2;22544;test_bench.dbs;T22;F22;L95
S0;buffer_low;2;22936;test_bench.dbs;T30;F22;L96
S0;is_header;2;23328;test_bench.dbs;T59;F22;L98
S0;intr_count;2;28064;test_bench.dbs;T18;F22;L99
S0;first;2;28456;test_bench.dbs;T18;F22;L101
S0;last;2;28848;test_bench.dbs;T18;F22;L101
S0;add_buffer;2;29240;test_bench.dbs;T137;F22;L102
S0;payload_size;2;29536;test_bench.dbs;T22;F22;L105
S0;timer;2;29928;test_bench.dbs;T17;F22;L108
S0;address;2;30320;test_bench.dbs;T22;F22;L109
S0;address_2;2;30712;test_bench.dbs;T22;F22;L110
S0;size;2;31104;test_bench.dbs;T22;F22;L111
S0;size_2;2;31496;test_bench.dbs;T22;F22;L112
S0;send_address;2;31888;test_bench.dbs;T22;F22;L113
S0;send_address_2;2;32280;test_bench.dbs;T22;F22;L114
S0;send_size;2;32672;test_bench.dbs;T22;F22;L115
S0;send_size_2;2;33064;test_bench.dbs;T22;F22;L116
S0;recv_address;2;33456;test_bench.dbs;T22;F22;L117
S0;recv_size;2;33848;test_bench.dbs;T22;F22;L118
S0;address_svc_header_RAM;2;34240;test_bench.dbs;T22;F22;L119
S0;prio;2;34632;test_bench.dbs;T137;F22;L121
S0;operation;2;34928;test_bench.dbs;T137;F22;L122
S0;read_av;2;35224;test_bench.dbs;T137;F22;L123
S0;slot_available;2;35520;test_bench.dbs;T137;F22;L124
S0;read_enable;2;35816;test_bench.dbs;T137;F22;L125
S0;write_enable;2;36112;test_bench.dbs;T137;F22;L126
S0;cont;2;36408;test_bench.dbs;T137;F22;L128
S0;start_copy_kernel;2;36704;test_bench.dbs;T137;F22;L129
S0;flag_high;2;37000;test_bench.dbs;T18;F22;L130
S0;reset_counter;2;37392;test_bench.dbs;T18;F22;L131
S0;cont_size;2;37784;test_bench.dbs;T18;F22;L132
S0;data_in_aux;2;38176;test_bench.dbs;T30;F22;L133
S0;flag_size;2;38568;test_bench.dbs;T137;F22;L134
S0;flag_wait_kernel;2;38864;test_bench.dbs;T137;F22;L135
S0;reg_interrupt_received;2;39160;test_bench.dbs;T137;F22;L136
S0;reg_interrupt_received_wait;2;39456;test_bench.dbs;T137;F22;L137
V0;address_router;0;39752;test_bench.dbs;T30;F22;L193
N0;dmni;(sc_core::sc_module_nameregaddress,);test_bench.dbs;F22;L152
N0;mem_address_update;();dmni.dbs;F23;L114
N0;credit_o_update;();dmni.dbs;F23;L122
N0;arbiter;();dmni.dbs;F23;L34
N0;buffer_control;();dmni.dbs;F23;L126
N0;receive_master_kernel;();dmni.dbs;F23;L544
N0;send_master_kernel;();dmni.dbs;F23;L449
N0;send;();dmni.dbs;F23;L352
N0;receive;();dmni.dbs;F23;L143
N0;config;();dmni.dbs;F23;L94

T132;dmni::arbiter_state;2;0;4;4;0;0;<NONE>
E0;ROUND;0
E0;SEND;1
E0;RECEIVE;2

T131;dmni::dmni_state;2;0;4;4;0;0;<NONE>
E0;WAIT;0
E0;LOAD;1
E0;COPY_FROM_MEM;2
E0;COPY_TO_MEM;3
E0;END;4
E0;FAILED_RECEPTION;5

T130;dmni::state_noc;2;0;4;4;0;0;<NONE>
E0;HEADER;0
E0;HEADER2;1
E0;PAYLOAD_SIZE;2
E0;DATA;3
E0;SOURCE_ROUTING_HEADER;4

M129;fail_WRAPPER_module;19;13312;7248;7248;0;0;test_bench.dbs;F18;L21
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F18;L22
P0;reset;12;536;test_bench.dbs;T137;F18;L23
P0;in_fail_cpu_local;12;784;test_bench.dbs;T137;F18;L24
P0;in_fail_cpu_config;12;1032;test_bench.dbs;T137;F18;L25
P0;mem_address_service_fail_cpu;12;1280;test_bench.dbs;T22;F18;L26
P0;in_source_wrapper_local;12;1512;test_bench.dbs;T22;F18;L29
P0;in_target_wrapper_local;12;1744;test_bench.dbs;T30;F18;L30
P0;in_payload_wrapper_local;12;1976;test_bench.dbs;T15;F18;L31
P0;in_service_wrapper_local;12;2208;test_bench.dbs;T17;F18;L32
P0;in_req_wrapper_local;12;2440;test_bench.dbs;T137;F18;L33
P0;in_opmode_wrapper_local;12;2688;test_bench.dbs;T137;F18;L34
P0;in_fail_wrapper_local;12;2936;test_bench.dbs;T137;F18;L35
P0;out_ack_wrapper_local;20;3184;test_bench.dbs;T137;F18;L36
P0;out_nack_wrapper_local;20;3440;test_bench.dbs;T137;F18;L37
P0;out_source_wrapper_local;20;3696;test_bench.dbs;T22;F18;L41
P0;out_target_wrapper_local;20;3936;test_bench.dbs;T30;F18;L42
P0;out_payload_wrapper_local;20;4176;test_bench.dbs;T15;F18;L43
P0;out_service_wrapper_local;20;4416;test_bench.dbs;T17;F18;L44
P0;out_req_wrapper_local;20;4656;test_bench.dbs;T137;F18;L45
P0;out_opmode_wrapper_local;20;4912;test_bench.dbs;T137;F18;L46
P0;out_fail_wrapper_local;20;5168;test_bench.dbs;T137;F18;L47
P0;in_ack_wrapper_local;12;5424;test_bench.dbs;T137;F18;L48
P0;in_nack_wrapper_local;12;5672;test_bench.dbs;T137;F18;L49
S0;in_source_router;2;5920;test_bench.dbs;T22;F18;L51
S0;in_target_router;2;6312;test_bench.dbs;T30;F18;L52
S0;EA_in;2;6704;test_bench.dbs;T128;F18;L55
P0;tick_counter;12;6976;test_bench.dbs;T22;F18;L59
V0;address;0;7208;test_bench.dbs;T30;F18;L80
N0;fail_WRAPPER_module;(sc_core::sc_module_nameregaddress,);test_bench.dbs;F18;L69
N0;brNoC_monitor;();fail_wrapper_module.dbs;F19;L90
N0;in_proc_FSM;();fail_wrapper_module.dbs;F19;L27

T128;fail_WRAPPER_module::fila_in;2;0;4;4;0;0;<NONE>
E0;S_INIT_IN;0
E0;S_END;1

M127;fifo_PDN;19;13312;9128;9128;0;0;test_bench.dbs;F16;L21
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F16;L22
P0;reset;12;536;test_bench.dbs;T137;F16;L23
P0;in_source_fifo_seek;12;784;test_bench.dbs;T22;F16;L25
P0;in_target_fifo_seek;12;1016;test_bench.dbs;T30;F16;L26
P0;in_payload_fifo_seek;12;1248;test_bench.dbs;T15;F16;L27
P0;in_service_fifo_seek;12;1480;test_bench.dbs;T17;F16;L28
P0;in_reg_backtrack_seek;12;1712;test_bench.dbs;T22;F16;L29
P0;in_sel_reg_backtrack;12;1944;test_bench.dbs;T24;F16;L30
P0;in_req_fifo_seek;12;2176;test_bench.dbs;T137;F16;L31
P0;in_ack_fifo_seek;12;2424;test_bench.dbs;T137;F16;L32
P0;in_opmode_fifo_seek;12;2672;test_bench.dbs;T137;F16;L33
P0;in_fail_cpu;12;2920;test_bench.dbs;T137;F16;L35
P0;out_service_fifo_seek;20;3168;test_bench.dbs;T17;F16;L38
P0;out_source_fifo_seek;20;3408;test_bench.dbs;T22;F16;L39
P0;out_target_fifo_seek;20;3648;test_bench.dbs;T30;F16;L40
P0;out_payload_fifo_seek;20;3888;test_bench.dbs;T15;F16;L41
P0;out_sel_reg_backtrack_seek;20;4128;test_bench.dbs;T24;F16;L42
P0;out_reg_backtrack;20;4368;test_bench.dbs;T22;F16;L43
P0;out_req_pe;20;4608;test_bench.dbs;T137;F16;L44
P0;out_ack_fifo_seek;20;4864;test_bench.dbs;T137;F16;L45
P0;out_nack_fifo_seek;20;5120;test_bench.dbs;T137;F16;L46
P0;out_opmode_fifo_seek;20;5376;test_bench.dbs;T137;F16;L47
S0;out_req_send_kernel_seek_local;2;5632;test_bench.dbs;T137;F16;L50
S0;in_ack_send_kernel_seek_local;2;5928;test_bench.dbs;T137;F16;L51
S0;EA_in;2;6224;test_bench.dbs;T126;F16;L54
S0;EA_out;2;6496;test_bench.dbs;T125;F16;L57
V0;buffer_source;0;6768;test_bench.dbs;T20;F16;L60
V0;buffer_target;0;6928;test_bench.dbs;T28;F16;L61
V0;buffer_payload;0;7088;test_bench.dbs;T14;F16;L62
V0;buffer_service;0;7248;test_bench.dbs;T16;F16;L63
V0;buffer_opmode;0;7408;test_bench.dbs;T25;F16;L64
V0;buffer_backtrack1;0;7568;test_bench.dbs;T20;F16;L65
V0;buffer_backtrack2;0;7728;test_bench.dbs;T20;F16;L66
V0;buffer_backtrack3;0;7888;test_bench.dbs;T20;F16;L67
S0;first;2;8048;test_bench.dbs;T18;F16;L70
S0;last;2;8440;test_bench.dbs;T18;F16;L70
S0;tem_espaco_na_fila;2;8832;test_bench.dbs;T137;F16;L71
N0;fifo_PDN;(sc_core::sc_module_name);test_bench.dbs;F16;L81
N0;change_state_comb;();<NONE>
N0;change_state_sequ;();<NONE>
N0;out_proc_FSM;();fifo_pdn.dbs;F17;L158
N0;out_backtrack;();fifo_pdn.dbs;F17;L214
N0;in_proc_updPtr;();fifo_pdn.dbs;F17;L132
N0;in_proc_FSM;();fifo_pdn.dbs;F17;L23

T126;fifo_PDN::fila_in;2;0;4;4;0;0;<NONE>
E0;S_INIT_IN;0
E0;S_COPY_DATA;1
E0;S_COPY_DATA1;2
E0;S_COPY_DATA2;3
E0;S_ACK;4
E0;S_NACK;5
E0;S_WAIT_REQ_DOWN;6
E0;S_WAIT_SPACE;7

T125;fifo_PDN::fila_out;2;0;4;4;0;0;<NONE>
E0;S_INIT_OUT;0
E0;S_OUT_REQ;1
E0;S_WAIT_ACK;2
E0;S_WAIT_ACK_DOWN;3

M124;hemps;19;13312;1011120;1011120;0;0;test_bench.dbs;F28;L31
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F28;L33
P0;reset;12;536;test_bench.dbs;T137;F28;L34
P0;clock_tx_io;20;784;test_bench.dbs;T80;F28;L37
P0;tx_io;20;1296;test_bench.dbs;T80;F28;L38
P0;data_out_io;20;1808;test_bench.dbs;T74;F28;L39
P0;credit_i_io;12;2288;test_bench.dbs;T99;F28;L40
P0;eop_in_io;12;2784;test_bench.dbs;T99;F28;L41
P0;clock_rx_io;12;3280;test_bench.dbs;T99;F28;L43
P0;rx_io;12;3776;test_bench.dbs;T99;F28;L44
P0;data_in_io;12;4272;test_bench.dbs;T94;F28;L45
P0;credit_o_io;20;4736;test_bench.dbs;T80;F28;L46
P0;eop_out_io;20;5248;test_bench.dbs;T80;F28;L47
P0;in_source_router_seek_io;12;5760;test_bench.dbs;T90;F28;L50
P0;in_target_router_seek_io;12;6224;test_bench.dbs;T94;F28;L51
P0;in_payload_router_seek_io;12;6688;test_bench.dbs;T84;F28;L52
P0;in_service_router_seek_io;12;7152;test_bench.dbs;T87;F28;L53
P0;in_req_router_seek_io;12;7616;test_bench.dbs;T99;F28;L54
P0;in_ack_router_seek_io;12;8112;test_bench.dbs;T99;F28;L55
P0;in_nack_router_seek_io;12;8608;test_bench.dbs;T99;F28;L56
P0;in_opmode_router_seek_io;12;9104;test_bench.dbs;T99;F28;L57
P0;fail_in_io;12;9600;test_bench.dbs;T99;F28;L58
P0;fail_out_io;20;10096;test_bench.dbs;T80;F28;L59
P0;out_req_router_seek_io;20;10608;test_bench.dbs;T80;F28;L60
P0;out_ack_router_seek_io;20;11120;test_bench.dbs;T80;F28;L61
P0;out_nack_router_seek_io;20;11632;test_bench.dbs;T80;F28;L62
P0;out_opmode_router_seek_io;20;12144;test_bench.dbs;T80;F28;L63
P0;out_service_router_seek_io;20;12656;test_bench.dbs;T67;F28;L64
P0;out_source_router_seek_io;20;13136;test_bench.dbs;T70;F28;L65
P0;out_target_router_seek_io;20;13616;test_bench.dbs;T74;F28;L66
P0;out_payload_router_seek_io;20;14096;test_bench.dbs;T64;F28;L67
S0;sig_clock_tx_io;2;14576;test_bench.dbs;T58;F28;L70
S0;sig_tx_io;2;15168;test_bench.dbs;T58;F28;L71
S0;sig_data_out_io;2;15760;test_bench.dbs;T50;F28;L72
S0;sig_credit_i_io;2;16544;test_bench.dbs;T58;F28;L73
S0;sig_eop_in_io;2;17136;test_bench.dbs;T58;F28;L74
S0;sig_clock_rx_io;2;17728;test_bench.dbs;T58;F28;L76
S0;sig_rx_io;2;18320;test_bench.dbs;T58;F28;L77
S0;sig_data_in_io;2;18912;test_bench.dbs;T50;F28;L78
S0;sig_credit_o_io;2;19696;test_bench.dbs;T58;F28;L79
S0;sig_eop_out_io;2;20288;test_bench.dbs;T58;F28;L80
S0;sig_in_source_router_seek_io;2;20880;test_bench.dbs;T43;F28;L83
S0;sig_in_target_router_seek_io;2;21664;test_bench.dbs;T50;F28;L84
S0;sig_in_payload_router_seek_io;2;22448;test_bench.dbs;T36;F28;L85
S0;sig_in_service_router_seek_io;2;23232;test_bench.dbs;T40;F28;L86
S0;sig_in_req_router_seek_io;2;24016;test_bench.dbs;T58;F28;L87
S0;sig_in_ack_router_seek_io;2;24608;test_bench.dbs;T58;F28;L88
S0;sig_in_nack_router_seek_io;2;25200;test_bench.dbs;T58;F28;L89
S0;sig_in_opmode_router_seek_io;2;25792;test_bench.dbs;T58;F28;L90
S0;sig_fail_in_io;2;26384;test_bench.dbs;T58;F28;L91
S0;sig_fail_out_io;2;26976;test_bench.dbs;T58;F28;L92
S0;sig_out_req_router_seek_io;2;27568;test_bench.dbs;T58;F28;L93
S0;sig_out_ack_router_seek_io;2;28160;test_bench.dbs;T58;F28;L94
S0;sig_out_nack_router_seek_io;2;28752;test_bench.dbs;T58;F28;L95
S0;sig_out_opmode_router_seek_io;2;29344;test_bench.dbs;T58;F28;L96
S0;sig_out_service_router_seek_io;2;29936;test_bench.dbs;T40;F28;L97
S0;sig_out_source_router_seek_io;2;30720;test_bench.dbs;T43;F28;L98
S0;sig_out_target_router_seek_io;2;31504;test_bench.dbs;T50;F28;L99
S0;sig_out_payload_router_seek_io;2;32288;test_bench.dbs;T36;F28;L100
S0;clock_tx;2;33072;test_bench.dbs;T53;F28;L103
S0;tx;2;75696;test_bench.dbs;T53;F28;L104
S0;data_out;2;118320;test_bench.dbs;T46;F28;L105
S0;credit_i;2;174768;test_bench.dbs;T53;F28;L106
S0;eop_in;2;217392;test_bench.dbs;T53;F28;L107
S0;clock_rx;2;260016;test_bench.dbs;T53;F28;L109
S0;rx;2;302640;test_bench.dbs;T53;F28;L110
S0;data_in;2;345264;test_bench.dbs;T46;F28;L111
S0;credit_o;2;401712;test_bench.dbs;T53;F28;L112
S0;eop_out;2;444336;test_bench.dbs;T53;F28;L113
S0;in_source_router_seek;2;486960;test_bench.dbs;T41;F28;L115
S0;in_target_router_seek;2;512048;test_bench.dbs;T48;F28;L116
S0;in_payload_router_seek;2;537136;test_bench.dbs;T34;F28;L117
S0;in_service_router_seek;2;562224;test_bench.dbs;T38;F28;L118
S0;in_req_router_seek;2;587312;test_bench.dbs;T56;F28;L119
S0;in_ack_router_seek;2;606256;test_bench.dbs;T56;F28;L120
S0;in_nack_router_seek;2;625200;test_bench.dbs;T56;F28;L121
S0;in_opmode_router_seek;2;644144;test_bench.dbs;T56;F28;L122
S0;external_fail_in;2;663088;test_bench.dbs;T53;F28;L123
S0;external_fail_out;2;705712;test_bench.dbs;T53;F28;L124
S0;fail_out;2;748336;test_bench.dbs;T53;F28;L125
S0;fail_in;2;790960;test_bench.dbs;T53;F28;L126
S0;out_req_router_seek;2;833584;test_bench.dbs;T56;F28;L127
S0;out_ack_router_seek;2;852528;test_bench.dbs;T56;F28;L128
S0;out_nack_router_seek;2;871472;test_bench.dbs;T56;F28;L129
S0;out_opmode_router_seek;2;890416;test_bench.dbs;T56;F28;L130
S0;out_service_router_seek;2;909360;test_bench.dbs;T38;F28;L131
S0;out_source_router_seek;2;934448;test_bench.dbs;T41;F28;L132
S0;out_target_router_seek;2;959536;test_bench.dbs;T48;F28;L133
S0;out_payload_router_seek;2;984624;test_bench.dbs;T34;F28;L134
C0;PE[0];524321;1009712;test_bench.dbs;M108;F28;L136
C0;PE[1];524321;1009720;test_bench.dbs;M108;F28;L136
C0;PE[2];524321;1009728;test_bench.dbs;M108;F28;L136
C0;PE[3];524321;1009736;test_bench.dbs;M108;F28;L136
C0;PE[4];524321;1009744;test_bench.dbs;M108;F28;L136
C0;PE[5];524321;1009752;test_bench.dbs;M108;F28;L136
C0;PE[6];524321;1009760;test_bench.dbs;M108;F28;L136
C0;PE[7];524321;1009768;test_bench.dbs;M108;F28;L136
C0;PE[8];524321;1009776;test_bench.dbs;M108;F28;L136
C0;PE[9];524321;1009784;test_bench.dbs;M108;F28;L136
C0;PE[10];524321;1009792;test_bench.dbs;M108;F28;L136
C0;PE[11];524321;1009800;test_bench.dbs;M108;F28;L136
C0;PE[12];524321;1009808;test_bench.dbs;M108;F28;L136
C0;PE[13];524321;1009816;test_bench.dbs;M108;F28;L136
C0;PE[14];524321;1009824;test_bench.dbs;M108;F28;L136
C0;PE[15];524321;1009832;test_bench.dbs;M108;F28;L136
V0;i;0;1009840;test_bench.dbs;T116;F28;L138
V0;j;0;1009844;test_bench.dbs;T116;F28;L138
V0;r_addr;0;1009848;test_bench.dbs;T30;F28;L142
V0;faults;0;1009888;test_bench.dbs;T123;F28;L153
V0;pe_name;0;1011088;test_bench.dbs;T135;F28;L155
V0;x_addr;0;1011108;test_bench.dbs;T116;F28;L156
V0;y_addr;0;1011112;test_bench.dbs;T116;F28;L156
N0;hemps;(sc_core::sc_module_name);test_bench.dbs;F28;L157
N0;test_faults_inserted;(<unnamed>);hemps.dbs;F29;L117
N0;fault_injection;();hemps.dbs;F29;L134
N0;io_interconnection;();hemps.dbs;F29;L205
N0;pes_interconnection;();hemps.dbs;F29;L249
N0;RouterAddress;(<unnamed>);hemps.dbs;F29;L67
N0;RouterPosition;(<unnamed>);hemps.dbs;F29;L17

T123;hemps::struct_faults;0;0;1200;1200;0;0;test_bench.dbs;F28;L149
V0;pe;0;0;test_bench.dbs;T115;F28;L150
V0;port;0;400;test_bench.dbs;T115;F28;L151
V0;time;0;800;test_bench.dbs;T115;F28;L152

M122;injector;19;13312;2116872;2116872;0;0;test_bench.dbs;F4;L48
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F4;L49
P0;reset;12;536;test_bench.dbs;T137;F4;L50
P0;in_source_router_seek_primary;12;784;test_bench.dbs;T22;F4;L54
P0;in_target_router_seek_primary;12;1016;test_bench.dbs;T30;F4;L55
P0;in_payload_router_seek_primary;12;1248;test_bench.dbs;T15;F4;L56
P0;in_service_router_seek_primary;12;1480;test_bench.dbs;T17;F4;L57
P0;in_req_router_seek_primary;12;1712;test_bench.dbs;T137;F4;L58
P0;in_ack_router_seek_primary;12;1960;test_bench.dbs;T137;F4;L59
P0;in_opmode_router_seek_primary;12;2208;test_bench.dbs;T137;F4;L60
P0;out_service_router_seek_primary;20;2456;test_bench.dbs;T17;F4;L62
P0;out_source_router_seek_primary;20;2696;test_bench.dbs;T22;F4;L63
P0;out_target_router_seek_primary;20;2936;test_bench.dbs;T30;F4;L64
P0;out_payload_router_seek_primary;20;3176;test_bench.dbs;T15;F4;L65
P0;out_ack_router_seek_primary;20;3416;test_bench.dbs;T137;F4;L66
P0;out_req_router_seek_primary;20;3672;test_bench.dbs;T137;F4;L67
P0;out_nack_router_seek_primary;20;3928;test_bench.dbs;T137;F4;L68
P0;out_opmode_router_seek_primary;20;4184;test_bench.dbs;T137;F4;L69
P0;clock_tx_primary;20;4440;test_bench.dbs;T137;F4;L72
P0;tx_primary;20;4696;test_bench.dbs;T137;F4;L73
P0;data_out_primary;20;4952;test_bench.dbs;T30;F4;L74
P0;credit_i_primary;12;5192;test_bench.dbs;T137;F4;L75
P0;eop_in_primary;12;5440;test_bench.dbs;T137;F4;L76
P0;clock_rx_primary;12;5688;test_bench.dbs;T137;F4;L78
P0;rx_primary;12;5936;test_bench.dbs;T137;F4;L79
P0;data_in_primary;12;6184;test_bench.dbs;T30;F4;L80
P0;credit_o_primary;20;6416;test_bench.dbs;T137;F4;L81
P0;eop_out_primary;20;6672;test_bench.dbs;T137;F4;L82
P0;in_source_router_seek_secondary;12;6928;test_bench.dbs;T22;F4;L86
P0;in_target_router_seek_secondary;12;7160;test_bench.dbs;T30;F4;L87
P0;in_payload_router_seek_secondary;12;7392;test_bench.dbs;T15;F4;L88
P0;in_service_router_seek_secondary;12;7624;test_bench.dbs;T17;F4;L89
P0;in_req_router_seek_secondary;12;7856;test_bench.dbs;T137;F4;L90
P0;in_ack_router_seek_secondary;12;8104;test_bench.dbs;T137;F4;L91
P0;in_opmode_router_seek_secondary;12;8352;test_bench.dbs;T137;F4;L92
P0;out_service_router_seek_secondary;20;8600;test_bench.dbs;T17;F4;L94
P0;out_source_router_seek_secondary;20;8840;test_bench.dbs;T22;F4;L95
P0;out_target_router_seek_secondary;20;9080;test_bench.dbs;T30;F4;L96
P0;out_payload_router_seek_secondary;20;9320;test_bench.dbs;T15;F4;L97
P0;out_ack_router_seek_secondary;20;9560;test_bench.dbs;T137;F4;L98
P0;out_req_router_seek_secondary;20;9816;test_bench.dbs;T137;F4;L99
P0;out_nack_router_seek_secondary;20;10072;test_bench.dbs;T137;F4;L100
P0;out_opmode_router_seek_secondary;20;10328;test_bench.dbs;T137;F4;L101
P0;clock_tx_secondary;20;10584;test_bench.dbs;T137;F4;L104
P0;tx_secondary;20;10840;test_bench.dbs;T137;F4;L105
P0;data_out_secondary;20;11096;test_bench.dbs;T30;F4;L106
P0;credit_i_secondary;12;11336;test_bench.dbs;T137;F4;L107
P0;eop_in_secondary;12;11584;test_bench.dbs;T137;F4;L108
P0;clock_rx_secondary;12;11832;test_bench.dbs;T137;F4;L109
P0;rx_secondary;12;12080;test_bench.dbs;T137;F4;L110
P0;data_in_secondary;12;12328;test_bench.dbs;T30;F4;L111
P0;credit_o_secondary;20;12560;test_bench.dbs;T137;F4;L112
P0;eop_out_secondary;20;12816;test_bench.dbs;T137;F4;L113
S0;EA_in_datanoc;2;13072;test_bench.dbs;T120;F4;L118
S0;EA_out_datanoc;2;13344;test_bench.dbs;T117;F4;L121
S0;EA_in_brnoc;2;13616;test_bench.dbs;T121;F4;L124
S0;EA_out_brnoc;2;13888;test_bench.dbs;T118;F4;L127
S0;EA_manager;2;14160;test_bench.dbs;T119;F4;L130
V0;buffer_in_flit;0;14432;test_bench.dbs;T29;F4;L132
V0;buffer_out_flit;0;15712;test_bench.dbs;T27;F4;L133
V0;reg_header;0;18272;test_bench.dbs;T30;F4;L135
V0;reg_msg_size;0;18312;test_bench.dbs;T30;F4;L136
V0;reg_service;0;18352;test_bench.dbs;T30;F4;L137
V0;reg_peripheral_ID;0;18392;test_bench.dbs;T30;F4;L138
V0;reg_task_ID;0;18432;test_bench.dbs;T30;F4;L139
V0;reg_source_PE;0;18472;test_bench.dbs;T30;F4;L140
V0;reg_mapped_tasks;0;18512;test_bench.dbs;T30;F4;L141
V0;IO_request;0;18552;test_bench.dbs;T26;F4;L143
V0;flit_in_counter;0;18592;test_bench.dbs;T22;F4;L144
V0;app_tasks;0;18632;test_bench.dbs;T138;F4;L146
V0;repository_txt;0;18672;test_bench.dbs;T5;F4;L147
V0;appstart;0;2115824;test_bench.dbs;T2;F4;L148
V0;task_number;0;2115864;test_bench.dbs;T116;F4;L149
V0;packet_size;0;2115868;test_bench.dbs;T116;F4;L149
V0;tasks_sent;0;2115872;test_bench.dbs;T116;F4;L149
V0;tasks_map_received;0;2115876;test_bench.dbs;T116;F4;L149
V0;flag_map_received;0;2115880;test_bench.dbs;T116;F4;L149
V0;current_time;0;2115884;test_bench.dbs;T10;F4;L152
V0;app_i;0;2115888;test_bench.dbs;T116;F4;L153
V0;app_count;0;2115892;test_bench.dbs;T116;F4;L153
V0;app_index;0;2115896;test_bench.dbs;T116;F4;L153
V0;repo_address;0;2115900;test_bench.dbs;T116;F4;L153
V0;aux;0;2115904;test_bench.dbs;T116;F4;L153
V0;flit_out_counter;0;2115908;test_bench.dbs;T116;F4;L155
V0;i;0;2115912;test_bench.dbs;T116;F4;L155
V0;need_to_clear;0;2115916;test_bench.dbs;T116;F4;L155
V0;global_master_location;0;2115920;test_bench.dbs;T116;F4;L155
V0;id_io;0;2115924;test_bench.dbs;T116;F4;L155
V0;buf_task_info;0;2115928;test_bench.dbs;T9;F4;L158
V0;app_start_time;0;2116344;test_bench.dbs;T21;F4;L160
V0;app_initial_address;0;2116424;test_bench.dbs;T21;F4;L161
V0;app_number_of_tasks;0;2116504;test_bench.dbs;T21;F4;L162
V0;app_status;0;2116584;test_bench.dbs;T21;F4;L163
V0;app_master_location;0;2116664;test_bench.dbs;T21;F4;L164
V0;app_ID;0;2116744;test_bench.dbs;T21;F4;L165
V0;address_to_clear;0;2116824;test_bench.dbs;T22;F4;L167
V0;io_id;0;2116864;test_bench.dbs;T116;F4;L218
N0;injector;(sc_core::sc_module_name<unnamed>,);test_bench.dbs;F4;L187
N0;current_time_inc;();injector.dbs;F5;L423
N0;new_app;();injector.dbs;F5;L504
N0;load_appstart_repository;();injector.dbs;F5;L431
N0;change_state_comb;();<NONE>
N0;change_state_sequ;();<NONE>
N0;brnoc_out_proc_FSM;();injector.dbs;F5;L76
N0;brnoc_in_proc_FSM;();injector.dbs;F5;L18
N0;datanoc_out_proc_FSM;();injector.dbs;F5;L211
N0;datanoc_in_proc_FSM;();injector.dbs;F5;L128

T121;injector::FSM_in_brnoc;2;0;4;4;0;0;<NONE>
E0;S_INIT;0
E0;S_GMV_RECEIVE;1
E0;S_ACK_NEW_APP_RECEIVE;2
E0;S_ACK;3
E0;S_WAIT_REQ_DOWN;4

T120;injector::FSM_in_datanoc;2;0;4;4;0;0;<NONE>
E0;S_INIT_IN;0
E0;S_RECEIVE_HEADER;1
E0;S_PAYLOAD;2
E0;S_SERVICE;3
E0;S_WAIT;4

T119;injector::FSM_manager;2;0;4;4;0;0;<NONE>
E0;S_WAITING_GM_READY;0
E0;S_WAIT_LMP_LOCATION;1
E0;S_INIT_MANAGER;2
E0;S_WAITING_GM;3
E0;S_WAITING_MAP;4
E0;S_SENDING_TASKS;5
E0;S_WAIT_SEND_DESCRIPTOR;6

T118;injector::FSM_out_brnoc;2;0;4;4;0;0;<NONE>
E0;S_WAIT_INIT;0
E0;S_WAIT_ACK;1
E0;S_ACK_DOWN;2
E0;S_CLEAR;3
E0;S_NEW_APP;4

T117;injector::FSM_out_datanoc;2;0;4;4;0;0;<NONE>
E0;S_INIT_DATANOC;0
E0;S_SEND_HEADER;1
E0;S_SEND_PAYLOAD_HIGH;2
E0;S_SEND_PAYLOAD_LOW;3
E0;S_WAIT_CREDIT_HEADER;4
E0;S_WAIT_CREDIT_PAYLOAD_LOW;5
E0;S_WAIT_CREDIT_PAYLOAD_HIGH;6
E0;S_SEND_EOP;7
E0;S_SEND_DESCRIPTOR;8
E0;S_SEND_TASK;9
E0;S_END_SEND_TASK;10

T116;int;5;0;4;4;0;0;<NONE>

T115;int[100];20;0;4;400;100;0;<NONE>;T116

M114;io_peripheral;19;134231040;11760;11760;0;0;io_peripheral.dbs;F2;L21
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;io_peripheral.dbs;T137;F2;L22
P0;reset;12;536;io_peripheral.dbs;T137;F2;L23
P0;in_source_router_seek_primary;12;784;io_peripheral.dbs;T22;F2;L26
P0;in_target_router_seek_primary;12;1016;io_peripheral.dbs;T30;F2;L27
P0;in_payload_router_seek_primary;12;1248;io_peripheral.dbs;T15;F2;L28
P0;in_service_router_seek_primary;12;1480;io_peripheral.dbs;T17;F2;L29
P0;in_req_router_seek_primary;12;1712;io_peripheral.dbs;T137;F2;L30
P0;in_ack_router_seek_primary;12;1960;io_peripheral.dbs;T137;F2;L31
P0;in_opmode_router_seek_primary;12;2208;io_peripheral.dbs;T137;F2;L32
P0;out_service_router_seek_primary;20;2456;io_peripheral.dbs;T17;F2;L34
P0;out_source_router_seek_primary;20;2696;io_peripheral.dbs;T22;F2;L35
P0;out_target_router_seek_primary;20;2936;io_peripheral.dbs;T30;F2;L36
P0;out_payload_router_seek_primary;20;3176;io_peripheral.dbs;T15;F2;L37
P0;out_ack_router_seek_primary;20;3416;io_peripheral.dbs;T137;F2;L38
P0;out_req_router_seek_primary;20;3672;io_peripheral.dbs;T137;F2;L39
P0;out_nack_router_seek_primary;20;3928;io_peripheral.dbs;T137;F2;L40
P0;out_opmode_router_seek_primary;20;4184;io_peripheral.dbs;T137;F2;L41
P0;clock_tx_primary;20;4440;io_peripheral.dbs;T137;F2;L44
P0;tx_primary;20;4696;io_peripheral.dbs;T137;F2;L45
P0;data_out_primary;20;4952;io_peripheral.dbs;T30;F2;L46
P0;credit_i_primary;12;5192;io_peripheral.dbs;T137;F2;L47
P0;eop_in_primary;12;5440;io_peripheral.dbs;T137;F2;L48
P0;clock_rx_primary;12;5688;io_peripheral.dbs;T137;F2;L50
P0;rx_primary;12;5936;io_peripheral.dbs;T137;F2;L51
P0;data_in_primary;12;6184;io_peripheral.dbs;T30;F2;L52
P0;credit_o_primary;20;6416;io_peripheral.dbs;T137;F2;L53
P0;eop_out_primary;20;6672;io_peripheral.dbs;T137;F2;L54
S0;EA_in;2;6928;io_peripheral.dbs;T113;F2;L58
S0;EA_out;2;7200;io_peripheral.dbs;T112;F2;L61
V0;buffer_in_flit;0;7472;io_peripheral.dbs;T29;F2;L64
V0;buffer_out_flit;0;8752;io_peripheral.dbs;T27;F2;L65
V0;reg_header;0;11312;io_peripheral.dbs;T30;F2;L67
V0;reg_msg_size;0;11352;io_peripheral.dbs;T30;F2;L68
V0;reg_service;0;11392;io_peripheral.dbs;T30;F2;L69
V0;reg_peripheral_ID;0;11432;io_peripheral.dbs;T30;F2;L70
V0;reg_task_ID;0;11472;io_peripheral.dbs;T30;F2;L71
V0;reg_source_PE;0;11512;io_peripheral.dbs;T30;F2;L72
V0;IO_request;0;11552;io_peripheral.dbs;T26;F2;L74
V0;IO_ack;0;11592;io_peripheral.dbs;T26;F2;L75
V0;flit_in_counter;0;11632;io_peripheral.dbs;T15;F2;L76
V0;flit_out_counter;0;11672;io_peripheral.dbs;T15;F2;L77
V0;packet_size;0;11712;io_peripheral.dbs;T22;F2;L78
V0;io_id;0;11752;io_peripheral.dbs;T116;F2;L103
N0;in_proc_FSM;();io_peripheral.dbs;F3;L18
N0;out_proc_FSM;();io_peripheral.dbs;F3;L110
N0;change_state_sequ;();<NONE>
N0;change_state_comb;();<NONE>
N0;seek_ack;();io_peripheral.dbs;F3;L262
N0;io_peripheral;(sc_core::sc_module_name<unnamed>,);io_peripheral.dbs;F2;L90

T113;io_peripheral::FSM_in;2;134217728;4;4;0;0;<NONE>
E0;S_INIT_IN;0
E0;S_RECEIVE;1
E0;S_WAIT;2
E0;S_SERVICE;3
E0;S_PAYLOAD;4

T112;io_peripheral::FSM_out;2;134217728;4;4;0;0;<NONE>
E0;S_WAIT_REQ;0
E0;S_SEND_HEADER;1
E0;S_SEND_PAYLOAD;2
E0;S_WAIT_CREDIT_PAYLOAD;3
E0;S_WAIT_CREDIT_HEADER;4
E0;S_SEND_EOP;5

T111;long;6;0;8;8;0;0;<NONE>

T110;long[32];20;0;8;256;32;0;<NONE>;T111

M109;mlite_cpu;19;13312;3224;3224;0;0;test_bench.dbs;F12;L34
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clk;12;288;test_bench.dbs;T137;F12;L36
P0;reset_in;12;536;test_bench.dbs;T137;F12;L37
P0;intr_in;12;784;test_bench.dbs;T137;F12;L38
P0;mem_pause;12;1032;test_bench.dbs;T137;F12;L39
P0;mem_address;20;1280;test_bench.dbs;T22;F12;L41
P0;mem_data_w;20;1520;test_bench.dbs;T22;F12;L42
P0;mem_data_r;12;1760;test_bench.dbs;T22;F12;L43
P0;mem_byte_we;20;1992;test_bench.dbs;T18;F12;L44
P0;current_page;20;2232;test_bench.dbs;T15;F12;L46
V0;state;0;2472;test_bench.dbs;T143;F12;L49
V0;state_instance;0;2480;test_bench.dbs;T140;F12;L49
V0;opcode;0;2776;test_bench.dbs;T10;F12;L51
V0;prefetched_opcode;0;2780;test_bench.dbs;T10;F12;L51
V0;pc_last;0;2784;test_bench.dbs;T10;F12;L51
V0;op;0;2788;test_bench.dbs;T10;F12;L52
V0;rs;0;2792;test_bench.dbs;T10;F12;L52
V0;rt;0;2796;test_bench.dbs;T10;F12;L52
V0;rd;0;2800;test_bench.dbs;T10;F12;L52
V0;re;0;2804;test_bench.dbs;T10;F12;L52
V0;func;0;2808;test_bench.dbs;T10;F12;L52
V0;imm;0;2812;test_bench.dbs;T10;F12;L52
V0;target;0;2816;test_bench.dbs;T10;F12;L52
V0;imm_shift;0;2820;test_bench.dbs;T116;F12;L53
V0;r;0;2824;test_bench.dbs;T143;F12;L54
V0;word_addr;0;2832;test_bench.dbs;T116;F12;L54
V0;u;0;2840;test_bench.dbs;T143;F12;L55
V0;ptr;0;2848;test_bench.dbs;T10;F12;L56
V0;page;0;2852;test_bench.dbs;T10;F12;L56
V0;byte_write;0;2856;test_bench.dbs;T10;F12;L56
V0;big_endian;0;2860;test_bench.dbs;T12;F12;L57
V0;shift;0;2861;test_bench.dbs;T12;F12;L57
V0;byte_en;0;2864;test_bench.dbs;T18;F12;L58
V0;intr_enable;0;2904;test_bench.dbs;T137;F12;L60
V0;prefetch;0;2905;test_bench.dbs;T137;F12;L60
V0;jump_or_branch;0;2906;test_bench.dbs;T137;F12;L60
V0;no_execute_branch_delay_slot;0;2907;test_bench.dbs;T137;F12;L60
V0;pc_count;0;2912;test_bench.dbs;T7;F12;L62
V0;global_inst;0;2920;test_bench.dbs;T7;F12;L64
V0;logical_inst;0;2928;test_bench.dbs;T7;F12;L65
V0;branch_inst;0;2936;test_bench.dbs;T7;F12;L66
V0;jump_inst;0;2944;test_bench.dbs;T7;F12;L67
V0;move_inst;0;2952;test_bench.dbs;T7;F12;L68
V0;other_inst;0;2960;test_bench.dbs;T7;F12;L69
V0;arith_inst;0;2968;test_bench.dbs;T7;F12;L70
V0;load_inst;0;2976;test_bench.dbs;T7;F12;L71
V0;shift_inst;0;2984;test_bench.dbs;T7;F12;L72
V0;nop_inst;0;2992;test_bench.dbs;T7;F12;L73
V0;mult_div_inst;0;3000;test_bench.dbs;T7;F12;L74
V0;global_inst_kernel;0;3008;test_bench.dbs;T7;F12;L77
V0;logical_inst_kernel;0;3016;test_bench.dbs;T7;F12;L78
V0;branch_inst_kernel;0;3024;test_bench.dbs;T7;F12;L79
V0;jump_inst_kernel;0;3032;test_bench.dbs;T7;F12;L80
V0;move_inst_kernel;0;3040;test_bench.dbs;T7;F12;L81
V0;other_inst_kernel;0;3048;test_bench.dbs;T7;F12;L82
V0;arith_inst_kernel;0;3056;test_bench.dbs;T7;F12;L83
V0;load_inst_kernel;0;3064;test_bench.dbs;T7;F12;L84
V0;shift_inst_kernel;0;3072;test_bench.dbs;T7;F12;L85
V0;nop_inst_kernel;0;3080;test_bench.dbs;T7;F12;L86
V0;mult_div_inst_kernel;0;3088;test_bench.dbs;T7;F12;L87
V0;global_inst_tasks;0;3096;test_bench.dbs;T7;F12;L91
V0;logical_inst_tasks;0;3104;test_bench.dbs;T7;F12;L92
V0;branch_inst_tasks;0;3112;test_bench.dbs;T7;F12;L93
V0;jump_inst_tasks;0;3120;test_bench.dbs;T7;F12;L94
V0;move_inst_tasks;0;3128;test_bench.dbs;T7;F12;L95
V0;other_inst_tasks;0;3136;test_bench.dbs;T7;F12;L96
V0;arith_inst_tasks;0;3144;test_bench.dbs;T7;F12;L97
V0;load_inst_tasks;0;3152;test_bench.dbs;T7;F12;L98
V0;shift_inst_tasks;0;3160;test_bench.dbs;T7;F12;L99
V0;nop_inst_tasks;0;3168;test_bench.dbs;T7;F12;L100
V0;mult_div_inst_tasks;0;3176;test_bench.dbs;T7;F12;L101
V0;address_router;0;3184;test_bench.dbs;T15;F12;L128
N0;mlite_cpu;(sc_core::sc_module_nameregmetadeflit,);test_bench.dbs;F12;L113
N0;mult_big_signed;(<unnamed><unnamed>,);mlite_cpu.dbs;F13;L1459
N0;mult_big;(<unnamed><unnamed>,);mlite_cpu.dbs;F13;L1433
N0;mlite;();mlite_cpu.dbs;F13;L31

M108;pe;19;13312;130472;130472;0;0;test_bench.dbs;F24;L20
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F24;L22
P0;reset;12;536;test_bench.dbs;T137;F24;L23
S0;clock_hold;2;784;test_bench.dbs;T137;F24;L24
S0;reset_plasma;2;1080;test_bench.dbs;T137;F24;L25
S0;reset_cpu_fail;2;1376;test_bench.dbs;T137;F24;L26
S0;reset_plasma_from_dmni;2;1672;test_bench.dbs;T137;F24;L27
S0;clock_aux;2;1968;test_bench.dbs;T137;F24;L28
S0;clock_wait_kernel;2;2264;test_bench.dbs;T137;F24;L29
P0;clock_tx;20;2560;test_bench.dbs;T77;F24;L32
P0;tx;20;4864;test_bench.dbs;T77;F24;L33
P0;data_out;20;7168;test_bench.dbs;T71;F24;L34
P0;credit_i;12;9328;test_bench.dbs;T96;F24;L35
P0;eop_in;12;11560;test_bench.dbs;T96;F24;L36
P0;clock_rx;12;13792;test_bench.dbs;T96;F24;L38
P0;rx;12;16024;test_bench.dbs;T96;F24;L39
P0;data_in;12;18256;test_bench.dbs;T91;F24;L40
P0;credit_o;20;20344;test_bench.dbs;T77;F24;L41
P0;eop_out;20;22648;test_bench.dbs;T77;F24;L42
P0;fail_in;12;24952;test_bench.dbs;T96;F24;L45
P0;fail_out;20;27184;test_bench.dbs;T77;F24;L46
P0;external_fail_in;12;29488;test_bench.dbs;T96;F24;L47
P0;external_fail_out;12;31720;test_bench.dbs;T96;F24;L48
S0;router_fail_out;2;33952;test_bench.dbs;T61;F24;L49
S0;router_fail_in;2;36912;test_bench.dbs;T61;F24;L50
P0;in_source_router_seek;12;39872;test_bench.dbs;T89;F24;L52
P0;in_target_router_seek;12;40800;test_bench.dbs;T93;F24;L53
P0;in_payload_router_seek;12;41728;test_bench.dbs;T83;F24;L54
P0;in_service_router_seek;12;42656;test_bench.dbs;T86;F24;L55
P0;in_req_router_seek;12;43584;test_bench.dbs;T98;F24;L56
P0;in_ack_router_seek;12;44576;test_bench.dbs;T98;F24;L57
P0;in_nack_router_seek;12;45568;test_bench.dbs;T98;F24;L58
P0;in_opmode_router_seek;12;46560;test_bench.dbs;T98;F24;L59
P0;out_req_router_seek;20;47552;test_bench.dbs;T79;F24;L60
P0;out_ack_router_seek;20;48576;test_bench.dbs;T79;F24;L61
P0;out_nack_router_seek;20;49600;test_bench.dbs;T79;F24;L62
P0;out_opmode_router_seek;20;50624;test_bench.dbs;T79;F24;L63
P0;out_service_router_seek;20;51648;test_bench.dbs;T66;F24;L64
P0;out_source_router_seek;20;52608;test_bench.dbs;T69;F24;L65
P0;out_target_router_seek;20;53568;test_bench.dbs;T73;F24;L66
P0;out_payload_router_seek;20;54528;test_bench.dbs;T63;F24;L67
S0;in_source_router_seek_local;2;55488;test_bench.dbs;T22;F24;L68
S0;in_target_router_seek_local;2;55880;test_bench.dbs;T30;F24;L69
S0;in_payload_router_seek_local;2;56272;test_bench.dbs;T15;F24;L70
S0;in_service_router_seek_local;2;56664;test_bench.dbs;T17;F24;L71
S0;in_req_router_seek_local;2;57056;test_bench.dbs;T137;F24;L72
S0;in_ack_router_seek_local;2;57352;test_bench.dbs;T137;F24;L73
S0;in_opmode_router_seek_local;2;57648;test_bench.dbs;T137;F24;L75
S0;in_fail_router_seek_local;2;57944;test_bench.dbs;T137;F24;L76
S0;out_req_router_seek_local;2;58240;test_bench.dbs;T137;F24;L77
S0;out_ack_router_seek_local;2;58536;test_bench.dbs;T137;F24;L78
S0;out_nack_router_seek_local;2;58832;test_bench.dbs;T137;F24;L79
S0;out_opmode_router_seek_local;2;59128;test_bench.dbs;T137;F24;L80
S0;out_service_router_seek_local;2;59424;test_bench.dbs;T17;F24;L81
S0;out_source_router_seek_local;2;59816;test_bench.dbs;T22;F24;L82
S0;out_target_router_seek_local;2;60208;test_bench.dbs;T30;F24;L83
S0;out_payload_router_seek_local;2;60600;test_bench.dbs;T15;F24;L84
S0;in_source_wrapper_local;2;60992;test_bench.dbs;T22;F24;L86
S0;in_target_wrapper_local;2;61384;test_bench.dbs;T30;F24;L87
S0;in_payload_wrapper_local;2;61776;test_bench.dbs;T15;F24;L88
S0;in_service_wrapper_local;2;62168;test_bench.dbs;T17;F24;L89
S0;in_req_wrapper_local;2;62560;test_bench.dbs;T137;F24;L90
S0;out_ack_wrapper_local;2;62856;test_bench.dbs;T137;F24;L91
S0;out_nack_wrapper_local;2;63152;test_bench.dbs;T137;F24;L92
S0;in_opmode_wrapper_local;2;63448;test_bench.dbs;T137;F24;L93
S0;in_fail_wrapper_local;2;63744;test_bench.dbs;T137;F24;L94
S0;in_source_fifopdn_local;2;64040;test_bench.dbs;T22;F24;L95
S0;in_target_fifopdn_local;2;64432;test_bench.dbs;T30;F24;L96
S0;in_payload_fifopdn_local;2;64824;test_bench.dbs;T15;F24;L97
S0;in_service_fifopdn_local;2;65216;test_bench.dbs;T17;F24;L98
S0;in_req_fifopdn_local;2;65608;test_bench.dbs;T137;F24;L99
S0;in_ack_fifopdn_local;2;65904;test_bench.dbs;T137;F24;L100
S0;in_nack_fifopdn_local;2;66200;test_bench.dbs;T137;F24;L101
S0;in_opmode_fifopdn_local;2;66496;test_bench.dbs;T137;F24;L102
S0;in_fail_fifopdn_local;2;66792;test_bench.dbs;T137;F24;L103
S0;out_req_fifopdn_local;2;67088;test_bench.dbs;T137;F24;L104
S0;out_ack_fifopdn_local;2;67384;test_bench.dbs;T137;F24;L105
S0;out_nack_fifopdn_local;2;67680;test_bench.dbs;T137;F24;L106
S0;out_opmode_fifopdn_local;2;67976;test_bench.dbs;T137;F24;L107
S0;out_service_fifopdn_local;2;68272;test_bench.dbs;T17;F24;L108
S0;out_source_fifopdn_local;2;68664;test_bench.dbs;T22;F24;L109
S0;out_target_fifopdn_local;2;69056;test_bench.dbs;T30;F24;L110
S0;out_payload_fifopdn_local;2;69448;test_bench.dbs;T15;F24;L111
S0;out_sel_reg_backtrack_fifopdn_local;2;69840;test_bench.dbs;T24;F24;L112
S0;in_reg_backtrack_fifopdn_local;2;70232;test_bench.dbs;T22;F24;L113
S0;in_sel_reg_backtrack_seek_local;2;70624;test_bench.dbs;T24;F24;L115
S0;out_reg_backtrack_seek_local;2;71016;test_bench.dbs;T22;F24;L116
S0;out_req_send_kernel_seek_local;2;71408;test_bench.dbs;T137;F24;L118
S0;in_ack_send_kernel_seek_local;2;71704;test_bench.dbs;T137;F24;L119
S0;cpu_mem_address_reg;2;72000;test_bench.dbs;T22;F24;L122
S0;cpu_mem_data_write_reg;2;72392;test_bench.dbs;T22;F24;L123
S0;cpu_mem_write_byte_enable_reg;2;72784;test_bench.dbs;T18;F24;L124
S0;irq_mask_reg;2;73176;test_bench.dbs;T15;F24;L125
S0;irq_status;2;73568;test_bench.dbs;T15;F24;L126
S0;irq;2;73960;test_bench.dbs;T137;F24;L127
S0;time_slice;2;74256;test_bench.dbs;T22;F24;L128
S0;write_enable;2;74648;test_bench.dbs;T137;F24;L129
S0;tick_counter_local;2;74944;test_bench.dbs;T22;F24;L130
S0;tick_counter;2;75336;test_bench.dbs;T22;F24;L131
S0;current_page;2;75728;test_bench.dbs;T15;F24;L132
S0;cpu_mem_address;2;76120;test_bench.dbs;T22;F24;L134
S0;cpu_mem_data_write;2;76512;test_bench.dbs;T22;F24;L135
S0;cpu_mem_data_read;2;76904;test_bench.dbs;T22;F24;L136
S0;cpu_mem_write_byte_enable;2;77296;test_bench.dbs;T18;F24;L137
S0;cpu_mem_pause;2;77688;test_bench.dbs;T137;F24;L138
S0;cpu_enable_ram;2;77984;test_bench.dbs;T137;F24;L139
S0;cpu_set_size;2;78280;test_bench.dbs;T137;F24;L140
S0;cpu_set_address;2;78576;test_bench.dbs;T137;F24;L141
S0;cpu_set_size_2;2;78872;test_bench.dbs;T137;F24;L142
S0;cpu_set_address_2;2;79168;test_bench.dbs;T137;F24;L143
S0;cpu_set_op;2;79464;test_bench.dbs;T137;F24;L144
S0;cpu_start;2;79760;test_bench.dbs;T137;F24;L145
S0;cpu_send_kernel;2;80056;test_bench.dbs;T137;F24;L146
S0;cpu_wait_kernel;2;80352;test_bench.dbs;T137;F24;L147
S0;cpu_fail_kernel;2;80648;test_bench.dbs;T137;F24;L148
S0;cpu_ack;2;80944;test_bench.dbs;T137;F24;L149
S0;data_read_ram;2;81240;test_bench.dbs;T22;F24;L152
S0;mem_data_read;2;81632;test_bench.dbs;T22;F24;L153
S0;mem_address_service_header_kernel;2;82024;test_bench.dbs;T22;F24;L154
S0;ni_intr;2;82416;test_bench.dbs;T137;F24;L157
S0;clock_tx_ni;2;82712;test_bench.dbs;T137;F24;L159
S0;tx_ni;2;83008;test_bench.dbs;T137;F24;L160
S0;data_out_ni;2;83304;test_bench.dbs;T22;F24;L161
S0;credit_i_ni;2;83696;test_bench.dbs;T137;F24;L162
S0;clock_rx_ni;2;83992;test_bench.dbs;T137;F24;L163
S0;rx_ni;2;84288;test_bench.dbs;T137;F24;L164
S0;data_in_ni;2;84584;test_bench.dbs;T30;F24;L165
S0;credit_o_ni;2;84976;test_bench.dbs;T137;F24;L166
S0;eop_out_ni;2;85272;test_bench.dbs;T137;F24;L167
S0;eop_in_ni;2;85568;test_bench.dbs;T137;F24;L168
S0;tx_sender;2;85864;test_bench.dbs;T137;F24;L172
S0;data_out_sender;2;86160;test_bench.dbs;T30;F24;L173
S0;credit_i_sender;2;86552;test_bench.dbs;T137;F24;L174
S0;eop_out_sender;2;86848;test_bench.dbs;T137;F24;L175
S0;eop_in_sender;2;87144;test_bench.dbs;T137;F24;L176
S0;dmni_mem_address;2;87440;test_bench.dbs;T22;F24;L179
S0;dmni_mem_addr_ddr;2;87832;test_bench.dbs;T22;F24;L180
S0;dmni_mem_ddr_read_req;2;88224;test_bench.dbs;T137;F24;L181
S0;mem_ddr_access;2;88520;test_bench.dbs;T137;F24;L182
S0;dmni_mem_write_byte_enable;2;88816;test_bench.dbs;T18;F24;L183
S0;dmni_mem_data_write;2;89208;test_bench.dbs;T22;F24;L184
S0;dmni_mem_data_read;2;89600;test_bench.dbs;T22;F24;L185
S0;dmni_mem_address_service_header_kernel;2;89992;test_bench.dbs;T22;F24;L186
S0;dmni_data_read;2;90384;test_bench.dbs;T22;F24;L187
S0;dmni_enable_internal_ram;2;90776;test_bench.dbs;T137;F24;L188
S0;dmni_send_active_sig;2;91072;test_bench.dbs;T137;F24;L189
S0;dmni_receive_active_sig;2;91368;test_bench.dbs;T137;F24;L190
S0;address_mux;2;91664;test_bench.dbs;T23;F24;L191
S0;cpu_mem_address_reg2;2;92056;test_bench.dbs;T22;F24;L192
S0;addr_a;2;92448;test_bench.dbs;T23;F24;L193
S0;addr_b;2;92840;test_bench.dbs;T23;F24;L194
S0;cpu_repo_acess;2;93232;test_bench.dbs;T137;F24;L195
S0;dmni_timeout_ni;2;93528;test_bench.dbs;T137;F24;L196
S0;pending_service;2;93824;test_bench.dbs;T137;F24;L199
S0;end_sim_reg;2;94120;test_bench.dbs;T22;F24;L201
S0;slack_update_timer;2;94512;test_bench.dbs;T22;F24;L205
S0;dummy_tx;2;94904;test_bench.dbs;T137;F24;L207
S0;dummy_rx;2;95200;test_bench.dbs;T137;F24;L208
S0;dummy_bus;2;95496;test_bench.dbs;T30;F24;L209
S0;clock_tx_local0;2;95888;test_bench.dbs;T137;F24;L211
S0;clock_rx_local0;2;96184;test_bench.dbs;T137;F24;L212
S0;rx_local0;2;96480;test_bench.dbs;T137;F24;L213
S0;tx_local0;2;96776;test_bench.dbs;T137;F24;L214
S0;credit_i_local0;2;97072;test_bench.dbs;T137;F24;L215
S0;data_in_local0;2;97368;test_bench.dbs;T30;F24;L217
S0;credit_o_local0;2;97760;test_bench.dbs;T137;F24;L218
S0;data_out_local0;2;98056;test_bench.dbs;T30;F24;L219
S0;eop_out_local0;2;98448;test_bench.dbs;T137;F24;L220
S0;eop_in_local0;2;98744;test_bench.dbs;T137;F24;L221
S0;source;2;99040;test_bench.dbs;T30;F24;L224
S0;target;2;99432;test_bench.dbs;T30;F24;L225
S0;w_source_target;2;99824;test_bench.dbs;T137;F24;L226
S0;w_addr;2;100120;test_bench.dbs;T18;F24;L227
S0;rot_table;2;100512;test_bench.dbs;T52;F24;L228
S0;MEM_waiting;2;104432;test_bench.dbs;T60;F24;L229
S0;MEM_source;2;107688;test_bench.dbs;T45;F24;L230
S0;MEM_target;2;112000;test_bench.dbs;T51;F24;L231
S0;MEM_payload;2;116312;test_bench.dbs;T37;F24;L232
S0;MEM_opmode;2;120624;test_bench.dbs;T60;F24;L233
S0;MEM_index_forwarded;2;123880;test_bench.dbs;T22;F24;L234
S0;waiting_seek;2;124272;test_bench.dbs;T137;F24;L236
S0;int_seek;2;124568;test_bench.dbs;T137;F24;L237
S0;int_dmni_seek;2;124864;test_bench.dbs;T137;F24;L238
S0;in_cpu_service_seek;2;125160;test_bench.dbs;T17;F24;L239
S0;in_cpu_source_seek;2;125552;test_bench.dbs;T22;F24;L240
S0;in_cpu_target_seek;2;125944;test_bench.dbs;T30;F24;L241
S0;in_cpu_payload_seek;2;126336;test_bench.dbs;T15;F24;L242
S0;in_cpu_opmode_seek;2;126728;test_bench.dbs;T137;F24;L243
S0;wrapper_reg;2;127024;test_bench.dbs;T61;F24;L244
V0;shift_mem_page;0;129984;test_bench.dbs;T12;F24;L246
C0;cpu;33;129992;test_bench.dbs;M109;F24;L248
C0;mem;33;130000;test_bench.dbs;M104;F24;L249
C0;dm_ni;33;130008;test_bench.dbs;M133;F24;L250
C0;ser;33;130016;test_bench.dbs;M107;F24;L251
C0;router;33;130024;test_bench.dbs;M141;F24;L253
C0;seek;33;130032;test_bench.dbs;M102;F24;L254
C0;fifo_pdn;33;130040;test_bench.dbs;M127;F24;L255
C0;fail_wrapper_module;33;130048;test_bench.dbs;M129;F24;L256
V0;log_interaction;0;130056;test_bench.dbs;T7;F24;L259
V0;instant_instructions;0;130064;test_bench.dbs;T7;F24;L260
V0;aux_instant_instructions;0;130072;test_bench.dbs;T7;F24;L261
V0;logical_instant_instructions;0;130080;test_bench.dbs;T7;F24;L263
V0;jump_instant_instructions;0;130088;test_bench.dbs;T7;F24;L264
V0;branch_instant_instructions;0;130096;test_bench.dbs;T7;F24;L265
V0;move_instant_instructions;0;130104;test_bench.dbs;T7;F24;L266
V0;other_instant_instructions;0;130112;test_bench.dbs;T7;F24;L267
V0;arith_instant_instructions;0;130120;test_bench.dbs;T7;F24;L268
V0;load_instant_instructions;0;130128;test_bench.dbs;T7;F24;L269
V0;shift_instant_instructions;0;130136;test_bench.dbs;T7;F24;L270
V0;nop_instant_instructions;0;130144;test_bench.dbs;T7;F24;L271
V0;mult_div_instant_instructions;0;130152;test_bench.dbs;T7;F24;L272
V0;aux;0;130160;test_bench.dbs;T134;F24;L275
V0;fp;0;130416;test_bench.dbs;T143;F24;L276
V0;i;0;130424;test_bench.dbs;T116;F24;L278
V0;router_address;0;130432;test_bench.dbs;T30;F24;L655
N0;pe;(sc_core::sc_module_nameregaddress,);test_bench.dbs;F24;L300
N0;wrapper_register_handle;();pe.dbs;F25;L423
N0;fail_out_generation;();pe.dbs;F25;L724
N0;fail_in_generation;();pe.dbs;F25;L729
N0;waiting_seek_trigger;();pe.dbs;F25;L487
N0;seek_receive;();pe.dbs;F25;L557
N0;seek_send;();pe.dbs;F25;L506
N0;src_tgt_control;();pe.dbs;F25;L480
N0;seek_fault_middle_packet;();pe.dbs;F25;L454
N0;seek_access;();pe.dbs;F25;L433
N0;end_of_simulation;();pe.dbs;F25;L300
N0;clock_stop;();pe.dbs;F25;L735
N0;reset_n_attr;();<NONE>
N0;mem_mapped_registers;();pe.dbs;F25;L18
N0;comb_assignments;();pe.dbs;F25;L102
N0;log_process;();pe.dbs;F25;L308
N0;sequential_attr;();pe.dbs;F25;L167

M107;plasma_sender;19;13312;6528;6528;0;0;test_bench.dbs;F20;L30
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F20;L32
P0;reset;12;536;test_bench.dbs;T137;F20;L33
P0;data_in;12;784;test_bench.dbs;T22;F20;L36
P0;rx;12;1016;test_bench.dbs;T137;F20;L37
P0;credit_o;20;1264;test_bench.dbs;T137;F20;L38
P0;eop_in;12;1520;test_bench.dbs;T137;F20;L39
P0;data_out;20;1768;test_bench.dbs;T30;F20;L41
P0;tx;20;2008;test_bench.dbs;T137;F20;L42
P0;credit_in;12;2264;test_bench.dbs;T137;F20;L43
P0;eop_out;20;2512;test_bench.dbs;T137;F20;L44
V0;buffer_in;0;2768;test_bench.dbs;T19;F20;L47
S0;eop_buffer;2;3008;test_bench.dbs;T55;F20;L48
S0;EA;2;4784;test_bench.dbs;T106;F20;L52
S0;first;2;5056;test_bench.dbs;T18;F20;L54
S0;last;2;5448;test_bench.dbs;T18;F20;L54
S0;tem_espaco_na_fila;2;5840;test_bench.dbs;T137;F20;L55
S0;data_avail;2;6136;test_bench.dbs;T26;F20;L56
N0;plasma_sender;(sc_core::sc_module_name);test_bench.dbs;F20;L64
N0;combinational;();plasma_sender.dbs;F21;L184
N0;out_proc_FSM;();plasma_sender.dbs;F21;L81
N0;in_proc_updPtr;();plasma_sender.dbs;F21;L60
N0;in_proc_FSM;();plasma_sender.dbs;F21;L32

T106;plasma_sender::fila_out;2;0;4;4;0;0;<NONE>
E0;S_INIT;0
E0;SEND_HIGH;1
E0;SEND_LOW;2
E0;SEND_LAST_FLIT;3

T105;ptrarray<char *>;0;1024;16;16;0;0;test_bench.dbs;F1;L35
V0;m_ptr;32;0;test_bench.dbs;T144;F1;L130
V0;m_size;0;8;test_bench.dbs;T116;F1;L131
V0;m_phys_size;0;12;test_bench.dbs;T116;F1;L132
N0;resize_physical;(<unnamed>);test_bench.dbs;F1;L164
N0;operator=;(<unnamed>);<NONE>
N0;ptrarray;(<unnamed>);<NONE>
N0;copy_from;(<unnamed>);test_bench.dbs;F1;L306
N0;swap;(<unnamed>);test_bench.dbs;F1;L289
N0;pop_back;(<unnamed>);test_bench.dbs;F1;L318
N0;push_back;(<unnamed>);test_bench.dbs;F1;L263
N0;removeFast;(<unnamed>);test_bench.dbs;F1;L247
N0;remove;(<unnamed>);test_bench.dbs;F1;L213
N0;get_rawptr;();test_bench.dbs;F1;L206
N0;operator[];(<unnamed>);test_bench.dbs;F1;L197
N0;operator[];(<unnamed>);test_bench.dbs;F1;L188
N0;reserve;(<unnamed>);test_bench.dbs;F1;L277
N0;resize;(<unnamed>);test_bench.dbs;F1;L96
N0;size;();test_bench.dbs;F1;L95
N0;~ptrarray;();test_bench.dbs;F1;L153
N0;ptrarray;();test_bench.dbs;F1;L145

M104;ram;19;13312;1051536;1051536;0;0;test_bench.dbs;F14;L13
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clk;12;288;test_bench.dbs;T137;F14;L15
P0;address_a;12;536;test_bench.dbs;T23;F14;L16
P0;enable_a;12;768;test_bench.dbs;T137;F14;L17
P0;wbe_a;12;1016;test_bench.dbs;T18;F14;L18
P0;data_write_a;12;1248;test_bench.dbs;T22;F14;L19
P0;data_read_a;20;1480;test_bench.dbs;T22;F14;L20
P0;address_b;12;1720;test_bench.dbs;T23;F14;L22
P0;enable_b;12;1952;test_bench.dbs;T137;F14;L23
P0;wbe_b;12;2200;test_bench.dbs;T18;F14;L24
P0;data_write_b;12;2432;test_bench.dbs;T22;F14;L25
P0;data_read_b;20;2664;test_bench.dbs;T22;F14;L26
V0;ram_data;0;2904;test_bench.dbs;T6;F14;L28
V0;byte;0;1051480;test_bench.dbs;T3;F14;L29
V0;half_word;0;1051512;test_bench.dbs;T4;F14;L30
V0;router_address;0;1051528;test_bench.dbs;T10;F14;L72
N0;ram;(sc_core::sc_module_name<unnamed>,);test_bench.dbs;F14;L42
N0;load_ram;();ram.dbs;F15;L21
N0;write_b;();ram.dbs;F15;L120
N0;read_b;();ram.dbs;F15;L108
N0;write_a;();ram.dbs;F15;L62
N0;read_a;();ram.dbs;F15;L50

M103;router_seek;19;12288;13568;13568;0;0;test_bench.dbs;F8;L6
B0;sc_core::sc_foreign_module;256;0;test_bench.dbs;T101;F0;L0
P0;clock;12;304;test_bench.dbs;T137;F8;L9
P0;reset;12;552;test_bench.dbs;T137;F8;L10
P0;in_tick_counter;12;800;test_bench.dbs;T22;F8;L13
P0;in_source_router_seek;12;1032;test_bench.dbs;T88;F8;L16
P0;in_target_router_seek;12;2192;test_bench.dbs;T92;F8;L17
P0;in_payload_router_seek;12;3352;test_bench.dbs;T82;F8;L18
P0;in_service_router_seek;12;4512;test_bench.dbs;T85;F8;L19
P0;in_req_router_seek;12;5672;test_bench.dbs;T17;F8;L20
P0;in_ack_router_seek;12;5904;test_bench.dbs;T17;F8;L21
P0;in_nack_router_seek;12;6136;test_bench.dbs;T17;F8;L22
P0;in_fail_router_seek;12;6368;test_bench.dbs;T17;F8;L23
P0;in_opmode_router_seek;12;6600;test_bench.dbs;T17;F8;L24
P0;out_req_router_seek;20;6832;test_bench.dbs;T17;F8;L25
P0;out_ack_router_seek;20;7072;test_bench.dbs;T17;F8;L26
P0;out_nack_router_seek;20;7312;test_bench.dbs;T17;F8;L27
P0;out_opmode_router_seek;20;7552;test_bench.dbs;T17;F8;L28
P0;out_service_router_seek;20;7792;test_bench.dbs;T65;F8;L29
P0;out_source_router_seek;20;8992;test_bench.dbs;T68;F8;L30
P0;out_target_router_seek;20;10192;test_bench.dbs;T72;F8;L31
P0;out_payload_router_seek;20;11392;test_bench.dbs;T62;F8;L32
P0;in_sel_reg_backtrack_seek;12;12592;test_bench.dbs;T24;F8;L34
P0;out_reg_backtrack_seek;20;12824;test_bench.dbs;T22;F8;L35
P0;out_req_send_kernel_seek;20;13064;test_bench.dbs;T137;F8;L37
P0;in_ack_send_kernel_seek;12;13320;test_bench.dbs;T137;F8;L38
N0;~router_seek;();test_bench.dbs;F8;L63
N0;router_seek;(sc_core::sc_module_name<unnamed>,<unnamed>,<unnamed>,);test_bench.dbs;F8;L59

M102;router_seek_wrapped;19;13312;26336;26336;0;0;test_bench.dbs;F6;L9
B0;sc_core::sc_module;256;0;<NONE>;M33
P0;clock;12;288;test_bench.dbs;T137;F6;L10
P0;reset;12;536;test_bench.dbs;T137;F6;L11
P0;in_tick_counter;12;784;test_bench.dbs;T22;F6;L15
P0;in_source_router_seek;12;1016;test_bench.dbs;T88;F6;L18
P0;in_target_router_seek;12;2176;test_bench.dbs;T92;F6;L19
P0;in_payload_router_seek;12;3336;test_bench.dbs;T82;F6;L20
P0;in_service_router_seek;12;4496;test_bench.dbs;T85;F6;L21
P0;in_req_router_seek;12;5656;test_bench.dbs;T97;F6;L22
P0;in_ack_router_seek;12;6896;test_bench.dbs;T97;F6;L23
P0;in_nack_router_seek;12;8136;test_bench.dbs;T97;F6;L24
P0;in_fail_router_seek;12;9376;test_bench.dbs;T97;F6;L25
P0;in_opmode_router_seek;12;10616;test_bench.dbs;T97;F6;L26
P0;out_req_router_seek;20;11856;test_bench.dbs;T78;F6;L27
P0;out_ack_router_seek;20;13136;test_bench.dbs;T78;F6;L28
P0;out_nack_router_seek;20;14416;test_bench.dbs;T78;F6;L29
P0;out_opmode_router_seek;20;15696;test_bench.dbs;T78;F6;L30
P0;out_service_router_seek;20;16976;test_bench.dbs;T65;F6;L31
P0;out_source_router_seek;20;18176;test_bench.dbs;T68;F6;L32
P0;out_target_router_seek;20;19376;test_bench.dbs;T72;F6;L33
P0;out_payload_router_seek;20;20576;test_bench.dbs;T62;F6;L34
P0;in_sel_reg_backtrack_seek;12;21776;test_bench.dbs;T24;F6;L36
P0;out_reg_backtrack_seek;20;22008;test_bench.dbs;T22;F6;L37
P0;out_req_send_kernel_seek;20;22248;test_bench.dbs;T137;F6;L39
P0;in_ack_send_kernel_seek;12;22504;test_bench.dbs;T137;F6;L40
S0;in_req_router_seek_internal;2;22752;test_bench.dbs;T17;F6;L43
S0;in_ack_router_seek_internal;2;23144;test_bench.dbs;T17;F6;L44
S0;in_nack_router_seek_internal;2;23536;test_bench.dbs;T17;F6;L45
S0;in_fail_router_seek_internal;2;23928;test_bench.dbs;T17;F6;L46
S0;in_opmode_router_seek_internal;2;24320;test_bench.dbs;T17;F6;L47
S0;out_req_router_seek_internal;2;24712;test_bench.dbs;T17;F6;L48
S0;out_ack_router_seek_internal;2;25104;test_bench.dbs;T17;F6;L49
S0;out_nack_router_seek_internal;2;25496;test_bench.dbs;T17;F6;L50
S0;out_opmode_router_seek_internal;2;25888;test_bench.dbs;T17;F6;L51
C0;seek;33;26280;test_bench.dbs;M103;F6;L53
V0;i;0;26288;test_bench.dbs;T116;F6;L65
V0;address;0;26296;test_bench.dbs;T30;F6;L196
N0;~router_seek_wrapped;();test_bench.dbs;F6;L193
N0;router_seek_wrapped;(sc_core::sc_module_nameregaddress,);test_bench.dbs;F6;L70
N0;upd_out_opmode_router_seek;();router_seek_wrapped2.dbs;F7;L105
N0;upd_out_nack_router_seek;();router_seek_wrapped2.dbs;F7;L94
N0;upd_out_ack_router_seek;();router_seek_wrapped2.dbs;F7;L83
N0;upd_out_req_router_seek;();router_seek_wrapped2.dbs;F7;L72
N0;upd_in_opmode_router_seek;();router_seek_wrapped2.dbs;F7;L50
N0;upd_in_fail_router_seek;();router_seek_wrapped2.dbs;F7;L61
N0;upd_in_nack_router_seek;();router_seek_wrapped2.dbs;F7;L39
N0;upd_in_ack_router_seek;();router_seek_wrapped2.dbs;F7;L28
N0;upd_in_req_router_seek;();router_seek_wrapped2.dbs;F7;L17

T101;sc_core::sc_foreign_module;0;9472;304;304;0;0;test_bench.dbs;F0;L16
B0;sc_core::sc_module;256;0;<NONE>;M33
V0;m_parameter_list;0;288;test_bench.dbs;T105;F0;L48
N0;clear_parameter_list;();<NONE>
N0;elaborate_foreign_module;(<unnamed><unnamed>,<unnamed>,);<NONE>
N0;add_parameter;(<unnamed><unnamed>,);<NONE>
N0;add_parameter;(<unnamed>);<NONE>
N0;~sc_foreign_module;();test_bench.dbs;F0;L33
N0;sc_foreign_module;(<unnamed><unnamed>,<unnamed>,);<NONE>
N0;sc_foreign_module;(<unnamed><unnamed>,<unnamed>,<unnamed>,);<NONE>

T100;sc_core::sc_in<bool>[10];24;0;248;2480;10;0;<NONE>;T137

T99;sc_core::sc_in<bool>[2];24;0;248;496;2;0;<NONE>;T137

T98;sc_core::sc_in<bool>[4];24;0;248;992;4;0;<NONE>;T137

T97;sc_core::sc_in<bool>[5];24;0;248;1240;5;0;<NONE>;T137

T96;sc_core::sc_in<bool>[9];24;0;248;2232;9;0;<NONE>;T137

T95;sc_core::sc_in<sc_dt::sc_uint<16> >[10];24;8192;232;2320;10;0;<NONE>;T30

T94;sc_core::sc_in<sc_dt::sc_uint<16> >[2];24;8192;232;464;2;0;<NONE>;T30

T93;sc_core::sc_in<sc_dt::sc_uint<16> >[4];24;8192;232;928;4;0;<NONE>;T30

T92;sc_core::sc_in<sc_dt::sc_uint<16> >[5];24;8192;232;1160;5;0;<NONE>;T30

T91;sc_core::sc_in<sc_dt::sc_uint<16> >[9];24;8192;232;2088;9;0;<NONE>;T30

T90;sc_core::sc_in<sc_dt::sc_uint<32> >[2];24;8192;232;464;2;0;<NONE>;T22

T89;sc_core::sc_in<sc_dt::sc_uint<32> >[4];24;8192;232;928;4;0;<NONE>;T22

T88;sc_core::sc_in<sc_dt::sc_uint<32> >[5];24;8192;232;1160;5;0;<NONE>;T22

T87;sc_core::sc_in<sc_dt::sc_uint<5> >[2];24;8192;232;464;2;0;<NONE>;T17

T86;sc_core::sc_in<sc_dt::sc_uint<5> >[4];24;8192;232;928;4;0;<NONE>;T17

T85;sc_core::sc_in<sc_dt::sc_uint<5> >[5];24;8192;232;1160;5;0;<NONE>;T17

T84;sc_core::sc_in<sc_dt::sc_uint<8> >[2];24;8192;232;464;2;0;<NONE>;T15

T83;sc_core::sc_in<sc_dt::sc_uint<8> >[4];24;8192;232;928;4;0;<NONE>;T15

T82;sc_core::sc_in<sc_dt::sc_uint<8> >[5];24;8192;232;1160;5;0;<NONE>;T15

T81;sc_core::sc_out<bool>[10];24;0;256;2560;10;0;<NONE>;T137

T80;sc_core::sc_out<bool>[2];24;0;256;512;2;0;<NONE>;T137

T79;sc_core::sc_out<bool>[4];24;0;256;1024;4;0;<NONE>;T137

T78;sc_core::sc_out<bool>[5];24;0;256;1280;5;0;<NONE>;T137

T77;sc_core::sc_out<bool>[9];24;0;256;2304;9;0;<NONE>;T137

T76;sc_core::sc_out<sc_dt::sc_uint<10> >[10];24;8192;240;2400;10;0;<NONE>;T31

T75;sc_core::sc_out<sc_dt::sc_uint<16> >[10];24;8192;240;2400;10;0;<NONE>;T30

T74;sc_core::sc_out<sc_dt::sc_uint<16> >[2];24;8192;240;480;2;0;<NONE>;T30

T73;sc_core::sc_out<sc_dt::sc_uint<16> >[4];24;8192;240;960;4;0;<NONE>;T30

T72;sc_core::sc_out<sc_dt::sc_uint<16> >[5];24;8192;240;1200;5;0;<NONE>;T30

T71;sc_core::sc_out<sc_dt::sc_uint<16> >[9];24;8192;240;2160;9;0;<NONE>;T30

T70;sc_core::sc_out<sc_dt::sc_uint<32> >[2];24;8192;240;480;2;0;<NONE>;T22

T69;sc_core::sc_out<sc_dt::sc_uint<32> >[4];24;8192;240;960;4;0;<NONE>;T22

T68;sc_core::sc_out<sc_dt::sc_uint<32> >[5];24;8192;240;1200;5;0;<NONE>;T22

T67;sc_core::sc_out<sc_dt::sc_uint<5> >[2];24;8192;240;480;2;0;<NONE>;T17

T66;sc_core::sc_out<sc_dt::sc_uint<5> >[4];24;8192;240;960;4;0;<NONE>;T17

T65;sc_core::sc_out<sc_dt::sc_uint<5> >[5];24;8192;240;1200;5;0;<NONE>;T17

T64;sc_core::sc_out<sc_dt::sc_uint<8> >[2];24;8192;240;480;2;0;<NONE>;T15

T63;sc_core::sc_out<sc_dt::sc_uint<8> >[4];24;8192;240;960;4;0;<NONE>;T15

T62;sc_core::sc_out<sc_dt::sc_uint<8> >[5];24;8192;240;1200;5;0;<NONE>;T15

T61;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[10];24;0;296;2960;10;0;<NONE>;T137

T60;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[11];24;0;296;3256;11;0;<NONE>;T137

T59;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[16];24;0;296;4736;16;0;<NONE>;T137

T58;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[2];24;0;296;592;2;0;<NONE>;T137

T57;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[4];24;0;296;1184;4;0;<NONE>;T137

T56;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[4][16];24;0;1184;18944;16;0;<NONE>;T57

T55;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[6];24;0;296;1776;6;0;<NONE>;T137

T54;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[9];24;0;296;2664;9;0;<NONE>;T137

T53;sc_core::sc_signal<bool, sc_core::SC_ONE_WRITER>[9][16];24;0;2664;42624;16;0;<NONE>;T54

T52;sc_core::sc_signal<sc_dt::sc_uint<10>, sc_core::SC_ONE_WRITER>[10];24;8192;392;3920;10;0;<NONE>;T31

T51;sc_core::sc_signal<sc_dt::sc_uint<16>, sc_core::SC_ONE_WRITER>[11];24;8192;392;4312;11;0;<NONE>;T30

T50;sc_core::sc_signal<sc_dt::sc_uint<16>, sc_core::SC_ONE_WRITER>[2];24;8192;392;784;2;0;<NONE>;T30

T49;sc_core::sc_signal<sc_dt::sc_uint<16>, sc_core::SC_ONE_WRITER>[4];24;8192;392;1568;4;0;<NONE>;T30

T48;sc_core::sc_signal<sc_dt::sc_uint<16>, sc_core::SC_ONE_WRITER>[4][16];24;8192;1568;25088;16;0;<NONE>;T49

T47;sc_core::sc_signal<sc_dt::sc_uint<16>, sc_core::SC_ONE_WRITER>[9];24;8192;392;3528;9;0;<NONE>;T30

T46;sc_core::sc_signal<sc_dt::sc_uint<16>, sc_core::SC_ONE_WRITER>[9][16];24;8192;3528;56448;16;0;<NONE>;T47

T45;sc_core::sc_signal<sc_dt::sc_uint<32>, sc_core::SC_ONE_WRITER>[11];24;8192;392;4312;11;0;<NONE>;T22

T44;sc_core::sc_signal<sc_dt::sc_uint<32>, sc_core::SC_ONE_WRITER>[16];24;8192;392;6272;16;0;<NONE>;T22

T43;sc_core::sc_signal<sc_dt::sc_uint<32>, sc_core::SC_ONE_WRITER>[2];24;8192;392;784;2;0;<NONE>;T22

T42;sc_core::sc_signal<sc_dt::sc_uint<32>, sc_core::SC_ONE_WRITER>[4];24;8192;392;1568;4;0;<NONE>;T22

T41;sc_core::sc_signal<sc_dt::sc_uint<32>, sc_core::SC_ONE_WRITER>[4][16];24;8192;1568;25088;16;0;<NONE>;T42

T40;sc_core::sc_signal<sc_dt::sc_uint<5>, sc_core::SC_ONE_WRITER>[2];24;8192;392;784;2;0;<NONE>;T17

T39;sc_core::sc_signal<sc_dt::sc_uint<5>, sc_core::SC_ONE_WRITER>[4];24;8192;392;1568;4;0;<NONE>;T17

T38;sc_core::sc_signal<sc_dt::sc_uint<5>, sc_core::SC_ONE_WRITER>[4][16];24;8192;1568;25088;16;0;<NONE>;T39

T37;sc_core::sc_signal<sc_dt::sc_uint<8>, sc_core::SC_ONE_WRITER>[11];24;8192;392;4312;11;0;<NONE>;T15

T36;sc_core::sc_signal<sc_dt::sc_uint<8>, sc_core::SC_ONE_WRITER>[2];24;8192;392;784;2;0;<NONE>;T15

T35;sc_core::sc_signal<sc_dt::sc_uint<8>, sc_core::SC_ONE_WRITER>[4];24;8192;392;1568;4;0;<NONE>;T15

T34;sc_core::sc_signal<sc_dt::sc_uint<8>, sc_core::SC_ONE_WRITER>[4][16];24;8192;1568;25088;16;0;<NONE>;T35

M33;sc_module;19;4352;0;0;0;0;<NONE>

T32;sc_root;0;64;0;0;0;0;<NONE>
V0;ptrarray<char *>::m_default_init_size;64;0;test_bench.dbs;T116;F1;L134

T31;sc_uint<10>;17;4608;10;40;0;0;<NONE>

T30;sc_uint<16>;17;4608;16;40;0;0;<NONE>

T29;sc_uint<16>[32];20;8192;40;1280;32;0;<NONE>;T30

T28;sc_uint<16>[4];20;8192;40;160;4;0;<NONE>;T30

T27;sc_uint<16>[64];20;8192;40;2560;64;0;<NONE>;T30

T26;sc_uint<1>;17;4608;1;40;0;0;<NONE>

T25;sc_uint<1>[4];20;8192;40;160;4;0;<NONE>;T26

T24;sc_uint<2>;17;4608;2;40;0;0;<NONE>

T23;sc_uint<30>;17;4608;30;40;0;0;<NONE>

T22;sc_uint<32>;17;4608;32;40;0;0;<NONE>

T21;sc_uint<32>[2];20;8192;40;80;2;0;<NONE>;T22

T20;sc_uint<32>[4];20;8192;40;160;4;0;<NONE>;T22

T19;sc_uint<32>[6];20;8192;40;240;6;0;<NONE>;T22

T18;sc_uint<4>;17;4608;4;40;0;0;<NONE>

T17;sc_uint<5>;17;4608;5;40;0;0;<NONE>

T16;sc_uint<5>[4];20;8192;40;160;4;0;<NONE>;T17

T15;sc_uint<8>;17;4608;8;40;0;0;<NONE>

T14;sc_uint<8>[4];20;8192;40;160;4;0;<NONE>;T15

M13;test_bench;19;13440;18488;18488;0;0;test_bench.dbs;F26;L11
B0;sc_core::sc_module;256;0;<NONE>;M33
S0;clock;2;288;test_bench.dbs;T137;F26;L13
S0;reset;2;584;test_bench.dbs;T137;F26;L14
C0;MPSoC;33;880;test_bench.dbs;M124;F26;L22
C0;Injector;33;888;test_bench.dbs;M122;F26;L23
V0;io_count;0;896;test_bench.dbs;T116;F26;L25
V0;aux;0;900;test_bench.dbs;T134;F26;L27
V0;fp;0;1160;test_bench.dbs;T143;F26;L28
S0;clock_tx_tb;2;1168;test_bench.dbs;T58;F26;L32
S0;tx_tb;2;1760;test_bench.dbs;T58;F26;L33
S0;data_out_tb;2;2352;test_bench.dbs;T50;F26;L34
S0;credit_i_tb;2;3136;test_bench.dbs;T58;F26;L35
S0;eop_in_tb;2;3728;test_bench.dbs;T58;F26;L36
S0;clock_rx_tb;2;4320;test_bench.dbs;T58;F26;L38
S0;rx_tb;2;4912;test_bench.dbs;T58;F26;L39
S0;data_in_tb;2;5504;test_bench.dbs;T50;F26;L40
S0;credit_o_tb;2;6288;test_bench.dbs;T58;F26;L41
S0;eop_out_tb;2;6880;test_bench.dbs;T58;F26;L42
S0;in_source_router_seek_tb;2;7472;test_bench.dbs;T43;F26;L48
S0;in_target_router_seek_tb;2;8256;test_bench.dbs;T50;F26;L49
S0;in_payload_router_seek_tb;2;9040;test_bench.dbs;T36;F26;L50
S0;in_service_router_seek_tb;2;9824;test_bench.dbs;T40;F26;L51
S0;in_req_router_seek_tb;2;10608;test_bench.dbs;T58;F26;L52
S0;in_ack_router_seek_tb;2;11200;test_bench.dbs;T58;F26;L53
S0;in_nack_router_seek_tb;2;11792;test_bench.dbs;T58;F26;L54
S0;in_opmode_router_seek_tb;2;12384;test_bench.dbs;T58;F26;L55
S0;out_req_router_seek_tb;2;12976;test_bench.dbs;T58;F26;L60
S0;out_ack_router_seek_tb;2;13568;test_bench.dbs;T58;F26;L61
S0;out_nack_router_seek_tb;2;14160;test_bench.dbs;T58;F26;L62
S0;out_opmode_router_seek_tb;2;14752;test_bench.dbs;T58;F26;L63
S0;out_service_router_seek_tb;2;15344;test_bench.dbs;T40;F26;L64
S0;out_source_router_seek_tb;2;16128;test_bench.dbs;T43;F26;L65
S0;out_target_router_seek_tb;2;16912;test_bench.dbs;T50;F26;L66
S0;out_payload_router_seek_tb;2;17696;test_bench.dbs;T36;F26;L67
V0;filename;0;18480;test_bench.dbs;T143;F26;L197
N0;test_bench;(sc_core::sc_module_name<unnamed>,);test_bench.dbs;F26;L75
N0;log_gen;();<NONE>
N0;debug_output;();<NONE>
N0;resetGenerator;();test_bench.dbs;F27;L31
N0;ClockGenerator;();test_bench.dbs;F27;L22

T12;unsigned char;3;512;1;1;0;0;<NONE>

T11;unsigned char[10];20;0;1;10;10;0;<NONE>;T12

T10;unsigned int;5;512;4;4;0;0;<NONE>

T9;unsigned int[104];20;0;4;416;104;0;<NONE>;T10

T8;unsigned int[10];20;0;4;40;10;0;<NONE>;T10

T7;unsigned long;6;512;8;8;0;0;<NONE>

T6;unsigned long[131072];20;0;8;1048576;131072;0;<NONE>;T7

T5;unsigned long[262144];20;0;8;2097152;262144;0;<NONE>;T7

T4;unsigned long[2];20;0;8;16;2;0;<NONE>;T7

T3;unsigned long[4];20;0;8;32;4;0;<NONE>;T7

T2;unsigned long[5];20;0;8;40;5;0;<NONE>;T7

T1;unsigned short;4;512;2;2;0;0;<NONE>

T0;unsigned short[10];20;0;2;20;10;0;<NONE>;T1

