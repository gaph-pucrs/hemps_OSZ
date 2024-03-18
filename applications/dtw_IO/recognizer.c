#include <api.h>
#include <stdlib.h>
#include "dtw.h"

Message msg;
Message msgIO;

/*int test[SIZE][SIZE] = {
		{7200, 4600},
		{1900, 5800}
};*/

int test[SIZE][SIZE] = {
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
};

int main(){

	int i, j, k, d_count = 0;
	int distances[NUM_PATTERNS];

	Echo("Recognizer Start\n");

	msg.length = SIZE*SIZE; //SIZE*SIZE nao pode ser maior que 128, senao usar o SendData

	Echo(itoh(TOTAL_TASKS));
	memcpy(msg.msg, test, sizeof(test));

	for(i=0; i<TOTAL_TASKS; i++){
		Send(&msg,P[i]);
		//Echo(itoa(GetTick()));		
		//Echo(itoh(i));		
	}

	Echo("Test sent to all tasks\n");
	//Echo(itoa(PATTERN_PER_TASK));

	for(j=0; j<PATTERN_PER_TASK; j++){

		for(i=0; i<TOTAL_TASKS; i++){
			Receive(&msg, P[i]);

			/* IO_WRITE */
   			msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
   			msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
   			msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
   			msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
   			for(k=3; k<13; k++)
   			   msgIO.msg[k] = k-3; // Fill the 10 words of data
			IOSend(&msgIO, IO_PERIPHERAL2);
			distances[d_count] = msg.msg[0];
			//sprintf(d, "DTW entre amostra de teste e o padrão %d = %d  TICK = %d", d_count, distances[d_count], GetTick());
			//d_count++;
			//Echo(itoa(d_count));
			//Echo(itoa(P[i]));
		}

		Echo("Iteration");
	}

	j = distances[0];

	for(i=1; i<TOTAL_TASKS; i++){
		if(j<distances[i])
			j = distances[i];
	}

	Echo("FIM DO RECONHECIMENTO DE PADROES, MENOR DISTANCIA:\n");
	/*Echo(itoa(j));
	Echo("tempo: ");
	Echo(itoa(GetTick()));*/


	exit();
}
