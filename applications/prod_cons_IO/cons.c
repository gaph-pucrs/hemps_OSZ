/*
 * cons.c
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
	volatile int p;

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

	Echo("Inicio da aplicacao cons");
	Echo(itoa(GetTick()));

	msg.length = 10;

	/* IO_WRITE */
    msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
    msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
    msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
    for(i=3; i<13; i++)
      msgIO.msg[i] = i-3; // Fill the 10 words of data

	for(i=0; i<PROD_CONS_ITERATIONS; i++){
		Echo(itoa(i));
		Receive(&msg, prod);
		IOSend(&msgIO, IO_PERIPHERAL);
		
		Echo(itoa(msg.msg[0]));
		Echo(itoa(msg.msg[msg.length]));
		Echo(itoa(GetTick()));
	}


	Echo("Fim da aplicacao cons");
	Echo(itoa(GetTick()));

	exit();

}


