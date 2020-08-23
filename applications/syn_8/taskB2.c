#include <api.h>
#include <stdlib.h>

#include "syn_std.h"

//MEMPHIS message structure
Message msg;

void main()
{
    Echo("Task B started at time ");
	Echo(itoa(GetTick()));

	for(int i=0;i<SYNTHETIC_ITERATIONS;i++)
	{
		Receive(&msg, taskB);

		compute(&msg.msg);

		Send(&msg,taskB4);
	}

    Echo("Task B finished at time");
    Echo(itoa(GetTick()));
	exit();
}
