#ifndef _SCGENMOD_routerCCWrapped_
#define _SCGENMOD_routerCCWrapped_

#include <systemc.h>

#include "../../standards.h"
#include "RouterCCwrapped.h"

SC_MODULE(RouterCCwrapped) {
		sc_in<bool> clock;
		sc_in<bool> reset;
		sc_in<bool > clock_rx[NPORT];
		sc_in<bool > rx[NPORT];
		sc_in<bool > eop_in[NPORT];
		sc_in<regflit > data_in[NPORT];
		sc_out<bool > credit_o[NPORT];
		sc_out<bool > clock_tx[NPORT];
		sc_out<bool > tx[NPORT];
		sc_out<bool > eop_out[NPORT];
		sc_out<regflit > data_out[NPORT];
		sc_in<bool > credit_i[NPORT];
		sc_in<bool >  access_i[NPORT];
		sc_out<bool >  access_o[NPORT];

    	sc_in<regflit> 		k1;
		sc_in<regflit> 		k2;
		sc_in<bool > 		ap[NPORT];
		sc_in<bool > 		sz[NPORT];
		sc_in<sc_uint<8 > >		apThreshold;
		sc_out<bool>            intAP;

		sc_out<bool > 		unreachable[NPORT];

		sc_out<regflit> 			source;
		sc_out<regflit> 			target;
		sc_out<bool> 				w_source_target;
    	sc_out<regNport >           rot_table[NPORT];
		sc_out<reg4> w_addr;


		//signals to bind in wrapped module
		sc_signal<regNport > clock_rx_internal;
		sc_signal<regNport > rx_internal;
		sc_signal<regNport > eop_in_internal;
		sc_signal<regNport > credit_o_internal;
		sc_signal<regNport > clock_tx_internal;
		sc_signal<regNport > tx_internal;
		sc_signal<regNport > eop_out_internal;
		sc_signal<regNport > credit_i_internal;
		sc_signal<regNport > ap_internal;
		sc_signal<regNport > sz_internal;
		sc_signal<regNport > unreachable_internal;
		sc_signal<regNport > access_i_internal;
		sc_signal<regNport > access_o_internal;
		sc_signal<bool > intAP_internal;



		RouterCC *router;

		void upd_clock_rx();
		void upd_rx();
		void upd_eop_in();
		void upd_credit_o();
		void upd_clock_tx();
		void upd_tx();
		void upd_eop_out();
		void upd_credit_i();
		void upd_ap();
		void upd_sz();
		// void upd_keys();
		void upd_unreach();
		void upd_access_i();
		void upd_access_o();
		void upd_intAP();


		//Traffic monitor
		sc_in<sc_uint<32 > > tick_counter;
		unsigned char SM_traffic_monitor[NPORT];
		unsigned int target_router[NPORT];
		unsigned int header_time[NPORT];
		unsigned short bandwidth_allocation[NPORT];
		unsigned short payload[NPORT];
		unsigned short payload_counter[NPORT];
		unsigned int service[NPORT];
		unsigned int task_id[NPORT];
		unsigned int counter_target[NPORT];
		unsigned int consumer_id[NPORT];
		unsigned int SR_found[NPORT];
		void traffic_monitor();

		int i;


		SC_HAS_PROCESS(RouterCCwrapped);
		RouterCCwrapped(sc_module_name name_, regaddress address_ = 0x0000) :
		sc_module(name_), address(address_)
		{

			const char* generic_list[1];
			generic_list[0] = strdup("address=x\"AAAA\"");
			sprintf((char*) generic_list[0],"address=x\"%.4x\"",(int)address);

			router = new RouterCC("RouterCC_AP", "RouterCC_AP", 1, generic_list);

			#ifdef DUPLICATED_CHANNEL
				router->reset(reset);
				router->clock(clock);
				router->clock_rx(clock_rx_internal);
				router->rx(rx_internal);
				router->eop_in(eop_in_internal);
				router->access_i(access_i_internal);
				router->access_o(access_o_internal);
				//ports interconnection are mixed due to an issue in SystemC - VHDL integration
				router->data_in[LOCAL1](data_in[EAST0]);
				router->data_in[LOCAL0](data_in[EAST1]);
				router->data_in[SOUTH1](data_in[WEST0]);
				router->data_in[SOUTH0](data_in[WEST1]);
				router->data_in[NORTH1](data_in[NORTH0]);
				router->data_in[NORTH0](data_in[NORTH1]);
				router->data_in[WEST1](data_in[SOUTH0]);
				router->data_in[WEST0](data_in[SOUTH1]);
				router->data_in[EAST1](data_in[LOCAL0]);
				router->data_in[EAST0](data_in[LOCAL1]);
				router->credit_o(credit_o_internal);
				router->clock_tx(clock_tx_internal);
				router->tx(tx_internal);
				router->eop_out(eop_out_internal);
				//ports interconnection are mixed due to an issue in SystemC - VHDL integration
				router->data_out[LOCAL1](data_out[EAST0]);
				router->data_out[LOCAL0](data_out[EAST1]);
				router->data_out[SOUTH1](data_out[WEST0]);
				router->data_out[SOUTH0](data_out[WEST1]);
				router->data_out[NORTH1](data_out[NORTH0]);
				router->data_out[NORTH0](data_out[NORTH1]);
				router->data_out[WEST1](data_out[SOUTH0]);
				router->data_out[WEST0](data_out[SOUTH1]);
				router->data_out[EAST1](data_out[LOCAL0]);
				router->data_out[EAST0](data_out[LOCAL1]);

				router->rot_table[LOCAL1](rot_table[EAST0]);
				router->rot_table[LOCAL0](rot_table[EAST1]);
				router->rot_table[SOUTH1](rot_table[WEST0]);
				router->rot_table[SOUTH0](rot_table[WEST1]);
				router->rot_table[NORTH1](rot_table[NORTH0]);
				router->rot_table[NORTH0](rot_table[NORTH1]);
				router->rot_table[WEST1](rot_table[SOUTH0]);
				router->rot_table[WEST0](rot_table[SOUTH1]);
				router->rot_table[EAST1](rot_table[LOCAL0]);
				router->rot_table[EAST0](rot_table[LOCAL1]);

				router->credit_i(credit_i_internal);
				router->ap(ap_internal);
				router->sz(sz_internal);
				router->unreachable(unreachable_internal);
			#else
				router->reset(reset);
				router->clock(clock);
				router->clock_rx(clock_rx_internal);
				router->rx(rx_internal);
				//ports interconnection are mixed due to an issue in SystemC - VHDL integration
				router->data_in[LOCAL](data_in[EAST]);
				router->data_in[SOUTH](data_in[WEST]);
				router->data_in[NORTH](data_in[NORTH]);
				router->data_in[WEST](data_in[SOUTH]);
				router->data_in[EAST](data_in[LOCAL]);
				router->credit_o(credit_o_internal);
				router->clock_tx(clock_tx_internal);
				router->tx(tx_internal);
				//ports interconnection are mixed due to an issue in SystemC - VHDL integration
				router->data_out[LOCAL](data_out[EAST]);
				router->data_out[SOUTH](data_out[WEST]);
				router->data_out[NORTH](data_out[NORTH]);
				router->data_out[WEST](data_out[SOUTH]);
				router->data_out[EAST](data_out[LOCAL]);
				router->credit_i(credit_i_internal);
			#endif

				router->k1(k1);
				router->k2(k2);
				router->apThreshold(apThreshold);
				router->intAP(intAP_internal);
				// router->ap(ap);
				router->target(target);
				router->source(source);
				router->w_source_target(w_source_target);
				router->w_addr(w_addr);
			

			// Cleanup the memory allocated for the generic list
			for (i = 0; i < 1; i++)
				free((char*)generic_list[i]);

			SC_METHOD(upd_access_i);
			for (i = 0; i < NPORT; i++){
				sensitive << access_i[i];
			}

			SC_METHOD(upd_clock_rx);
			for (i = 0; i < NPORT; i++){
				sensitive << clock_rx[i];
			}

			SC_METHOD(upd_rx);
			for (i = 0; i < NPORT; i++){
				sensitive << rx[i];
				sensitive << access_o[i];
			}

			SC_METHOD(upd_eop_in);
			for (i = 0; i < NPORT; i++){
				sensitive << eop_in[i];
			}

			SC_METHOD(upd_credit_i);
			for (i = 0; i < NPORT; i++){
				sensitive << credit_i[i];
				sensitive << access_i[i];
			}

			SC_METHOD(upd_ap);
			for (i = 0; i < NPORT; i++){
				sensitive << ap[i];
			}

			SC_METHOD(upd_sz);
			for (i = 0; i < NPORT; i++){
				sensitive << sz[i];
			}

			// SC_METHOD(upd_keys);
			// 	sensitive << k1 << k2;

			SC_METHOD(upd_unreach);
			sensitive << unreachable_internal;
			// for (i = 0; i < NPORT; i++){
			// 	sensitive << unreachable[i];
			// }

			//output

			SC_METHOD(upd_access_o);
			sensitive << access_o_internal;

			SC_METHOD(upd_credit_o);
			sensitive << credit_o_internal;
			for (i = 0; i < NPORT; i++){
				sensitive << access_o[i];
			}

			SC_METHOD(upd_clock_tx);
			sensitive << clock_tx_internal;

			SC_METHOD(upd_tx);
			sensitive << tx_internal;
			for (i = 0; i < NPORT; i++){
				sensitive << access_i[i];
			}

			SC_METHOD(traffic_monitor);
			sensitive << clock;
			sensitive << reset;
// 
			SC_METHOD(upd_eop_out);
			sensitive << eop_out_internal;

			SC_METHOD(upd_intAP);
			sensitive << intAP_internal;


		}
		~RouterCCwrapped()
		{}

	public:
		regaddress address;

};

#endif

