#include <api.h>
#include <stdlib.h>

#include "syn_std.h"

//Message structure of MEMPHIS, provided by api.h
Message msg;

void main()
{
    Echo("Task D started at time ");
	Echo(itoa(GetTick()));

	for(int i=0;i<SYNTHETIC_ITERATIONS;i++)
	{
		Receive(&msg, taskB);
		Receive(&msg, taskC);

		Echo(itoa(GetTick()));
	}

    Echo("Task D finished at time");
    Echo(itoa(GetTick()));
	exit();
}
