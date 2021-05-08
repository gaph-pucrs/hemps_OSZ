/*
 * prod.c
 *
 *  Created on: 07/03/2013
 *      Author: mruaro
 */

#include <api.h>
#include <stdlib.h>
#include "prod_cons_std.h"

Message msg;

int main()
{

	int i,j;
	volatile int t;

	Echo("Inicio da aplicacao prod");
	Echo(itoa(GetTick()));

	msg.length = 10;
	for(i=0;i<msg.length;i++) msg.msg[i]= 0XF0+i;

	//msg.msg[9] = 0xB0A;
	//for (j = 0; j < 1000; j++)
	//{
		for(i=0; i<PROD_CONS_ITERATIONS; i++){
			Echo(itoa(i));
			//Send(&msg, cons);
			//IOSend(&msg, 8);		// caimi test Working :-)
			//IOReceive(&msg, IO_PERIPHERAL);  	//
			//Echo(itoa(msg.msg[0]));
			//Echo(itoa(msg.msg[1]));
			//Echo(itoa(GetTick()));
		}
	//}
	
	SendDirect();

	Echo("Fim da aplicacao prod");
	Echo(itoa(GetTick()));
	exit();

}


