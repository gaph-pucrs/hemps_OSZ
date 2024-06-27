#!/usr/bin/env python3
import sys
import math
import os
import bisect 
import re
from yaml_intf import *
from build_utils import *

## @package hw_builder
#This script compiles the hardware part inside the testcase dir
#It also generate the hardware includes hemps.h or hemps.vhd in the include directory inside the testcase

def main():
    
    testcase_name = sys.argv[1]
    
    yaml_r = get_yaml_reader(testcase_name)

    generate_testbench_h( yaml_r )

    generate_hw_pkg( yaml_r )
    
    #compile_hw
    exit_status = os.system("cd hardware/; make")
    
    if exit_status != 0:
        sys.exit("\nError compiling hardware source code\n");



def generate_testbench_h( yaml_r ):
    
    #Variables from yaml used into this function
    open_ports =        get_open_ports(yaml_r)
    io_number =         get_io_number(yaml_r)    
    x_mpsoc_dim =       get_mpsoc_x_dim(yaml_r)
    y_mpsoc_dim =       get_mpsoc_y_dim(yaml_r)
    
    peripheral_files = os.listdir("hardware/sc/peripherals/IO_peripheral/")

    file_lines = []
    #---------------- SYSTEMC SINTAX ------------------
    file_lines.append("#include <systemc.h>\n")
    file_lines.append("#include <iostream>//TIRAR DEPOIS\n")
    file_lines.append("#include <fstream>\n")
    file_lines.append("#include <string>\n")
    file_lines.append("\n")
    file_lines.append("using namespace std;\n")
    file_lines.append("\n")
    file_lines.append("#include \"hemps.h\"\n")

    ############################# verify if peripheral file exists in /hardware/sc/peripherals/IO_peripheral/ directory
    ############################# to include the respective .h file in testbench
    for port in open_ports:
        module_name = re.sub (r'\d\d*\w*', '',  port[0], flags=re.IGNORECASE)
        module_name = re.sub (r'_(?![a-z])', '', module_name, flags=re.IGNORECASE)

        file_name = str.lower(module_name + ".h")
        if file_name in peripheral_files:
            file_lines.append("#include \"./peripherals/IO_peripheral/"+ str(file_name) + "\"\n")
        else:
            print ("FATAL ERROR: peripheral file " + str(file_name) + " not found in /hardware/sc/peripherals/IO_peripheral/ directory\n")
            print ("\'testbench.h\'' automatic generation requeriments: ")
            print ("     - the peripheral file name and hardware module MUST have same write, using lowercase letters")
            print ("       e.g.: \'injector.h\' to the file and \'injector\' to the name of hardware module ")
            print ("     - the peripheral name in yaml testcase file MUST start with the hardware module name (but not the same):")
            print ("       e.g.: [injector1, 2, 0, S, 0, 1, W]")
            print ("             [injector_1, 2, 0, S, 0, 1, W]")
            print ("             [Injector, 2, 0, S, 0, 1, W]")
            sys.exit( )


        ############################# verify if hardware module is defined in .h file of respective peripheral
        file_to_open = "hardware/sc/peripherals/IO_peripheral/"+str(file_name)

        with open(file_to_open) as openfileobject:
            flag = 0
            string_to_search = "SC_MODULE("+str.lower(module_name)
            #print string_to_search
            for line in openfileobject:
                found_module = line.find(string_to_search)
                if found_module != -1:
                    flag = 1
                    #print "Achou"
                    break
            if flag == 0:
                print ("FATAL ERROR: hardware module not found in /hardware/sc/peripherals/IO_peripheral/" + str(item))
                print ("\'testbench.h\'' automatic generation requeriments: ")
                print ("     - the peripheral file name and hardware module MUST have same write, using lowercase letters")
                print ("       e.g.: \'injector.h\' to the file and \'injector\' to the name of hardware module ")
                print ("     - the peripheral name in yaml testcase file MUST start with the hardware module name:")
                print ("       e.g.: [injector1, 2, 0, S, 0, 1, W]")
                print ("             [injector_1, 2, 0, S, 0, 1, W]")
                print ("             [Injector, 2, 0, S, 0, 1, W]")
                sys.exit( )

    file_lines.append("\n")
    file_lines.append("SC_MODULE(test_bench) {\n")
    file_lines.append("    \n")
    file_lines.append("    sc_signal< bool >   clock;\n")
    file_lines.append("    sc_signal< bool >   reset;\n")
    file_lines.append("        \n")
    file_lines.append("    void ClockGenerator();\n")
    file_lines.append("    void resetGenerator();\n")
    file_lines.append("    void debug_output();\n")
    file_lines.append("    void log_gen();\n")
    file_lines.append("  \n")
    file_lines.append("    \n")
    file_lines.append("    hemps *MPSoC;\n")

    ############################# verify if the peripheral name in yaml file is equal to module name in .h peripheral file
    ############################# and change the pointer name if equal (module and pointer equal result in compilation error)
    ############################# then declare the peripheral hardware pointer
    for port in open_ports:
        module_name = re.sub (r'\d\d*\w*', '',  port[0], flags=re.IGNORECASE)
        module_name = re.sub (r'_(?![a-z])', '', module_name, flags=re.IGNORECASE)        
        file_name = str.lower(module_name + ".h")
        if file_name in peripheral_files:
            if port[0] == str.lower(module_name):
                file_lines.append("    "+ str.lower(str(module_name)) + " * ptr_"+ str(port[0]) + ";\n")
            else: 
                file_lines.append("    "+ str.lower(str(module_name)) + " *"+ str(port[0]) + ";\n")


    file_lines.append("\n")
    file_lines.append("    int io_count;\n")
    file_lines.append("\n")
    file_lines.append("    char aux[255];\n")
    file_lines.append("    FILE *fp;\n")
    file_lines.append("    \n")
    file_lines.append("    //connection tb_io to hemps\n")
    file_lines.append("    // NoC Interface\n")
    file_lines.append("    sc_signal<bool >        clock_tx_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        tx_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<regflit >     data_out_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        credit_i_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        eop_in_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        bop_in_tb[IO_NUMBER];\n")
    file_lines.append("    \n")
    file_lines.append("    sc_signal<bool >        clock_rx_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        rx_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<regflit >     data_in_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        credit_o_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        eop_out_tb[IO_NUMBER];\n")
    file_lines.append("    sc_signal<bool >        bop_out_tb[IO_NUMBER];\n")
    file_lines.append("\n")
    file_lines.append("    //credit_i              [i][EAST0].write(credit_i_io[IO_NUMBER].read());\n")
    file_lines.append("\n")
    file_lines.append("\n")
    file_lines.append("    \n")
    file_lines.append("        sc_signal<reg_seek_source >                         in_source_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<reg_seek_target >                         in_target_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<reg_seek_payload >                        in_payload_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<reg_seek_service >                        in_service_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<bool >                                    in_req_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<bool >                                    in_ack_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<bool >                                    in_nack_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<bool >                                    in_opmode_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        //sc_signal<bool >                                  external_fail_in_tb[IO_NUMBER][NPORT-1];\n")
    file_lines.append("        //sc_signal<bool >                                  external_fail_out_tb[IO_NUMBER][NPORT-1];\n")
    file_lines.append("        //sc_signal<bool >                                  fail_out_tb[IO_NUMBER][NPORT-1];\n")
    file_lines.append("        //sc_signal<bool >                                  fail_in_tb[IO_NUMBER][NPORT-1];\n")
    file_lines.append("        sc_signal<bool >                                    out_req_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<bool >                                    out_ack_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<bool >                                    out_nack_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<bool >                                    out_opmode_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<reg_seek_service >                        out_service_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<reg_seek_source >                         out_source_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<reg_seek_target >                         out_target_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("        sc_signal<reg_seek_payload >                        out_payload_router_seek_tb[IO_NUMBER];\n")
    file_lines.append("\n")
    file_lines.append("\n")
    file_lines.append("\n")
    file_lines.append("\n")
    file_lines.append("    SC_HAS_PROCESS(test_bench);\n")
    file_lines.append("    test_bench(sc_module_name name_, char *filename_= \"output_master.txt\") :\n")
    file_lines.append("    sc_module(name_), filename(filename_)\n")
    file_lines.append("    {\n")
    file_lines.append("        io_count = 0; //!! KEEP IN MIND\n")
    file_lines.append("        //load_appstart_repository();\n")
    file_lines.append("        //load_appstart();\n")
    file_lines.append("\n")
    file_lines.append("        MPSoC = new hemps(\"HeMPS\");\n")
    file_lines.append("        MPSoC->clock(clock);\n")
    file_lines.append("        MPSoC->reset(reset);\n")
    file_lines.append("\n")

    ############################# verify if the peripheral name in yaml file is equal to module name in .h peripheral file
    ############################# and change the pointer name if equal (module and pointer equal result in compilation error)
    ############################# then instance the peripheral hardware module
    for port in open_ports:
        module_name = re.sub (r'\d\d*\w*', '',  port[0], flags=re.IGNORECASE)
        module_name = re.sub (r'_(?![a-z])', '', module_name, flags=re.IGNORECASE)
        file_name = str.lower(module_name + ".h")
        if file_name in peripheral_files:
            if port[0] == str.lower(module_name):
                file_lines.append("        ptr_"+ str(port[0]) + " = new "+ str.lower(str(module_name)) + "(\""+ str.upper(str(port[0])) + "\", " + str(port[1]) + ");\n")
                file_lines.append("        ptr_"+ str(port[0]) + "->clock(clock);\n")
                file_lines.append("        ptr_"+ str(port[0]) + "->reset(reset);\n")
                file_lines.append("\n")
            else: 
                file_lines.append("        "+ str(port[0]) + " = new "+ str.lower(str(module_name)) + "(\""+ str.upper(str(port[0])) + "\", " + str(port[1]) + ");\n")
                file_lines.append("        "+ str(port[0]) + "->clock(clock);\n")
                file_lines.append("        "+ str(port[0]) + "->reset(reset);\n")
                file_lines.append("\n")


    file_lines.append(" // NoC Interface\n")
    file_lines.append("\n")

    list_index = []

    for port in open_ports:
        pe_number = (port[3] * x_mpsoc_dim) + port[2]
        bisect.insort(list_index, pe_number)
        if len(port) > 5: 
            pe_number = (port[6] * x_mpsoc_dim) + port[5]
            bisect.insort(list_index, pe_number)

    for port in open_ports:
            module_name = re.sub (r'\d\d*\w*', '',  port[0], flags=re.IGNORECASE)
            module_name = re.sub (r'_(?![a-z])', '', module_name, flags=re.IGNORECASE)
            if port[0] == str.lower(module_name): 
                module_name = "ptr_" + port[0]
            else:
                module_name = port[0]
            pe_number = (port[3] * x_mpsoc_dim) + port[2]
            index = list_index.index(pe_number)
            #print "indice"
            #print index

            if port[4] == "N" and port[3] != y_mpsoc_dim-1:
                sys.exit( str(port[0]) + " - FATAL ERROR - impossible connect peripheral to NORTH position of PE: [" + str(port[2]) + "," + str(port[3]) + "]" ) 
            if port[4] == "S" and port[3] != 0:
                sys.exit( str(port[0]) +" - FATAL ERROR - impossible connect peripheral to SOUTH position of PE: [" + str(port[2]) + "," + str(port[3]) + "]" )
            if port[4] == "E" and port[2] != x_mpsoc_dim-1:
                sys.exit( str(port[0]) + " - FATAL ERROR - impossible connect peripheral to EAST position of PE: [" + str(port[2]) + "," + str(port[3]) + "]" )
            if port[4] == "W" and port[2] != 0:
                sys.exit( str(port[0]) + " - FATAL ERROR - impossible connect peripheral to WEST position of PE: [" + str(port[2]) + "," + str(port[3]) + "]" )

            file_lines.append("        "+ str(module_name) + "->clock_tx_primary(clock_rx_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->tx_primary(rx_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->data_out_primary(data_in_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->credit_i_primary(credit_o_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->eop_in_primary(eop_out_tb["+ str(index) + "]);  \n")
            file_lines.append("        "+ str(module_name) + "->bop_in_primary(bop_out_tb["+ str(index) + "]);  \n")
            file_lines.append("        "+ str(module_name) + "->clock_rx_primary(clock_tx_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->rx_primary(tx_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->data_in_primary(data_out_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->credit_o_primary(credit_i_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->eop_out_primary(eop_in_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->bop_out_primary(bop_in_tb["+ str(index) + "]);\n")
            file_lines.append("\n")
            file_lines.append("  \n")
            file_lines.append("        "+ str(module_name) + "->in_source_router_seek_primary(out_source_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->in_target_router_seek_primary(out_target_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->in_payload_router_seek_primary(out_payload_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->in_service_router_seek_primary(out_service_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->in_req_router_seek_primary(out_req_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->in_ack_router_seek_primary(out_ack_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->in_opmode_router_seek_primary(out_opmode_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("\n")
            file_lines.append("        "+ str(module_name) + "->out_service_router_seek_primary(in_service_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->out_source_router_seek_primary(in_source_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->out_target_router_seek_primary(in_target_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->out_payload_router_seek_primary(in_payload_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->out_ack_router_seek_primary(in_ack_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->out_nack_router_seek_primary(in_nack_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->out_opmode_router_seek_primary(in_opmode_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("        "+ str(module_name) + "->out_req_router_seek_primary(in_req_router_seek_tb["+ str(index) + "]);\n")
            file_lines.append("\n")
            if len(port) > 5:
                pe_number = (port[6] * x_mpsoc_dim) + port[5]
                index = list_index.index(pe_number)
                #print "indice"
                #print index
                if port[7] == "N" and port[6] != y_mpsoc_dim-1:
                    sys.exit( str(port[0]) + " - FATAL ERROR - impossible connect peripheral to NORTH position of PE: [" + str(port[5]) + "," + str(port[6]) + "]" )
                if port[7] == "S" and port[6] != 0:
                    sys.exit( str(port[0]) + " - FATAL ERROR - impossible connect peripheral to SOUTH position of PE: [" + str(port[5]) + "," + str(port[6]) + "]" ) 
                if port[7] == "E" and port[5] != x_mpsoc_dim-1:
                    sys.exit( str(port[0]) + " - FATAL ERROR - impossible connect peripheral to EAST position of PE: [" + str(port[5]) + "," + str(port[6]) + "]" )
                if port[7] == "W" and port[5] != 0:
                    sys.exit( str(port[0]) + " - FATAL ERROR - impossible connect peripheral to WEST position of PE: [" + str(port[5]) + "," + str(port[6]) + "]" )

                file_lines.append("\n")
                file_lines.append("\n")
                file_lines.append("        "+ str(module_name) + "->clock_tx_secondary(clock_rx_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->tx_secondary(rx_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->data_out_secondary(data_in_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->credit_i_secondary(credit_o_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->eop_in_secondary(eop_out_tb["+ str(index) + "]);  \n")
                file_lines.append("        "+ str(module_name) + "->bop_in_secondary(bop_out_tb["+ str(index) + "]);  \n")
                file_lines.append("        "+ str(module_name) + "->clock_rx_secondary(clock_tx_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->rx_secondary(tx_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->data_in_secondary(data_out_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->credit_o_secondary(credit_i_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->eop_out_secondary(eop_in_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->bop_out_secondary(bop_in_tb["+ str(index) + "]);\n")
                file_lines.append("\n")
                file_lines.append("  \n")
                file_lines.append("        "+ str(module_name) + "->in_source_router_seek_secondary(out_source_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->in_target_router_seek_secondary(out_target_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->in_payload_router_seek_secondary(out_payload_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->in_service_router_seek_secondary(out_service_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->in_req_router_seek_secondary(out_req_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->in_ack_router_seek_secondary(out_ack_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->in_opmode_router_seek_secondary(out_opmode_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("\n")
                file_lines.append("        "+ str(module_name) + "->out_service_router_seek_secondary(in_service_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->out_source_router_seek_secondary(in_source_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->out_target_router_seek_secondary(in_target_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->out_payload_router_seek_secondary(in_payload_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->out_ack_router_seek_secondary(in_ack_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->out_nack_router_seek_secondary(in_nack_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->out_opmode_router_seek_secondary(in_opmode_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("        "+ str(module_name) + "->out_req_router_seek_secondary(in_req_router_seek_tb["+ str(index) + "]);\n")
                file_lines.append("\n")
                file_lines.append("\n")


    file_lines.append("\n")
    file_lines.append("        for(int i =0; i<N_PE; i++){\n")
    file_lines.append("            if (open_io[i] != GROUND){\n")
    file_lines.append("\n")
    file_lines.append("\n")
    file_lines.append("\n")
    file_lines.append("            MPSoC->clock_tx_io[io_count](clock_tx_tb[io_count]);\n")
    file_lines.append("            MPSoC->tx_io[io_count](tx_tb[io_count]);\n")
    file_lines.append("            MPSoC->data_out_io[io_count](data_out_tb[io_count]);\n")
    file_lines.append("            MPSoC->credit_i_io[io_count](credit_i_tb[io_count]);\n")
    file_lines.append("            MPSoC->eop_in_io[io_count](eop_in_tb[io_count]);\n")
    file_lines.append("            MPSoC->bop_in_io[io_count](bop_in_tb[io_count]);\n")
    file_lines.append("    \n")
    file_lines.append("            MPSoC->clock_rx_io[io_count](clock_rx_tb[io_count]);\n")
    file_lines.append("            MPSoC->rx_io[io_count](rx_tb[io_count]);\n")
    file_lines.append("            MPSoC->data_in_io[io_count](data_in_tb[io_count]);\n")
    file_lines.append("            MPSoC->credit_o_io[io_count](credit_o_tb[io_count]);\n")
    file_lines.append("            MPSoC->eop_out_io[io_count](eop_out_tb[io_count]);\n")
    file_lines.append("            MPSoC->bop_out_io[io_count](bop_out_tb[io_count]);\n")
    file_lines.append("\n")
    file_lines.append("            MPSoC->in_source_router_seek_io[io_count](in_source_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->in_target_router_seek_io[io_count](in_target_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->in_payload_router_seek_io[io_count](in_payload_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->in_service_router_seek_io[io_count](in_service_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->in_req_router_seek_io[io_count](in_req_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->in_ack_router_seek_io[io_count](in_ack_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->in_nack_router_seek_io[io_count](in_nack_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->in_opmode_router_seek_io[io_count](in_opmode_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_req_router_seek_io[io_count](out_req_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_ack_router_seek_io[io_count](out_ack_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_nack_router_seek_io[io_count](out_nack_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_opmode_router_seek_io[io_count](out_opmode_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_service_router_seek_io[io_count](out_service_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_source_router_seek_io[io_count](out_source_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_target_router_seek_io[io_count](out_target_router_seek_tb[io_count]);\n")
    file_lines.append("            MPSoC->out_payload_router_seek_io[io_count](out_payload_router_seek_tb[io_count]);\n")
    file_lines.append("            io_count++;\n")
    file_lines.append("            }\n")
    file_lines.append("\n")
    file_lines.append("        }\n")
    file_lines.append("        \n")
    file_lines.append("        SC_THREAD(ClockGenerator);\n")
    file_lines.append("\n")
    file_lines.append("        SC_THREAD(resetGenerator);\n")
    file_lines.append("        \n")
    file_lines.append("    }\n")
    file_lines.append("\n")
    file_lines.append("    private:\n")
    file_lines.append("        char *filename;\n")
    file_lines.append("};\n")
    file_lines.append("\n")
    file_lines.append("\n")
    file_lines.append("#ifndef MTI_SYSTEMC\n")
    file_lines.append("\n")
    file_lines.append("int sc_main(int argc, char *argv[]){\n")
    file_lines.append("    int time_to_run=0;\n")
    file_lines.append("    int i;\n")
    file_lines.append("    char *filename = \"output_master.txt\";\n")
    file_lines.append("    if(argc<3){\n")
    file_lines.append("        cout << \"Sintax: \" << argv[0] << \" -c <milisecons to execute> [-o <output filename>]\" << endl;\n")
    file_lines.append("        exit(EXIT_FAILURE);\n")
    file_lines.append("    }\n")
    file_lines.append("    \n")
    file_lines.append("    for (i = 1; i < argc; i++){/* Check for a switch (leading \"-\"). */\n")
    file_lines.append("        if (argv[i][0] == '-') {/* Use the next character to decide what to do. */\n")
    file_lines.append("            switch (argv[i][1]){\n")
    file_lines.append("                case 'c':\n")
    file_lines.append("                    time_to_run = atoi(argv[++i]);\n")
    file_lines.append("                break;\n")
    file_lines.append("                case 'o':\n")
    file_lines.append("                    filename = argv[++i];\n")
    file_lines.append("                    cout << filename << endl;\n")
    file_lines.append("                break;\n")
    file_lines.append("                default:\n")
    file_lines.append("                    cout << \"Sintax: \" << argv[0] << \"-c <milisecons to execute> [-o <output name file>]\" << endl;\n")
    file_lines.append("                    exit(EXIT_FAILURE);\n")
    file_lines.append("                break;\n")
    file_lines.append("            }\n")
    file_lines.append("        }\n")
    file_lines.append("    }\n")
    file_lines.append("    \n")
    file_lines.append("    \n")
    file_lines.append("    test_bench tb(\"testbench\",filename);\n")
    file_lines.append("    sc_start(time_to_run,SC_MS);\n")
    file_lines.append("    return 0;\n")
    file_lines.append("}\n")
    file_lines.append("#endif\n")

    writes_file_into_testcase("hardware/sc/test_bench.h", file_lines)

    

#####################################################################################################################################    

def generate_hw_pkg( yaml_r ):
    
    #Variables from yaml used into this function
    x_mpsoc_dim =       get_mpsoc_x_dim(yaml_r)
    y_mpsoc_dim =       get_mpsoc_y_dim(yaml_r)
    x_cluster_dim =     get_cluster_x_dim(yaml_r)
    y_cluster_dim =     get_cluster_y_dim(yaml_r)
    master_location =   get_master_location(yaml_r)
    system_model_desc = get_model_description(yaml_r)

    cluster_list = create_cluster_list(x_mpsoc_dim, y_mpsoc_dim, x_cluster_dim, y_cluster_dim, master_location)
    
    pe_type = []
    #----------- Generates PEs types ----------------
    is_master_list = []
    #Walk over x and y address
    for y in range(0, y_mpsoc_dim):
        
        for x in range(0, x_mpsoc_dim):
            #By default is a slave PE
            master_pe = False
            
            for cluster_obj in cluster_list:
                if x == cluster_obj.master_x and y == cluster_obj.master_y:
                    master_pe = True
                    break
     
            if master_pe == True:
                is_master_list.append(1) # master
            else:
                is_master_list.append(0) # slave
                
    #------------  Updates the include path -----------
    include_dir_path = "include"
    
    #Creates the include path if not exists
    if os.path.exists(include_dir_path) == False:
        os.mkdir(include_dir_path)
    
    
    if system_model_desc == "sc" or system_model_desc == "scmod":
        
        generate_to_systemc(is_master_list, yaml_r )
    
    elif system_model_desc == "vhdl":
       
        generate_to_vhdl(is_master_list, yaml_r )

    elif system_model_desc == "hybrid":

        generate_to_systemc(is_master_list, yaml_r )

        generate_to_vhdl(is_master_list, yaml_r )


def generate_to_systemc(is_master_list, yaml_r):
   
    #Variables from yaml used into this function
    page_size_KB =      get_page_size_KB(yaml_r)
    memory_size_KB =    get_memory_size_KB(yaml_r)
    repo_size_bytes =   get_repository_size_BYTES(yaml_r)
    x_mpsoc_dim =       get_mpsoc_x_dim(yaml_r)
    y_mpsoc_dim =       get_mpsoc_y_dim(yaml_r)
    app_number =        get_apps_number(yaml_r)
    open_ports =        get_open_ports(yaml_r)
    io_number =         get_io_number(yaml_r)
    apps_list =         get_apps_name_list(yaml_r)
    hts =               get_hts(yaml_r)

        #Computes the max of tasks into an app
    max_task_per_app = 0
    
    for app_name in apps_list:
        
        task_count = len( get_app_task_name_list(".", app_name) )
       
        if task_count > max_task_per_app:
            max_task_per_app = task_count


    ####
    string_pe_type_sc = ""
    
    #Walk over is master list
    for pe_type in is_master_list:
        
        string_pe_type_sc = string_pe_type_sc + str(pe_type) + ", "
    
    #Remove the lost ',' in the string_pe_type_vhdl
    string_pe_type_sc = string_pe_type_sc[0:len(string_pe_type_sc)-2] # 2 because the space, otherelse will be 1
    
    open_ports_vector = []
    for i in range(0,x_mpsoc_dim*y_mpsoc_dim):
        open_ports_vector.append(5);

    for port in open_ports:
        
        index = port[3]*x_mpsoc_dim + port[2]
        if port[4] == "N":
            open_ports_vector[index] = 2
        if port[4] == "S":
            open_ports_vector[index] = 3
        if port[4] == "E":
            open_ports_vector[index] = 0
        if port[4] == "W":
            open_ports_vector[index] = 1
        if len(port) > 5: 
            index = port[6]*x_mpsoc_dim + port[5]
            io_number=io_number + 1
            if port[7] == "N":
                open_ports_vector[index] = 2
            if port[7] == "S":
                open_ports_vector[index] = 3
            if port[7] == "E":
                open_ports_vector[index] = 0
            if port[7] == "W":
                open_ports_vector[index] = 1



    open_ports_string = ""
    for i in range(0,x_mpsoc_dim*y_mpsoc_dim):
        open_ports_string = open_ports_string + str(open_ports_vector[i]) +", "
    open_ports_string = open_ports_string[0:len(open_ports_string)-2]


    file_lines = []
    #---------------- SYSTEMC SINTAX ------------------
    file_lines.append("#ifndef _HEMPS_PKG_\n")
    file_lines.append("#define _HEMPS_PKG_\n\n")
    
    file_lines.append("#include <string>\n\n")

    file_lines.append("#define PAGE_SIZE_BYTES\t\t\t"+str(page_size_KB*1024)+"\n")
    file_lines.append("#define MEMORY_SIZE_BYTES\t\t"+str(memory_size_KB*1024)+"\n")
    file_lines.append("#define TOTAL_REPO_SIZE_BYTES\t"+str(repo_size_bytes)+"\n")
    file_lines.append("#define APP_NUMBER\t\t\t\t"+str(app_number)+"\n")
    file_lines.append("#define N_PE_X\t\t\t\t\t"+str(x_mpsoc_dim)+"\n")
    file_lines.append("#define N_PE_Y\t\t\t\t\t"+str(y_mpsoc_dim)+"\n")
    file_lines.append("#define N_PE\t\t\t\t\t"+str(x_mpsoc_dim*y_mpsoc_dim)+"\n")
    file_lines.append("#define IO_NUMBER\t\t\t\t"+str(io_number)+"\n")
    file_lines.append("#define MAX_TASKS_APP\t\t\t"+str(max_task_per_app)+" //max number of tasks for the APPs described into testcase file\n")

    for port in open_ports:
        file_lines.append("#define "+str.upper(port[0])+"\t\t\t\t"+str(port[1])+"\n")

    file_lines.append("\n//PE_TYPE \n//0-slave \n//1-master \n")
    file_lines.append("const int pe_type[N_PE] = {"+string_pe_type_sc+"};\n\n")
    file_lines.append("//OPEN_IO \n//0-EAST \n//1-WEST \n//2-NORTH \n//3-SOUTH \n//5-GND \n")
    file_lines.append("const int open_io[N_PE] = {"+open_ports_string+"};\n\n")

    # INSERT HT ARRAY HERE

    number_of_pes = x_mpsoc_dim*y_mpsoc_dim
    ht_params_array = ["xxxxxxxxxx" for router in range(number_of_pes)] # init array with blank string for each pe

    for router in hts:
        x_addr = router[0]
        y_addr = router[1]
        param_string = router[2]
        pe_number = x_addr + (y_addr * x_mpsoc_dim) # calculate pe index from addr
        ht_params_array[pe_number] = param_string
    
    file_lines.append("//Hardware Trojan parameters for each router\n")
    file_lines.append("const std::string ht_params[N_PE] = ")
    file_lines.append(str(ht_params_array).replace("'",'"').replace("[","{").replace("]","}")) # print array substituing simple for double quotation marks and [] for {}
    file_lines.append(";\n\n")

    file_lines.append("#endif\n")
    
    #Use this function to create any file into testcase, it automatically only updates the old file if necessary
    writes_file_into_testcase("include/hemps_pkg.h", file_lines)
    

def generate_to_vhdl(is_master_list, yaml_r):
    
    #Variables from yaml used into this function
    page_size_KB =      get_page_size_KB(yaml_r)
    memory_size_KB =    get_memory_size_KB(yaml_r)
    repo_size_bytes =   get_repository_size_BYTES(yaml_r)
    noc_buffer_size =   get_noc_buffer_size(yaml_r)
    x_mpsoc_dim =       get_mpsoc_x_dim(yaml_r)
    y_mpsoc_dim =       get_mpsoc_y_dim(yaml_r)
    app_number =        get_apps_number(yaml_r)
    open_ports =        get_open_ports(yaml_r)
    io_number =         get_io_number(yaml_r)
    apps_list =         get_apps_name_list(yaml_r)

    #Computes the max of tasks into an app
    max_task_per_app = 0
    
    for app_name in apps_list:
        
        task_count = len( get_app_task_name_list(".", app_name) )
       
        if task_count > max_task_per_app:
            max_task_per_app = task_count

    page_size_h_index   = int( math.log ( (page_size_KB * 1024),           2 ) - 1 )
    page_number_h_index = int( math.log ( (memory_size_KB/ page_size_KB) , 2 ) + page_size_h_index )
    
    string_pe_type_vhdl = ""
    
    #Walk over is master list
    for pe_type in is_master_list:
        
        if pe_type == 0: #slave
            string_pe_type_vhdl = string_pe_type_vhdl + "\"sla\","
        else:
            string_pe_type_vhdl = string_pe_type_vhdl + "\"mas\","
    
    #Remove the lost ',' in the string_pe_type_vhdl
    string_pe_type_vhdl = string_pe_type_vhdl[0:len(string_pe_type_vhdl)-1]

    open_ports_vector = []
    for i in range(0,x_mpsoc_dim*y_mpsoc_dim):
        open_ports_vector.append("gnd");

    for port in open_ports:
        index = port[3]*x_mpsoc_dim + port[2]
        if port[4] == "N":
            open_ports_vector[index] = "nor"
        if port[4] == "S":
            open_ports_vector[index] = "sou"
        if port[4] == "E":
            open_ports_vector[index] = "eas"
        if port[4] == "W":
            open_ports_vector[index] = "wes"
        if len(port) > 5: 
            index = port[6]*x_mpsoc_dim + port[5]
            io_number=io_number + 1
            if port[7] == "N":
                open_ports_vector[index] = "nor"
            if port[7] == "S":
                open_ports_vector[index] = "sou"
            if port[7] == "E":
                open_ports_vector[index] = "eas"
            if port[7] == "W":
                open_ports_vector[index] = "wes"    
#
#    if open_ports[0][3] == "N":
#        loader_addr = 0xC0000000
#    if open_ports[0][3] == "S":
#        loader_addr = 0xE0000000
#    if open_ports[0][3] == "E":
#        loader_addr = 0x80000000
#    if open_ports[0][3] == "W":
#        loader_addr = 0xA0000000
#
#    loader_addr = loader_addr + (open_ports[0][1] << 8) + open_ports[0][1]
#
#
    open_ports_string = ""
    for i in range(0,x_mpsoc_dim*y_mpsoc_dim):
        open_ports_string = open_ports_string + "\"" + open_ports_vector[i] + "\","
    open_ports_string = open_ports_string[0:len(open_ports_string)-1]

    
   
    file_lines = []
    #---------------- VHDL SINTAX ------------------
    file_lines.append("library IEEE;\n")
    file_lines.append("use IEEE.Std_Logic_1164.all;\n")
    file_lines.append("use IEEE.std_logic_unsigned.all;\n")
    file_lines.append("use IEEE.std_logic_arith.all;\n\n")
    file_lines.append("package hemps_pkg is\n\n")
    file_lines.append("    -- paging definitions\n")
    file_lines.append("    constant PAGE_SIZE_BYTES             : integer := "+str(page_size_KB*1024)+";\n")
    file_lines.append("    constant MEMORY_SIZE_BYTES           : integer := "+str(memory_size_KB*1024)+";\n")
    file_lines.append("    constant TOTAL_REPO_SIZE_BYTES       : integer := "+str(repo_size_bytes)+";\n")
    file_lines.append("    constant APP_NUMBER                  : integer := "+str(app_number)+";\n")
    file_lines.append("    constant PAGE_SIZE_H_INDEX        : integer := "+str(page_size_h_index)+";\n")
    file_lines.append("    constant PAGE_NUMBER_H_INDEX      : integer := "+str(page_number_h_index)+";\n")
    file_lines.append("    -- Hemps top definitions\n")
    file_lines.append("    constant NUMBER_PROCESSORS_X      : integer := "+str(x_mpsoc_dim)+";\n")
    file_lines.append("    constant NUMBER_PROCESSORS_Y      : integer := "+str(y_mpsoc_dim)+";\n")
    file_lines.append("    constant TAM_BUFFER               : integer := "+str(noc_buffer_size)+";\n")
    file_lines.append("    constant NUMBER_PROCESSORS        : integer := "+str(x_mpsoc_dim*y_mpsoc_dim)+";\n\n")
    file_lines.append("    constant IO_NUMBER                : integer := "+str(io_number)+";\n")
    file_lines.append("    constant MAX_TASKS_APP                : integer := "+str(max_task_per_app)+";\n")
    file_lines.append("    subtype kernel_str is string(1 to 3);\n")
    #file_lines.append("    type pe_type_t is array(0 to NUMBER_PROCESSORS-1) of kernel_str;\n")
    #file_lines.append("    constant pe_type : pe_type_t := ("+string_pe_type_vhdl+");\n\n")
    file_lines.append("    subtype manual_io_option is string(1 to 3);\n")
    file_lines.append("    type manual_io_type is array(0 to NUMBER_PROCESSORS-1) of manual_io_option;\n")
    file_lines.append("    constant OPEN_IO : manual_io_type := ("+open_ports_string+");\n\n")
    file_lines.append("end hemps_pkg;\n")
    
    #Use this function to create any file into testcase, it automatically only updates the old file if necessary
    writes_file_into_testcase("include/hemps_pkg.vhd", file_lines)
    
main()
