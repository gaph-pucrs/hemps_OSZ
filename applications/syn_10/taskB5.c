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
		Receive(&msg, taskB3);

		compute(&msg.msg);

		Send(&msg,taskB6);
	}

    Echo("Task B finished at time");
    Echo(itoa(GetTick()));
	exit();
}
