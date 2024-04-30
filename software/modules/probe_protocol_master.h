#ifndef PROBE_PROTOCOL_MASTER_H_
#define PROBE_PROTOCOL_MASTER_H_

#include "probe_protocol.h"
#include "packet.h"

#define PLATFORM_DIMENSION_X 5
#define PLATFORM_DIMENSION_Y 5
#define NUM_LINKS_PER_ROUTER 4

#define MAX_PATH_SIZE 32

#define BINARY_SEARCH_INIT 0
#define BINARY_SEARCH_LEFT 1
#define BINARY_SEARCH_RIGHT 2

char probe_path[MAX_PATH_SIZE];
int probe_path_size;

int link_trust_scores[PLATFORM_DIMENSION_X][PLATFORM_DIMENSION_Y][NUM_LINKS_PER_ROUTER];

char broken_path[MAX_PATH_SIZE];
int broken_path_size;

int binary_search_state;
unsigned int search_source;
unsigned int search_target;
char *searched_path;
int searched_path_size;
int result_left, result_right;
unsigned int broken_router;
char broken_port;

int enable_binary_search;

void print_trust_score_matrix();

void init_probe_master_structures();

void probe_protocol();

void print_search_result();

void start_binary_search_xy(unsigned short source, unsigned short target);

void continue_binary_search(int result);

void send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size);

void handle_probe_results(unsigned int source, unsigned int target, unsigned int payload);

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result);

#endif
