#ifndef PROBE_PROTOCOL_MASTER_H_
#define PROBE_PROTOCOL_MASTER_H_

#include "packet.h"

#define probe_m_puts(argument) puts(argument)
// #define probe_m_puts(argument) 

#define PROBE_RESULT_SUCCESS 10
#define PROBE_RESULT_FAILURE 20

#define PLATFORM_DIMENSION_X 5
#define PLATFORM_DIMENSION_Y 5
#define NUM_LINKS_PER_ROUTER 4

#define MAX_PATH_SIZE 32

char probe_path[MAX_PATH_SIZE];
int probe_path_size;

int link_trust_scores[PLATFORM_DIMENSION_X][PLATFORM_DIMENSION_Y][NUM_LINKS_PER_ROUTER];

void init_probe_master_structures();

void probe_protocol();

void handle_probe_results(unsigned int source, unsigned int target, unsigned int payload);

#endif
