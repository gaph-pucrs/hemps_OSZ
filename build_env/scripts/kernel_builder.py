#!/usr/bin/python
import sys
import math
import os
from yaml_intf import *
from build_utils import *

## @package kernel_builder
#This scripts compile the kernels and generates the include files kernel_pkg.h and kernel_pkg.c
#Additionally, this scripts generate the processors' memory text files

def main():
    
    testcase_name = sys.argv[1]
    
    yaml_r = get_yaml_reader(testcase_name)
    
    generate_sw_pkg( yaml_r )
    
    #compile_kernel master and slave and if exit status is equal to 0 (ok) then check page_size
    exit_status = os.system("cd software/; make")
        
    if exit_status != 0:
        sys.exit("\nError compiling kernel source code\n");
        
    print "\n***************** kernel page size report ***********************"
    check_page_size("software/kernel_slave.txt", get_page_size_KB(yaml_r) )
    
    check_page_size("software/kernel_master.txt", get_page_size_KB(yaml_r) )
        
    print "***************** end kernel page size report *********************\n"
    
    generate_memory( yaml_r )

def generate_sw_pkg( yaml_r ):
    
    #Variables from yaml used into this function
    page_size_KB =      get_page_size_KB(yaml_r)
    memory_size_KB =    get_memory_size_KB(yaml_r)
    max_local_tasks =   get_tasks_per_PE(yaml_r)
    x_mpsoc_dim =       get_mpsoc_x_dim(yaml_r)
    y_mpsoc_dim =       get_mpsoc_y_dim(yaml_r)
    x_cluster_dim =     get_cluster_x_dim(yaml_r)
    y_cluster_dim =     get_cluster_y_dim(yaml_r)
    master_location =   get_master_location(yaml_r)
    apps_list =         get_apps_name_list(yaml_r)
    static_mapping_list = get_static_mapping_list(yaml_r)
    io_number =         get_io_number(yaml_r)
    open_ports =        get_open_ports(yaml_r)
    session =           get_session(yaml_r)
    gray_area_rows =    get_gray_area_rows(yaml_r)
    gray_area_cols =    get_gray_area_cols(yaml_r)

    
    cluster_list = create_cluster_list(x_mpsoc_dim, y_mpsoc_dim, x_cluster_dim, y_cluster_dim, master_location)

   # peripheral_list = create_peripheral_list(peripheral_ID, address1_x, address1_y, port1, address2_x, address2_y, port2)
    
    master_number = len(cluster_list)
    max_slave_processors = (x_mpsoc_dim*y_mpsoc_dim) - master_number
    max_cluster_slave = (x_cluster_dim * y_cluster_dim) - 1
    max_cluster_PEs = (x_cluster_dim * y_cluster_dim) 
    apps_number = len(apps_list)
    static_lenght = str(len(static_mapping_list)) 
    
    #Computes the max of tasks into an app
    max_task_per_app = 0
    
    for app_name in apps_list:
        
        task_count = len( get_app_task_name_list(".", app_name) )
       
        if task_count > max_task_per_app:
            max_task_per_app = task_count
            
            
    
    file_lines = []
    #---------------- C SINTAX ------------------
    file_lines.append("#ifndef _KERNEL_PKG_\n")
    file_lines.append("#define _KERNEL_PKG_\n\n")
    
    file_lines.append("#define MAX_LOCAL_TASKS             "+str(max_local_tasks)+"  //max task allowed to execute into a single slave processor \n")
    file_lines.append("#define PAGE_SIZE                   "+str(page_size_KB*1024)+"//bytes\n")
    file_lines.append("#define MAX_TASKS_APP               "+str(max_task_per_app)+" //max number of tasks for the APPs described into testcase file\n")
    
    file_lines.append("\n//Only used by kernel master\n")
    file_lines.append("#define MAX_SLAVE_PROCESSORS        "+str(max_slave_processors)+"    //total of slave processors for the whole mpsoc\n")
    file_lines.append("#define MAX_CLUSTER_PEs             "+str(max_cluster_PEs)+"      //total of processors for each cluster\n")
    #file_lines.append("#define MAX_CLUSTER_SLAVES          "+str(max_cluster_slave)+"    //total of slave processors for each cluster\n")
    file_lines.append("#define MAX_CLUSTER_APP             "+str(max_cluster_slave*max_local_tasks)+"    //max of app running simultaneously into each cluster\n")
    file_lines.append("#define XDIMENSION                  "+str(x_mpsoc_dim)+"     //mpsoc  x dimension\n")
    file_lines.append("#define YDIMENSION                  "+str(y_mpsoc_dim)+"     //mpsoc  y dimension\n")
    file_lines.append("#define XCLUSTER                    "+str(x_cluster_dim)+"     //cluster x dimension\n") 
    file_lines.append("#define YCLUSTER                    "+str(y_cluster_dim)+"     //cluster y dimension\n")
    file_lines.append("#define CLUSTER_NUMBER              "+str(master_number)+"     //total number of cluster\n")
    file_lines.append("#define APP_NUMBER                  "+str(apps_number)+"     //max number of APPs described into testcase file\n")
    file_lines.append("#define MAX_STATIC_TASKS            "+static_lenght+"      //max number of tasks mapped statically \n\n")
    file_lines.append("#define IO_NUMBER                   "+str(io_number)+"\n")

    if gray_area_rows:
        file_lines.append("\n//Gray Area enabled\n")
        file_lines.append("#define GRAY_AREA\n")
        file_lines.append("#define MAX_GRAY_ROWS               "+str(len(gray_area_rows))+"\n")
        file_lines.append("#define MAX_GRAY_COLS               "+str(len(gray_area_cols))+"\n\n")


    for port in open_ports:
        file_lines.append("#define "+str.upper(port[0])+"\t\t\t\t\t"+str(port[1])+"\n")
    
    if session:
        file_lines.append("\n//Comunication Session protocol is Enabled\n")
        file_lines.append("#define SESSION_MANAGER\n")



    file_lines.append("\n")
    #file_lines.append("#ifdef IS_MASTER\n")
    file_lines.append("//This struct stores the cluster information\n")
    file_lines.append("typedef struct {\n")
    file_lines.append("    int master_x;		//master x address\n")
    file_lines.append("    int master_y;		//master y address\n")
    file_lines.append("    int xi;				//initial x address of the cluster perimeter\n")
    file_lines.append("    int yi;				//initial y address of the cluster perimeter\n")
    file_lines.append("    int xf;				//final x address of the cluster perimeter\n")
    file_lines.append("    int yf;				//final y address of the cluster perimeter\n")
    file_lines.append("    int free_resources;	//number of free pages available into the cluster's slave processors\n")
    file_lines.append("} ClusterInfo;\n\n")
    

    file_lines.append("extern ClusterInfo cluster_info[CLUSTER_NUMBER];\n\n")


      #file_lines.append("#ifdef IS_MASTER\n")
    file_lines.append("//This struct stores the peripheral information\n")
    file_lines.append("typedef struct {\n")
    file_lines.append("    int peripheral_id;            //ID of the peripheral\n")
    file_lines.append("    int default_address_x;        //IO x address\n")
    file_lines.append("    int default_address_y;        //IO y address\n")
    file_lines.append("    int default_port;             //PORT from noc to external peripheral\n")
    file_lines.append("    int alternative_address_x;    //IO x address\n")
    file_lines.append("    int alternative_address_y;    //IO y address\n")
    file_lines.append("    int alternative_port;         //PORT from noc to external peripheral\n")
    file_lines.append("    int active_connection;        // indicates the active address (0-default 1-alternative)\n")
    file_lines.append("} IO_Info;\n\n")
    

    file_lines.append("extern IO_Info io_info[IO_NUMBER];\n\n")
    
    if gray_area_rows:
        file_lines.append("//This struct stores the gray area information\n")
        file_lines.append("typedef struct {\n")
        file_lines.append("    int rows[MAX_GRAY_ROWS];\n")
        file_lines.append("    int cols[MAX_GRAY_COLS];\n")
        file_lines.append("    int IOside;\n")
        file_lines.append("} GrayArea;\n")

        file_lines.append(" extern GrayArea ga;\n")

    #Check if the list is not emply
    if static_mapping_list:
        file_lines.append("//Stores the task static mapping. It is a list of tuple = {task_id, mapped_proc}\n")
        file_lines.append("extern unsigned int static_map[MAX_STATIC_TASKS][2];\n\n")

    
    file_lines.append("#endif\n")
    
    #Use this function to create any file into testcase, it automatically only updates the old file if necessary
    writes_file_into_testcase("include/kernel_pkg.h", file_lines)
    
    
    file_lines = []
    
    file_lines.append("#include \"kernel_pkg.h\"\n\n")
    
    file_lines.append("ClusterInfo cluster_info[CLUSTER_NUMBER] = {")
    
    for cluster_obj in cluster_list:
        file_lines.append( "\n\t{"+str(cluster_obj.master_x)   +
                           ", "+ str(cluster_obj.master_y) +
                           ", "+ str(cluster_obj.leftbottom_x) +
                           ", "+ str(cluster_obj.leftbottom_y) +
                           ", "+ str(cluster_obj.topright_x) +
                           ", "+ str(cluster_obj.topright_y) +
                           ", "+ str(max_cluster_slave*max_local_tasks)+"},")
    file_lines.append("\n};\n\n")

    file_lines.append("IO_Info io_info[IO_NUMBER] = {")


    for port in open_ports:
        if port[4] == "N":
            aux_port = 5
        if port[4] == "S":
            aux_port = 2
        if port[4] == "E":
            aux_port = 4
        if port[4] == "W":
            aux_port = 3
        
        if len(port) > 5: 
            if port[7] == "N":
                aux_port2 = 5
            if port[7] == "S":
                aux_port2 = 2
            if port[7] == "E":
                aux_port2 = 4
            if port[7] == "W":
                aux_port2 = 3

            file_lines.append( "\n\t{"+str(port[1])   +
                           ", "+ str(port[2]) +
                           ", "+ str(port[3]) +
                           ", "+ str(aux_port) +
                           ", "+ str(port[5]) +
                           ", "+ str(port[6]) +
                           ", "+ str(aux_port2) +                           
                           ", "+ str(0)+"},")
           # file_lines.append("\n};\n\n")

        else:
             file_lines.append( "\n\t{"+str(port[1])   +
                           ", "+ str(port[2]) +
                           ", "+ str(port[3]) +
                           ", "+ str(aux_port) +
                           ", "+ str(port[2]) +
                           ", "+ str(port[3]) +
                           ", "+ str(aux_port) +                           
                           ", "+ str(0)+"},")
    file_lines.append("\n};\n\n")
    
    if gray_area_rows:
        file_lines.append("GrayArea ga = {\n")
        file_lines.append("\t{")
        for rows in gray_area_rows:
            file_lines.append(str(rows)+",")
        file_lines[-1] = file_lines[-1][:-1] #erasing last comma
        file_lines.append("}, {")
        for cols in gray_area_cols:
            file_lines.append(str(cols)+",")
        file_lines[-1] = file_lines[-1][:-1] #erasing last comma
        file_lines.append("}, " + str(aux_port))
        file_lines.append("};\n")

    if static_mapping_list:
        
        static_table_string = ""
        
        #static_mapping_list is a list of tuple={task_id, proc} and static_tuple is one instance (one tuple) of this list
        for static_tuple in static_mapping_list:
            
            task_id_str   = str ( static_tuple[0] )
            task_proc_str = str ( static_tuple[1] )
            
            static_table_string = static_table_string + "{"+task_id_str+", "+task_proc_str+"}, "
        
        #Removes the lost ',' at the end of string
        static_table_string = static_table_string[0:len(static_table_string)-2] # 2 because the space, other else will be 1
        
        file_lines.append("//Stores the task static mapping. It is a list of tuple = {task_id, mapped_proc}\n")
        file_lines.append("unsigned int static_map[MAX_STATIC_TASKS][2] = {"+static_table_string+"};\n\n")
            
            
    #Use this function to create any file into testcase, it automatically only updates the old file if necessary
    writes_file_into_testcase("include/kernel_pkg.c", file_lines)
        
#Generates the memory symbolic link
def generate_memory( yaml_r ):
    
    #Variables from yaml used into this function
    x_mpsoc_dim     =   get_mpsoc_x_dim(yaml_r)
    y_mpsoc_dim     =   get_mpsoc_y_dim(yaml_r)
    x_cluster_dim   =   get_cluster_x_dim(yaml_r)
    y_cluster_dim   =   get_cluster_y_dim(yaml_r)
    model_descr     =   get_model_description(yaml_r)
    master_location =   get_master_location(yaml_r)
    mem_size_KB     =   get_memory_size_KB(yaml_r)
    
    
    memory_path = "ram_pe"
    delete_if_exists(memory_path)
    os.mkdir(memory_path)
  
    if model_descr == "vhdl":
        
        ext_slave  = os.system("cd software; ram_generator " + str(mem_size_KB) + " -rtl kernel_slave.txt > ../ram_pe/ram_slave.vhd")
        ext_master = os.system("cd software; ram_generator " + str(mem_size_KB) + " -rtl kernel_master.txt > ../ram_pe/ram_master.vhd")
        
        if ext_master != 0 or ext_slave != 0:
            sys.exit("ERROR: Error in the ram_generation process")
        
    else:
        cluster_list = create_cluster_list(x_mpsoc_dim, y_mpsoc_dim, x_cluster_dim, y_cluster_dim, master_location)
        
        for x in range(0, x_mpsoc_dim):
            for y in range(0, y_mpsoc_dim):
                
                master_pe = False
                for cluster_obj in cluster_list:
                    if x == cluster_obj.master_x and y == cluster_obj.master_y:
                        master_pe = True
                        break
                
                dst_ram_file = memory_path+"/ram"+str(x)+"x"+str(y)+".txt"
                
                if master_pe == True:
                    os.symlink("../software/kernel_master.txt", dst_ram_file)
                else:
                    os.symlink("../software/kernel_slave.txt", dst_ram_file)
              
      
main()