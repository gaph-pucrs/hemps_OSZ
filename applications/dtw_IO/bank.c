#include <api.h>
#include <stdlib.h>
#include "dtw.h"


/*int pattern[SIZE][SIZE] = {
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0},
	{0,1,2,3,4,5,6,7,8,9,0}
};*/

void randPattern(int in[SIZE][SIZE]){
	int i,j;

	for(i=0; i<SIZE; i++){
		for(j=0; j<SIZE; j++){
			in[i][j] = abs(rand(23, 1, 100));
		}
	}
}


Message msg;
Message msgIO;

int main(){

	int i, j;
	int pattern[SIZE][SIZE];
	char a[50];

	Echo("Bank Start\n");
	
	msg.length = SIZE * SIZE; //SIZE*SIZE nao pode ser maior que 128, senao usar o SendData

	for(j=0; j<PATTERN_PER_TASK; j++){
		Echo("Iteration");
		for(i=0; i<TOTAL_TASKS; i++){
			
			/* IO_READ */
       		msgIO.length = 3;      // Message size = 3 words (IO Header)
       		msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
       		msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
       		msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
			IOReceive(&msgIO, IO_PERIPHERAL);
			
			randPattern(pattern); //gera uma matriz de valores aleatorios, poderiam ser coeficientes MFCC
			memcpy(msg.msg, pattern, sizeof(pattern));
			msg.length = SIZE * SIZE;
			Send(&msg, P[i]);
			//sprintf(a, "Bank sendedd pattern to task %d", (i+1));
			//Echo(a);
			//Echo(itoa(GetTick()));
		}
		//Echo(itoa(GetTick()));
	}

	Echo("Bank sendedd all patterns\n");

	exit();
}
