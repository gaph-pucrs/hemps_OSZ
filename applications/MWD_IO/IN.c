#include <api.h>
#include <stdlib.h>

Message msg;
Message msgIO;

int main()
{

int i, j;
	Echo("##### INICIO DA MWD");

	for(j=0;j<128;j++) msg.msg[j]=i;
	//for(j=0;j<128;j++) msgIO.msg[j]=i;

	/*Comm Peripheral*/
	//msgIO.length=128;
	for(j=0;j<10;j++){
		/* IO_READ */
        msgIO.length = 3;      // Message size = 3 words (IO Header)
        msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
        msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
        msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
		IOReceive(&msgIO, IO_PERIPHERAL);
	}

	/*Comm HS 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,HS);
	
	/*Comm Peripheral*/
	//msgIO.length=128;
	for(j=0;j<5;j++){
		/* IO_READ */
       	msgIO.length = 3;      // Message size = 3 words (IO Header)
       	msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
       	msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
       	msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
		IOReceive(&msgIO, IO_PERIPHERAL);
	}

	/*Comm NR 640*/
	msg.length=128;
	for(j=0;j<5;j++) Send(&msg,NR);

exit();

}
