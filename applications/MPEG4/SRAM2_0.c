#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo("b,SRAM2");
Echo(itoa(GetTick()));


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm RISC 8440*/
	msg.length=128;
	for(j=0;j<65;j++) Send(&msg,RISC_0);
	msg.length=120;
	Send(&msg,RISC_0);
	Echo( "s,MPEG_m(8440)," );
	/*Comm RISC 8440*/
	msg.length=128;
	for(j=0;j<65;j++) Receive(&msg,RISC_0);
	msg.length=120;
	Receive(&msg,RISC_0);
	Echo( "r,MPEG_m2(8440)," );
	/*Comm BAB 2930*/
	msg.length=128;
	for(j=0;j<22;j++) Send(&msg,BAB_0);
	msg.length=114;
	Send(&msg,BAB_0);
	Echo( "s,MPEG_m3(2930)," );
	/*Comm IDCT 4220*/
	msg.length=128;
	for(j=0;j<32;j++) Send(&msg,IDCT_0);
	msg.length=124;
	Send(&msg,IDCT_0);
	Echo( "s,MPEG_m4(4220)," );
	/*Comm IDCT 4220*/
	msg.length=128;
	for(j=0;j<32;j++) Receive(&msg,IDCT_0);
	msg.length=124;
	Receive(&msg,IDCT_0);
	Echo( "r,MPEG_m5(4220)," );
	/*Comm UPSAMP 11310*/
	msg.length=128;
	for(j=0;j<88;j++) Send(&msg,UPSAMP_0);
	msg.length=46;
	Send(&msg,UPSAMP_0);
	Echo( "s,MPEG_m7(11310)," );
	//Echo(   "i,",itoa(i)),",") );

Echo( "e,SRAM2," );

exit();

}
