#include <api.h>
#include <stdlib.h>

int main()
{

Message msg,msgIO;
int j;
	Echo("STRIPEM");

	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	Receive(&msg,ACDC_0);
	Echo("Recebeu ACDC_0");
	msg.length=22;
	Receive(&msg,ACDC_0);
	Echo("Recebeu ACDC_0");

	/*Comm Peripheral*/
	msgIO.length = 128;
	IOSend(&msgIO,IO_PERIPHERAL2);
	
	/*Comm Peripheral*/
	msgIO.length = 128;
	IOReceive(&msgIO,IO_PERIPHERAL2);

	msg.length=128;
	Send(&msg,IQUANT_0);
	Echo("Mandou ACDC_0");

	exit();

}
