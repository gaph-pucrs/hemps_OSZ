#include <api.h>
#include <stdlib.h>
#include "syn_std.h"

Message msg, msgIO;

int main()
{
	
	int i, j,t;

	Echo("synthetic task C started.");
	Echo(itoa(GetTick()));

	/* IO_WRITE */
   	msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
   	msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
   	msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
   	msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
   	for(i=3; i<13; i++)
   	   msgIO.msg[i] = i-3; // Fill the 10 words of data

for(i=0;i<SYNTHETIC_ITERATIONS;i++){
	
	msg.length = 30;
	for(j=0;j<30;j++) msg.msg[j]=i;

	Receive(&msg,taskA);
	
	for(t=0;t<1000;t++){
	}
	
	Send(&msg,taskD);
	
	Receive(&msg,taskB);
	
	for(t=0;t<1000;t++){
	}
	
	Send(&msg,taskE);

	//msgIO.length = 30;
	IOSend(&msgIO, IO_PERIPHERAL2);

}
    Echo(itoa(GetTick()));
    Echo("synthetic task C finished.");

	exit();
}
