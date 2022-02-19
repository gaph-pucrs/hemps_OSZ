#include <api.h>
#include <stdlib.h>

Message msg;
Message msgIO;

int main()
{

int i, j;
	Echo("##### INICIO DA MWD");

	for(j=0;j<128;j++) msg.msg[j]=i;
	for(j=0;j<128;j++) msgIO.msg[j]=i;

	/*Comm Peripheral*/
	msgIO.length=128;
	for(j=0;j<10;j++) IOReceive(&msgIO, IO_PERIPHERAL);

	/*Comm HS 1280*/
	msg.length=128;
	for(j=0;j<10;j++) Send(&msg,HS);
	
	/*Comm Peripheral*/
	msgIO.length=128;
	for(j=0;j<5;j++) IOReceive(&msgIO, IO_PERIPHERAL);

	/*Comm NR 640*/
	msg.length=128;
	for(j=0;j<5;j++) Send(&msg,NR);

exit();

}
