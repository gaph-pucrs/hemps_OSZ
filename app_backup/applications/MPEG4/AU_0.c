#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo( "b,AU," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SDRAM 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m18(1280)," );

Echo( "e,AU," );

exit();

}
