from sys import argv

if len(argv) == 6:
	scriptname,MAX_X,MAX_Y,MAX_CLUSTER_X,MAX_CLUSTER_Y,master_pe = argv
	MAX_X=int(MAX_X)
	MAX_Y=int(MAX_Y)
	MAX_CLUSTER_X=int(MAX_CLUSTER_X)
	MAX_CLUSTER_Y=int(MAX_CLUSTER_Y)	
	master_pe=int(master_posX, posY)
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
	print "usage:"
	print "wavegen.py [MAX_X] [MAX_Y] [MAX_CLUSTER_X] [MAX_CLUSTER_Y] [master position]"
	print "	wavegen.py 4 4 2 2 0: 4x4 MPSOC with master on 0x0"
	print "wavegen.py [MAX_X] [MAX_Y] : assumes master on 0 and just one cluster"
	#print "argv[0] %s \nargv[1] %s \nargv[2] %s \nargv[3] %s \nargv[4] %s \n" % (scriptname, MAX_X, MAX_Y, MAX_CLUSTER_X, MAX_CLUSTER_Y)
	exit();

max_pe=MAX_X*MAX_Y
portname=["E0","E1","W0","W1","N0","N1","S0","S1","L0","L1"]
portseek=["E","W","N","S","L"]

posX=0
posY=0

print "onerror {resume}\n\
quietly WaveActivateNextPane {} 0\n"

# print "printing MPSOC %dx%d master on %d" % (MAX_X,MAX_Y,master_posX, posY)
print "MAX_X = %d" % (MAX_X)
print "MAX_Y = %d" % (MAX_Y)
print "MAX_CLUSTER_X = %d" % (MAX_CLUSTER_X)
print "MAX_CLUSTER_Y = %d" % (MAX_CLUSTER_Y)

for pe in xrange(0,max_pe):						
	if MAX_CLUSTER_X == 0:
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
	
	print "add wave -noupdate -group {%s %dx%d - %d} /test_bench/HeMPS/%s%dx%d/clock" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)

	#pe signals
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/int_seek" % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/irq" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/irq_mask_reg" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/irq_status" % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/cpu/mem_address" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/cpu/mem_byte_we" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/cpu/mem_data_r" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/cpu/mem_data_w" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group pe /test_bench/HeMPS/%s%dx%d/cpu/page" % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)

	#faults signals
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/clock" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/external_fail_in"  % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/external_fail_out"  % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/fail_in"  % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/fail_out"  % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/router_fail_in"  % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/router_fail_out"  % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group faults /test_bench/HeMPS/%s%dx%d/wrapper_reg"  % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)

	#SEEK signals

	for port in xrange(0,5):
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_req_router_seek(%d)" % 		(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_ack_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_nack_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_service_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_source_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_target_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {input %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_payload_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)

		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_req_router_seek(%d)" % 		(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_ack_router_seek(%d)" % 		(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_nack_router_seek(%d)" % 		(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_service_router_seek(%d)" %	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_source_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_target_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)
		print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group {output %s} /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_payload_router_seek(%d)" % 	(pe_type_str, posX, posY, pe, portseek[port], pe_type_str, posX, posY, port)

	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/router_address" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/backtrack_id" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/EA_manager" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/EA_manager_input" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/sel_port" %  					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/next_port" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/req_int" %  					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/task" %  						(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/req_task" %					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/sel" %  						(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/prox" %  						(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/free_index" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/source_index" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/source_table" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/target_table" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/service_table" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/payload_table" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/opmode_table" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/my_payload_table" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/backtrack_port_table" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/source_router_port_table" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/used_table" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/pending_table" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/pending_local" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/int_out_ack_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_nack_router_seek" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_ack_router_seek" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_fail_router_seek" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/fail_with_mode_in" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/fail_with_mode_out" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/int_in_req_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_nack_router_seek" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_ack_router_seek" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/int_in_ack_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_source_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_target_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_payload_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_service_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_opmode_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/int_out_req_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_service_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_source_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_target_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_payload_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/out_opmode_router_seek" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/backtrack_port" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/reg_backtrack" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/vector_ack_ports" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/vector_nack_ports" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/in_the_table" %  				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/space_aval_in_the_table" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group seek -group signals /test_bench/HeMPS/%s%dx%d/router_seek_wrapped/router_seek/is_my_turn_send_backtrack" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)

	# #fifo_PDN signals
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/clock" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/reset" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/EA_in" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/EA_out" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/last" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/first" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/tem_espaco_na_fila" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_source_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_target_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_payload_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_service_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_reg_backtrack_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_sel_reg_backtrack" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_req_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_ack_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_opmode_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_req_send_kernel_seek_local" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/in_ack_send_kernel_seek_local" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_service_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_source_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_target_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_payload_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_sel_reg_backtrack_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_reg_backtrack" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_req_pe" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_ack_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_nack_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/out_opmode_fifo_seek" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_source" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_target" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_payload" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_service" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_opmode" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_backtrack1" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_backtrack2" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fifo_PDN /test_bench/HeMPS/%s%dx%d/fifo_PDN/buffer_backtrack3" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)

	#fail_wrapper_module signals
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/clock" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/reset" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_fail_cpu_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_fail_cpu_config" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/mem_address_service_fail_cpu" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_source_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_target_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_payload_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_service_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_req_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_opmode_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_fail_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_ack_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_nack_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_source_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_target_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_payload_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_service_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_req_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_opmode_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/out_fail_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_ack_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_nack_wrapper_local" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_source_router" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/in_target_router" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group fail_WRAPPER_module /test_bench/HeMPS/%s%dx%d/fail_WRAPPER_module/EA_in" % (pe_type_str, posX, posY, pe, pe_type_str, posX, posY)

	# dmni signals
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/dmni_timeout" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/mem_address" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/mem_byte_we" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/mem_data_read" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/mem_data_write" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/config_data" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/receive_active" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/send_active" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/set_address" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/set_address_2" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/set_op" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/set_size" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/set_size_2" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/start" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/intr" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni -divider buffer control" %  								(pe_type_str, posX, posY, pe)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/last" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/buffer_high" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/flag_middle_eop" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/intr_counter_temp" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni -divider SR" %  									(pe_type_str, posX, posY, pe)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/SR" %				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/cont" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/payload_size" %  	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/last" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni -divider DMNI_Receive" %  							(pe_type_str, posX, posY, pe)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/DMNI_Receive" %		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/recv_size" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/first" %  			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni -divider DMNI_Send" %  							(pe_type_str, posX, posY, pe)
	print "add wave -noupdate -group {%s %dx%d - %d} -group dmni /test_bench/HeMPS/%s%dx%d/dmni/DMNI_Send" %  		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)


	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/EA" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ask" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/shift_counter" % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/Xsource" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/Ysource" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ack_routing" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/address" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/clock" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header" % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/data_in_header_fixed" % 	(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/dirx" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/diry" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/enable_shift" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/flit_type" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/even_line" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/free_port" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/header_fixed" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/lx" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ly" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/next_flit" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/priority" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/prox" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/req_routing" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/reset" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/rot_table" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/routing" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sel" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sender" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sr_channel_0" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sr_port_0" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/sr_valid_0" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/source" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/target_internal" % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/try_again" % 			(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/tx" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/ty" % 					(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_addr" % 				(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)
	print "add wave -noupdate -group {%s %dx%d - %d} -group {switch control} /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/RouterCC/SwitchControl_SR_write/w_source_target" % 		(pe_type_str, posX, posY, pe, pe_type_str, posX, posY)

	# for port in xrange(0,8):
	for port in xrange(0,10):
		if port != 8:
			if port == 9:
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/credit_o(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/rx(%d)" % 			(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/data_in(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/eop_in(%d)" % 		(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/credit_i(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/tx(%d)" % 		(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/data_out(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group LOCAL -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/eop_out(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
			else:
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/credit_o(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/rx(%d)" % 			(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/data_in(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d input %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/eop_in(%d)" % 		(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/credit_i(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/tx(%d)" % 		(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/data_out(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
				print "add wave -noupdate -group {%s %dx%d - %d} -group ports -group {router %dx%d output %s} -radix hexadecimal /test_bench/HeMPS/%s%dx%d/RouterCCwrapped/eop_out(%d)" % 	(pe_type_str, posX, posY, pe, posX, posY, portname[port], pe_type_str, posX, posY, port)
	

	if pe%MAX_X==MAX_X-1:
		posX=0
		posY=posY+1
	else:
		posX=posX+1	
					
#INJECTOR SIGNALS
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/reset"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_source_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_target_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_payload_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_service_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_req_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_ack_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_opmode_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_service_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_source_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_target_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_payload_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_ack_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_req_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_nack_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_opmode_router_seek_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_tx_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/tx_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_out_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_i_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_in_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_rx_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/rx_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_in_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_o_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_out_primary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_source_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_target_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_payload_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_service_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_req_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_ack_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/in_opmode_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_service_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_source_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_target_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_payload_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_ack_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_req_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_nack_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/out_opmode_router_seek_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_tx_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/tx_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_out_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_i_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_in_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/clock_rx_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/rx_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/data_in_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/credit_o_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/eop_out_secondary"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_in_datanoc"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_out_datanoc"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_in_brnoc"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_out_brnoc"
print "add wave -noupdate -group INJECTOR /test_bench/INJECTOR/EA_manager"
#IO_PERIPHERAL SIGNALS
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/clock"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/reset"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/in_source_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/in_target_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/in_payload_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/in_service_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/in_req_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/in_ack_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/in_opmode_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_service_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_source_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_target_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_payload_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_ack_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_req_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_nack_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/out_opmode_router_seek_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/clock_tx_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/tx_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/data_out_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/credit_i_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/eop_in_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/clock_rx_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/rx_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/data_in_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/credit_o_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/eop_out_primary"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/EA_in"
print "add wave -noupdate -group IO_PERIPHERAL /test_bench/IO_PERIPHERAL/EA_out"
	


print "TreeUpdate [SetDefaultTree]\n\
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
configure wave -timelineunits ps\n"
