#include "kernel_pkg.h"

ClusterInfo cluster_info[CLUSTER_NUMBER] = {
	{0, 0, 0, 0, 3, 3, 15},
};

IO_Info io_info[IO_NUMBER] = {
	{90, 0, 0, 3, 1, 0, 2, 0},
};

//Stores the task static mapping. It is a list of tuple = {task_id, mapped_proc}
unsigned int static_map[MAX_STATIC_TASKS][2] = {{1, 257}, {0, 514}, {257, 1}, {256, 769}};

