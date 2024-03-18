#include <api.h>
#include <stdlib.h>

int main()
{

Message msg,msgIO;
int i, j;


Echo( "b,VU," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SDRAM 3210*/
	msg.length=128;
	for(j=0;j<25;j++) Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m20(3210)," );
	msg.length=10;
	Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m21(3210)," );

	/*Comm Peripheral*/
	//msgIO.length = 128;
	/* IO_WRITE */
    msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
    msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
    msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
    for(i=3; i<13; i++)
       msgIO.msg[i] = i-3; // Fill the 10 words of data
	IOSend(&msgIO,IO_PERIPHERAL5);

Echo("b,VU");
Echo(itoa(GetTick()));

exit();

}
