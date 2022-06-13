#include <api.h>
#include "dtw.h"

Message msg;

int main(){

	int test[SIZE][SIZE];
	int pattern[SIZE][SIZE];
	int result, j;

	Echo(itoa(GetTick()));
	Receive(&msg, recognizer);

	Echo("Task P3 INIT");

	memcpy(test, msg.msg, sizeof(test));

	for(j=0; j<PATTERN_PER_TASK; j++){

		Echo("Task P3 FOR");

		memset(msg.msg,0, sizeof(int)*MSG_SIZE);

		Receive(&msg, bank);

		//Echo("Task P3 received pattern from bank\n");

		memcpy(pattern, msg.msg, sizeof(pattern));

		result = dynamicTimeWarping(test, pattern);

		msg.length = 2;

		msg.msg[0] = result;

		Send(&msg, recognizer);

		Echo(itoa(GetTick()));		
	}

	Echo("Task P3 FINISH");
//	Echo(itoa(GetTick()));

	exit();
}
