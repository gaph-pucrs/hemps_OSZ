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
	//msgIO.length = 30;
	/* IO_READ */
    msgIO.length = 3;      // Message size = 3 words (IO Header)
    msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
    msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
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
