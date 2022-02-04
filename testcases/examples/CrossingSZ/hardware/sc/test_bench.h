#include <systemc.h>
#include <iostream>//TIRAR DEPOIS
#include <fstream>
#include <string>

using namespace std;

#include "hemps.h"
#include "./peripherals/IO_peripheral/injector.h"

SC_MODULE(test_bench) {
    
    sc_signal< bool >   clock;
    sc_signal< bool >   reset;
        
    void ClockGenerator();
    void resetGenerator();
    void debug_output();
    void log_gen();
  
    
    hemps *MPSoC;
    injector *Injector;

    int io_count;

    char aux[255];
    FILE *fp;
    
    //connection tb_io to hemps
    // NoC Interface
    sc_signal<bool >        clock_tx_tb[IO_NUMBER];
    sc_signal<bool >        tx_tb[IO_NUMBER];
    sc_signal<regflit >     data_out_tb[IO_NUMBER];
    sc_signal<bool >        credit_i_tb[IO_NUMBER];
    sc_signal<bool >        eop_in_tb[IO_NUMBER];
    
    sc_signal<bool >        clock_rx_tb[IO_NUMBER];
    sc_signal<bool >        rx_tb[IO_NUMBER];
    sc_signal<regflit >     data_in_tb[IO_NUMBER];
    sc_signal<bool >        credit_o_tb[IO_NUMBER];
    sc_signal<bool >        eop_out_tb[IO_NUMBER];

    //credit_i              [i][EAST0].write(credit_i_io[IO_NUMBER].read());


    
        sc_signal<reg_seek_source >                         in_source_router_seek_tb[IO_NUMBER];
        sc_signal<reg_seek_target >                         in_target_router_seek_tb[IO_NUMBER];
        sc_signal<reg_seek_payload >                        in_payload_router_seek_tb[IO_NUMBER];
        sc_signal<reg_seek_service >                        in_service_router_seek_tb[IO_NUMBER];
        sc_signal<bool >                                    in_req_router_seek_tb[IO_NUMBER];
        sc_signal<bool >                                    in_ack_router_seek_tb[IO_NUMBER];
        sc_signal<bool >                                    in_nack_router_seek_tb[IO_NUMBER];
        sc_signal<bool >                                    in_opmode_router_seek_tb[IO_NUMBER];
        //sc_signal<bool >                                  external_fail_in_tb[IO_NUMBER][NPORT-1];
        //sc_signal<bool >                                  external_fail_out_tb[IO_NUMBER][NPORT-1];
        //sc_signal<bool >                                  fail_out_tb[IO_NUMBER][NPORT-1];
        //sc_signal<bool >                                  fail_in_tb[IO_NUMBER][NPORT-1];
        sc_signal<bool >                                    out_req_router_seek_tb[IO_NUMBER];
        sc_signal<bool >                                    out_ack_router_seek_tb[IO_NUMBER];
        sc_signal<bool >                                    out_nack_router_seek_tb[IO_NUMBER];
        sc_signal<bool >                                    out_opmode_router_seek_tb[IO_NUMBER];
        sc_signal<reg_seek_service >                        out_service_router_seek_tb[IO_NUMBER];
        sc_signal<reg_seek_source >                         out_source_router_seek_tb[IO_NUMBER];
        sc_signal<reg_seek_target >                         out_target_router_seek_tb[IO_NUMBER];
        sc_signal<reg_seek_payload >                        out_payload_router_seek_tb[IO_NUMBER];




    SC_HAS_PROCESS(test_bench);
    test_bench(sc_module_name name_, char *filename_= "output_master.txt") :
    sc_module(name_), filename(filename_)
    {
        io_count = 0; //!! KEEP IN MIND
        //load_appstart_repository();
        //load_appstart();

        MPSoC = new hemps("HeMPS");
        MPSoC->clock(clock);
        MPSoC->reset(reset);

        Injector = new injector("INJECTOR", 90);
        Injector->clock(clock);
        Injector->reset(reset);

 // NoC Interface

        Injector->clock_tx_primary(clock_rx_tb[0]);
        Injector->tx_primary(rx_tb[0]);
        Injector->data_out_primary(data_in_tb[0]);
        Injector->credit_i_primary(credit_o_tb[0]);
        Injector->eop_in_primary(eop_out_tb[0]);  
        Injector->clock_rx_primary(clock_tx_tb[0]);
        Injector->rx_primary(tx_tb[0]);
        Injector->data_in_primary(data_out_tb[0]);
        Injector->credit_o_primary(credit_i_tb[0]);
        Injector->eop_out_primary(eop_in_tb[0]);

  
        Injector->in_source_router_seek_primary(out_source_router_seek_tb[0]);
        Injector->in_target_router_seek_primary(out_target_router_seek_tb[0]);
        Injector->in_payload_router_seek_primary(out_payload_router_seek_tb[0]);
        Injector->in_service_router_seek_primary(out_service_router_seek_tb[0]);
        Injector->in_req_router_seek_primary(out_req_router_seek_tb[0]);
        Injector->in_ack_router_seek_primary(out_ack_router_seek_tb[0]);
        Injector->in_opmode_router_seek_primary(out_opmode_router_seek_tb[0]);

        Injector->out_service_router_seek_primary(in_service_router_seek_tb[0]);
        Injector->out_source_router_seek_primary(in_source_router_seek_tb[0]);
        Injector->out_target_router_seek_primary(in_target_router_seek_tb[0]);
        Injector->out_payload_router_seek_primary(in_payload_router_seek_tb[0]);
        Injector->out_ack_router_seek_primary(in_ack_router_seek_tb[0]);
        Injector->out_nack_router_seek_primary(in_nack_router_seek_tb[0]);
        Injector->out_opmode_router_seek_primary(in_opmode_router_seek_tb[0]);
        Injector->out_req_router_seek_primary(in_req_router_seek_tb[0]);



        Injector->clock_tx_secondary(clock_rx_tb[1]);
        Injector->tx_secondary(rx_tb[1]);
        Injector->data_out_secondary(data_in_tb[1]);
        Injector->credit_i_secondary(credit_o_tb[1]);
        Injector->eop_in_secondary(eop_out_tb[1]);  
        Injector->clock_rx_secondary(clock_tx_tb[1]);
        Injector->rx_secondary(tx_tb[1]);
        Injector->data_in_secondary(data_out_tb[1]);
        Injector->credit_o_secondary(credit_i_tb[1]);
        Injector->eop_out_secondary(eop_in_tb[1]);

  
        Injector->in_source_router_seek_secondary(out_source_router_seek_tb[1]);
        Injector->in_target_router_seek_secondary(out_target_router_seek_tb[1]);
        Injector->in_payload_router_seek_secondary(out_payload_router_seek_tb[1]);
        Injector->in_service_router_seek_secondary(out_service_router_seek_tb[1]);
        Injector->in_req_router_seek_secondary(out_req_router_seek_tb[1]);
        Injector->in_ack_router_seek_secondary(out_ack_router_seek_tb[1]);
        Injector->in_opmode_router_seek_secondary(out_opmode_router_seek_tb[1]);

        Injector->out_service_router_seek_secondary(in_service_router_seek_tb[1]);
        Injector->out_source_router_seek_secondary(in_source_router_seek_tb[1]);
        Injector->out_target_router_seek_secondary(in_target_router_seek_tb[1]);
        Injector->out_payload_router_seek_secondary(in_payload_router_seek_tb[1]);
        Injector->out_ack_router_seek_secondary(in_ack_router_seek_tb[1]);
        Injector->out_nack_router_seek_secondary(in_nack_router_seek_tb[1]);
        Injector->out_opmode_router_seek_secondary(in_opmode_router_seek_tb[1]);
        Injector->out_req_router_seek_secondary(in_req_router_seek_tb[1]);



        for(int i =0; i<N_PE; i++){
            if (open_io[i] != GROUND){



            MPSoC->clock_tx_io[io_count](clock_tx_tb[io_count]);
            MPSoC->tx_io[io_count](tx_tb[io_count]);
            MPSoC->data_out_io[io_count](data_out_tb[io_count]);
            MPSoC->credit_i_io[io_count](credit_i_tb[io_count]);
            MPSoC->eop_in_io[io_count](eop_in_tb[io_count]);
    
            MPSoC->clock_rx_io[io_count](clock_rx_tb[io_count]);
            MPSoC->rx_io[io_count](rx_tb[io_count]);
            MPSoC->data_in_io[io_count](data_in_tb[io_count]);
            MPSoC->credit_o_io[io_count](credit_o_tb[io_count]);
            MPSoC->eop_out_io[io_count](eop_out_tb[io_count]);

            MPSoC->in_source_router_seek_io[io_count](in_source_router_seek_tb[io_count]);
            MPSoC->in_target_router_seek_io[io_count](in_target_router_seek_tb[io_count]);
            MPSoC->in_payload_router_seek_io[io_count](in_payload_router_seek_tb[io_count]);
            MPSoC->in_service_router_seek_io[io_count](in_service_router_seek_tb[io_count]);
            MPSoC->in_req_router_seek_io[io_count](in_req_router_seek_tb[io_count]);
            MPSoC->in_ack_router_seek_io[io_count](in_ack_router_seek_tb[io_count]);
            MPSoC->in_nack_router_seek_io[io_count](in_nack_router_seek_tb[io_count]);
            MPSoC->in_opmode_router_seek_io[io_count](in_opmode_router_seek_tb[io_count]);
            MPSoC->out_req_router_seek_io[io_count](out_req_router_seek_tb[io_count]);
            MPSoC->out_ack_router_seek_io[io_count](out_ack_router_seek_tb[io_count]);
            MPSoC->out_nack_router_seek_io[io_count](out_nack_router_seek_tb[io_count]);
            MPSoC->out_opmode_router_seek_io[io_count](out_opmode_router_seek_tb[io_count]);
            MPSoC->out_service_router_seek_io[io_count](out_service_router_seek_tb[io_count]);
            MPSoC->out_source_router_seek_io[io_count](out_source_router_seek_tb[io_count]);
            MPSoC->out_target_router_seek_io[io_count](out_target_router_seek_tb[io_count]);
            MPSoC->out_payload_router_seek_io[io_count](out_payload_router_seek_tb[io_count]);
            io_count++;
            }

        }
        
        SC_THREAD(ClockGenerator);

        SC_THREAD(resetGenerator);
        
    }

    private:
        char *filename;
};


#ifndef MTI_SYSTEMC

int sc_main(int argc, char *argv[]){
    int time_to_run=0;
    int i;
    char *filename = "output_master.txt";
    if(argc<3){
        cout << "Sintax: " << argv[0] << " -c <milisecons to execute> [-o <output filename>]" << endl;
        exit(EXIT_FAILURE);
    }
    
    for (i = 1; i < argc; i++){/* Check for a switch (leading "-"). */
        if (argv[i][0] == '-') {/* Use the next character to decide what to do. */
            switch (argv[i][1]){
                case 'c':
                    time_to_run = atoi(argv[++i]);
                break;
                case 'o':
                    filename = argv[++i];
                    cout << filename << endl;
                break;
                default:
                    cout << "Sintax: " << argv[0] << "-c <milisecons to execute> [-o <output name file>]" << endl;
                    exit(EXIT_FAILURE);
                break;
            }
        }
    }
    
    
    test_bench tb("testbench",filename);
    sc_start(time_to_run,SC_MS);
    return 0;
}
#endif
