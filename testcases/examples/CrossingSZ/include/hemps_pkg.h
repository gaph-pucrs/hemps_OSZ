#ifndef _HEMPS_PKG_
#define _HEMPS_PKG_

#define PAGE_SIZE_BYTES			65536
#define MEMORY_SIZE_BYTES		131072
#define TOTAL_REPO_SIZE_BYTES	1048576
#define APP_NUMBER				2
#define N_PE_X					4
#define N_PE_Y					4
#define N_PE					16
#define IO_NUMBER				2
#define MAX_TASKS_APP			2 //max number of tasks for the APPs described into testcase file
#define INJECTOR				90

//PE_TYPE 
//0-slave 
//1-master 
const int pe_type[N_PE] = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

//OPEN_IO 
//0-EAST 
//1-WEST 
//2-NORTH 
//3-SOUTH 
//5-GND 
const int open_io[N_PE] = {1, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};

#endif
