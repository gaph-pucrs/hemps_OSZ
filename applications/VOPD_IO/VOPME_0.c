#include <api.h>
#include <stdlib.h>

int main()
{

Message msg,msgIO;
int j;

	Echo("VOPME");


	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	for(j=0;j<7;j++) Receive(&msg,PAD_0);
	Echo("Recebeu 8 PAD_0");
	msg.length=66;
	Receive(&msg,PAD_0);
	Echo("Recebeu PAD_0");

	/*Comm Peripheral*/
	msgIO.length = 128;
	IOSend(&msgIO,IO_PERIPHERAL);
	
	/*Comm Peripheral*/
	msgIO.length = 128;
	IOReceive(&msgIO,IO_PERIPHERAL);

	msg.length=128;
	for(j=0;j<2;j++) Send(&msg,PAD_0);
	Echo("Enviou 3 PAD_0");
	msg.length=33;
	Send(&msg,PAD_0);
	Echo("Enviou PAD_0");
	msg.length=128;
	for(j=0;j<11;j++) Send(&msg,VOPREC_0);
	Echo("Enviou 12 VOPREC_0");
	msg.length=92;
	Send(&msg,VOPREC_0);
	Echo("Enviou 1 VOPREC_0");

	exit();

}
