from sys import argv

if len(argv) == 7:
	scriptname,MAX_X,MAX_Y,MAX_CLUSTER_X,MAX_CLUSTER_Y,master_pe,snip_number = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=int(MAX_CLUSTER_X)
	MAX_CLUSTER_Y=int(MAX_CLUSTER_Y)
	master_pe=int(master_pe)
	snip_number=int(snip_number)
elif len(argv) == 6:
	scriptname,MAX_X,MAX_Y,MAX_CLUSTER_X,MAX_CLUSTER_Y,master_pe = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=int(MAX_CLUSTER_X)
	MAX_CLUSTER_Y=int(MAX_CLUSTER_Y)
	master_pe=int(master_pe)
	snip_number=0
elif len(argv) == 5:
	scriptname,MAX_X,MAX_Y,MAX_CLUSTER_X,MAX_CLUSTER_Y = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=int(MAX_CLUSTER_X)
	MAX_CLUSTER_Y=int(MAX_CLUSTER_Y)
	master_pe=0
	snip_number=0
elif len(argv) == 4:
	scriptname,MAX_X,MAX_Y,master_pe = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=0
	MAX_CLUSTER_Y=0
	master_pe=int(master_posX, posY)
	snip_number=0
elif len(argv) == 3:
	scriptname,MAX_X,MAX_Y = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=0
	MAX_CLUSTER_Y=0
	master_pe=0
	snip_number=0
else:
	print ("usage:\n"
	+ "wavegen.py [MAX_X] [MAX_Y] [MAX_CLUSTER_X] [MAX_CLUSTER_Y] [master position] [snip_number - optional]\n"
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
	group_pe_signals_sds = ['irq','int_seek','irq_mask_reg','irq_status','cpu/mem_address','cpu/mem_byte_we','cpu/mem_data_r','cpu/mem_data_w','cpu/page','ap_mask']
	for it in map(lambda sd: group_pe_signals_pfx + sd,group_pe_signals_sds):
		print (it)
	#security signals
	group_security_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group security /test_bench/HeMPS/%s%dx%d/" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	group_security_signals_sds = ['clock','access_i','access_o', 'link_control_message']
	for it in map(lambda sd: group_security_signals_pfx + sd,group_security_signals_sds):
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
	
	slc_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group seek -group slc /test_bench/HeMPS/%s%dx%d/seek_local_controller/" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	slc_signals_sds = ["pe_target", "pe_source", "pe_service", "pe_payload", "pe_opmode", "pe_req", "pe_ack", "pe_nack", "unr_target", "unr_source", "unr_service", "seek_target", "seek_source", "seek_service", "seek_payload", "seek_opmode", "seek_req", "seek_ack", "seek_nack", "reg_target", "reg_source", "ask_unr", "sending"]
	for it in map(lambda sd: slc_signals_pfx + sd, slc_signals_sds):
		print (it)
		
		
	# #fifo_PDN signals
	fifo_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	fifo_signals_sds = ["clock", "reset", "EA_in", "EA_out", "/last", "first", "tem_espaco_na_fila", "in_source_fifo_seek", "in_target_fifo_seek", "in_payload_fifo_seek", "in_service_fifo_seek", "in_reg_backtrack_seek", "in_sel_reg_backtrack", "in_req_fifo_seek", "in_ack_fifo_seek", "in_opmode_fifo_seek", "out_req_send_kernel_seek_local", "in_ack_send_kernel_seek_local", "out_service_fifo_seek", "out_source_fifo_seek", "out_target_fifo_seek", "out_payload_fifo_seek", "out_sel_reg_backtrack_seek", "out_reg_backtrack" , "out_req_pe", "out_ack_fifo_seek", "out_nack_fifo_seek", "out_opmode_fifo_seek", "buffer_source" , "buffer_target", "buffer_payload", "buffer_service", "buffer_opmode", "buffer_backtrack1", "buffer_backtrack2", "buffer_backtrack3"]
	for it in map(lambda sd: fifo_signals_pfx + sd, fifo_signals_sds):
		print (it)
    
	# #fail_wrapper_module signals
	# fail_wrapper_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	# fail_wrapper_signals_sds = ["clock", "reset", "in_fail_cpu_local", "in_fail_cpu_config", "mem_address_service_fail_cpu", "in_source_wrapper_local", "in_target_wrapper_local", "in_payload_wrapper_local", "in_service_wrapper_local", "in_req_wrapper_local", "in_opmode_wrapper_local", "in_fail_wrapper_local", "out_ack_wrapper_local", "out_nack_wrapper_local", "out_source_wrapper_local", "out_target_wrapper_local", "out_payload_wrapper_local", "out_service_wrapper_local", "out_req_wrapper_local", "out_opmode_wrapper_local", "out_fail_wrapper_local", "in_ack_wrapper_local", "in_nack_wrapper_local", "in_source_router", "in_target_router", "EA_in"]
	# for it in map(lambda sd: fail_wrapper_signals_pfx + sd, fail_wrapper_signals_sds):
	# 	print (it)

	# dmni signals
	dmni_signals_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	dmni_dividers_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group dmni -divider " % (pe_type_str, posX, posY, pe)
	dmni_signals_sds = ["dmni_timeout"	,"mem_address", "mem_byte_we", "mem_data_read", "mem_data_write", "config_data", "receive_active", "send_active", "set_address", "set_address_2", "set_op", "set_size", "set_size_2", "start", "intr"]
	for it in map(lambda sd: dmni_signals_pfx + sd, dmni_signals_sds):
		print (it)

	print (dmni_dividers_pfx +"SR")
	dmni_signals_sds2=["SR","cont","payload_size","last", "pig_signal"]
	for it in map(lambda sd: dmni_signals_pfx + sd, dmni_signals_sds2):
		print (it)

	print (dmni_dividers_pfx +"DMNI_Receive")
	dmni_signals_sds3=["DMNI_Receive","recv_size","first"]
	for it in map(lambda sd: dmni_signals_pfx + sd, dmni_signals_sds3):
		print (it)
		
	print (dmni_dividers_pfx +"DMNI_Send")
	print (dmni_signals_pfx+"DMNI_Send")

	# switch control signals
	router_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC_AP/coreRouter/SwitchControl_SR_write/" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	router_sds = ["EA","ask","ack_routing","address","clock","data_in_header","data_in_header_fixed","dirx","diry","enable_shift", "free_port","header","header_fixed","lx","next_flit","prox","req_routing" ,"try_again"]
	for it in map (lambda sd: router_pfx + sd, router_sds):
		print (it)

	# for port in range(0,8):
	ap = 0 # Access points vao de 0 até 4, só nos canais 0
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

			if (port % 2) == 0: # Caso for um CH0, tem AP
				#Cria divisores
				ap_dividers_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d input %s} -divider " % (pe_type_str, posX, posY, pe,location, posX, posY, portname[port])
				print (ap_dividers_pfx +"AP")
				#Printa os singals AP ~> Router
				access_point_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC_AP/" % 	(pe_type_str, posX, posY, pe,location, posX, posY, portname[port], pe_type_str, posX, posY)
				access_point_sds = ["credit_o_router", "rx_router","data_in_router", "eop_in_router"]
			    # Incrementa pq a contagem do Ap é diferente das portas
				for it in map(lambda sd: access_point_pfx + sd + f"({port:d})",access_point_sds):
					print (it)

			router_output_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/" % 	(pe_type_str, posX, posY, pe, location, posX, posY, portname[port], pe_type_str, posX, posY)
			router_output_sds = ["credit_i","tx","data_out","eop_out"]
			for it in map(lambda sd: router_output_pfx + sd + f"({port:d})",router_output_sds):
				print (it)
			
			if (port % 2) == 0:
				#Cria divisor
				ap_dividers_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d output %s} -divider " % (pe_type_str, posX, posY, pe,location, posX, posY, portname[port])
				print (ap_dividers_pfx +"AP")
				#Printa os singals AP ~> Router
				access_point_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC_AP/" % 	(pe_type_str, posX, posY, pe,location, posX, posY, portname[port], pe_type_str, posX, posY)
				access_point_sds = ["credit_i_router","tx_router","data_out_router","eop_out_router"]
				for it in map(lambda sd: access_point_pfx + sd + f"({port:d})",access_point_sds):
					print (it)

			# Signals internos do AP
				access_point_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d AP %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC_AP/" % 	(pe_type_str, posX, posY, pe,location, posX, posY, portname[port], pe_type_str, posX, posY)
				access_point_sds = ["k1","k2","intAP"]
				for it in map(lambda sd: access_point_pfx + sd ,access_point_sds):
					print (it)
				access_point_sds = ["sz","apThreshold"]
				for it in map(lambda sd: access_point_pfx + sd + f"({port:d})",access_point_sds):
					print (it)
				access_point_pfx = "add wave -noupdate -group {%s %dx%d - %d} -group %s -group {router %dx%d AP %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC_AP/AP_gen(%d)/AP_CH0/" % 	(pe_type_str, posX, posY, pe,location, posX, posY, portname[port], pe_type_str, posX, posY,ap)
				access_point_sds = ["pass", "auth" ,"mask", "enable", "Cin", "Cout"]
				for it in map(lambda sd: access_point_pfx + sd,access_point_sds):
					print (it)
				ap += 1

	
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
# io_peripheral_pfx="add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/"
# io_peripheral_sds=["clock", "reset", "in_source_router_seek_primary", "in_target_router_seek_primary", "in_payload_router_seek_primary", "in_service_router_seek_primary", "in_req_router_seek_primary", "in_ack_router_seek_primary", "in_opmode_router_seek_primary", "out_service_router_seek_primary", "out_source_router_seek_primary", "out_target_router_seek_primary", "out_payload_router_seek_primary", "out_ack_router_seek_primary", "out_req_router_seek_primary", "out_nack_router_seek_primary", "out_opmode_router_seek_primary", "clock_tx_primary", "tx_primary", "data_out_primary", "credit_i_primary", "eop_in_primary", "clock_rx_primary", "rx_primary", "data_in_primary", "credit_o_primary", "eop_out_primary", "EA_in", "EA_out", "SR_path"]
# for it in map(lambda sd: io_peripheral_pfx + sd, io_peripheral_sds):
# 	print (it)

#SNIP SIGNALS

for snip_idx in range(0, snip_number):

	#-----------#
	# SNIP Name #
	#-----------#

	if snip_idx == 0:
		snip_name = "SNIP"
		snip_entity_name = "IO_PERIPHERAL"
	else:
		snip_name = "SNIP" + str(snip_idx + 1)
		snip_entity_name = "IO_PERIPHERAL" + str(snip_idx + 1)
	
	snip_top = "/test_bench/" + snip_entity_name + "/snip"

	#-------------#
	# Top Signals #
	#-------------#

	snip_divider_pfx = "add wave -noupdate -group {%s} -divider " % (snip_name)

	snip_pfx = "add wave -noupdate -group {%s} %s/" % (snip_name, snip_top)
	snip_sds = ["clock", "reset"]
	for it in map(lambda sd: snip_pfx + sd, snip_sds):
		print (it)

	#---------------------------#
	# Application Table Signals #
	#---------------------------#

	print(snip_divider_pfx + "Application_Table")

	### Table Columns

	snip_table_columns_pfx = "add wave -noupdate -group {%s} -group {Table Columns} %s/ApplicationTable/" % (snip_name, snip_top)
	snip_table_columns_sds = ["table.used", "table.app_id", "table.key1", "table.key2", "table.path_size", "table.path"]
	for it in map(lambda sd: snip_table_columns_pfx + sd, snip_table_columns_sds):
		print (it)	

	### Primary Interface (Read-Write)

	snip_table_primary_pfx = "add wave -noupdate -group {%s} -group {Primary Interface (RW)} %s/ApplicationTable/" % (snip_name, snip_top)
	snip_table_primary_sds = ["state", "slot", "match"]
	for it in map(lambda sd: snip_table_primary_pfx + sd, snip_table_primary_sds):
		print (it)	

	##### RW Control

	snip_table_primary_rwctrl_pfx = "add wave -noupdate -group {%s} -group {Primary Interface (RW)} -group {RW Control} %s/ApplicationTable/" % (snip_name, snip_top)
	snip_table_primary_rwctrl_sds = ["primaryIn.request", "primaryIn.crypto", "primaryIn.newLine", "primaryIn.tag", "primaryIn.tagAux", "primaryIn.clearSlot", "primaryOut.ready", "primaryOut.fail", "primaryOut.full"]
	for it in map(lambda sd: snip_table_primary_rwctrl_pfx + sd, snip_table_primary_rwctrl_sds):
		print (it)

	##### RW Data

	snip_table_primary_rwdata_pfx = "add wave -noupdate -group {%s} -group {Primary Interface (RW)} -group {RW Data} %s/ApplicationTable/" % (snip_name, snip_top)
	snip_table_primary_rwdata_divider_pfx = "add wave -noupdate -group {%s} -group {Primary Interface (RW)} -group {RW Data} -divider " % (snip_name)

	print(snip_table_primary_rwdata_divider_pfx + "AppID")
	print(snip_table_primary_rwdata_pfx + "primaryOut.appId")
	print(snip_table_primary_rwdata_pfx + "primaryIn.appId_w")
	print(snip_table_primary_rwdata_pfx + "primaryIn.appId_wen")

	print(snip_table_primary_rwdata_divider_pfx + "k1")
	print(snip_table_primary_rwdata_pfx + "primaryOut.key1")
	print(snip_table_primary_rwdata_pfx + "primaryIn.key1_w")
	print(snip_table_primary_rwdata_pfx + "primaryIn.key1_wen")

	print(snip_table_primary_rwdata_divider_pfx + "k2")
	print(snip_table_primary_rwdata_pfx + "primaryOut.key2")
	print(snip_table_primary_rwdata_pfx + "primaryIn.key2_w")
	print(snip_table_primary_rwdata_pfx + "primaryIn.key2_wen")

	print(snip_table_primary_rwdata_divider_pfx + "PathSize")
	print(snip_table_primary_rwdata_pfx + "primaryOut.pathSize")
	print(snip_table_primary_rwdata_pfx + "primaryIn.pathSize_w")
	print(snip_table_primary_rwdata_pfx + "primaryIn.pathSize_wen")

	print(snip_table_primary_rwdata_divider_pfx + "Path")
	print(snip_table_primary_rwdata_pfx + "primaryIn.pathFlit_idx")	
	print(snip_table_primary_rwdata_pfx + "primaryOut.pathFlit")
	print(snip_table_primary_rwdata_pfx + "primaryIn.pathFlit_w")
	print(snip_table_primary_rwdata_pfx + "primaryIn.pathFlit_wen")

	### Secondary Interface (Read Only)

	snip_table_secondary_pfx = "add wave -noupdate -group {%s} -group {Secondary Interface (RO)} %s/ApplicationTable/" % (snip_name, snip_top)
	snip_table_secondary_sds = ["secondary_slot"]
	for it in map(lambda sd: snip_table_secondary_pfx + sd, snip_table_secondary_sds):
		print (it)
	
	##### RO Control

	snip_table_secondary_roctrl_pfx = "add wave -noupdate -group {%s} -group {Secondary Interface (RO)} -group {RO Control} %s/ApplicationTable/" % (snip_name, snip_top)
	snip_table_secondary_roctrl_sds = ["secondaryIn.tag", "secondaryOut.ready"]
	for it in map(lambda sd: snip_table_secondary_roctrl_pfx + sd, snip_table_secondary_roctrl_sds):
		print (it)

	##### RO Data

	snip_table_secondary_rodata_pfx = "add wave -noupdate -group {%s} -group {Secondary Interface (RO)} -group {RO Data} %s/ApplicationTable/" % (snip_name, snip_top)
	snip_table_secondary_rodata_sds = ["secondaryOut.appId", "secondaryOut.key1", "secondaryOut.key2", "secondaryOut.pathSize", "secondaryOut.pathFlit", "secondaryIn.pathFlit_idx"]
	for it in map(lambda sd: snip_table_secondary_rodata_pfx + sd, snip_table_secondary_rodata_sds):
		print (it)

	#------------------------#
	# Packet Handler Signals #
	#------------------------#

	print(snip_divider_pfx + "Handler")

	snip_handler_pfx = "add wave -noupdate -group {%s} %s/PacketHandler/" % (snip_name, snip_top)
	snip_handler_sds = ["clock", "hermes_rx", "hermes_data_in", "hermes_eop_in", "hermes_credit_out"]
	for it in map(lambda sd: snip_handler_pfx + sd, snip_handler_sds):
		print (it)

	### States

	snip_handler_states_pfx = "add wave -noupdate -group {%s} -group {States} %s/PacketHandler/" % (snip_name, snip_top)
	snip_handler_states_sds = ["stage", "start_rx_state", "table_state", "keygen_state", "data_state", "finish_rx_state", "respond_state"]
	for it in map(lambda sd: snip_handler_states_pfx + sd, snip_handler_states_sds):
		print (it)

	### Registers

	snip_handler_regs_divider_pfx = "add wave -noupdate -group {%s} -group {Registers} -divider " % (snip_name)
	snip_handler_regs_pfx = "add wave -noupdate -group {%s} -group {Registers} %s/PacketHandler/" % (snip_name, snip_top)

	print(snip_handler_regs_divider_pfx + "f1")
	print(snip_handler_regs_pfx + "f1")
	print(snip_handler_regs_pfx + "f1_valid")

	print(snip_handler_regs_divider_pfx + "f2")
	print(snip_handler_regs_pfx + "f2")
	print(snip_handler_regs_pfx + "f2_valid")

	print(snip_handler_regs_divider_pfx + "Service")
	print(snip_handler_regs_pfx + "hermes_service")
	print(snip_handler_regs_pfx + "hermes_service_valid")

	print(snip_handler_regs_divider_pfx + "k0")
	print(snip_handler_regs_pfx + "k0")
	print(snip_handler_regs_pfx + "k0_valid")

	print(snip_handler_regs_divider_pfx + "Source")
	print(snip_handler_regs_pfx + "packet_source")
	print(snip_handler_regs_pfx + "packet_source_valid")

	print(snip_handler_regs_divider_pfx + "Target")
	print(snip_handler_regs_pfx + "packet_target")
	print(snip_handler_regs_pfx + "packet_target_valid")

	print(snip_handler_regs_divider_pfx + "AppID_(Decoded)")
	print(snip_handler_regs_pfx + "app_id")
	print(snip_handler_regs_pfx + "app_id_valid")

	print(snip_handler_regs_divider_pfx + "KeyParams_(Decoded)")
	print(snip_handler_regs_pfx + "key_params")
	print(snip_handler_regs_pfx + "key_params_valid")

	print(snip_handler_regs_divider_pfx + "Crypto_Tag_(Decoded)")
	print(snip_handler_regs_pfx + "crypto_tag")
	print(snip_handler_regs_pfx + "crypto_tag_valid")

	print(snip_handler_regs_divider_pfx + "Crypto_Tag2_(Decoded)")
	print(snip_handler_regs_pfx + "crypto_tag2")
	print(snip_handler_regs_pfx + "crypto_tag2_valid")

	### Table Interface (RW)

	##### Table Control
	snip_handler_table_ctrl_pfx = "add wave -noupdate -group {%s} -group {Table Interface (RW)} -group {Control Signals} %s/PacketHandler/" % (snip_name, snip_top)
	snip_handler_table_ctrl_sds = ["tableOut.request", "tableOut.crypto", "tableOut.newLine", "tableOut.tag", "tableOut.tagAux", "tableOut.clearSlot", "tableIn.ready", "tableIn.fail", "tableIn.full"]
	for it in map(lambda sd: snip_handler_table_ctrl_pfx + sd, snip_handler_table_ctrl_sds):
		print (it)

	##### Table Data

	snip_handler_table_data_divider_pfx = "add wave -noupdate -group {%s} -group {Table Interface (RW)} -group {Data Signals} -divider " % (snip_name)
	snip_hander_table_data_pfx = "add wave -noupdate -group {%s} -group {Table Interface (RW)} -group {Data Signals} %s/PacketHandler/" % (snip_name, snip_top)

	print(snip_handler_table_data_divider_pfx + "AppID")
	print(snip_hander_table_data_pfx + "tableIn.appId")
	print(snip_hander_table_data_pfx + "tableOut.appId_w")
	print(snip_hander_table_data_pfx + "tableOut.appId_wen")

	print(snip_handler_table_data_divider_pfx + "k1")
	print(snip_hander_table_data_pfx + "tableIn.key1")
	print(snip_hander_table_data_pfx + "tableOut.key1_w")
	print(snip_hander_table_data_pfx + "tableOut.key1_wen")

	print(snip_handler_table_data_divider_pfx + "k2")
	print(snip_hander_table_data_pfx + "tableIn.key2")
	print(snip_hander_table_data_pfx + "tableOut.key2_w")
	print(snip_hander_table_data_pfx + "tableOut.key2_wen")

	print(snip_handler_table_data_divider_pfx + "PathSize")
	print(snip_hander_table_data_pfx + "tableIn.pathSize")
	print(snip_hander_table_data_pfx + "tableOut.pathSize_w")
	print(snip_hander_table_data_pfx + "tableOut.pathSize_wen")

	print(snip_handler_table_data_divider_pfx + "Path")
	print(snip_hander_table_data_pfx + "tableOut.pathFlit_idx")	
	print(snip_hander_table_data_pfx + "tableIn.pathFlit")
	print(snip_hander_table_data_pfx + "tableOut.pathFlit_w")
	print(snip_hander_table_data_pfx + "tableOut.pathFlit_wen")

	### Key Generator

	snip_handler_keygen_pfx = "add wave -noupdate -group {%s} -group {Key Generator} %s/PacketHandler/" % (snip_name, snip_top)
	snip_handler_keygen_sds = ["keygen.request", "keygen.appID", "keygen.n", "keygen.p", "keygen.busy", "keygen.ready", "keygen.k1", "keygen.k2"]
	for it in map(lambda sd: snip_handler_keygen_pfx + sd, snip_handler_keygen_sds):
		print (it)

	### Response Request Interface

	snip_handler_respond_pfx = "add wave -noupdate -group {%s} -group {Response Request} %s/PacketHandler/" % (snip_name, snip_top)
	snip_handler_respond_sds = ["response_req", "response_param", "tx_status"]
	for it in map(lambda sd: snip_handler_respond_pfx + sd, snip_handler_respond_sds):
		print (it)

	### Output Buffer Interface
	snip_handler_buffer_pfx = "add wave -noupdate -group {%s} -group {Output Buffer Interface} %s/PacketHandler/" % (snip_name, snip_top)
	snip_handler_buffer_sds = ["buffer_wdata", "buffer_wen", "buffer_full"]
	for it in map(lambda sd: snip_handler_buffer_pfx + sd, snip_handler_buffer_sds):
		print (it)
	
	### Internal Control Signals
	snip_handler_buffer_pfx = "add wave -noupdate -group {%s} -group {Handler Control Signals} %s/PacketHandler/" % (snip_name, snip_top)
	snip_handler_buffer_sds = ["hermesControl", "tableControl", "unknown_service", "authenticated", "keygen_necessary", "response_necessary", "data_to_write_on_table", "end_of_handling"]
	for it in map(lambda sd: snip_handler_buffer_pfx + sd, snip_handler_buffer_sds):
		print (it)

	#------------------------#
	# Packet Builder Signals #
	#------------------------#

	print(snip_divider_pfx + "Packet_Builder")

	snip_builder_pfx = "add wave -noupdate -group {%s} %s/PacketBuilder/" % (snip_name, snip_top)
	snip_builder_sds = ["clock", "hermes_tx", "hermes_data_out", "hermes_eop_out", "hermes_credit_in", "state"]
	for it in map(lambda sd: snip_builder_pfx + sd, snip_builder_sds):
		print (it)

	### Response Request Interface
	snip_builder_req_pfx = "add wave -noupdate -group {%s} -group {Response Request Interface} %s/PacketBuilder/" % (snip_name, snip_top)
	snip_builder_req_sds = ["response_req", "response_param_in", "status", "response_param_reg"]
	for it in map(lambda sd: snip_builder_req_pfx + sd, snip_builder_req_sds):
		print (it)

	### Table Interface (RO)

	##### Table Control
	snip_builder_table_ctrl_pfx = "add wave -noupdate -group {%s} -group {Table Interface (RO)} -group {Control Signals} %s/PacketBuilder/" % (snip_name, snip_top)
	snip_builder_table_ctrl_sds = ["tableOut.tag", "tableIn.ready"]
	for it in map(lambda sd: snip_builder_table_ctrl_pfx + sd, snip_builder_table_ctrl_sds):
		print (it)

	##### Table Data
	snip_builder_table_data_pfx = "add wave -noupdate -group {%s} -group {Table Interface (RO)} -group {Data Signals} %s/PacketBuilder/" % (snip_name, snip_top)
	snip_builder_table_data_sds = ["tableIn.appId", "tableIn.key1", "tableIn.key2", "tableIn.pathSize", "tableIn.pathFlit", "tableOut.pathFlit_idx"]
	for it in map(lambda sd: snip_builder_table_data_pfx + sd, snip_builder_table_data_sds):
		print (it)

	### Input Buffer Interface
	snip_builder_buffer_pfx = "add wave -noupdate -group {%s} -group {Input Buffer Interface} %s/PacketBuilder/" % (snip_name, snip_top)
	snip_builder_buffer_sds = ["buffer_rdata", "buffer_ren", "buffer_empty"]
	for it in map(lambda sd: snip_builder_buffer_pfx + sd, snip_builder_buffer_sds):
		print (it)

	### Internal Control Signals

	##### Header Control
	snip_builder_ctrl_hdr_pfx = "add wave -noupdate -group {%s} -group {Builder Control Signals} -group {Header Control} %s/PacketBuilder/" % (snip_name, snip_top)
	snip_builder_ctrl_hdr_sds = ["fixed_header_flit", "fixed_header_end", "path_flit", "path_end", "header_flit", "header_end", "header_tx", "header_eop"]
	for it in map(lambda sd: snip_builder_ctrl_hdr_pfx + sd, snip_builder_ctrl_hdr_sds):
		print (it)

	##### Data Payload Control
	snip_builder_ctrl_payload_pfx = "add wave -noupdate -group {%s} -group {Builder Control Signals} -group {Data Payload Control} %s/PacketBuilder/" % (snip_name, snip_top)
	snip_builder_ctrl_payload_sds = ["send_data", "data_words_to_read", "data_flit_low", "data_flit_ready", "last_data_flit", "data_flit_blocked", "data_tx", "data_eop"]
	for it in map(lambda sd: snip_builder_ctrl_payload_pfx + sd, snip_builder_ctrl_payload_sds):
		print (it) 

print ("TreeUpdate [SetDesecurityTree]\n\
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
configure wave -timelineunits us\n")
