#include <api.h>
#include <stdlib.h>
#include <stdio.h>

#define NUM_NODES                  16		//16 for small input; 160 for large input; 30 for medium input;
#define MAXPROCESSORS			   64		//The amount of processor
#define NPROC 						5

int PROCESSORS;
int pthread_n_workers;
int paths;
int tasks[MAXPROCESSORS][2];
int nodes_tasks[NUM_NODES*(NUM_NODES-1)/2][2];
int AdjMatrix[NUM_NODES][NUM_NODES];
int result[33];
int ended;
Message msg;


int main(int argc, char *argv[])
{
	int m_argc,size,i;
	char *m_argv[3];
	ended = 0;

	Echo("########START dijkstra");


	//RealTime(103349, 103349, 87835, 0);

	pthread_n_workers = NPROC;

	PROCESSORS = pthread_n_workers;

	Message msgIO;
	
	//IO: get num nodes
	/* IO_READ */
    msgIO.length = 3;      // Message size = 3 words (IO Header)
    msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
    msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
	IOReceive(&msgIO, IO_PERIPHERAL);

	//IO: get graph
	int num_weights = NUM_NODES * NUM_NODES;
	for(int x = 0; x < num_weights; x += MSG_SIZE)
	{
		//msgIO.length = (num_weights - x > MSG_SIZE) ? MSG_SIZE : num_weights - x;

		/* IO_READ */
        msgIO.length = 3;      // Message size = 3 words (IO Header)
        msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
        msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
        msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
		IOReceive(&msgIO, IO_PERIPHERAL);
		Echo(".");
	}

	execute();

	exit();
}


void startThreads(void) {
	int i, j;

	/* SEND nodes_tasks[NUM_NODES*(NUM_NODES-1)/2][2] */
	msg.length = NUM_NODES*(NUM_NODES-1)/2;
	// Send X of nodes_tasks
	for (i=0; i<(NUM_NODES*(NUM_NODES-1)/2); i++)
	{
		msg.msg[i] = nodes_tasks[i][0];
	}
	Send(&msg, dijkstra_0);
	Send(&msg, dijkstra_1);
	Send(&msg, dijkstra_2);
	Send(&msg, dijkstra_3);
	Send(&msg, dijkstra_4);

	// Send Y of nodes_tasks
	for (i=0; i<(NUM_NODES*(NUM_NODES-1)/2); i++)
		msg.msg[i] = nodes_tasks[i][1];
	Send(&msg, dijkstra_0);
	Send(&msg, dijkstra_1);
	Send(&msg, dijkstra_2);
	Send(&msg, dijkstra_3);
	Send(&msg, dijkstra_4);

	/* SEND tasks[MAXPROCESSORS][2] */
	msg.length = MAXPROCESSORS;
	// Send X of tasks
	for (i=0; i<MAXPROCESSORS; i++)
		msg.msg[i] = tasks[i][0];
	Send(&msg, dijkstra_0);
	Send(&msg, dijkstra_1);
	Send(&msg, dijkstra_2);
	Send(&msg, dijkstra_3);
	Send(&msg, dijkstra_4);

	// Send Y of tasks
	for (i=0; i<MAXPROCESSORS; i++)
		msg.msg[i] = tasks[i][1];
	Send(&msg, dijkstra_0);
	Send(&msg, dijkstra_1);
	Send(&msg, dijkstra_2);
	Send(&msg, dijkstra_3);
	Send(&msg, dijkstra_4);

	/* SEND AdjMatrix[NUM_NODES][NUM_NODES] */
	msg.length = NUM_NODES;
	for (i=0; i<NUM_NODES; i++) {
		for (j=0; j<NUM_NODES; j++) {
			msg.msg[j] = AdjMatrix[j][i];
		}
		Send(&msg, dijkstra_0);
		Send(&msg, dijkstra_1);
		Send(&msg, dijkstra_2);
		Send(&msg, dijkstra_3);
		Send(&msg, dijkstra_4);
	}
}

void divide_task_group(int task) {
	int i;
	for(i=0;i<PROCESSORS;i++){
		tasks[i][0] = task/PROCESSORS* (i);
		tasks[i][1] = task/PROCESSORS* (i+1) + (i+1==PROCESSORS&task%PROCESSORS!=0?task%PROCESSORS:0);

	}
}

int execute() {

	int i,j,k;
	k = 0;

	int fpTrix[NUM_NODES*NUM_NODES] = { 1,    6,    3,    9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999,
										6,    1,    2,    5,    9999, 9999, 1,    9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999,
										3,    2,    1,    3,    4,    9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999,
										9999, 5,    3,    1,    2,    3,    9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999,
										9999, 9999, 4,    2,    1,    5,    9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999,
										9999, 9999, 9999, 3,    5,    1,    3,    2,    9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999,
										9999, 1,    9999, 9999, 9999, 3,    1,    4,    9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999,
										9999, 9999, 9999, 9999, 9999, 2,    4,    1,    7,    9999, 9999, 9999, 9999, 9999, 9999, 9999,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 7,    1,    5,    1,    9999, 9999, 9999, 9999, 9999,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 5,    1,    9999, 3,    9999, 9999, 9999, 9999,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 1,    9999, 1,    9999, 4,    9999, 9999, 8,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 3,    9999, 1,    9999, 2,    9999, 9999,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 4,    9999, 1,    1,    9999, 2,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 2,    1,    1,    6,    9999,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 6,    1,    3,
										9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 9999, 8,    9999, 2,    9999, 3,    1 };

	/* Step 1: geting the working vertexs and assigning values */
	for (i=0;i<NUM_NODES;i++) {
		for (j=0;j<NUM_NODES;j++) {
			AdjMatrix[i][j]= fpTrix[k];
			k++;
		}
	}

	int tasks = NUM_NODES*(NUM_NODES-1)/2;

	int x=0;
	for(i=0;i<NUM_NODES-1;i++){ //small:15; large:159
		for(j=i+1;j<NUM_NODES;j++){	//small:16; large:160
			nodes_tasks[x][0] = i;
			nodes_tasks[x][1] = j;
			x++;
		}
	}

	divide_task_group(tasks);
	startThreads();

	return 0;
}
