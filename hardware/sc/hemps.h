//------------------------------------------------------------------------------------------------
//
//  HEMPS -  7.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  2016
//
//  Source name:  hemps.h
//
//  Brief description: Control of intefaces.
//
//------------------------------------------------------------------------------------------------

#include <systemc.h>
#include "standards.h"
#include "pe/pe.h"

#define BL 0
#define BC 1
#define BR 2
#define CL 3
#define CC 4
#define CRX 5
#define TL 6
#define TC 7
#define TR 8



SC_MODULE(hemps) {
	
	sc_in< bool >			clock;
	sc_in< bool >			reset;

	//NoC Interface (IO) MANAGER_IO to HEMPS
	sc_out<bool >		clock_tx_io[IO_NUMBER];
	sc_out<bool >		tx_io[IO_NUMBER];
	sc_out<regflit >	data_out_io[IO_NUMBER];
	sc_in<bool >		credit_i_io[IO_NUMBER];
	sc_in<bool >		eop_in_io[IO_NUMBER];
	
	sc_in<bool >		clock_rx_io[IO_NUMBER];
	sc_in<bool > 		rx_io[IO_NUMBER];
	sc_in<regflit >		data_in_io[IO_NUMBER];
	sc_out<bool >		credit_o_io[IO_NUMBER];
	sc_out<bool >		eop_out_io[IO_NUMBER];

	//SEEK Interface (IO)
	sc_in<reg_seek_source >							in_source_router_seek_io[IO_NUMBER];
	sc_in<reg_seek_target >							in_target_router_seek_io[IO_NUMBER];
	sc_in<reg_seek_payload > 						in_payload_router_seek_io[IO_NUMBER];
	sc_in<reg_seek_service > 						in_service_router_seek_io[IO_NUMBER];
	sc_in<bool > 									in_req_router_seek_io[IO_NUMBER];
	sc_in<bool > 									in_ack_router_seek_io[IO_NUMBER];
	sc_in<bool > 									in_nack_router_seek_io[IO_NUMBER];
	sc_in<bool > 									in_opmode_router_seek_io[IO_NUMBER];
	sc_in<bool > 									fail_in_io[IO_NUMBER];
	sc_out<bool > 									fail_out_io[IO_NUMBER];
	sc_out<bool > 									out_req_router_seek_io[IO_NUMBER];
	sc_out<bool > 									out_ack_router_seek_io[IO_NUMBER];
	sc_out<bool > 									out_nack_router_seek_io[IO_NUMBER];
	sc_out<bool > 									out_opmode_router_seek_io[IO_NUMBER];
	sc_out<reg_seek_service > 						out_service_router_seek_io[IO_NUMBER];
	sc_out<reg_seek_source >						out_source_router_seek_io[IO_NUMBER];
	sc_out<reg_seek_target >						out_target_router_seek_io[IO_NUMBER];
	sc_out<reg_seek_payload > 						out_payload_router_seek_io[IO_NUMBER];
	
	//NoC Interface (IO) MANAGER_IO to HEMPS
	sc_signal<bool >		sig_clock_tx_io[IO_NUMBER];
	sc_signal<bool >		sig_tx_io[IO_NUMBER];
	sc_signal<regflit >		sig_data_out_io[IO_NUMBER];
	sc_signal<bool >		sig_credit_i_io[IO_NUMBER];
	sc_signal<bool >		sig_eop_in_io[IO_NUMBER];
	
	sc_signal<bool >		sig_clock_rx_io[IO_NUMBER];
	sc_signal<bool > 		sig_rx_io[IO_NUMBER];
	sc_signal<regflit >		sig_data_in_io[IO_NUMBER];
	sc_signal<bool >		sig_credit_o_io[IO_NUMBER];
	sc_signal<bool >		sig_eop_out_io[IO_NUMBER];

	//SEEK Interface (IO)
	sc_signal<reg_seek_source >							sig_in_source_router_seek_io[IO_NUMBER];
	sc_signal<reg_seek_target >							sig_in_target_router_seek_io[IO_NUMBER];
	sc_signal<reg_seek_payload > 						sig_in_payload_router_seek_io[IO_NUMBER];
	sc_signal<reg_seek_service > 						sig_in_service_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_in_req_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_in_ack_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_in_nack_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_in_opmode_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_fail_in_io[IO_NUMBER];
	sc_signal<bool > 									sig_fail_out_io[IO_NUMBER];
	sc_signal<bool > 									sig_out_req_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_out_ack_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_out_nack_router_seek_io[IO_NUMBER];
	sc_signal<bool > 									sig_out_opmode_router_seek_io[IO_NUMBER];
	sc_signal<reg_seek_service > 						sig_out_service_router_seek_io[IO_NUMBER];
	sc_signal<reg_seek_source >							sig_out_source_router_seek_io[IO_NUMBER];
	sc_signal<reg_seek_target >							sig_out_target_router_seek_io[IO_NUMBER];
	sc_signal<reg_seek_payload > 						sig_out_payload_router_seek_io[IO_NUMBER];
	
	// NoC Interface
	sc_signal<bool >		clock_tx[N_PE][NPORT-1];
	sc_signal<bool >		tx[N_PE][NPORT-1];
	sc_signal<regflit >		data_out[N_PE][NPORT-1];
	sc_signal<bool >		credit_i[N_PE][NPORT-1];
	sc_signal<bool >		eop_in[N_PE][NPORT-1];
	
	sc_signal<bool >		clock_rx[N_PE][NPORT-1];
	sc_signal<bool > 		rx[N_PE][NPORT-1];
	sc_signal<regflit >		data_in[N_PE][NPORT-1];
	sc_signal<bool >		credit_o[N_PE][NPORT-1];
	sc_signal<bool >		eop_out[N_PE][NPORT-1];
	
	sc_signal<reg_seek_source >							in_source_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<reg_seek_target >							in_target_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<reg_seek_payload > 						in_payload_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<reg_seek_service > 						in_service_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									in_req_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									in_ack_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									in_nack_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									in_opmode_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									external_fail_in[N_PE][NPORT-1];
	sc_signal<bool > 									external_fail_out[N_PE][NPORT-1];
	sc_signal<bool > 									fail_out[N_PE][NPORT-1];
	sc_signal<bool > 									fail_in[N_PE][NPORT-1];
	sc_signal<bool > 									out_req_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									out_ack_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									out_nack_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<bool > 									out_opmode_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<reg_seek_service > 						out_service_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<reg_seek_source >							out_source_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<reg_seek_target >							out_target_router_seek[N_PE][NPORT_SEEK-1];
	sc_signal<reg_seek_payload > 						out_payload_router_seek[N_PE][NPORT_SEEK-1];

	pe  *	PE[N_PE];//store slaves PEs
	
	int i,j;
	
	int RouterPosition(int router);
	regaddress RouterAddress(int router);
	regaddress r_addr;
 	void pes_interconnection();
 	void io_interconnection();
	void ni_interconnection();
	
 	void fault_injection();
	int test_faults_inserted(int nbr_faults);
	#define MAX_FAULTS 100
	struct struct_faults{
		int pe[MAX_FAULTS];
		int port[MAX_FAULTS];
		int time[MAX_FAULTS];
	}faults;
	
	char pe_name[20];
	int x_addr, y_addr;
	SC_CTOR(hemps){
	
		cout << "This version of HeMPS contains:" << endl;
		#ifdef DUPLICATED_CHANNEL
		cout << "Noc with duplicated channel:" << endl;
		#else
		cout << "Noc with single channel" << endl;
		#endif
		cout << "Seek Module" << endl;

		for (j = 0; j < N_PE; j++) {

			r_addr = RouterAddress(j);
			x_addr = ((int) r_addr) >> 8; //get 2 most signaficative bytes
			y_addr = ((int) r_addr) & 0xFF;//get 2 least signaficative bytes

			switch (pe_type[j]) {
			case 0: //Slave
				sprintf(pe_name, "slave%dx%d", x_addr, y_addr);
				break;
			case 1: //Local Master
				sprintf(pe_name, "local%dx%d", x_addr, y_addr);
				break;
			case 2: //Global Master
				sprintf(pe_name, "master%dx%d", x_addr, y_addr);
				break;
			default:
				cout << "ERROR: pe_type not compatible\n";
				exit(1);
				break;
			}

			printf("Creating PE %s\n", pe_name, r_addr);

			PE[j] = new pe(pe_name, r_addr);
			PE[j]->clock(clock);
			PE[j]->reset(reset);

			for (i = 0; i < NPORT - 1; i++) {
				PE[j]->clock_tx					[i]	(clock_tx		[j][i]);
				PE[j]->tx						[i]	(tx				[j][i]);
				PE[j]->data_out					[i]	(data_out		[j][i]);
				PE[j]->credit_i					[i]	(credit_i		[j][i]);
				PE[j]->eop_out					[i]	(eop_out		[j][i]);
				PE[j]->clock_rx					[i]	(clock_rx		[j][i]);
				PE[j]->data_in					[i]	(data_in		[j][i]);
				PE[j]->rx						[i]	(rx				[j][i]);
				PE[j]->credit_o					[i]	(credit_o		[j][i]);
				PE[j]->eop_in					[i]	(eop_in			[j][i]);
				PE[j]->fail_in					[i]	(fail_in			[j][i]);
				PE[j]->fail_out					[i]	(fail_out			[j][i]);
				PE[j]->external_fail_out		[i]	(external_fail_out	[j][i]);
				PE[j]->external_fail_in			[i]	(external_fail_in	[j][i]);
			}
			
			for(i=0;i<NPORT_SEEK-1;i++){
				PE[j]->in_source_router_seek	[i]	(in_source_router_seek		[j][i]);
				PE[j]->in_target_router_seek	[i]	(in_target_router_seek		[j][i]);
				PE[j]->in_payload_router_seek	[i]	(in_payload_router_seek			[j][i]);
				PE[j]->in_service_router_seek	[i]	(in_service_router_seek		[j][i]);
				PE[j]->in_req_router_seek		[i]	(in_req_router_seek			[j][i]);
				PE[j]->in_ack_router_seek		[i]	(in_ack_router_seek			[j][i]);
				PE[j]->in_nack_router_seek		[i]	(in_nack_router_seek		[j][i]);
				PE[j]->in_opmode_router_seek	[i]	(in_opmode_router_seek		[j][i]);
				PE[j]->out_req_router_seek		[i]	(out_req_router_seek		[j][i]);
				PE[j]->out_ack_router_seek		[i]	(out_ack_router_seek		[j][i]);
				PE[j]->out_nack_router_seek		[i]	(out_nack_router_seek		[j][i]);
				PE[j]->out_opmode_router_seek	[i]	(out_opmode_router_seek		[j][i]);
				PE[j]->out_service_router_seek	[i]	(out_service_router_seek	[j][i]);
				PE[j]->out_source_router_seek	[i]	(out_source_router_seek		[j][i]);
				PE[j]->out_target_router_seek	[i]	(out_target_router_seek		[j][i]);
				PE[j]->out_payload_router_seek	[i]	(out_payload_router_seek		[j][i]);
			}
		}
 		SC_THREAD(fault_injection);
		sensitive << reset;

		SC_METHOD(pes_interconnection);
		for (j = 0; j < N_PE; j++) {
			for (i = 0; i < NPORT - 1; i++) {
				sensitive << clock_tx[j][i];
				sensitive << tx[j][i];
				sensitive << data_out[j][i];
				sensitive << credit_i[j][i];
				sensitive << clock_rx[j][i];
				sensitive << eop_in[i][j];
				sensitive << eop_out[i][j];
				sensitive << data_in[j][i];
				sensitive << rx[j][i];
				sensitive << credit_o[j][i];
			}
		}
		for (i = 2; i < IO_NUMBER; i++) {
			sensitive << sig_clock_rx_io[i];
			sensitive << sig_rx_io[i];
			sensitive << sig_data_in_io[i];
			sensitive << sig_credit_i_io[i];
			sensitive << sig_eop_in_io[i];
		}

		SC_METHOD(io_interconnection);
		sensitive << clock.pos();
		sensitive << reset;

		SC_METHOD(ni_interconnection);
		for(i = 2; i < IO_NUMBER; i++) {
			sensitive << sig_clock_tx_io[i];
			sensitive << sig_tx_io[i];
			sensitive << sig_data_out_io[i];
			sensitive << credit_i_io[i];
			sensitive << sig_eop_out_io[i];
			sensitive << eop_in_io[i];
			sensitive << data_in_io[i];
			sensitive << clock_rx_io[i];
			sensitive << rx_io[i];
			sensitive << sig_credit_o_io[i];
		}
	}
};

