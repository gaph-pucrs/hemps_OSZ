#include <api.h>
#include <stdlib.h>

int main()
{

Message msg,msgIO;
int j;

	Echo("##### INICIO 2 DA VOPD");

	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm Peripheral*/
	//msgIO.length = 128;
	/* IO_READ */
    msgIO.length = 3;      // Message size = 3 words (IO Header)
    msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
    msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
	IOReceive(&msgIO,IO_PERIPHERAL);

	msg.length=128;
	Send(&msg,RUN_0);
	Echo("Enviou p RUN_0");
	msg.length=87;
	Send(&msg,RUN_0);
	Echo("Enviou p RUN_0");

	exit();

}
