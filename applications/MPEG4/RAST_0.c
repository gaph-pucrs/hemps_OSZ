#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo( "b,RAST," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SRAM1 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,SRAM1_0);
	Echo( "r,MPEG_m15(1280)," );
	/*Comm SDRAM 10130*/
	msg.length=128;
	for(j=0;j<79;j++) Receive(&msg,SDRAM_0);
	msg.length=18;
	Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m16(10130)," );
	/*Comm SDRAM 10130*/
	msg.length=128;
	for(j=0;j<79;j++) Send(&msg,SDRAM_0);
	msg.length=18;
	Send(&msg,SDRAM_0);
	Echo( "s,MPEG_m17(10130)," );

Echo( "e,RAST," );

exit();

}
