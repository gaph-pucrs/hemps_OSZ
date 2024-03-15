#include <api.h>
#include <stdlib.h>

Message msg;
Message msgIO;

int main()
{

int i, j;

	/* IO_WRITE */
   	msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
   	msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
   	msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
   	msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
   	for(i=3; i<13; i++)
   	   msgIO.msg[i] = i-3; // Fill the 10 words of data

	for(j=0;j<128;j++) msg.msg[j]=i;
	//for(j=0;j<128;j++) msgIO.msg[j]=i;

	/*Comm JUG1 960*/
	msg.length=128;
	for(j=0;j<7;j++) Receive(&msg,JUG1);
	msg.length=64;
	Receive(&msg,JUG1);

	/*Comm Peripheral4*/
	//msgIO.length=128;
	for(j=0;j<7;j++){
		IOSend(&msgIO, IO_PERIPHERAL2);
	}

	//msgIO.length=64;
	IOSend(&msgIO, IO_PERIPHERAL2);

	/*Comm JUG2 960*/
	msg.length=128;
	for(j=0;j<7;j++) Receive(&msg,JUG2);
	msg.length=64;
	Receive(&msg,JUG2);

	/*Comm Peripheral4*/
	//msgIO.length=128;
	for(j=0;j<7;j++){
		IOSend(&msgIO, IO_PERIPHERAL2);
	}

	//msgIO.length=64;
	IOSend(&msgIO, IO_PERIPHERAL2);

	/*Comm Peripheral4*/
	//msgIO.length=128;
	for(j=0;j<5;j++){
		/* IO_READ */
       	msgIO.length = 3;      // Message size = 3 words (IO Header)
       	msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
       	msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
       	msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
		IOReceive(&msgIO, IO_PERIPHERAL2);
	}
	
	/*Comm SE 640*/
	msg.length=128;
	for(j=0;j<5;j++) Send(&msg,SE);

exit();

}
