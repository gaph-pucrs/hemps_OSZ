#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg,msgIO;

Echo("b,ADSP,");


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SDRAM 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,SDRAM_0);
	Echo("r,MPEG_m11(1280),");

	/*Comm Peripheral*/
	msgIO.length = 128;
	IOSend(&msgIO,IO_PERIPHERAL8);
	
	/*Comm Peripheral*/
	msgIO.length = 128;
	IOReceive(&msgIO,IO_PERIPHERAL8);

	/*Comm SDRAM 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,SDRAM_0);
	Echo( "s,MPEG_m13(1280),");

Echo("e,ADSP,");

exit();

}
