#include <api.h>
#include <stdlib.h>

Message msg;
Message msgIO;

int main()
{

int i, j;

	for(j=0;j<128;j++) msg.msg[j]=i;
	for(j=0;j<128;j++) msgIO.msg[j]=i;

	/*Comm NR 960*/
	msg.length=128;
	for(j=0;j<7;j++) Receive(&msg,NR);
	msg.length=64;
	Receive(&msg,NR);

	/*Comm Peripheral3*/
	msgIO.length=128;
	for(j=0;j<7;j++) IOSend(&msgIO, IO_PERIPHERAL2);
	msgIO.length=64;
	IOSend(&msgIO, IO_PERIPHERAL2);

	/*Comm Peripheral3*/
	msgIO.length=128;
	for(j=0;j<7;j++) IOReceive(&msgIO, IO_PERIPHERAL2);
	msgIO.length=64;
	IOReceive(&msgIO, IO_PERIPHERAL2);
	
	/*Comm HVS 960*/
	msg.length=128;
	for(j=0;j<7;j++) Send(&msg,HVS);
	msg.length=64;
	Send(&msg,HVS);

exit();

}
