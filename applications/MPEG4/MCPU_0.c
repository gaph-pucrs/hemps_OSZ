#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo( "b,MCPU," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SDRAM 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m12(1280)," );
	/*Comm SRAM1 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,SRAM1_0);
	Echo( "s,MPEG_m14(1280)," );

Echo( "e,MCPU," );

exit();

}
