#include <api.h>
#include <stdlib.h>

int main()
{

Message msg;
int j;

	Echo("ISCAN");

	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	for(j=0;j<8;j++){ Receive(&msg,RUN_0); 	Echo("Recebeu de RUN_0");}
	msg.length=88;
	Receive(&msg,RUN_0);
	Echo("Recebeu de RUN_0");
	msg.length=128;
	for(j=0;j<8;j++){ Send(&msg,ACDC_0); Echo("Mandou pra ACDC_0");}
	msg.length=88;
	Send(&msg,ACDC_0);
	Echo("Mandou pra ACDC_0");
	//Echo("Chamou exit");

	exit();

}
