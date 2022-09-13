from sys import argv

if len(argv) == 6:
	scriptname,MAX_X,MAX_Y,MAX_CLUSTER_X,MAX_CLUSTER_Y,master_pe = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=int(MAX_CLUSTER_X)
	MAX_CLUSTER_Y=int(MAX_CLUSTER_Y)
	master_pe=int(master_pe)
elif len(argv) == 5:
	scriptname,MAX_X,MAX_Y,MAX_CLUSTER_X,MAX_CLUSTER_Y = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=int(MAX_CLUSTER_X)
	MAX_CLUSTER_Y=int(MAX_CLUSTER_Y)
	master_pe=0
elif len(argv) == 4:
	scriptname,MAX_X,MAX_Y,master_pe = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=0
	MAX_CLUSTER_Y=0
	master_pe=int(master_posX, posY)
elif len(argv) == 3:
	scriptname,MAX_X,MAX_Y = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=0
	MAX_CLUSTER_Y=0
	master_pe=0
else:
	print ("usage:\n"
	+ "wavegen.py [MAX_X] [MAX_Y] [MAX_CLUSTER_X] [MAX_CLUSTER_Y] [master position]\n"
	+ "	wavegen.py 4 4 2 2 0: 4x4 MPSOC with master on 0x0\n"
	+ "wavegen.py [MAX_X] [MAX_Y] : assumes master on 0 and just one cluster")
	#print "argv[0] %s \nargv[1] %s \nargv[2] %s \nargv[3] %s \nargv[4] %s \n" % (scriptname, MAX_X, MAX_Y, MAX_CLUSTER_X, MAX_CLUSTER_Y)
	exit();

max_pe=MAX_X*MAX_Y
portname=["E0","E1","W0","W1","N0","N1","S0","S1","L0","L1"]
portseek=["E","W","N","S","L"]

posX=0
posY=0

print ("onerror {resume}\n\
quietly WaveActivateNextPane {} 0\n")

# print "printing MPSOC %dx%d master on %d" % (MAX_X,MAX_Y,master_posX, posY)
# print (f"MAX_X = {MAX_X:d} \n"
# + f"MAX_Y = {MAX_Y:d} \n"
# + f"MAX_CLUSTER_X = {MAX_CLUSTER_X:d} \n"
# + f"MAX_CLUSTER_Y = {MAX_CLUSTER_Y:d}")

for pe in range(0,max_pe):
	if(MAX_CLUSTER_X == MAX_X and  MAX_CLUSTER_Y == MAX_Y): # Sem clusterização
		if master_pe==pe:
			pe_type_str="local"
		else:
			pe_type_str="slave"
	elif MAX_CLUSTER_X == 0:
		if master_pe==pe:
			pe_type_str="local"
		else:
			pe_type_str="slave"
	elif(MAX_CLUSTER_X != MAX_CLUSTER_Y or MAX_X != MAX_Y):
		if pe == master_pe:
			pe_type_str="local"
		elif(((posX == MAX_CLUSTER_X) or (posX == 0)) and ((posY == MAX_X*MAX_CLUSTER_Y) or (posY+MAX_CLUSTER_X==MAX_CLUSTER_Y*MAX_X))):
			pe_type_str="local"
		elif ((posX == MAX_CLUSTER_X or posX == 0) and (posY == 0)):
			pe_type_str="local"
		else:
			pe_type_str="slave"
	else:
		if ((posX % MAX_CLUSTER_X) == 0) and ((posY % MAX_CLUSTER_Y)== 0):
			pe_type_str="local"
		else:
			pe_type_str="slave"

	# print "PE %dx%d" % (posX,posY)

	print ("add wave -noupdate -group {%s %dx%d - %d} /test_bench/HeMPS/%s%dx%d/clock\n" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY))

	#pe signals
	group_pe_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	group_pe_signals_sds = ['irq','int_seek','irq_mask_reg','irq_status','cpu/mem_address','cpu/mem_byte_we','cpu/mem_data_r','cpu/mem_data_w','cpu/page','ap_mask','ke','kap']
	for it in map(lambda sd: group_pe_signals_pfx + sd,group_pe_signals_sds):
		print (it)
	#faults signals
	group_faults_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	group_faults_signals_sds = ['clock','external_fail_in','external_fail_out','fail_in','fail_out','router_fail_in','router_fail_out','wrapper_reg']
	for it in map(lambda sd: group_faults_signals_pfx + sd,group_faults_signals_sds):
		print (it)

	for port in range(0,5):
		#SEEK signals
		seek_input_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/" % (pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY)
		seek_input_sds = ["out_ack_router_seek", "in_req_router_seek", "out_ack_router_seek", "out_nack_router_seek", "in_service_router_seek", "in_source_router_seek", "in_target_router_seek", "in_payload_router_seek"]
        
		seek_output_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/" %	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY)
		seek_output_sds = ["out_req_router_seek", "in_ack_router_seek", "in_nack_router_seek", "out_service_router_seek", "out_source_router_seek", "out_target_router_seek", "out_payload_router_seek"]
		
		for it in map(lambda sd: seek_input_pfx+sd+f"({port:d})",seek_input_sds):
			print(it)

		for it in map(lambda sd: seek_output_pfx+sd+f"({port:d})",seek_output_sds):
			print(it)

	signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	signals_sds = ["router_address", "backtrack_id", "EA_manager", "EA_manager_input", "sel_port", "next_port", "req_int", "task", "req_task", "sel", "prox", "free_index", "source_index", "source_table", "target_table", "service_table", "payload_table", "opmode_table", "my_payload_table", "backtrack_port_table", "source_router_port_table", "used_table", "pending_table", "pending_local", "int_out_ack_router_seek", "out_nack_router_seek", "out_ack_router_seek", "in_fail_router_seek", "fail_with_mode_in", "fail_with_mode_out", "int_in_req_router_seek", "in_nack_router_seek", "in_ack_router_seek", "int_in_ack_router_seek", "in_source_router_seek", "in_target_router_seek", "in_payload_router_seek", "in_service_router_seek", "in_opmode_router_seek", "int_out_req_router_seek", "out_service_router_seek", "out_source_router_seek", "out_target_router_seek", "out_payload_router_seek", "out_opmode_router_seek", "backtrack_port", "reg_backtrack", "vector_ack_ports", "vector_nack_ports", "in_the_table", "space_aval_in_the_table", "is_my_turn_send_backtrack"]
	for it in map(lambda sd: signals_pfx + sd, signals_sds):
		print (it)
		
	# #fifo_PDN signals
	fifo_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	fifo_signals_sds = ["clock", "reset", "EA_in", "EA_out", "/last", "first", "tem_espaco_na_fila", "in_source_fifo_seek", "in_target_fifo_seek", "in_payload_fifo_seek", "in_service_fifo_seek", "in_reg_backtrack_seek", "in_sel_reg_backtrack", "in_req_fifo_seek", "in_ack_fifo_seek", "in_opmode_fifo_seek", "out_req_send_kernel_seek_local", "in_ack_send_kernel_seek_local", "out_service_fifo_seek", "out_source_fifo_seek", "out_target_fifo_seek", "out_payload_fifo_seek", "out_sel_reg_backtrack_seek", "out_reg_backtrack" , "out_req_pe", "out_ack_fifo_seek", "out_nack_fifo_seek", "out_opmode_fifo_seek", "buffer_source" , "buffer_target", "buffer_payload", "buffer_service", "buffer_opmode", "buffer_backtrack1", "buffer_backtrack2", "buffer_backtrack3"]
	for it in map(lambda sd: fifo_signals_pfx + sd, fifo_signals_sds):
		print (it)
    
	#fail_wrapper_module signals
	fail_wrapper_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	fail_wrapper_signals_sds = ["clock", "reset", "in_fail_cpu_local", "in_fail_cpu_config", "mem_address_service_fail_cpu", "in_source_wrapper_local", "in_target_wrapper_local", "in_payload_wrapper_local", "in_service_wrapper_local", "in_req_wrapper_local", "in_opmode_wrapper_local", "in_fail_wrapper_local", "out_ack_wrapper_local", "out_nack_wrapper_local", "out_source_wrapper_local", "out_target_wrapper_local", "out_payload_wrapper_local", "out_service_wrapper_local", "out_req_wrapper_local", "out_opmode_wrapper_local", "out_fail_wrapper_local", "in_ack_wrapper_local", "in_nack_wrapper_local", "in_source_router", "in_target_router", "EA_in"]
	for it in map(lambda sd: fail_wrapper_signals_pfx + sd, fail_wrapper_signals_sds):
		print (it)

	# dmni signals
	dmni_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	dmni_dividers_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group dmni -divider " % (pe_type_str, posX, posY, pe)
	dmni_signals_sds = ["dmni_timeout"	,"mem_address", "mem_byte_we", "mem_data_read", "mem_data_write", "config_data", "receive_active", "send_active", "set_address", "set_address_2", "set_op", "set_size", "set_size_2", "start", "intr"]
	for it in map(lambda sd: dmni_signals_pfx + sd, dmni_signals_sds):
		print (it)

	print (dmni_dividers_pfx +"SR")
	dmni_signals_sds2=["SR","cont","payload_size","last"]
	for it in map(lambda sd: dmni_signals_pfx + sd, dmni_signals_sds2):
		print (it)

	print (dmni_dividers_pfx +"DMNI_Receive")
	dmni_signals_sds3=["DMNI_Receive","recv_size","first"]
	for it in map(lambda sd: dmni_signals_pfx + sd, dmni_signals_sds3):
		print (it)
		
	print (dmni_dividers_pfx +"DMNI_Send")
	print (dmni_signals_pfx+"DMNI_Send")

	router_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	router_sds = ["EA","ask","ack_routing","address","clock","data_in_header","data_in_header_fixed","dirx","diry","enable_shift", "free_port","header","header_fixed","lx","next_flit","prox","req_routing" ,"reset","rot_table","sel","sender","source" ,"target","target_internal","try_again","tx","w_addr","w_source_target"]
	for it in map (lambda sd: router_pfx + sd, router_sds):
		print (it)

	# for port in range(0,8):
	for port in range(0,10):
		if port != 8: 
			if port == 9:
				location = "LOCAL"
			else:
				location = "ports"
				
			router_input_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/" % 	(pe_type_str, posX, posY, pe,location, posX, posY, portname[port], pe_type_str, posX, posY)
			router_input_sds = ["credit_o", "rx","data_in", "eop_in"]
			for it in map(lambda sd: router_input_pfx + sd + f"({port:d})",router_input_sds):
				print (it)
			
			router_output_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/" % 	(pe_type_str, posX, posY, pe, location, posX, posY, portname[port], pe_type_str, posX, posY)
			router_output_sds = ["credit_i","tx","data_out","eop_out"]
								 
			for it in map(lambda sd: router_output_pfx + sd + f"({port:d})",router_output_sds):
				print (it)

	if pe%MAX_X==MAX_X-1:
		posX=0
		posY=posY+1
	else:
		posX=posX+1

#INJECTOR SIGNALS
injectors_pfx = "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/"
injectors_sds = ["clock", "reset", "in_source_router_seek_primary", "in_target_router_seek_primary", "in_payload_router_seek_primary", "in_service_router_seek_primary", "in_req_router_seek_primary", "in_ack_router_seek_primary", "in_opmode_router_seek_primary", "out_service_router_seek_primary", "out_source_router_seek_primary", "out_target_router_seek_primary", "out_payload_router_seek_primary", "out_ack_router_seek_primary", "out_req_router_seek_primary", "out_nack_router_seek_primary", "out_opmode_router_seek_primary", "clock_tx_primary", "tx_primary", "data_out_primary", "credit_i_primary", "eop_in_primary", "clock_rx_primary", "rx_primary", "data_in_primary", "credit_o_primary", "eop_out_primary", "in_source_router_seek_secondary", "in_target_router_seek_secondary", "in_payload_router_seek_secondary", "in_service_router_seek_secondary", "in_req_router_seek_secondary", "in_ack_router_seek_secondary", "in_opmode_router_seek_secondary", "out_service_router_seek_secondary", "out_source_router_seek_secondary", "out_target_router_seek_secondary", "out_payload_router_seek_secondary", "out_ack_router_seek_secondary", "out_req_router_seek_secondary", "out_nack_router_seek_secondary", "out_opmode_router_seek_secondary", "clock_tx_secondary", "tx_secondary", "data_out_secondary", "credit_i_secondary", "eop_in_secondary", "clock_rx_secondary", "rx_secondary", "data_in_secondary", "credit_o_secondary", "eop_out_secondary", "EA_in_datanoc", "EA_out_datanoc", "EA_in_brnoc", "EA_out_brnoc", "EA_manager"]
for it in map(lambda sd: injectors_pfx + sd, injectors_sds):
	print (it)

#IO_PERIPHERAL SIGNALS
io_peripheral_pfx="add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/"
io_peripheral_sds=["clock", "reset", "in_source_router_seek_primary", "in_target_router_seek_primary", "in_payload_router_seek_primary", "in_service_router_seek_primary", "in_req_router_seek_primary", "in_ack_router_seek_primary", "in_opmode_router_seek_primary", "out_service_router_seek_primary", "out_source_router_seek_primary", "out_target_router_seek_primary", "out_payload_router_seek_primary", "out_ack_router_seek_primary", "out_req_router_seek_primary", "out_nack_router_seek_primary", "out_opmode_router_seek_primary", "clock_tx_primary", "tx_primary", "data_out_primary", "credit_i_primary", "eop_in_primary", "clock_rx_primary", "rx_primary", "data_in_primary", "credit_o_primary", "eop_out_primary", "EA_in", "EA_out", "SR_path"]
for it in map(lambda sd: io_peripheral_pfx + sd, io_peripheral_sds):
	print (it)

#NI SIGNALS
ni_pfx="add wave -noupdate -group NI /test_bench/NI/network_interface/"
ni_sds=["clock", "reset", "hermes_rx", "hermes_data_in", "hermes_eop_in", "hermes_credit_out", "hermes_tx", "hermes_data_out", "hermes_eop_out", "hermes_credit_in", "tableIn_rxOut", "tableOut_rxIn", "tableIn_txOut", "tableOut_txIn", "response_req", "response_param", "tx_status"]
for it in map(lambda sd: ni_pfx + sd, ni_sds):
	print (it)

#NI_TABLE SIGNALS
ni_table_pfx="add wave -noupdate -group NI_Table /test_bench/NI/network_interface/Table/"
ni_table_sds=["state", "is_fetching", "match", "match_regular", "match_crypto", "match_new", "slot", "reset_slot", "enable_counter", "slot_is_last", "read_enable", "table", "read_only_slot", "secondary_match"]
for it in map(lambda sd: ni_table_pfx + sd, ni_table_sds):
	print (it)

#NI_RX SIGNALS
ni_rx_pfx="add wave -noupdate -group NI_RX /test_bench/NI/network_interface/ModuleRX/"
ni_rx_sds=["stage", "start_rx_state", "table_state", "data_state", "finish_rx_state", "respond_state", "routing_header_flit", "header_flit", "path_flit", "hermes_service", "app_id", "crypto_tag", "key_periph", "burst_size", "hermesControl", "tableControl", "unknown_service", "authenticated", "response_necessary", "data_to_write_on_table", "end_of_handling"]
for it in map(lambda sd: ni_rx_pfx + sd, ni_rx_sds):
	print (it)

#NI_TX SIGNALS
ni_tx_pfx="add wave -noupdate -group NI_TX /test_bench/NI/network_interface/ModuleTX/"
ni_tx_sds=["state", "fixed_header_flit", "fixed_header_end", "path_flit", "path_end", "header_flit", "header_end", "response_param_reg"]
for it in map(lambda sd: ni_tx_pfx + sd, ni_tx_sds):
	print (it)

#NI_FIFO_IN SIGNALS
ni_fifo_in_pfx="add wave -noupdate -group NI_FIFO_IN /test_bench/NI/network_interface/InputBuffer/"
ni_fifo_in_sds=["fifo_buffer", "counter", "r_ptr","w_ptr", "underflow","overflow"]
for it in map(lambda sd: ni_fifo_in_pfx + sd, ni_fifo_in_sds):
	print (it)

#NI_FIFO_OUT SIGNALS
ni_fifo_out_pfx="add wave -noupdate -group NI_FIFO_OUT /test_bench/NI/network_interface/OutputBuffer/"
ni_fifo_out_sds=["fifo_buffer", "counter", "r_ptr","w_ptr", "underflow","overflow"]
for it in map(lambda sd: ni_fifo_out_pfx + sd, ni_fifo_out_sds):
	print (it)

print ("TreeUpdate [SetDefaultTree]\n\
WaveRestoreCursors {{Cursor 1} {10 ps} 0}\n\
quietly wave cursor active 1\n\
configure wave -namecolwidth 242\n\
configure wave -valuecolwidth 108\n\
configure wave -justifyvalue left\n\
configure wave -signalnamewidth 1\n\
configure wave -snapdistance 10\n\
configure wave -datasetprefix 0\n\
configure wave -rowmargin 4\n\
configure wave -childrowmargin 2\n\
configure wave -gridoffset 0\n\
configure wave -gridperiod 1\n\
configure wave -griddelta 40\n\
configure wave -timeline 0\n\
configure wave -timelineunits ps\n")
