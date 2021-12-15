/*
 * prod.c
 *
 *  Created on: 07/03/2013
 *      Author: mruaro
 */

#include <api.h>
#include <stdlib.h>
#include "prod_cons_std.h"

Message msg, msgIO;

int main()
{

	int i;
	volatile int t;

	/* 2K */
	//Echo("my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");

	/* 3K */
	// Echo("ay app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("by app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("cy app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");

	// /* 4K */
	// Echo("xy app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("yy app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("zy app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");

	// /* 5K */
	// Echo("xa app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("yb app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("zc app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");

	// /* 6K */
	// Echo("aa app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("ab app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("ac app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");


	//  7K 
	// Echo("ba app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("bb app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("bc app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");


	// /* 8K */
	// Echo("ca app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("cb app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("cc app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");


	// /* 9K */
	// Echo("da app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("db app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("dc app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");


	// /* 10K */
	// Echo("ea app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("eb app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");
	// Echo("ec app 890my y app 890my app 890my app 890my apmy app 890my app 890my app 890my app 890my app 890my app 890abcdefgij");

	Echo("Inicio da aplicacao prod");
	Echo(itoa(GetTick()));

	msg.length = 10;
	msgIO.length = 10;
	for(i=0;i<msg.length;i++) msg.msg[i]= 0XF0+i;

	//msg.msg[9] = 0xB0A;

	for(i=0; i<PROD_CONS_ITERATIONS; i++){
		Echo(itoa(i));
		IOReceive(&msgIO, IO_PERIPHERAL2);		// caimi test Working :-)
		Echo("Sent IO");  
		Send(&msg, cons);
		Echo("Sent Cons");
	  	

		//Echo(itoa(msg.msg[0]));
		//Echo(itoa(msg.msg[1]));
		//Echo(itoa(GetTick()));
	}


	Echo("Fim da aplicacao prod");
	Echo(itoa(GetTick()));
	exit();

}


