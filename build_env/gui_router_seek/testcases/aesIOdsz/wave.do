onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -group {slave 0x0 - 0} /test_bench/HeMPS/slave0x0/clock

add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/irq
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/int_seek
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/irq_mask_reg
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/irq_status
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/cpu/mem_address
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/cpu/mem_byte_we
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/cpu/mem_data_r
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/cpu/mem_data_w
add wave -noupdate -group {slave 0x0 - 0} -group pe /test_bench/HeMPS/slave0x0/cpu/page
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/clock
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/external_fail_in
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/external_fail_out
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/fail_in
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/fail_out
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/router_fail_in
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/router_fail_out
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/wrapper_reg
add wave -noupdate -group {slave 0x0 - 0} -group faults /test_bench/HeMPS/slave0x0/io_packet_mask
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output E} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output W} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output N} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output S} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {input L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group {output L} /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 0x0 - 0} -group seek -group signals /test_bench/HeMPS/slave0x0/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/clock
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/reset
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/EA_in
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/EA_out
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN//last
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/first
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_source
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_target
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_service
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 0x0 - 0} -group fifo_PDN /test_bench/HeMPS/slave0x0/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 0x0 - 0} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x0/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/dmni_timeout
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/mem_address
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/mem_byte_we
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/mem_data_read
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/mem_data_write
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/config_data
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/receive_active
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/send_active
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/set_address
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/set_address_2
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/set_op
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/set_size
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/set_size_2
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/start
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/intr
add wave -noupdate -group {slave 0x0 - 0} -group dmni -divider SR
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/SR
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/cont
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/payload_size
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/last
add wave -noupdate -group {slave 0x0 - 0} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/DMNI_Receive
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/recv_size
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/first
add wave -noupdate -group {slave 0x0 - 0} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 0x0 - 0} -group dmni /test_bench/HeMPS/slave0x0/dmni/DMNI_Send
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 0x0 - 0} -group {switch control} /test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 0x0 - 0} -group ports -group {router 0x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 0x0 - 0} -group LOCAL -group {router 0x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x0/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 1x0 - 1} /test_bench/HeMPS/slave1x0/clock

add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/irq
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/int_seek
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/irq_mask_reg
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/irq_status
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/cpu/mem_address
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/cpu/mem_byte_we
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/cpu/mem_data_r
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/cpu/mem_data_w
add wave -noupdate -group {slave 1x0 - 1} -group pe /test_bench/HeMPS/slave1x0/cpu/page
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/clock
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/external_fail_in
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/external_fail_out
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/fail_in
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/fail_out
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/router_fail_in
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/router_fail_out
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/wrapper_reg
add wave -noupdate -group {slave 1x0 - 1} -group faults /test_bench/HeMPS/slave1x0/io_packet_mask
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output E} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output W} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output N} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output S} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {input L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group {output L} /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 1x0 - 1} -group seek -group signals /test_bench/HeMPS/slave1x0/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/clock
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/reset
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/EA_in
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/EA_out
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN//last
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/first
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_source
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_target
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_service
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 1x0 - 1} -group fifo_PDN /test_bench/HeMPS/slave1x0/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 1x0 - 1} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x0/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/dmni_timeout
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/mem_address
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/mem_byte_we
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/mem_data_read
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/mem_data_write
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/config_data
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/receive_active
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/send_active
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/set_address
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/set_address_2
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/set_op
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/set_size
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/set_size_2
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/start
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/intr
add wave -noupdate -group {slave 1x0 - 1} -group dmni -divider SR
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/SR
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/cont
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/payload_size
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/last
add wave -noupdate -group {slave 1x0 - 1} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/DMNI_Receive
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/recv_size
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/first
add wave -noupdate -group {slave 1x0 - 1} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 1x0 - 1} -group dmni /test_bench/HeMPS/slave1x0/dmni/DMNI_Send
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 1x0 - 1} -group {switch control} /test_bench/HeMPS/slave1x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 1x0 - 1} -group ports -group {router 1x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 1x0 - 1} -group LOCAL -group {router 1x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x0/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 2x0 - 2} /test_bench/HeMPS/slave2x0/clock

add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/irq
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/int_seek
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/irq_mask_reg
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/irq_status
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/cpu/mem_address
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/cpu/mem_byte_we
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/cpu/mem_data_r
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/cpu/mem_data_w
add wave -noupdate -group {slave 2x0 - 2} -group pe /test_bench/HeMPS/slave2x0/cpu/page
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/clock
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/external_fail_in
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/external_fail_out
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/fail_in
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/fail_out
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/router_fail_in
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/router_fail_out
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/wrapper_reg
add wave -noupdate -group {slave 2x0 - 2} -group faults /test_bench/HeMPS/slave2x0/io_packet_mask
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output E} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output W} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output N} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output S} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {input L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group {output L} /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 2x0 - 2} -group seek -group signals /test_bench/HeMPS/slave2x0/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/clock
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/reset
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/EA_in
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/EA_out
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN//last
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/first
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_source
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_target
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_service
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 2x0 - 2} -group fifo_PDN /test_bench/HeMPS/slave2x0/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 2x0 - 2} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x0/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/dmni_timeout
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/mem_address
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/mem_byte_we
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/mem_data_read
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/mem_data_write
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/config_data
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/receive_active
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/send_active
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/set_address
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/set_address_2
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/set_op
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/set_size
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/set_size_2
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/start
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/intr
add wave -noupdate -group {slave 2x0 - 2} -group dmni -divider SR
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/SR
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/cont
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/payload_size
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/last
add wave -noupdate -group {slave 2x0 - 2} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/DMNI_Receive
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/recv_size
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/first
add wave -noupdate -group {slave 2x0 - 2} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 2x0 - 2} -group dmni /test_bench/HeMPS/slave2x0/dmni/DMNI_Send
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 2x0 - 2} -group {switch control} /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 2x0 - 2} -group ports -group {router 2x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 2x0 - 2} -group LOCAL -group {router 2x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x0/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 3x0 - 3} /test_bench/HeMPS/slave3x0/clock

add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/irq
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/int_seek
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/irq_mask_reg
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/irq_status
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/cpu/mem_address
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/cpu/mem_byte_we
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/cpu/mem_data_r
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/cpu/mem_data_w
add wave -noupdate -group {slave 3x0 - 3} -group pe /test_bench/HeMPS/slave3x0/cpu/page
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/clock
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/external_fail_in
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/external_fail_out
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/fail_in
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/fail_out
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/router_fail_in
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/router_fail_out
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/wrapper_reg
add wave -noupdate -group {slave 3x0 - 3} -group faults /test_bench/HeMPS/slave3x0/io_packet_mask
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output E} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output W} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output N} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output S} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {input L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group {output L} /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 3x0 - 3} -group seek -group signals /test_bench/HeMPS/slave3x0/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/clock
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/reset
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/EA_in
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/EA_out
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN//last
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/first
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_source
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_target
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_service
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 3x0 - 3} -group fifo_PDN /test_bench/HeMPS/slave3x0/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 3x0 - 3} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x0/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/dmni_timeout
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/mem_address
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/mem_byte_we
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/mem_data_read
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/mem_data_write
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/config_data
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/receive_active
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/send_active
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/set_address
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/set_address_2
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/set_op
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/set_size
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/set_size_2
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/start
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/intr
add wave -noupdate -group {slave 3x0 - 3} -group dmni -divider SR
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/SR
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/cont
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/payload_size
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/last
add wave -noupdate -group {slave 3x0 - 3} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/DMNI_Receive
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/recv_size
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/first
add wave -noupdate -group {slave 3x0 - 3} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 3x0 - 3} -group dmni /test_bench/HeMPS/slave3x0/dmni/DMNI_Send
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 3x0 - 3} -group {switch control} /test_bench/HeMPS/slave3x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 3x0 - 3} -group ports -group {router 3x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 3x0 - 3} -group LOCAL -group {router 3x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x0/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 4x0 - 4} /test_bench/HeMPS/slave4x0/clock

add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/irq
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/int_seek
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/irq_mask_reg
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/irq_status
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/cpu/mem_address
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/cpu/mem_byte_we
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/cpu/mem_data_r
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/cpu/mem_data_w
add wave -noupdate -group {slave 4x0 - 4} -group pe /test_bench/HeMPS/slave4x0/cpu/page
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/clock
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/external_fail_in
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/external_fail_out
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/fail_in
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/fail_out
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/router_fail_in
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/router_fail_out
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/wrapper_reg
add wave -noupdate -group {slave 4x0 - 4} -group faults /test_bench/HeMPS/slave4x0/io_packet_mask
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output E} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output W} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output N} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output S} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {input L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group {output L} /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 4x0 - 4} -group seek -group signals /test_bench/HeMPS/slave4x0/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/clock
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/reset
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/EA_in
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/EA_out
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN//last
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/first
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_source
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_target
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_service
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 4x0 - 4} -group fifo_PDN /test_bench/HeMPS/slave4x0/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 4x0 - 4} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x0/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/dmni_timeout
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/mem_address
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/mem_byte_we
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/mem_data_read
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/mem_data_write
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/config_data
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/receive_active
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/send_active
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/set_address
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/set_address_2
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/set_op
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/set_size
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/set_size_2
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/start
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/intr
add wave -noupdate -group {slave 4x0 - 4} -group dmni -divider SR
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/SR
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/cont
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/payload_size
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/last
add wave -noupdate -group {slave 4x0 - 4} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/DMNI_Receive
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/recv_size
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/first
add wave -noupdate -group {slave 4x0 - 4} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 4x0 - 4} -group dmni /test_bench/HeMPS/slave4x0/dmni/DMNI_Send
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 4x0 - 4} -group {switch control} /test_bench/HeMPS/slave4x0/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 4x0 - 4} -group ports -group {router 4x0 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 4x0 - 4} -group LOCAL -group {router 4x0 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x0/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 0x1 - 5} /test_bench/HeMPS/slave0x1/clock

add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/irq
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/int_seek
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/irq_mask_reg
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/irq_status
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/cpu/mem_address
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/cpu/mem_byte_we
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/cpu/mem_data_r
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/cpu/mem_data_w
add wave -noupdate -group {slave 0x1 - 5} -group pe /test_bench/HeMPS/slave0x1/cpu/page
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/clock
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/external_fail_in
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/external_fail_out
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/fail_in
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/fail_out
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/router_fail_in
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/router_fail_out
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/wrapper_reg
add wave -noupdate -group {slave 0x1 - 5} -group faults /test_bench/HeMPS/slave0x1/io_packet_mask
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output E} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output W} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output N} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output S} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {input L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group {output L} /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 0x1 - 5} -group seek -group signals /test_bench/HeMPS/slave0x1/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/clock
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/reset
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/EA_in
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/EA_out
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN//last
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/first
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_source
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_target
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_service
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 0x1 - 5} -group fifo_PDN /test_bench/HeMPS/slave0x1/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 0x1 - 5} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x1/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/dmni_timeout
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/mem_address
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/mem_byte_we
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/mem_data_read
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/mem_data_write
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/config_data
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/receive_active
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/send_active
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/set_address
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/set_address_2
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/set_op
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/set_size
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/set_size_2
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/start
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/intr
add wave -noupdate -group {slave 0x1 - 5} -group dmni -divider SR
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/SR
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/cont
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/payload_size
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/last
add wave -noupdate -group {slave 0x1 - 5} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/DMNI_Receive
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/recv_size
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/first
add wave -noupdate -group {slave 0x1 - 5} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 0x1 - 5} -group dmni /test_bench/HeMPS/slave0x1/dmni/DMNI_Send
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 0x1 - 5} -group {switch control} /test_bench/HeMPS/slave0x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 0x1 - 5} -group ports -group {router 0x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 0x1 - 5} -group LOCAL -group {router 0x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x1/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 1x1 - 6} /test_bench/HeMPS/slave1x1/clock

add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/irq
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/int_seek
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/irq_mask_reg
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/irq_status
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/cpu/mem_address
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/cpu/mem_byte_we
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/cpu/mem_data_r
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/cpu/mem_data_w
add wave -noupdate -group {slave 1x1 - 6} -group pe /test_bench/HeMPS/slave1x1/cpu/page
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/clock
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/external_fail_in
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/external_fail_out
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/fail_in
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/fail_out
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/router_fail_in
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/router_fail_out
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/wrapper_reg
add wave -noupdate -group {slave 1x1 - 6} -group faults /test_bench/HeMPS/slave1x1/io_packet_mask
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output E} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output W} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output N} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output S} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {input L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group {output L} /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 1x1 - 6} -group seek -group signals /test_bench/HeMPS/slave1x1/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/clock
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/reset
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/EA_in
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/EA_out
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN//last
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/first
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_source
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_target
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_service
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 1x1 - 6} -group fifo_PDN /test_bench/HeMPS/slave1x1/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 1x1 - 6} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x1/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/dmni_timeout
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/mem_address
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/mem_byte_we
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/mem_data_read
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/mem_data_write
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/config_data
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/receive_active
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/send_active
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/set_address
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/set_address_2
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/set_op
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/set_size
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/set_size_2
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/start
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/intr
add wave -noupdate -group {slave 1x1 - 6} -group dmni -divider SR
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/SR
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/cont
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/payload_size
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/last
add wave -noupdate -group {slave 1x1 - 6} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/DMNI_Receive
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/recv_size
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/first
add wave -noupdate -group {slave 1x1 - 6} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 1x1 - 6} -group dmni /test_bench/HeMPS/slave1x1/dmni/DMNI_Send
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 1x1 - 6} -group {switch control} /test_bench/HeMPS/slave1x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 1x1 - 6} -group ports -group {router 1x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 1x1 - 6} -group LOCAL -group {router 1x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x1/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 2x1 - 7} /test_bench/HeMPS/slave2x1/clock

add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/irq
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/int_seek
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/irq_mask_reg
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/irq_status
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/cpu/mem_address
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/cpu/mem_byte_we
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/cpu/mem_data_r
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/cpu/mem_data_w
add wave -noupdate -group {slave 2x1 - 7} -group pe /test_bench/HeMPS/slave2x1/cpu/page
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/clock
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/external_fail_in
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/external_fail_out
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/fail_in
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/fail_out
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/router_fail_in
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/router_fail_out
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/wrapper_reg
add wave -noupdate -group {slave 2x1 - 7} -group faults /test_bench/HeMPS/slave2x1/io_packet_mask
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output E} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output W} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output N} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output S} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {input L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group {output L} /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 2x1 - 7} -group seek -group signals /test_bench/HeMPS/slave2x1/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/clock
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/reset
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/EA_in
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/EA_out
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN//last
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/first
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_source
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_target
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_service
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 2x1 - 7} -group fifo_PDN /test_bench/HeMPS/slave2x1/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 2x1 - 7} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x1/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/dmni_timeout
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/mem_address
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/mem_byte_we
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/mem_data_read
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/mem_data_write
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/config_data
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/receive_active
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/send_active
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/set_address
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/set_address_2
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/set_op
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/set_size
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/set_size_2
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/start
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/intr
add wave -noupdate -group {slave 2x1 - 7} -group dmni -divider SR
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/SR
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/cont
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/payload_size
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/last
add wave -noupdate -group {slave 2x1 - 7} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/DMNI_Receive
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/recv_size
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/first
add wave -noupdate -group {slave 2x1 - 7} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 2x1 - 7} -group dmni /test_bench/HeMPS/slave2x1/dmni/DMNI_Send
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 2x1 - 7} -group {switch control} /test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 2x1 - 7} -group ports -group {router 2x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 2x1 - 7} -group LOCAL -group {router 2x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x1/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 3x1 - 8} /test_bench/HeMPS/slave3x1/clock

add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/irq
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/int_seek
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/irq_mask_reg
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/irq_status
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/cpu/mem_address
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/cpu/mem_byte_we
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/cpu/mem_data_r
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/cpu/mem_data_w
add wave -noupdate -group {slave 3x1 - 8} -group pe /test_bench/HeMPS/slave3x1/cpu/page
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/clock
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/external_fail_in
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/external_fail_out
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/fail_in
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/fail_out
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/router_fail_in
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/router_fail_out
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/wrapper_reg
add wave -noupdate -group {slave 3x1 - 8} -group faults /test_bench/HeMPS/slave3x1/io_packet_mask
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output E} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output W} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output N} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output S} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {input L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group {output L} /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 3x1 - 8} -group seek -group signals /test_bench/HeMPS/slave3x1/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/clock
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/reset
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/EA_in
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/EA_out
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN//last
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/first
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_source
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_target
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_service
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 3x1 - 8} -group fifo_PDN /test_bench/HeMPS/slave3x1/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 3x1 - 8} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x1/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/dmni_timeout
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/mem_address
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/mem_byte_we
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/mem_data_read
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/mem_data_write
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/config_data
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/receive_active
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/send_active
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/set_address
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/set_address_2
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/set_op
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/set_size
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/set_size_2
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/start
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/intr
add wave -noupdate -group {slave 3x1 - 8} -group dmni -divider SR
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/SR
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/cont
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/payload_size
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/last
add wave -noupdate -group {slave 3x1 - 8} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/DMNI_Receive
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/recv_size
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/first
add wave -noupdate -group {slave 3x1 - 8} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 3x1 - 8} -group dmni /test_bench/HeMPS/slave3x1/dmni/DMNI_Send
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 3x1 - 8} -group {switch control} /test_bench/HeMPS/slave3x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 3x1 - 8} -group ports -group {router 3x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 3x1 - 8} -group LOCAL -group {router 3x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x1/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 4x1 - 9} /test_bench/HeMPS/slave4x1/clock

add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/irq
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/int_seek
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/irq_mask_reg
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/irq_status
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/cpu/mem_address
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/cpu/mem_byte_we
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/cpu/mem_data_r
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/cpu/mem_data_w
add wave -noupdate -group {slave 4x1 - 9} -group pe /test_bench/HeMPS/slave4x1/cpu/page
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/clock
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/external_fail_in
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/external_fail_out
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/fail_in
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/fail_out
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/router_fail_in
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/router_fail_out
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/wrapper_reg
add wave -noupdate -group {slave 4x1 - 9} -group faults /test_bench/HeMPS/slave4x1/io_packet_mask
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output E} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output W} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output N} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output S} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {input L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group {output L} /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 4x1 - 9} -group seek -group signals /test_bench/HeMPS/slave4x1/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/clock
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/reset
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/EA_in
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/EA_out
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN//last
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/first
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_source
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_target
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_service
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 4x1 - 9} -group fifo_PDN /test_bench/HeMPS/slave4x1/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 4x1 - 9} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x1/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/dmni_timeout
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/mem_address
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/mem_byte_we
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/mem_data_read
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/mem_data_write
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/config_data
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/receive_active
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/send_active
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/set_address
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/set_address_2
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/set_op
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/set_size
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/set_size_2
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/start
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/intr
add wave -noupdate -group {slave 4x1 - 9} -group dmni -divider SR
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/SR
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/cont
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/payload_size
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/last
add wave -noupdate -group {slave 4x1 - 9} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/DMNI_Receive
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/recv_size
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/first
add wave -noupdate -group {slave 4x1 - 9} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 4x1 - 9} -group dmni /test_bench/HeMPS/slave4x1/dmni/DMNI_Send
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 4x1 - 9} -group {switch control} /test_bench/HeMPS/slave4x1/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 4x1 - 9} -group ports -group {router 4x1 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 4x1 - 9} -group LOCAL -group {router 4x1 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x1/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 0x2 - 10} /test_bench/HeMPS/slave0x2/clock

add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/irq
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/int_seek
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/irq_mask_reg
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/irq_status
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/cpu/mem_address
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/cpu/mem_byte_we
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/cpu/mem_data_r
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/cpu/mem_data_w
add wave -noupdate -group {slave 0x2 - 10} -group pe /test_bench/HeMPS/slave0x2/cpu/page
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/clock
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/external_fail_in
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/external_fail_out
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/fail_in
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/fail_out
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/router_fail_in
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/router_fail_out
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/wrapper_reg
add wave -noupdate -group {slave 0x2 - 10} -group faults /test_bench/HeMPS/slave0x2/io_packet_mask
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output E} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output W} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output N} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output S} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {input L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group {output L} /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 0x2 - 10} -group seek -group signals /test_bench/HeMPS/slave0x2/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/clock
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/reset
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/EA_in
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/EA_out
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN//last
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/first
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_source
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_target
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_service
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 0x2 - 10} -group fifo_PDN /test_bench/HeMPS/slave0x2/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 0x2 - 10} -group fail_WRAPPER_module /test_bench/HeMPS/slave0x2/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/dmni_timeout
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/mem_address
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/mem_byte_we
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/mem_data_read
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/mem_data_write
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/config_data
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/receive_active
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/send_active
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/set_address
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/set_address_2
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/set_op
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/set_size
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/set_size_2
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/start
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/intr
add wave -noupdate -group {slave 0x2 - 10} -group dmni -divider SR
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/SR
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/cont
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/payload_size
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/last
add wave -noupdate -group {slave 0x2 - 10} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/DMNI_Receive
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/recv_size
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/first
add wave -noupdate -group {slave 0x2 - 10} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 0x2 - 10} -group dmni /test_bench/HeMPS/slave0x2/dmni/DMNI_Send
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 0x2 - 10} -group {switch control} /test_bench/HeMPS/slave0x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 0x2 - 10} -group ports -group {router 0x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 0x2 - 10} -group LOCAL -group {router 0x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave0x2/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 1x2 - 11} /test_bench/HeMPS/slave1x2/clock

add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/irq
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/int_seek
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/irq_mask_reg
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/irq_status
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/cpu/mem_address
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/cpu/mem_byte_we
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/cpu/mem_data_r
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/cpu/mem_data_w
add wave -noupdate -group {slave 1x2 - 11} -group pe /test_bench/HeMPS/slave1x2/cpu/page
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/clock
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/external_fail_in
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/external_fail_out
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/fail_in
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/fail_out
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/router_fail_in
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/router_fail_out
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/wrapper_reg
add wave -noupdate -group {slave 1x2 - 11} -group faults /test_bench/HeMPS/slave1x2/io_packet_mask
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output E} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output W} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output N} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output S} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {input L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group {output L} /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 1x2 - 11} -group seek -group signals /test_bench/HeMPS/slave1x2/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/clock
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/reset
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/EA_in
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/EA_out
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN//last
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/first
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_source
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_target
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_service
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 1x2 - 11} -group fifo_PDN /test_bench/HeMPS/slave1x2/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 1x2 - 11} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x2/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/dmni_timeout
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/mem_address
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/mem_byte_we
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/mem_data_read
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/mem_data_write
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/config_data
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/receive_active
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/send_active
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/set_address
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/set_address_2
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/set_op
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/set_size
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/set_size_2
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/start
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/intr
add wave -noupdate -group {slave 1x2 - 11} -group dmni -divider SR
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/SR
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/cont
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/payload_size
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/last
add wave -noupdate -group {slave 1x2 - 11} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/DMNI_Receive
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/recv_size
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/first
add wave -noupdate -group {slave 1x2 - 11} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 1x2 - 11} -group dmni /test_bench/HeMPS/slave1x2/dmni/DMNI_Send
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 1x2 - 11} -group {switch control} /test_bench/HeMPS/slave1x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 1x2 - 11} -group ports -group {router 1x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 1x2 - 11} -group LOCAL -group {router 1x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x2/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 2x2 - 12} /test_bench/HeMPS/slave2x2/clock

add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/irq
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/int_seek
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/irq_mask_reg
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/irq_status
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/cpu/mem_address
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/cpu/mem_byte_we
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/cpu/mem_data_r
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/cpu/mem_data_w
add wave -noupdate -group {slave 2x2 - 12} -group pe /test_bench/HeMPS/slave2x2/cpu/page
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/clock
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/external_fail_in
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/external_fail_out
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/fail_in
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/fail_out
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/router_fail_in
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/router_fail_out
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/wrapper_reg
add wave -noupdate -group {slave 2x2 - 12} -group faults /test_bench/HeMPS/slave2x2/io_packet_mask
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output E} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output W} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output N} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output S} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {input L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group {output L} /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 2x2 - 12} -group seek -group signals /test_bench/HeMPS/slave2x2/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/clock
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/reset
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/EA_in
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/EA_out
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN//last
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/first
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_source
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_target
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_service
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 2x2 - 12} -group fifo_PDN /test_bench/HeMPS/slave2x2/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 2x2 - 12} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x2/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/dmni_timeout
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/mem_address
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/mem_byte_we
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/mem_data_read
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/mem_data_write
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/config_data
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/receive_active
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/send_active
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/set_address
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/set_address_2
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/set_op
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/set_size
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/set_size_2
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/start
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/intr
add wave -noupdate -group {slave 2x2 - 12} -group dmni -divider SR
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/SR
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/cont
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/payload_size
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/last
add wave -noupdate -group {slave 2x2 - 12} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/DMNI_Receive
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/recv_size
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/first
add wave -noupdate -group {slave 2x2 - 12} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 2x2 - 12} -group dmni /test_bench/HeMPS/slave2x2/dmni/DMNI_Send
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 2x2 - 12} -group {switch control} /test_bench/HeMPS/slave2x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 2x2 - 12} -group ports -group {router 2x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 2x2 - 12} -group LOCAL -group {router 2x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x2/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 3x2 - 13} /test_bench/HeMPS/slave3x2/clock

add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/irq
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/int_seek
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/irq_mask_reg
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/irq_status
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/cpu/mem_address
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/cpu/mem_byte_we
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/cpu/mem_data_r
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/cpu/mem_data_w
add wave -noupdate -group {slave 3x2 - 13} -group pe /test_bench/HeMPS/slave3x2/cpu/page
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/clock
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/external_fail_in
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/external_fail_out
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/fail_in
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/fail_out
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/router_fail_in
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/router_fail_out
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/wrapper_reg
add wave -noupdate -group {slave 3x2 - 13} -group faults /test_bench/HeMPS/slave3x2/io_packet_mask
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output E} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output W} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output N} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output S} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {input L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group {output L} /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 3x2 - 13} -group seek -group signals /test_bench/HeMPS/slave3x2/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/clock
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/reset
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/EA_in
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/EA_out
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN//last
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/first
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_source
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_target
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_service
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 3x2 - 13} -group fifo_PDN /test_bench/HeMPS/slave3x2/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 3x2 - 13} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x2/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/dmni_timeout
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/mem_address
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/mem_byte_we
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/mem_data_read
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/mem_data_write
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/config_data
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/receive_active
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/send_active
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/set_address
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/set_address_2
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/set_op
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/set_size
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/set_size_2
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/start
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/intr
add wave -noupdate -group {slave 3x2 - 13} -group dmni -divider SR
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/SR
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/cont
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/payload_size
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/last
add wave -noupdate -group {slave 3x2 - 13} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/DMNI_Receive
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/recv_size
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/first
add wave -noupdate -group {slave 3x2 - 13} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 3x2 - 13} -group dmni /test_bench/HeMPS/slave3x2/dmni/DMNI_Send
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 3x2 - 13} -group {switch control} /test_bench/HeMPS/slave3x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 3x2 - 13} -group ports -group {router 3x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 3x2 - 13} -group LOCAL -group {router 3x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x2/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 4x2 - 14} /test_bench/HeMPS/slave4x2/clock

add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/irq
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/int_seek
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/irq_mask_reg
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/irq_status
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/cpu/mem_address
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/cpu/mem_byte_we
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/cpu/mem_data_r
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/cpu/mem_data_w
add wave -noupdate -group {slave 4x2 - 14} -group pe /test_bench/HeMPS/slave4x2/cpu/page
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/clock
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/external_fail_in
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/external_fail_out
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/fail_in
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/fail_out
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/router_fail_in
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/router_fail_out
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/wrapper_reg
add wave -noupdate -group {slave 4x2 - 14} -group faults /test_bench/HeMPS/slave4x2/io_packet_mask
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output E} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output W} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output N} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output S} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {input L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group {output L} /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 4x2 - 14} -group seek -group signals /test_bench/HeMPS/slave4x2/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/clock
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/reset
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/EA_in
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/EA_out
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN//last
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/first
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_source
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_target
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_service
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 4x2 - 14} -group fifo_PDN /test_bench/HeMPS/slave4x2/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 4x2 - 14} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x2/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/dmni_timeout
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/mem_address
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/mem_byte_we
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/mem_data_read
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/mem_data_write
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/config_data
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/receive_active
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/send_active
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/set_address
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/set_address_2
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/set_op
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/set_size
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/set_size_2
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/start
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/intr
add wave -noupdate -group {slave 4x2 - 14} -group dmni -divider SR
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/SR
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/cont
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/payload_size
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/last
add wave -noupdate -group {slave 4x2 - 14} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/DMNI_Receive
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/recv_size
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/first
add wave -noupdate -group {slave 4x2 - 14} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 4x2 - 14} -group dmni /test_bench/HeMPS/slave4x2/dmni/DMNI_Send
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 4x2 - 14} -group {switch control} /test_bench/HeMPS/slave4x2/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 4x2 - 14} -group ports -group {router 4x2 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 4x2 - 14} -group LOCAL -group {router 4x2 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x2/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {local 0x3 - 15} /test_bench/HeMPS/local0x3/clock

add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/irq
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/int_seek
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/irq_mask_reg
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/irq_status
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/cpu/mem_address
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/cpu/mem_byte_we
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/cpu/mem_data_r
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/cpu/mem_data_w
add wave -noupdate -group {local 0x3 - 15} -group pe /test_bench/HeMPS/local0x3/cpu/page
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/clock
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/external_fail_in
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/external_fail_out
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/fail_in
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/fail_out
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/router_fail_in
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/router_fail_out
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/wrapper_reg
add wave -noupdate -group {local 0x3 - 15} -group faults /test_bench/HeMPS/local0x3/io_packet_mask
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output E} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output W} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output N} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output S} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {input L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group {output L} /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/task
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {local 0x3 - 15} -group seek -group signals /test_bench/HeMPS/local0x3/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/clock
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/reset
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/EA_in
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/EA_out
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN//last
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/first
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_req_pe
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_source
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_target
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_payload
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_service
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_opmode
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {local 0x3 - 15} -group fifo_PDN /test_bench/HeMPS/local0x3/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/clock
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/reset
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {local 0x3 - 15} -group fail_WRAPPER_module /test_bench/HeMPS/local0x3/fail_WRAPPER_module/EA_in
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/dmni_timeout
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/mem_address
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/mem_byte_we
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/mem_data_read
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/mem_data_write
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/config_data
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/receive_active
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/send_active
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/set_address
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/set_address_2
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/set_op
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/set_size
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/set_size_2
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/start
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/intr
add wave -noupdate -group {local 0x3 - 15} -group dmni -divider SR
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/SR
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/cont
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/payload_size
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/last
add wave -noupdate -group {local 0x3 - 15} -group dmni -divider DMNI_Receive
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/DMNI_Receive
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/recv_size
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/first
add wave -noupdate -group {local 0x3 - 15} -group dmni -divider DMNI_Send
add wave -noupdate -group {local 0x3 - 15} -group dmni /test_bench/HeMPS/local0x3/dmni/DMNI_Send
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {local 0x3 - 15} -group {switch control} /test_bench/HeMPS/local0x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output E1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output W1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output N1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S0} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(7)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(7)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 input S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(7)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(7)
add wave -noupdate -group {local 0x3 - 15} -group ports -group {router 0x3 output S1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 input L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 input L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/rx(9)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 input L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_in(9)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 input L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 output L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 output L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/tx(9)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 output L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/data_out(9)
add wave -noupdate -group {local 0x3 - 15} -group LOCAL -group {router 0x3 output L1} -radix hexadecimal /test_bench/HeMPS/local0x3/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 1x3 - 16} /test_bench/HeMPS/slave1x3/clock

add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/irq
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/int_seek
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/irq_mask_reg
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/irq_status
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/cpu/mem_address
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/cpu/mem_byte_we
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/cpu/mem_data_r
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/cpu/mem_data_w
add wave -noupdate -group {slave 1x3 - 16} -group pe /test_bench/HeMPS/slave1x3/cpu/page
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/clock
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/external_fail_in
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/external_fail_out
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/fail_in
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/fail_out
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/router_fail_in
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/router_fail_out
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/wrapper_reg
add wave -noupdate -group {slave 1x3 - 16} -group faults /test_bench/HeMPS/slave1x3/io_packet_mask
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output E} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output W} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output N} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output S} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {input L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group {output L} /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 1x3 - 16} -group seek -group signals /test_bench/HeMPS/slave1x3/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/clock
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/reset
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/EA_in
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/EA_out
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN//last
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/first
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_source
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_target
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_service
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 1x3 - 16} -group fifo_PDN /test_bench/HeMPS/slave1x3/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 1x3 - 16} -group fail_WRAPPER_module /test_bench/HeMPS/slave1x3/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/dmni_timeout
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/mem_address
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/mem_byte_we
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/mem_data_read
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/mem_data_write
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/config_data
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/receive_active
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/send_active
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/set_address
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/set_address_2
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/set_op
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/set_size
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/set_size_2
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/start
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/intr
add wave -noupdate -group {slave 1x3 - 16} -group dmni -divider SR
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/SR
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/cont
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/payload_size
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/last
add wave -noupdate -group {slave 1x3 - 16} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/DMNI_Receive
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/recv_size
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/first
add wave -noupdate -group {slave 1x3 - 16} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 1x3 - 16} -group dmni /test_bench/HeMPS/slave1x3/dmni/DMNI_Send
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 1x3 - 16} -group {switch control} /test_bench/HeMPS/slave1x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 1x3 - 16} -group ports -group {router 1x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 1x3 - 16} -group LOCAL -group {router 1x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave1x3/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 2x3 - 17} /test_bench/HeMPS/slave2x3/clock

add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/irq
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/int_seek
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/irq_mask_reg
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/irq_status
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/cpu/mem_address
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/cpu/mem_byte_we
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/cpu/mem_data_r
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/cpu/mem_data_w
add wave -noupdate -group {slave 2x3 - 17} -group pe /test_bench/HeMPS/slave2x3/cpu/page
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/clock
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/external_fail_in
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/external_fail_out
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/fail_in
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/fail_out
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/router_fail_in
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/router_fail_out
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/wrapper_reg
add wave -noupdate -group {slave 2x3 - 17} -group faults /test_bench/HeMPS/slave2x3/io_packet_mask
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output E} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output W} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output N} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output S} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {input L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group {output L} /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 2x3 - 17} -group seek -group signals /test_bench/HeMPS/slave2x3/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/clock
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/reset
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/EA_in
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/EA_out
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN//last
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/first
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_source
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_target
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_service
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 2x3 - 17} -group fifo_PDN /test_bench/HeMPS/slave2x3/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 2x3 - 17} -group fail_WRAPPER_module /test_bench/HeMPS/slave2x3/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/dmni_timeout
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/mem_address
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/mem_byte_we
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/mem_data_read
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/mem_data_write
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/config_data
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/receive_active
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/send_active
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/set_address
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/set_address_2
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/set_op
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/set_size
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/set_size_2
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/start
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/intr
add wave -noupdate -group {slave 2x3 - 17} -group dmni -divider SR
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/SR
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/cont
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/payload_size
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/last
add wave -noupdate -group {slave 2x3 - 17} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/DMNI_Receive
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/recv_size
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/first
add wave -noupdate -group {slave 2x3 - 17} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 2x3 - 17} -group dmni /test_bench/HeMPS/slave2x3/dmni/DMNI_Send
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 2x3 - 17} -group {switch control} /test_bench/HeMPS/slave2x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 2x3 - 17} -group ports -group {router 2x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 2x3 - 17} -group LOCAL -group {router 2x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave2x3/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 3x3 - 18} /test_bench/HeMPS/slave3x3/clock

add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/irq
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/int_seek
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/irq_mask_reg
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/irq_status
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/cpu/mem_address
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/cpu/mem_byte_we
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/cpu/mem_data_r
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/cpu/mem_data_w
add wave -noupdate -group {slave 3x3 - 18} -group pe /test_bench/HeMPS/slave3x3/cpu/page
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/clock
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/external_fail_in
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/external_fail_out
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/fail_in
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/fail_out
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/router_fail_in
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/router_fail_out
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/wrapper_reg
add wave -noupdate -group {slave 3x3 - 18} -group faults /test_bench/HeMPS/slave3x3/io_packet_mask
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output E} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output W} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output N} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output S} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {input L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group {output L} /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 3x3 - 18} -group seek -group signals /test_bench/HeMPS/slave3x3/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/clock
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/reset
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/EA_in
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/EA_out
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN//last
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/first
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_source
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_target
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_service
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 3x3 - 18} -group fifo_PDN /test_bench/HeMPS/slave3x3/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 3x3 - 18} -group fail_WRAPPER_module /test_bench/HeMPS/slave3x3/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/dmni_timeout
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/mem_address
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/mem_byte_we
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/mem_data_read
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/mem_data_write
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/config_data
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/receive_active
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/send_active
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/set_address
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/set_address_2
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/set_op
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/set_size
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/set_size_2
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/start
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/intr
add wave -noupdate -group {slave 3x3 - 18} -group dmni -divider SR
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/SR
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/cont
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/payload_size
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/last
add wave -noupdate -group {slave 3x3 - 18} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/DMNI_Receive
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/recv_size
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/first
add wave -noupdate -group {slave 3x3 - 18} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 3x3 - 18} -group dmni /test_bench/HeMPS/slave3x3/dmni/DMNI_Send
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 3x3 - 18} -group {switch control} /test_bench/HeMPS/slave3x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 3x3 - 18} -group ports -group {router 3x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 3x3 - 18} -group LOCAL -group {router 3x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave3x3/RouterCCwrapped/eop_out(9)
add wave -noupdate -group {slave 4x3 - 19} /test_bench/HeMPS/slave4x3/clock

add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/irq
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/int_seek
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/irq_mask_reg
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/irq_status
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/cpu/mem_address
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/cpu/mem_byte_we
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/cpu/mem_data_r
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/cpu/mem_data_w
add wave -noupdate -group {slave 4x3 - 19} -group pe /test_bench/HeMPS/slave4x3/cpu/page
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/clock
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/external_fail_in
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/external_fail_out
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/fail_in
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/fail_out
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/router_fail_in
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/router_fail_out
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/wrapper_reg
add wave -noupdate -group {slave 4x3 - 19} -group faults /test_bench/HeMPS/slave4x3/io_packet_mask
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_req_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_nack_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_service_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_source_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_target_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_payload_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_req_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_ack_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_nack_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_service_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_source_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_target_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output E} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_payload_router_seek(0)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_req_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_nack_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_service_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_source_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_target_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_payload_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_req_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_ack_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_nack_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_service_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_source_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_target_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output W} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_payload_router_seek(1)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_req_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_nack_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_service_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_source_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_target_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_payload_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_req_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_ack_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_nack_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_service_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_source_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_target_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output N} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_payload_router_seek(2)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_req_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_nack_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_service_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_source_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_target_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_payload_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_req_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_ack_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_nack_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_service_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_source_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_target_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output S} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_payload_router_seek(3)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_req_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_nack_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_service_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_source_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_target_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {input L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_payload_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_req_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_ack_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_nack_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_service_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_source_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_target_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group {output L} /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_payload_router_seek(4)
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/router_address
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/backtrack_id
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/EA_manager
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/EA_manager_input
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/sel_port
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/next_port
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/req_int
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/task
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/req_task
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/sel
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/prox
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/free_index
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/source_index
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/source_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/target_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/service_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/payload_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/opmode_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/my_payload_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/backtrack_port_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/source_router_port_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/used_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/pending_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/pending_local
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/int_out_ack_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_nack_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_ack_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_fail_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/fail_with_mode_in
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/fail_with_mode_out
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/int_in_req_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_nack_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_ack_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/int_in_ack_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_source_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_target_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_payload_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_service_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_opmode_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/int_out_req_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_service_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_source_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_target_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_payload_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/out_opmode_router_seek
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/backtrack_port
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/reg_backtrack
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/vector_ack_ports
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/vector_nack_ports
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/in_the_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/space_aval_in_the_table
add wave -noupdate -group {slave 4x3 - 19} -group seek -group signals /test_bench/HeMPS/slave4x3/router_seek_wrapped/router_seek/is_my_turn_send_backtrack
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/clock
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/reset
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/EA_in
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/EA_out
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN//last
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/first
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/tem_espaco_na_fila
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_source_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_target_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_payload_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_service_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_reg_backtrack_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_sel_reg_backtrack
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_req_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_ack_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_opmode_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_req_send_kernel_seek_local
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/in_ack_send_kernel_seek_local
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_service_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_source_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_target_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_payload_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_sel_reg_backtrack_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_reg_backtrack
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_req_pe
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_ack_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_nack_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/out_opmode_fifo_seek
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_source
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_target
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_payload
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_service
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_opmode
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_backtrack1
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_backtrack2
add wave -noupdate -group {slave 4x3 - 19} -group fifo_PDN /test_bench/HeMPS/slave4x3/fifo_PDN/buffer_backtrack3
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/clock
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/reset
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_fail_cpu_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_fail_cpu_config
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/mem_address_service_fail_cpu
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_source_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_target_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_payload_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_service_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_req_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_opmode_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_fail_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_ack_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_nack_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_source_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_target_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_payload_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_service_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_req_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_opmode_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/out_fail_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_ack_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_nack_wrapper_local
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_source_router
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/in_target_router
add wave -noupdate -group {slave 4x3 - 19} -group fail_WRAPPER_module /test_bench/HeMPS/slave4x3/fail_WRAPPER_module/EA_in
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/dmni_timeout
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/mem_address
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/mem_byte_we
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/mem_data_read
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/mem_data_write
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/config_data
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/receive_active
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/send_active
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/set_address
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/set_address_2
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/set_op
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/set_size
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/set_size_2
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/start
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/intr
add wave -noupdate -group {slave 4x3 - 19} -group dmni -divider SR
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/SR
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/cont
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/payload_size
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/last
add wave -noupdate -group {slave 4x3 - 19} -group dmni -divider DMNI_Receive
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/DMNI_Receive
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/recv_size
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/first
add wave -noupdate -group {slave 4x3 - 19} -group dmni -divider DMNI_Send
add wave -noupdate -group {slave 4x3 - 19} -group dmni /test_bench/HeMPS/slave4x3/dmni/DMNI_Send
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr
add wave -noupdate -group {slave 4x3 - 19} -group {switch control} /test_bench/HeMPS/slave4x3/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(0)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output E1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(1)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(2)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output W1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(3)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(4)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output N1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(5)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S0} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(6)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(7)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(7)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(7)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 input S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(7)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(7)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(7)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(7)
add wave -noupdate -group {slave 4x3 - 19} -group ports -group {router 4x3 output S1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(7)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_o(9)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/rx(9)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_in(9)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 input L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_in(9)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/credit_i(9)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/tx(9)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/data_out(9)
add wave -noupdate -group {slave 4x3 - 19} -group LOCAL -group {router 4x3 output L1} -radix hexadecimal /test_bench/HeMPS/slave4x3/RouterCCwrapped/eop_out(9)
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/reset
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_source_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_target_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_payload_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_service_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_req_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_ack_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_opmode_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_service_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_source_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_target_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_payload_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_ack_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_req_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_nack_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_opmode_router_seek_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_tx_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/tx_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_out_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_i_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_in_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_rx_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/rx_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_in_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_o_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_out_primary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_source_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_target_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_payload_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_service_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_req_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_ack_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_opmode_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_service_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_source_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_target_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_payload_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_ack_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_req_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_nack_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_opmode_router_seek_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_tx_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/tx_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_out_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_i_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_in_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_rx_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/rx_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_in_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_o_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_out_secondary
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_in_datanoc
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_out_datanoc
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_in_brnoc
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_out_brnoc
add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_manager
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 242
configure wave -valuecolwidth 108
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps

