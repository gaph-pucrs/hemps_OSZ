//------------------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS -  5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  September 2013
//
//  Source name:  hemps.cpp
//
//  Brief description: Control of router position.
//
//------------------------------------------------------------------------------------------------

#include "hemps.h"

int hemps::RouterPosition(int router){
	int pos;
	
	int column = router%N_PE_X;
	
	if(router>=(N_PE-N_PE_X)){ //TOP
		if(column==(N_PE_X-1)){ //RIGHT
			pos = TR;
		}
		else{
			if(column==0){//LEFT
				pos = TL;
			}
			else{//CENTER_X
				pos = TC;
			}
		}
	}
	else{
		if(router<N_PE_X){ //BOTTOM
			if(column==(N_PE_X-1)){ //RIGHT
				pos = BR;
			}
			else{
				if(column==0){//LEFT
					pos = BL;
				}
				else{//CENTER_X
					pos = BC;
				}
			}
		}
		else{//CENTER_Y
			if(column==(N_PE_X-1)){ //RIGHT
				pos = CRX;
			}
			else{
				if(column==0){//LEFT
					pos = CL;
				}
				else{//CENTER_X
					pos = CC;
				}
			}
		}
	}
			
	return pos;
}

regaddress hemps::RouterAddress(int router){
	regaddress r_address;
	
	if(N_PE_X <= N_PE_Y){
		sc_uint<8> pos_x = router%N_PE_Y;
		sc_uint<8> pos_y = router/N_PE_Y;

		r_address[15] = pos_x[7];
		r_address[14] = pos_x[6];
		r_address[13] = pos_x[5];
		r_address[12] = pos_x[4];
		r_address[11] = pos_x[3];
		r_address[10] = pos_x[2];
		r_address[ 9] = pos_x[1];
		r_address[ 8] = pos_x[0];
		r_address[7] = pos_y[7];
		r_address[6] = pos_y[6];
		r_address[5] = pos_y[5];
		r_address[4] = pos_y[4];
		r_address[3] = pos_y[3];
		r_address[2] = pos_y[2];
		r_address[1] = pos_y[1];
		r_address[0] = pos_y[0];
	}
	else{
		sc_uint<8> pos_x = router%N_PE_X;
		sc_uint<8> pos_y = router/N_PE_X;
		
		r_address[15] = pos_x[7];
		r_address[14] = pos_x[6];
		r_address[13] = pos_x[5];
		r_address[12] = pos_x[4];
		r_address[11] = pos_x[3];
		r_address[10] = pos_x[2];
		r_address[ 9] = pos_x[1];
		r_address[ 8] = pos_x[0];
		r_address[7] = pos_y[7];
		r_address[6] = pos_y[6];
		r_address[5] = pos_y[5];
		r_address[4] = pos_y[4];
		r_address[3] = pos_y[3];
		r_address[2] = pos_y[2];
		r_address[1] = pos_y[1];
		r_address[0] = pos_y[0];
	}
		
	return r_address;	
}

//test if all faults were inserted. return 1 if true, 0 if not
int hemps::test_faults_inserted(int nbr_faults){
	int i;
	sc_time t_1micro(1,SC_US);
	sc_time t_FAULT;
	
	for (int i=0; i<nbr_faults; i++){
		t_FAULT = (sc_time) t_1micro * faults.time[i] - t_1micro;//the simulation time differs in 1 us
		if(sc_time_stamp() > t_FAULT){
			//continues
		}
		else{
			return 0;
		}
	}
	return 1;
}

// void hemps::fault_injection(){
// 	FILE *fp;
// 	char line[100];
// 	char port[10];
// 	// #define MAX_FAULTS 10
// 	// struct struct_faults{
// 	// 	int pe[MAX_FAULTS];
// 	// 	int port[MAX_FAULTS];
// 	// 	int time[MAX_FAULTS];
// 	// }faults;
// 	int nbr_faults;

// 	sc_time t_1micro(1,SC_US);
// 	sc_time t_FAULT;

// 	int i;

// 	fp = fopen ("faults", "r");

// 	if (fp != NULL){


// 		i=0;
// 		while(fgets(line, 100, fp) != NULL){
			
// 			//TODO: add the option 'in' and 'out' in faults model
// 			if(line[0]!='#'){//character # acts as comment
// 				//cout << "inserting faults:\n";
// 				sscanf(line,"%d %s %d",&faults.pe[i], port, &faults.time[i]);
// 				switch(port[0]){//in fact I will just check the first letter
// 					case 'E': faults.port[i] = 0;//EAST
// 					break;
// 					case 'W': faults.port[i] = 2;//WEST
// 					break;
// 					case 'N': faults.port[i] = 4;//NORTH
// 					break;
// 					default: faults.port[i] = 6; //SOUTH
// 					break;
// 				}
// 				if(port[1]=='1'){
// 					faults.port[i]++;
// 				}
// 				printf("pe:%d;port:%d;time:%d\n",faults.pe[i], faults.port[i], faults.time[i]);
// 				i++;
// 			}
// 		}

// 		nbr_faults = i;

// 		while(1){
// 			for (int i=0; i<nbr_faults; i++){
// 				t_FAULT = (sc_time) t_1micro * faults.time[i] - t_1micro;//the simulation time differs in 1 us
// 				if(sc_time_stamp() > t_FAULT){
// 					cout << t_FAULT;
// 					external_fail_in	[faults.pe[i]][faults.port[i]].write(1);
// 					external_fail_out	[faults.pe[i]][faults.port[i]].write(1);
// 					printf(" INSERTING FAULT = pe:%d;port:%d;time:%d\n",faults.pe[i], faults.port[i], faults.time[i]);
// 				}

// 			}
// 			if(test_faults_inserted(nbr_faults)==1){
// 				break;
// 			}
// 			else{
// 				wait(1, SC_US);
// 			}
// 		}
// 	}

// }

void hemps::io_interconnection(){

int i;
 	 	
 	//for(i=0;i<N_PE;i++){
	//cout << "open_io = " << open_io[i] << endl;
	//		// cout << "grounding EAST in seek: " << i << endl;
 	//}	
 	for(i=0; i<I0_LIMITS; i++){
		clock_tx_io[i].write(sig_clock_tx_io[i].read());
		tx_io[i].write(sig_tx_io[i].read());
		data_out_io[i].write(sig_data_out_io[i].read());
		sig_credit_i_io[i].write(credit_i_io[i].read());
		sig_eop_in_io[i].write(eop_in_io[i].read());
	
		sig_data_in_io[i].write(data_in_io[i].read());
		sig_clock_rx_io[i].write(clock_rx_io[i].read());
		sig_rx_io[i].write(rx_io[i].read());
		credit_o_io[i].write(sig_credit_o_io[i].read());
		eop_out_io[i].write(sig_eop_out_io[i].read());

		out_req_router_seek_io[i].write(sig_out_req_router_seek_io[i].read());
		out_ack_router_seek_io[i].write(sig_out_ack_router_seek_io[i].read());
		out_nack_router_seek_io[i].write(sig_out_nack_router_seek_io[i].read());
		out_opmode_router_seek_io[i].write(sig_out_opmode_router_seek_io[i].read());
		out_service_router_seek_io[i].write(sig_out_service_router_seek_io[i].read());
		out_source_router_seek_io[i].write(sig_out_source_router_seek_io[i].read());
		out_target_router_seek_io[i].write(sig_out_target_router_seek_io[i].read());
		out_payload_router_seek_io[i].write(sig_out_payload_router_seek_io[i].read());

		sig_in_req_router_seek_io[i].write(in_req_router_seek_io[i].read());
		sig_in_ack_router_seek_io[i].write(in_ack_router_seek_io[i].read());
		sig_in_nack_router_seek_io[i].write(in_nack_router_seek_io[i].read());
		sig_in_opmode_router_seek_io[i].write(in_opmode_router_seek_io[i].read());
		sig_in_service_router_seek_io[i].write(in_service_router_seek_io[i].read());
		sig_in_source_router_seek_io[i].write(in_source_router_seek_io[i].read());
		sig_in_target_router_seek_io[i].write(in_target_router_seek_io[i].read());
		sig_in_payload_router_seek_io[i].write(in_payload_router_seek_io[i].read());


	}	

}

void hemps::ni_interconnection(){

 	for(i=I0_LIMITS; i<IO_NUMBER; i++) {
		
		clock_tx_io[i].write(sig_clock_tx_io[i].read());
		tx_io[i].write(sig_tx_io[i].read());
		data_out_io[i].write(sig_data_out_io[i].read());
		sig_credit_i_io[i].write(credit_i_io[i].read());
		sig_eop_in_io[i].write(eop_in_io[i].read());
	
		sig_data_in_io[i].write(data_in_io[i].read());
		sig_clock_rx_io[i].write(clock_rx_io[i].read());
		sig_rx_io[i].write(rx_io[i].read());
		credit_o_io[i].write(sig_credit_o_io[i].read());
		eop_out_io[i].write(sig_eop_out_io[i].read());

		out_req_router_seek_io[i].write(sig_out_req_router_seek_io[i].read());
		out_ack_router_seek_io[i].write(sig_out_ack_router_seek_io[i].read());
		out_nack_router_seek_io[i].write(sig_out_nack_router_seek_io[i].read());
		out_opmode_router_seek_io[i].write(sig_out_opmode_router_seek_io[i].read());
		out_service_router_seek_io[i].write(sig_out_service_router_seek_io[i].read());
		out_source_router_seek_io[i].write(sig_out_source_router_seek_io[i].read());
		out_target_router_seek_io[i].write(sig_out_target_router_seek_io[i].read());
		out_payload_router_seek_io[i].write(sig_out_payload_router_seek_io[i].read());

		sig_in_req_router_seek_io[i].write(in_req_router_seek_io[i].read());
		sig_in_ack_router_seek_io[i].write(in_ack_router_seek_io[i].read());
		sig_in_nack_router_seek_io[i].write(in_nack_router_seek_io[i].read());
		sig_in_opmode_router_seek_io[i].write(in_opmode_router_seek_io[i].read());
		sig_in_service_router_seek_io[i].write(in_service_router_seek_io[i].read());
		sig_in_source_router_seek_io[i].write(in_source_router_seek_io[i].read());
		sig_in_target_router_seek_io[i].write(in_target_router_seek_io[i].read());
		sig_in_payload_router_seek_io[i].write(in_payload_router_seek_io[i].read());

	}
}

void hemps::pes_interconnection(){
 	int i, io_count;
 	io_count = 0;
 	 	
 	for(i=0;i<N_PE;i++){
		
		//EAST GROUNDING // TIP IS ALL WIRES 
		if(open_io[i] == 0 && (RouterPosition(i) == BR || RouterPosition(i) == CRX || RouterPosition(i) == TR)){
	//	if((RouterPosition(i) == BR || RouterPosition(i) == CRX || RouterPosition(i) == TR)){
			#ifdef DUPLICATED_CHANNEL
				credit_i				[i][EAST0].write(sig_credit_i_io[io_count].read());
				//credit_i				[i][EAST0].write(1);
				credit_i				[i][EAST1].write(0);
				clock_rx				[i][EAST0].write(sig_clock_rx_io[io_count].read());
				clock_rx				[i][EAST1].write(0);
				data_in 				[i][EAST0].write(sig_data_in_io[io_count].read());
				data_in 				[i][EAST1].write(0);
				rx      				[i][EAST0].write(sig_rx_io[io_count].read());
				rx      				[i][EAST1].write(0);
				eop_in     				[i][EAST0].write(sig_eop_in_io[io_count].read());
				eop_in  				[i][EAST1].write(0);

				sig_clock_tx_io[io_count].write(clock_tx[i][EAST0].read());
				sig_tx_io[io_count].write(tx[i][EAST0].read());
				sig_data_out_io[io_count].write(data_out[i][EAST0].read());
				sig_credit_o_io[io_count].write(credit_o[i][EAST0].read());
				sig_eop_out_io[io_count].write(eop_out[i][EAST0].read());

				// cout << "grounding EAST in seek: " << i << endl;
				in_source_router_seek	[i][EAST].write(sig_in_source_router_seek_io[io_count].read());
				in_target_router_seek	[i][EAST].write(sig_in_target_router_seek_io[io_count].read());
				in_payload_router_seek	[i][EAST].write(sig_in_payload_router_seek_io[io_count].read());
				in_service_router_seek	[i][EAST].write(sig_in_service_router_seek_io[io_count].read());
				in_req_router_seek		[i][EAST].write(sig_in_req_router_seek_io[io_count].read());
				in_ack_router_seek		[i][EAST].write(sig_in_ack_router_seek_io[io_count].read());
				//in_ack_router_seek		[i][EAST].write(1);
				in_nack_router_seek		[i][EAST].write(sig_in_nack_router_seek_io[io_count].read());
				in_opmode_router_seek	[i][EAST].write(sig_in_opmode_router_seek_io[io_count].read());
				access_i 				[i][EAST0].write(sig_fail_in_io[io_count].read());
				access_i 				[i][EAST1].write(0);
				sig_out_req_router_seek_io[io_count].write(out_req_router_seek[i][EAST].read());
				sig_out_ack_router_seek_io[io_count].write(out_ack_router_seek[i][EAST].read());
				sig_out_nack_router_seek_io[io_count].write(out_nack_router_seek[i][EAST].read());
				sig_out_opmode_router_seek_io[io_count].write(out_opmode_router_seek[i][EAST].read());
				sig_out_service_router_seek_io[io_count].write(out_service_router_seek[i][EAST].read());
				sig_out_source_router_seek_io[io_count].write(out_source_router_seek[i][EAST].read());
				sig_out_target_router_seek_io[io_count].write(out_target_router_seek[i][EAST].read());
				sig_out_payload_router_seek_io[io_count].write(out_payload_router_seek[i][EAST].read());
				io_count++;
			#endif
		}		 
 		//else if((RouterPosition(i) == BR || RouterPosition(i) == CRX || RouterPosition(i) == TR)){
 		else if((RouterPosition(i) == BR || RouterPosition(i) == CRX || RouterPosition(i) == TR)){
			#ifdef DUPLICATED_CHANNEL
				credit_i				[i][EAST0].write(0);
				credit_i				[i][EAST1].write(0);
				clock_rx				[i][EAST0].write(0);
				clock_rx				[i][EAST1].write(0);
				data_in 				[i][EAST0].write(0);
				data_in 				[i][EAST1].write(0);
				rx      				[i][EAST0].write(0);
				rx      				[i][EAST1].write(0);
				eop_in     				[i][EAST0].write(0);
				eop_in  				[i][EAST1].write(0);
				// cout << "grounding EAST in seek: " << i << endl;
				in_source_router_seek	[i][EAST].write(0);
				in_target_router_seek	[i][EAST].write(0);
				in_payload_router_seek		[i][EAST].write(0);
				in_service_router_seek	[i][EAST].write(0);
				in_req_router_seek		[i][EAST].write(0);
				in_ack_router_seek		[i][EAST].write(1);
				in_nack_router_seek		[i][EAST].write(0);
				in_opmode_router_seek	[i][EAST].write(0);
				access_i 				[i][EAST0].write(0);
				access_i 				[i][EAST1].write(0);
			#else
 			credit_i[i][EAST].write(0);
 			clock_rx[i][EAST].write(0);
 			data_in [i][EAST].write(0);
 			rx      [i][EAST].write(0); 		
			#endif
		}
 		else{//EAST CONNECTION
			#ifdef DUPLICATED_CHANNEL
				credit_i[i][EAST0].write(credit_o[i+1][WEST0].read());
				credit_i[i][EAST1].write(credit_o[i+1][WEST1].read());
				clock_rx[i][EAST0].write(clock_tx[i+1][WEST0].read());
				clock_rx[i][EAST1].write(clock_tx[i+1][WEST1].read());
				data_in [i][EAST0].write(data_out[i+1][WEST0].read());
				data_in [i][EAST1].write(data_out[i+1][WEST1].read());
				rx      [i][EAST0].write(tx      [i+1][WEST0].read());
				rx      [i][EAST1].write(tx      [i+1][WEST1].read());
				eop_in  [i][EAST0].write(eop_out [i+1][WEST0].read());
				eop_in  [i][EAST1].write(eop_out [i+1][WEST1].read());
				in_source_router_seek	[i][EAST].write(out_source_router_seek	[i+1][WEST].read());
				in_target_router_seek	[i][EAST].write(out_target_router_seek	[i+1][WEST].read());
				in_payload_router_seek	[i][EAST].write(out_payload_router_seek		[i+1][WEST].read());
				in_service_router_seek	[i][EAST].write(out_service_router_seek	[i+1][WEST].read());
				in_req_router_seek		[i][EAST].write(out_req_router_seek		[i+1][WEST].read());
				in_ack_router_seek		[i][EAST].write(out_ack_router_seek		[i+1][WEST].read());
				in_nack_router_seek		[i][EAST].write(out_nack_router_seek	[i+1][WEST].read());
				in_opmode_router_seek	[i][EAST].write(out_opmode_router_seek	[i+1][WEST].read());
				access_i 				[i][EAST0].write(access_o 				[i+1][WEST0].read());
				access_i 				[i][EAST1].write(access_o 				[i+1][WEST1].read());
			#else
 			credit_i[i][EAST].write(credit_o[i+1][WEST].read());
 			clock_rx[i][EAST].write(clock_tx[i+1][WEST].read());
 			data_in [i][EAST].write(data_out[i+1][WEST].read());
 			rx      [i][EAST].write(tx      [i+1][WEST].read());
			#endif
 		}
 		
 		//WEST GROUNDING
		//if((RouterPosition(i) == BL || RouterPosition(i) == CL || RouterPosition(i) == TL)){
		if(open_io[i] == 1 && (RouterPosition(i) == BL || RouterPosition(i) == CL || RouterPosition(i) == TL)){
				#ifdef DUPLICATED_CHANNEL
				//credit_i				[i][WEST0].write(1);
				credit_i				[i][WEST0].write(sig_credit_i_io[io_count].read());
				credit_i				[i][WEST1].write(0);
				clock_rx				[i][WEST0].write(sig_clock_rx_io[io_count].read());
				clock_rx				[i][WEST1].write(0);
				data_in 				[i][WEST0].write(sig_data_in_io[io_count].read());
				data_in 				[i][WEST1].write(0);
				rx      				[i][WEST0].write(sig_rx_io[io_count].read());
				rx      				[i][WEST1].write(0);
				eop_in     				[i][WEST0].write(sig_eop_in_io[io_count].read());
				eop_in  				[i][WEST1].write(0);

				sig_clock_tx_io[io_count].write(clock_tx[i][WEST0].read());
				sig_tx_io[io_count].write(tx[i][WEST0].read());
				sig_data_out_io[io_count].write(data_out[i][WEST0].read());
				sig_credit_o_io[io_count].write(credit_o[i][WEST0].read());
				sig_eop_out_io[io_count].write(eop_out[i][WEST0].read());
				// cout << "grounding WEST in seek: " << i << endl;
				in_source_router_seek	[i][WEST].write(sig_in_source_router_seek_io[io_count].read());
				in_target_router_seek	[i][WEST].write(sig_in_target_router_seek_io[io_count].read());
				in_payload_router_seek	[i][WEST].write(sig_in_payload_router_seek_io[io_count].read());
				in_service_router_seek	[i][WEST].write(sig_in_service_router_seek_io[io_count].read());
				in_req_router_seek		[i][WEST].write(sig_in_req_router_seek_io[io_count].read());
				//in_ack_router_seek		[i][WEST].write(1);
				in_ack_router_seek		[i][WEST].write(sig_in_ack_router_seek_io[io_count].read());
				in_nack_router_seek		[i][WEST].write(sig_in_nack_router_seek_io[io_count].read());
				in_opmode_router_seek	[i][WEST].write(sig_in_opmode_router_seek_io[io_count].read());
				access_i 				[i][WEST0].write(sig_fail_in_io[io_count].read());
				access_i 				[i][WEST1].write(0);
				sig_out_req_router_seek_io[io_count].write(out_req_router_seek[i][WEST].read());
				sig_out_ack_router_seek_io[io_count].write(out_ack_router_seek[i][WEST].read());
				sig_out_nack_router_seek_io[io_count].write(out_nack_router_seek[i][WEST].read());
				sig_out_opmode_router_seek_io[io_count].write(out_opmode_router_seek[i][WEST].read());
				sig_out_service_router_seek_io[io_count].write(out_service_router_seek[i][WEST].read());
				sig_out_source_router_seek_io[io_count].write(out_source_router_seek[i][WEST].read());
				sig_out_target_router_seek_io[io_count].write(out_target_router_seek[i][WEST].read());
				sig_out_payload_router_seek_io[io_count].write(out_payload_router_seek[i][WEST].read());
				io_count++;
				#endif

		}		 
 		else if((RouterPosition(i) == BL || RouterPosition(i) == CL || RouterPosition(i) == TL)){
			#ifdef DUPLICATED_CHANNEL
				credit_i				[i][WEST0].write(0);
				credit_i				[i][WEST1].write(0);
				clock_rx				[i][WEST0].write(0);
				clock_rx				[i][WEST1].write(0);
				data_in 				[i][WEST0].write(0);
				data_in 				[i][WEST1].write(0);
				rx      				[i][WEST0].write(0);
				rx      				[i][WEST1].write(0);
				eop_in     				[i][WEST0].write(0);
				eop_in  				[i][WEST1].write(0);
				// cout << "grounding WEST in seek: " << i << endl;
				in_source_router_seek	[i][WEST].write(0);
				in_target_router_seek	[i][WEST].write(0);
				in_payload_router_seek	[i][WEST].write(0);
				in_service_router_seek	[i][WEST].write(0);
				in_req_router_seek		[i][WEST].write(0);
				in_ack_router_seek		[i][WEST].write(1);
				in_nack_router_seek		[i][WEST].write(0);
				in_opmode_router_seek	[i][WEST].write(0);
				access_i 				[i][WEST0].write(0);
				access_i 				[i][WEST1].write(0);
			#else
 			credit_i[i][WEST].write(0);
 			clock_rx[i][WEST].write(0);
 			data_in [i][WEST].write(0);
 			rx      [i][WEST].write(0); 		
			#endif
		}			
 		else{//WEST CONNECTION
			#ifdef DUPLICATED_CHANNEL
				credit_i[i][WEST0].write(credit_o[i-1][EAST0].read());
				credit_i[i][WEST1].write(credit_o[i-1][EAST1].read());
				clock_rx[i][WEST0].write(clock_tx[i-1][EAST0].read());
				clock_rx[i][WEST1].write(clock_tx[i-1][EAST1].read());
				data_in [i][WEST0].write(data_out[i-1][EAST0].read());
				data_in [i][WEST1].write(data_out[i-1][EAST1].read());
				rx      [i][WEST0].write(tx      [i-1][EAST0].read());
				rx      [i][WEST1].write(tx      [i-1][EAST1].read());
				eop_in  [i][WEST0].write(eop_out [i-1][EAST0].read());
				eop_in  [i][WEST1].write(eop_out [i-1][EAST1].read());
				in_source_router_seek	[i][WEST].write(out_source_router_seek	[i-1][EAST]);
				in_target_router_seek	[i][WEST].write(out_target_router_seek	[i-1][EAST]);
				in_payload_router_seek	[i][WEST].write(out_payload_router_seek	[i-1][EAST]);
				in_service_router_seek	[i][WEST].write(out_service_router_seek	[i-1][EAST]);
				in_req_router_seek		[i][WEST].write(out_req_router_seek		[i-1][EAST]);
				in_ack_router_seek		[i][WEST].write(out_ack_router_seek		[i-1][EAST]);
				in_nack_router_seek		[i][WEST].write(out_nack_router_seek	[i-1][EAST]);
				in_opmode_router_seek	[i][WEST].write(out_opmode_router_seek	[i-1][EAST]);
				access_i 				[i][WEST0].write(access_o 				[i-1][EAST0]);
				access_i 				[i][WEST1].write(access_o 				[i-1][EAST1]);
			#else
			credit_i[i][WEST].write(credit_o[i-1][EAST].read());
 			clock_rx[i][WEST].write(clock_tx[i-1][EAST].read());
 			data_in [i][WEST].write(data_out[i-1][EAST].read());
 			rx      [i][WEST].write(tx      [i-1][EAST].read());
			#endif
 		}
 		
 		//NORTH GROUNDING
		if(open_io[i] == 2 && (RouterPosition(i) == TL || RouterPosition(i) == TC || RouterPosition(i) == TR)){
		//if((RouterPosition(i) == TL || RouterPosition(i) == TC || RouterPosition(i) == TR)){
			#ifdef DUPLICATED_CHANNEL
				//credit_i				[i][NORTH0].write(1);
				credit_i				[i][NORTH0].write(sig_credit_i_io[io_count].read());
				credit_i				[i][NORTH1].write(0);
				clock_rx				[i][NORTH0].write(sig_clock_rx_io[io_count].read());
				clock_rx				[i][NORTH1].write(0);
				data_in 				[i][NORTH0].write(sig_data_in_io[io_count].read());
				data_in 				[i][NORTH1].write(0);
				rx      				[i][NORTH0].write(sig_rx_io[io_count].read());
				rx      				[i][NORTH1].write(0);
				eop_in     				[i][NORTH0].write(sig_eop_in_io[io_count].read());
				eop_in  				[i][NORTH1].write(0);

				sig_clock_tx_io[io_count].write(clock_tx[i][NORTH0].read());
				sig_tx_io[io_count].write(tx[i][NORTH0].read());
				sig_data_out_io[io_count].write(data_out[i][NORTH0].read());
				sig_credit_o_io[io_count].write(credit_o[i][NORTH0].read());
				sig_eop_out_io[io_count].write(eop_out[i][NORTH0].read());
				// cout << "grounding NORTH in seek: " << i << endl;
				in_source_router_seek	[i][NORTH].write(sig_in_source_router_seek_io[io_count].read());
				in_target_router_seek	[i][NORTH].write(sig_in_target_router_seek_io[io_count].read());
				in_payload_router_seek	[i][NORTH].write(sig_in_payload_router_seek_io[io_count].read());
				in_service_router_seek	[i][NORTH].write(sig_in_service_router_seek_io[io_count].read());
				in_req_router_seek		[i][NORTH].write(sig_in_req_router_seek_io[io_count].read());
				//in_ack_router_seek		[i][NORTH].write(1);
				in_ack_router_seek		[i][NORTH].write(sig_in_ack_router_seek_io[io_count].read());
				in_nack_router_seek		[i][NORTH].write(sig_in_nack_router_seek_io[io_count].read());
				in_opmode_router_seek	[i][NORTH].write(sig_in_opmode_router_seek_io[io_count].read());
				access_i 				[i][NORTH0].write(sig_fail_in_io[io_count].read());
				access_i 				[i][NORTH1].write(0);
				sig_out_req_router_seek_io[io_count].write(out_req_router_seek[i][NORTH].read());
				sig_out_ack_router_seek_io[io_count].write(out_ack_router_seek[i][NORTH].read());
				sig_out_nack_router_seek_io[io_count].write(out_nack_router_seek[i][NORTH].read());
				sig_out_opmode_router_seek_io[io_count].write(out_opmode_router_seek[i][NORTH].read());
				sig_out_service_router_seek_io[io_count].write(out_service_router_seek[i][NORTH].read());
				sig_out_source_router_seek_io[io_count].write(out_source_router_seek[i][NORTH].read());
				sig_out_target_router_seek_io[io_count].write(out_target_router_seek[i][NORTH].read());
				sig_out_payload_router_seek_io[io_count].write(out_payload_router_seek[i][NORTH].read());
				io_count++;
			#endif						
		}	
 		//else if((RouterPosition(i) == TL || RouterPosition(i) == TC || RouterPosition(i) == TR)){
 		else if((RouterPosition(i) == TL || RouterPosition(i) == TC || RouterPosition(i) == TR)){
			#ifdef DUPLICATED_CHANNEL
				credit_i[i][NORTH0].write(1);
				credit_i[i][NORTH1].write(1);
				clock_rx[i][NORTH0].write(0);
				clock_rx[i][NORTH1].write(0);
				data_in [i][NORTH0].write(0);
				data_in [i][NORTH1].write(0);
				rx      [i][NORTH0].write(0);
				rx      [i][NORTH1].write(0);
	 			eop_in  [i][NORTH0].write(0);
	 			eop_in  [i][NORTH1].write(0);
				in_source_router_seek	[i][NORTH].write(0);
				in_target_router_seek	[i][NORTH].write(0);
				in_payload_router_seek	[i][NORTH].write(0);
				in_service_router_seek	[i][NORTH].write(0);
				in_req_router_seek		[i][NORTH].write(0);
				in_ack_router_seek		[i][NORTH].write(1);
				in_nack_router_seek		[i][NORTH].write(0);
				in_opmode_router_seek	[i][NORTH].write(0);
				access_i 				[i][NORTH0].write(0);
				access_i 				[i][NORTH1].write(0);
			#else
 			credit_i[i][NORTH].write(1);
 			clock_rx[i][NORTH].write(0);
 			data_in [i][NORTH].write(0);
 			rx      [i][NORTH].write(0);
			#endif
 		}
 		else{//NORTH CONNECTION
			#ifdef DUPLICATED_CHANNEL
				credit_i[i][NORTH0].write(credit_o[i+N_PE_X][SOUTH0].read());
				credit_i[i][NORTH1].write(credit_o[i+N_PE_X][SOUTH1].read());
				clock_rx[i][NORTH0].write(clock_tx[i+N_PE_X][SOUTH0].read());
				clock_rx[i][NORTH1].write(clock_tx[i+N_PE_X][SOUTH1].read());
				data_in [i][NORTH0].write(data_out[i+N_PE_X][SOUTH0].read());
				data_in [i][NORTH1].write(data_out[i+N_PE_X][SOUTH1].read());
				rx      [i][NORTH0].write(tx      [i+N_PE_X][SOUTH0].read());
				rx      [i][NORTH1].write(tx      [i+N_PE_X][SOUTH1].read());
				eop_in  [i][NORTH0].write(eop_out [i+N_PE_X][SOUTH0].read());
				eop_in  [i][NORTH1].write(eop_out [i+N_PE_X][SOUTH1].read());
				in_source_router_seek	[i][NORTH].write(out_source_router_seek		[i+N_PE_X][SOUTH].read());
				in_target_router_seek	[i][NORTH].write(out_target_router_seek		[i+N_PE_X][SOUTH].read());
				in_payload_router_seek	[i][NORTH].write(out_payload_router_seek	[i+N_PE_X][SOUTH].read());
				in_service_router_seek	[i][NORTH].write(out_service_router_seek	[i+N_PE_X][SOUTH].read());
				in_req_router_seek		[i][NORTH].write(out_req_router_seek		[i+N_PE_X][SOUTH].read());
				in_ack_router_seek		[i][NORTH].write(out_ack_router_seek		[i+N_PE_X][SOUTH].read());
				in_nack_router_seek		[i][NORTH].write(out_nack_router_seek		[i+N_PE_X][SOUTH].read());
				in_opmode_router_seek	[i][NORTH].write(out_opmode_router_seek		[i+N_PE_X][SOUTH].read());
				access_i 				[i][NORTH0].write(access_o 					[i+N_PE_X][SOUTH0].read());
				access_i 				[i][NORTH1].write(access_o 					[i+N_PE_X][SOUTH1].read());
			#else
			credit_i[i][NORTH].write(credit_o[i+N_PE_X][SOUTH].read());
 			clock_rx[i][NORTH].write(clock_tx[i+N_PE_X][SOUTH].read());
 			data_in [i][NORTH].write(data_out[i+N_PE_X][SOUTH].read());
 			rx      [i][NORTH].write(tx      [i+N_PE_X][SOUTH].read());
			#endif
 		}
 		
 		//SOUTH GROUNDING
 		//if((RouterPosition(i) == BL || RouterPosition(i) == BC || RouterPosition(i) == BR)){
 		if(open_io[i] == 3 && (RouterPosition(i) == BL || RouterPosition(i) == BC || RouterPosition(i) == BR)){
			#ifdef DUPLICATED_CHANNEL
				credit_i				[i][SOUTH0].write(sig_credit_i_io[io_count].read());
				//credit_i				[i][SOUTH0].write(1);
				credit_i				[i][SOUTH1].write(0);
				clock_rx				[i][SOUTH0].write(sig_clock_rx_io[io_count].read());
				clock_rx				[i][SOUTH1].write(0);
				data_in 				[i][SOUTH0].write(sig_data_in_io[io_count].read());
				data_in 				[i][SOUTH1].write(0);
				rx      				[i][SOUTH0].write(sig_rx_io[io_count].read());
				rx      				[i][SOUTH1].write(0);
				eop_in     				[i][SOUTH0].write(sig_eop_in_io[io_count].read());
				eop_in  				[i][SOUTH1].write(0);
				sig_clock_tx_io[io_count].write(clock_tx[i][SOUTH0].read());
				sig_tx_io[io_count].write(tx[i][SOUTH0].read());
				sig_data_out_io[io_count].write(data_out[i][SOUTH0].read());
				sig_credit_o_io[io_count].write(credit_o[i][SOUTH0].read());
				sig_eop_out_io[io_count].write(eop_out[i][SOUTH0].read());
				// cout << "grounding SOUTH in seek: " << i << endl;
				in_source_router_seek	[i][SOUTH].write(sig_in_source_router_seek_io[io_count].read());
				in_target_router_seek	[i][SOUTH].write(sig_in_target_router_seek_io[io_count].read());
				in_payload_router_seek	[i][SOUTH].write(sig_in_payload_router_seek_io[io_count].read());
				in_service_router_seek	[i][SOUTH].write(sig_in_service_router_seek_io[io_count].read());
				in_req_router_seek		[i][SOUTH].write(sig_in_req_router_seek_io[io_count].read());
				//in_ack_router_seek		[i][SOUTH].write(1);
				in_ack_router_seek		[i][SOUTH].write(sig_in_ack_router_seek_io[io_count].read());
				in_nack_router_seek		[i][SOUTH].write(sig_in_nack_router_seek_io[io_count].read());
				in_opmode_router_seek	[i][SOUTH].write(sig_in_opmode_router_seek_io[io_count].read());
				access_i 				[i][SOUTH0].write(sig_fail_in_io[io_count].read());
				access_i 				[i][SOUTH1].write(0);
				sig_out_req_router_seek_io[io_count].write(out_req_router_seek[i][SOUTH].read());
				sig_out_ack_router_seek_io[io_count].write(out_ack_router_seek[i][SOUTH].read());
				sig_out_nack_router_seek_io[io_count].write(out_nack_router_seek[i][SOUTH].read());
				sig_out_opmode_router_seek_io[io_count].write(out_opmode_router_seek[i][SOUTH].read());
				sig_out_service_router_seek_io[io_count].write(out_service_router_seek[i][SOUTH].read());
				sig_out_source_router_seek_io[io_count].write(out_source_router_seek[i][SOUTH].read());
				sig_out_target_router_seek_io[io_count].write(out_target_router_seek[i][SOUTH].read());
				sig_out_payload_router_seek_io[io_count].write(out_payload_router_seek[i][SOUTH].read());
				io_count++;
			#endif
		}	
 		//else if((RouterPosition(i) == BL || RouterPosition(i) == BC || RouterPosition(i) == BR)){
 		else if((RouterPosition(i) == BL || RouterPosition(i) == BC || RouterPosition(i) == BR)){
			#ifdef DUPLICATED_CHANNEL
				credit_i[i][SOUTH0].write(0);
				credit_i[i][SOUTH1].write(0);
				clock_rx[i][SOUTH0].write(0);
				clock_rx[i][SOUTH1].write(0);
				data_in [i][SOUTH0].write(0);
				data_in [i][SOUTH1].write(0);
				rx      [i][SOUTH0].write(0);
				rx      [i][SOUTH1].write(0);
	 			eop_in  [i][SOUTH0].write(0);
	 			eop_in  [i][SOUTH1].write(0);
				in_source_router_seek	[i][SOUTH].write(0);
				in_target_router_seek	[i][SOUTH].write(0);
				in_payload_router_seek		[i][SOUTH].write(0);
				in_service_router_seek	[i][SOUTH].write(0);
				in_req_router_seek		[i][SOUTH].write(0);
				in_ack_router_seek		[i][SOUTH].write(1);
				in_nack_router_seek		[i][SOUTH].write(0);
				in_opmode_router_seek		[i][SOUTH].write(0);
				access_i 				[i][SOUTH0].write(0);
				access_i 				[i][SOUTH1].write(0);
			#else
 			credit_i[i][SOUTH].write(0);
 			clock_rx[i][SOUTH].write(0);
 			data_in [i][SOUTH].write(0);
 			rx      [i][SOUTH].write(0);
			#endif
 		}
 		else{//SOUTH CONNECTION
			#ifdef DUPLICATED_CHANNEL
				credit_i[i][SOUTH0].write(credit_o[i-N_PE_X][NORTH0].read());
				credit_i[i][SOUTH1].write(credit_o[i-N_PE_X][NORTH1].read());
				clock_rx[i][SOUTH0].write(clock_tx[i-N_PE_X][NORTH0].read());
				clock_rx[i][SOUTH1].write(clock_tx[i-N_PE_X][NORTH1].read());
				data_in [i][SOUTH0].write(data_out[i-N_PE_X][NORTH0].read());
				data_in [i][SOUTH1].write(data_out[i-N_PE_X][NORTH1].read());
				rx      [i][SOUTH0].write(tx      [i-N_PE_X][NORTH0].read());
				rx      [i][SOUTH1].write(tx      [i-N_PE_X][NORTH1].read());
				eop_in  [i][SOUTH0].write(eop_out [i-N_PE_X][NORTH0].read());
				eop_in  [i][SOUTH1].write(eop_out [i-N_PE_X][NORTH1].read());
				in_source_router_seek	[i][SOUTH].write(out_source_router_seek		[i-N_PE_X][NORTH].read());
				in_target_router_seek	[i][SOUTH].write(out_target_router_seek		[i-N_PE_X][NORTH].read());
				in_payload_router_seek	[i][SOUTH].write(out_payload_router_seek		[i-N_PE_X][NORTH].read());
				in_service_router_seek	[i][SOUTH].write(out_service_router_seek	[i-N_PE_X][NORTH].read());
				in_req_router_seek		[i][SOUTH].write(out_req_router_seek		[i-N_PE_X][NORTH].read());
				in_ack_router_seek		[i][SOUTH].write(out_ack_router_seek		[i-N_PE_X][NORTH].read());
				in_nack_router_seek		[i][SOUTH].write(out_nack_router_seek		[i-N_PE_X][NORTH].read());
				in_opmode_router_seek	[i][SOUTH].write(out_opmode_router_seek		[i-N_PE_X][NORTH].read());
				access_i 				[i][SOUTH0].write(access_o 					[i-N_PE_X][NORTH0].read());
				access_i 				[i][SOUTH1].write(access_o 					[i-N_PE_X][NORTH1].read());
			#else
			credit_i[i][SOUTH].write(credit_o[i-N_PE_X][NORTH].read());
 			clock_rx[i][SOUTH].write(clock_tx[i-N_PE_X][NORTH].read());
 			data_in [i][SOUTH].write(data_out[i-N_PE_X][NORTH].read());
 			rx      [i][SOUTH].write(tx      [i-N_PE_X][NORTH].read());
			#endif
 		}
 	}
}
