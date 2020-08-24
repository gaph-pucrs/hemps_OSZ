//#include <stdio.h>
//#include <stdlib.h>

#define MAX_PAIRS 20
#include "../../include/kernel_pkg.h"

 
// int mpsoc_X = 4;
// int mpsoc_Y = 4;
// int cluster_X = 2;
// int cluster_Y = 2;   
 
typedef struct 
{
    int Address;     
    int tasks_number; 
    int task_id0;
    int task_id1;
    //unsigned int Address_new_master, Y_Address_new_master;    

} struct_slave_candidate_other_cluster;

typedef struct 
{
    int Address;     
  //  int tasks_number; 
    //unsigned int Address_new_master, Y_Address_new_master;    

} struct_slave_candidate_my_cluster;


typedef struct 
{
    int Address;
    int tasks_number;
    
} struct_ward_master; // mestre que ele manda os ward

typedef struct 
{
    int pe_number;
    int X_Address, Y_Address;
    int alone;

    int pe_warded_1;
    int X_warded_1, Y_warded_1;  

    int pe_warded_2;
    int X_warded_2, Y_warded_2;     

} struct_pairs;

struct_pairs ward_pairs[MAX_PAIRS]; 
struct_slave_candidate_other_cluster slave_candidate_other_cluster; 
struct_slave_candidate_my_cluster slave_candidate_my_cluster; 
struct_ward_master ward_master;
struct_ward_master master_other_cluster;

void initialize_struct_pairs();
void define_pairs(int PE, struct_pairs *); 
int get_master_other_cluster();
void set_master_other_cluster(int net_address_to_send);

int  get_slave_candidate_my_cluster();
void set_slave_candidate_my_cluster(int net_address_to_send);

int get_task_candidate_other_cluster();
int get_task0_candidate_other_cluster();
int get_task1_candidate_other_cluster();

int  get_slave_candidate_other_cluster();
void set_slave_candidate_other_cluster(int net_address_to_send, int task);
