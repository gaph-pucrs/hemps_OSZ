#include <api.h>
#include <stdlib.h>

int main()
{

int i, j;
Message msg,msgIO;

Echo( "b,RISC," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SRAM2 8440*/
	msg.length=128;
	for(j=0;j<65;j++) Receive(&msg,SRAM2_0);
	msg.length=120;
	Receive(&msg,SRAM2_0);
	Echo( "r,MPEG_m(8440)," );

	/*Comm Peripheral*/
	//msgIO.length = 128;
	/* IO_WRITE */
    msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
    msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
    msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
    for(i=3; i<13; i++)
       msgIO.msg[i] = i-3; // Fill the 10 words of data
	IOSend(&msgIO,IO_PERIPHERAL6);
	
	/*Comm Peripheral*/
	//msgIO.length = 128;
	/* IO_READ */
    msgIO.length = 3;      // Message size = 3 words (IO Header)
    msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
    msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
	IOReceive(&msgIO,IO_PERIPHERAL6);

	/*Comm SRAM2 8440*/
	msg.length=128;
	for(j=0;j<65;j++) Send(&msg,SRAM2_0);
	msg.length=120;
	Send(&msg,SRAM2_0);
	Echo( "s,MPEG_m2(8440)," );

Echo( "e,RISC," );

exit();

}
