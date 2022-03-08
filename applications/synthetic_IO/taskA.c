#include <api.h>
#include <stdlib.h>
#include "syn_std.h"

Message msg, msgIO;

int main()
{
	
	int i, j,t;

    Echo("synthetic task A started.");
	Echo(itoa(GetTick()));

for(i=0;i<SYNTHETIC_ITERATIONS;i++){
	
	for(t=0;t<500;t++){
	}
	msgIO.length = 30;
	IOReceive(&msgIO, IO_PERIPHERAL);
	
	for(t=0;t<500;t++){
	}
	msg.length = 30;
	for(j=0;j<30;j++) msg.msg[j]=i;
	Send(&msg,taskC);
}

    Echo(itoa(GetTick()));
    Echo("synthetic task A finished.");
	exit();
}
