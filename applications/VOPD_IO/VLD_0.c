#include <api.h>
#include <stdlib.h>

int main()
{

Message msg,msgIO;
int j;

	Echo("##### INICIO 2 DA VOPD");

	for(j=0;j<128;j++) msg.msg[j]=j;

	/*Comm Peripheral*/
	msgIO.length = 128;
	IOReceive(&msgIO,IO_PERIPHERAL);

	msg.length=128;
	Send(&msg,RUN_0);
	Echo("Enviou p RUN_0");
	msg.length=87;
	Send(&msg,RUN_0);
	Echo("Enviou p RUN_0");

	exit();

}
