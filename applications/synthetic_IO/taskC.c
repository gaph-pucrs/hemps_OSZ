#include <api.h>
#include <stdlib.h>
#include "syn_std.h"

Message msg, msgIO;

int main()
{
	
	int i, j,t;

	Echo("synthetic task C started.");
	Echo(itoa(GetTick()));

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

	msgIO.length = 30;
	IOSend(&msgIO, IO_PERIPHERAL2);

}
    Echo(itoa(GetTick()));
    Echo("synthetic task C finished.");

	exit();
}
