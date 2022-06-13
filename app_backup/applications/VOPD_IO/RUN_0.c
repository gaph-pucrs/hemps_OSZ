#include <api.h>
#include <stdlib.h>

int main()
{

Message msg;
int j;

	Echo("RUN");


	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	Receive(&msg,VLD_0); Echo("Recebeu de VLD_0");
	msg.length=87;
	Receive(&msg,VLD_0); Echo("Recebeu de VLD_0");
	msg.length=128;
	for(j=0;j<8;j++) Send(&msg,ISCAN_0);
	Echo("Mandou 8 pra ISCAN_0");
	msg.length=88;
	Send(&msg,ISCAN_0);
	Echo("Mandou pra ISCAN_0");

	exit();

}
