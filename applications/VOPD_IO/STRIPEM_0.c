#include <api.h>
#include <stdlib.h>

int main()
{

Message msg,msgIO;
int j;
	Echo("STRIPEM");

	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	Receive(&msg,ACDC_0);
	Echo("Recebeu ACDC_0");
	msg.length=22;
	Receive(&msg,ACDC_0);
	Echo("Recebeu ACDC_0");

	/*Comm Peripheral*/
	//msgIO.length = 128;
	/* IO_WRITE */
   	msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
   	msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
   	msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
   	msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
   	for(j=3; j<13; j++)
   	   msgIO.msg[j] = j-3; // Fill the 10 words of data
	IOSend(&msgIO,IO_PERIPHERAL2);
	
	/*Comm Peripheral*/
	//msgIO.length = 128;
	/* IO_READ */
    msgIO.length = 3;      // Message size = 3 words (IO Header)
    msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
    msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
	IOReceive(&msgIO,IO_PERIPHERAL2);

	msg.length=128;
	Send(&msg,IQUANT_0);
	Echo("Mandou ACDC_0");

	exit();

}
