#include <api.h>
#include <stdlib.h>

#include "syn_std.h"

//MEMPHIS message structure
Message msg1;
Message msg2;

void main()
{
    Echo("Task A started at time ");
	Echo(itoa(GetTick()));

	for(int k=0; k<MSG_SIZE; k++){
		msg1.msg[k] = k;
		msg2.msg[k] = MSG_SIZE-k;
	}

	msg1.length = MSG_SIZE;
	msg2.length = MSG_SIZE;

	for(int i=0;i<SYNTHETIC_ITERATIONS;i++)
	{

		//compute(&msg1.msg);
		Send(&msg1,taskB);

		//compute(&msg2.msg);
		Send(&msg2,taskC);
	}

    Echo("Task A finished at time");
    Echo(itoa(GetTick()));
	exit();
}

