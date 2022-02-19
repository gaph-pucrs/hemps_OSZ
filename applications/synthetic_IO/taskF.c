#include <api.h>
#include <stdlib.h>
#include "syn_std.h"

Message msg, msgIO;

int main()
{

	int i,t;

    Echo("synthetic task F started.");
	Echo(itoa(GetTick()));

for(i=0;i<SYNTHETIC_ITERATIONS;i++){
	
		Receive(&msg,taskE);

		msgIO.length = 30;
		IOSend(&msgIO, IO_PERIPHERAL);

		for(t=0;t<1000;t++){
		}
		
		Receive(&msg,taskD);

		msgIO.length = 30;
		IOSend(&msgIO, IO_PERIPHERAL2);

	}

	Echo(itoa(GetTick()));
    Echo("synthetic task F finished.");

	exit();

}
