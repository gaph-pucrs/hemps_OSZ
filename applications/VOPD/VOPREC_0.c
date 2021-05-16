#include <api.h>
#include <stdlib.h>

int main()
{

Message msg;
int j;

	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	for(j=0;j<7;j++) Receive(&msg,UPSAMP_0);
	Echo("Recebeu 7 UPSAMP_0");
	msg.length=26;
	Receive(&msg,UPSAMP_0);
	Echo("Recebeu UPSAMP_0");
	msg.length=128;
	for(j=0;j<7;j++) Send(&msg,PAD_0);
	Echo("Mandou 7 PAD_0");
	msg.length=66;
	Send(&msg,PAD_0);
	Echo("Mandou PAD_0");
	msg.length=128;
	for(j=0;j<11;j++) Receive(&msg,VOPME_0);
	Echo("Recebeu 11 VOPME_0");
	msg.length=92;
	Receive(&msg,VOPME_0);
	Echo("Recebeu VOPME_0");

	exit();

}
