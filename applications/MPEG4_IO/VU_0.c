#include <api.h>
#include <stdlib.h>

int main()
{

Message msg;
int j;


Echo( "b,VU," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SDRAM 3210*/
	msg.length=128;
	for(j=0;j<25;j++) Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m20(3210)," );
	msg.length=10;
	Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m21(3210)," );

Echo("b,VU");
Echo(itoa(GetTick()));

exit();

}
