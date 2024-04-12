#ifndef PROBE_PROTOCOL_MASTER_H_
#define PROBE_PROTOCOL_MASTER_H_

#include "probe_protocol.h"
#include "packet.h"

#define PLATFORM_DIMENSION_X 5
#define PLATFORM_DIMENSION_Y 5
#define NUM_LINKS_PER_ROUTER 4

#define MAX_PATH_SIZE 32

char probe_path[MAX_PATH_SIZE];
int probe_path_size;

int link_trust_scores[PLATFORM_DIMENSION_X][PLATFORM_DIMENSION_Y][NUM_LINKS_PER_ROUTER];

void print_trust_score_matrix();

void init_probe_master_structures();

void probe_protocol();

void send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size);

void handle_probe_results(unsigned int source, unsigned int target, unsigned int payload);

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result);

#endif
