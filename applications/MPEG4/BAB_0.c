#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo( "b,BAB," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SRAM2 2930*/
	msg.length=128;
	for(j=0;j<22;j++) Receive(&msg,SRAM2_0);
	msg.length=114;
	Receive(&msg,SRAM2_0);
	Echo( "r,MPEG_m3(2930)," );
	/*Comm SDRAM 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m6(1280)," );
	/*Comm SDRAM 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,SDRAM_0);
	Echo( "s,MPEG_m8(1280)," );

Echo( "e,BAB," );

exit();

}
