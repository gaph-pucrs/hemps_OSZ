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
Message msgIO;

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

	for(i=0; i<PROD_CONS_ITERATIONS; i++){
		Echo(itoa(i));

		/* IO_READ */
        msgIO.length = 3;      // Message size = 3 words (IO Header)
        msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
        msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
        msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
		IOReceive(&msgIO, IO_PERIPHERAL);
		
		Send(&msg, cons);

		Echo(itoa(msg.msg[0]));
		Echo(itoa(msg.msg[msg.length]));
		Echo(itoa(GetTick()));
	}


	Echo("Fim da aplicacao prod");
	Echo(itoa(GetTick()));
	
	exit();

}


