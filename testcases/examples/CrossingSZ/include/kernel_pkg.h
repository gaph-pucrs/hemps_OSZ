#ifndef _KERNEL_PKG_
#define _KERNEL_PKG_

#define MAX_LOCAL_TASKS             1  //max task allowed to execute into a single slave processor 
#define PAGE_SIZE                   65536//bytes
#define MAX_TASKS_APP               2 //max number of tasks for the APPs described into testcase file

//Only used by kernel master
#define MAX_SLAVE_PROCESSORS        15    //total of slave processors for the whole mpsoc
#define MAX_CLUSTER_PEs             16      //total of processors for each cluster
#define MAX_CLUSTER_APP             15    //max of app running simultaneously into each cluster
#define XDIMENSION                  4     //mpsoc  x dimension
#define YDIMENSION                  4     //mpsoc  y dimension
#define XCLUSTER                    4     //cluster x dimension
#define YCLUSTER                    4     //cluster y dimension
#define CLUSTER_NUMBER              1     //total number of cluster
#define APP_NUMBER                  2     //max number of APPs described into testcase file
#define MAX_STATIC_TASKS            4      //max number of tasks mapped statically 

#define IO_NUMBER                   1
#define INJECTOR					90

//This struct stores the cluster information
typedef struct {
    int master_x;		//master x address
    int master_y;		//master y address
    int xi;				//initial x address of the cluster perimeter
    int yi;				//initial y address of the cluster perimeter
    int xf;				//final x address of the cluster perimeter
    int yf;				//final y address of the cluster perimeter
    int free_resources;	//number of free pages available into the cluster's slave processors
} ClusterInfo;

extern ClusterInfo cluster_info[CLUSTER_NUMBER];

//This struct stores the peripheral information
typedef struct {
    int peripheral_id;            //ID of the peripheral
    int default_address_x;        //IO x address
    int default_address_y;        //IO y address
    int default_port;             //PORT from noc to external peripheral
    int alternative_address_x;    //IO x address
    int alternative_address_y;    //IO y address
    int alternative_port;         //PORT from noc to external peripheral
    int active_connection;        // indicates the active address (0-default 1-alternative)
} IO_Info;

extern IO_Info io_info[IO_NUMBER];

//Stores the task static mapping. It is a list of tuple = {task_id, mapped_proc}
extern unsigned int static_map[MAX_STATIC_TASKS][2];

#endif
