#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo( "b,SRAM1," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm MCPU 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,MCPU_0);
	Echo( "r,MPEG_m14(1280)," );
	/*Comm RAST 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,RAST_0);
	Echo( "s,MPEG_m15(1280)," );

Echo( "e,SRAM1," );

exit();

}
