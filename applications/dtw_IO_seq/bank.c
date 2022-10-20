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

unsigned int previousFlit = 0;
int previousFlitValid = 0;

void assertSequence()
{
	unsigned int firstFlit = (msgIO.msg[0] >> 16) & 0xffff;
	unsigned int lastFlit = (msgIO.msg[9]) & 0xffff;

	unsigned int expectedFirstFlit = (previousFlit-1) & 0xffff;

	Echo("First:"); Echo(itoh(firstFlit));

	Echo("Last:"); Echo(itoh(lastFlit));

	Echo("Previous:"); Echo(itoh(previousFlit));

	Echo("Expected:"); Echo(itoh(expectedFirstFlit));

	if((previousFlitValid == 1) && (firstFlit != expectedFirstFlit))
	{
		Echo("[DTW] Nonsequential data received, halting.\n");
		while(1);
	}
	Echo("[DTW] Sequential data successfully received.\n");

	previousFlit = lastFlit;
	previousFlitValid = 1;
}

int main(){

	int i, j;
	int pattern[SIZE][SIZE];
	char a[50];

	Echo("Bank Start\n");
	
	msg.length = SIZE * SIZE; //SIZE*SIZE nao pode ser maior que 128, senao usar o SendData

	for(j=0; j<PATTERN_PER_TASK; j++){
		Echo("Iteration");
		for(i=0; i<TOTAL_TASKS; i++){
			IOReceive(&msgIO, IO_PERIPHERAL);

			assertSequence();

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
