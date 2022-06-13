#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo("b,SDRAM0");
Echo(itoa(GetTick()));


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm BAB 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,BAB_0);
	Echo( "s,MPEG_m6(1280)," );
	/*Comm BAB 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,BAB_0);
	Echo( "r,MPEG_m8(1280)," );
	/*Comm UPSAMP 15000*/
	msg.length=128;
	for(j=0;j<117;j++)
	{
		//Echo("SEND upsamp antes\n");
		Send(&msg,UPSAMP_0);
		//Echo("SEND upsamp depois\n");
	}
	msg.length=24;
	Send(&msg,UPSAMP_0);
	Echo( "s,MPEG_m9(15000)," );
	/*Comm UPSAMP 15000*/
	msg.length=128;
	for(j=0;j<117;j++)
	{
		//Echo("receive upsamp antes\n");
		Receive(&msg,UPSAMP_0);
		//Echo("receive upsamp depois\n");
	}
	msg.length=24;
	Receive(&msg,UPSAMP_0);
	Echo( "r,MPEG_m10(15000)," );
	/*Comm ADSP 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,ADSP_0);
	Echo( "s,MPEG_m11(1280)," );
	/*Comm MCPU 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,MCPU_0);
	Echo( "s,MPEG_m12(1280)," );
	/*Comm ADSP 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Receive(&msg,ADSP_0);
	Echo( "r,MPEG_m13(1280)," );
	/*Comm RAST 10130*/
	msg.length=128;
	for(j=0;j<79;j++) Send(&msg,RAST_0);
	msg.length=18;
	Send(&msg,RAST_0);
	Echo( "s,MPEG_m16(10130)," );
	/*Comm RAST 10130*/
	msg.length=128;
	for(j=0;j<79;j++) Receive(&msg,RAST_0);
	msg.length=18;
	Receive(&msg,RAST_0);
	Echo( "r,MPEG_m17(10130)," );
	/*Comm AU 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,AU_0);
	Echo( "s,MPEG_m18(1280)," );
	/*Comm VU 3210*/
	msg.length=128;
	for(j=0;j<25;j++) Send(&msg,VU_0);
	Echo( "s,MPEG_m20(testanmo)," );
	msg.length=10;
	Send(&msg,VU_0);
	Echo( "s,MPEG_m21(10)," );

Echo( "e,SDRAM," );

exit();

}
