#include <api.h>
#include <stdlib.h>

int main()
{

Message msg;
int j;

	Echo("PAD");

	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	for(j=0;j<7;j++) Receive(&msg,VOPREC_0);
	Echo("Recebeu 8 de VOPREC_0");
	msg.length=66;
	Receive(&msg,VOPREC_0);
	Echo("Recebeu de VOPREC_0");
	msg.length=128;
	for(j=0;j<7;j++) Send(&msg,VOPME_0);
	Echo("Enviou 8 para VOPREC_0");
	msg.length=66;
	Send(&msg,VOPME_0);
	Echo("Enviou para VOPREC_0");
	msg.length=128;
	for(j=0;j<2;j++) Receive(&msg,VOPME_0);
	msg.length=33;
	Receive(&msg,VOPME_0);
	Echo("Recebeu 3 de VOPME_0");

	exit();

}
