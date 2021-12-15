#include <api.h>
#include <stdlib.h>

int main()
{

Message msg;
int j;

	Echo("UPSAMP");

	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	for(j=0;j<8;j++) Receive(&msg,IDCT2_0);
	Echo("Recebeu 8 de IDCT2_0");
	msg.length=61;
	Receive(&msg,IDCT2_0);
	Echo("Recebeu de IDCT2_0");
	msg.length=128;
	for(j=0;j<7;j++) Send(&msg,VOPREC_0);
	Echo("Enviou 8 VOPREC_0");
	msg.length=26;
	Send(&msg,VOPREC_0);
	Echo("Enviou VOPREC_0");

	exit();

}
