#include <api.h>
#include <stdlib.h>

int main()
{

int j;
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
	msgIO.length = 128;
	IOSend(&msgIO,IO_PERIPHERAL6);
	
	/*Comm Peripheral*/
	msgIO.length = 128;
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
