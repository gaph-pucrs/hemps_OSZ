#include <api.h>
#include <stdlib.h>

int main()
{

int j;
Message msg;

Echo( "b,UPSAMP," );


	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm SRAM2 11310*/
	msg.length=128;
	for(j=0;j<88;j++) Receive(&msg,SRAM2_0);
	//Echo("FIM RECEIVEEEEEEEEEEEEEEEEEEEEE!!!!!!!!!!!!!\n");
	msg.length=46;
	Receive(&msg,SRAM2_0);
	//Echo("FIM RECEIVEEEEEEEEEEEEEEEEEEEEE!!!!!!!!!!!!!\n");
	Echo( "r,MPEG_m7(11310)," );
	/*Comm SDRAM 15000*/
	msg.length=128;
	for(j=0;j<117;j++)
	{
		//Echo("ANTES!!!!!!!!!!!!!\n");
		Receive(&msg,SDRAM_0);
 		//Echo("DEPOIS!!!!!!!!!!!!!\n");
	}
	msg.length=24;
	Receive(&msg,SDRAM_0);
	Echo( "r,MPEG_m9(15000)," );
	/*Comm SDRAM 15000*/
	msg.length=128;
	for(j=0;j<117;j++) Send(&msg,SDRAM_0);
	msg.length=24;
	Send(&msg,SDRAM_0);
	Echo( "s,MPEG_m10(15000)," );
	//Echo(   "i,",itoa(i)),",") );

Echo( "e,UPSAMP," );

exit();

}
