#include <api.h>
#include <stdlib.h>

int main()
{

int i, j;
Message msg,msgIO;

Echo( "b,SRAM1," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm MCPU 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,MCPU_0);
	Echo( "r,MPEG_m14(1280)," );

	/*Comm Peripheral*/
	//msgIO.length = 128;
	/* IO_WRITE */
    msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
    msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
    msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
    for(i=3; i<13; i++)
       msgIO.msg[i] = i-3; // Fill the 10 words of data
	IOSend(&msgIO,IO_PERIPHERAL3);

	/*Comm RAST 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,RAST_0);
	Echo( "s,MPEG_m15(1280)," );

Echo( "e,SRAM1," );

exit();

}
