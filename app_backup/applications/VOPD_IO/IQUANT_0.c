#include <api.h>
#include <stdlib.h>

int main()
{

Message msg;
int j;

	Echo("IQUANT");

	for(j=0;j<128;j++) msg.msg[j]=j;

	msg.length=128;
	for(j=0;j<8;j++) Receive(&msg,ACDC_0);
	Echo("Recebeu 8 de ACDC_0");
	msg.length=88;
	Receive(&msg,ACDC_0);
	Echo("Recebeu de ACDC_0");
	msg.length=128;
	Receive(&msg,STRIPEM_0);
	Echo("Recebeu de STRIPEM_0");
	msg.length=128;
	for(j=0;j<8;j++) Send(&msg,IDCT2_0);
	Echo("Mandou 8 IDCT2_0");
	msg.length=72;
	Send(&msg,IDCT2_0);
	Echo("Mandou IDCT2_0");

	exit();

}
