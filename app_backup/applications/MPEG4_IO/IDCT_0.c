#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo( "b,IDCT," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SRAM2 4220*/
	msg.length=128;
	for(j=0;j<32;j++) Receive(&msg,SRAM2_0);
	msg.length=124;
	Receive(&msg,SRAM2_0);
	Echo( "r,MPEG_m4(4220)," );
	/*Comm SRAM2 4220*/
	msg.length=128;
	for(j=0;j<32;j++) Send(&msg,SRAM2_0);
	msg.length=124;
	Send(&msg,SRAM2_0);
	Echo( "s,MPEG_m5(4220)," );

Echo( "e,IDCT," );

exit();

}
