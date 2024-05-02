#ifndef PROBE_PROTOCOL_MASTER_H_
#define PROBE_PROTOCOL_MASTER_H_

#include "probe_protocol.h"
#include "packet.h"

#define PLATFORM_DIMENSION_X 5
#define PLATFORM_DIMENSION_Y 5
#define NUM_LINKS_PER_ROUTER 4

#define MAX_PATH_SIZE 32
#define MAX_PROBE_ENTRIES 50

#define BINARY_SEARCH_INIT 0
#define BINARY_SEARCH_LEFT 1
#define BINARY_SEARCH_RIGHT 2

#define PROBE_STATUS_FREE 0
#define PROBE_STATUS_ALLOCATED 1
#define PROBE_STATUS_PENDING 2
#define PROBE_STATUS_SUCCEEDED 3
#define PROBE_STATUS_FAILED 4

#define PROBE_INDEX(probe_id) (probe_id % MAX_PROBE_ENTRIES)

struct probe {
    short id;
    unsigned short source;
    unsigned short target;
    char path[MAX_PATH_SIZE];
    char path_size;
    char status;
};

short next_probe_id;
struct probe probes[MAX_PROBE_ENTRIES];

int link_trust_scores[PLATFORM_DIMENSION_X][PLATFORM_DIMENSION_Y][NUM_LINKS_PER_ROUTER];

// Start binary search
char broken_path[MAX_PATH_SIZE];
int broken_path_size;
int enable_binary_search;

// Binary search internal signals
int binary_search_state;
unsigned int search_source;
unsigned int search_target;
char *searched_path;
int searched_path_size;
int result_left, result_right;

// Binary search result
unsigned int broken_router;
char broken_port;

void print_trust_score_matrix();

void init_probe_master_structures();

int get_new_probe_slot();

void probe_protocol(int last_result);

void print_search_result();

void start_binary_search_xy(unsigned int source, unsigned int target);

void continue_binary_search(int result);

void send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size);

void handle_probe_results(unsigned int packet_source_field, unsigned int payload);

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result);

#endif
