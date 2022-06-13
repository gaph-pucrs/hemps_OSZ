#include <api.h>
#include <stdlib.h>

Message msg;
Message msgIO;

int main()
{

int i, j;

	for(j=0;j<128;j++) msg.msg[j]=i;
	for(j=0;j<128;j++) msgIO.msg[j]=i;

	/*Comm NR 640*/
	msg.length=128;
	for(j=0;j<5;j++) Receive(&msg,NR);

	/*Comm Peripheral2*/
	msgIO.length=128;
	for(j=0;j<5;j++) IOSend(&msgIO, IO_PERIPHERAL2);

	/*Comm Peripheral2*/
	msgIO.length=128;
	for(j=0;j<5;j++) IOReceive(&msgIO, IO_PERIPHERAL2);

	/*Comm NR 640*/
	msg.length=128;
	for(j=0;j<5;j++) Send(&msg,NR);

exit();

}
