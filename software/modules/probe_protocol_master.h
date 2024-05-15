#ifndef PROBE_PROTOCOL_MASTER_H_
#define PROBE_PROTOCOL_MASTER_H_

#include "probe_protocol.h"
#include "packet.h"
#include "seek.h"
#include "../../include/kernel_pkg.h"

#define NUM_LINKS_PER_ROUTER 4

#define MAX_PATH_SIZE 32
#define MAX_PROBE_ENTRIES 50
#define SIZE_MISSING_PACKETS_QUEUE 10

#define BINARY_SEARCH_SIDE_BLANK 0
#define BINARY_SEARCH_SIDE_PENDING 1
#define BINARY_SEARCH_SIDE_SUCCESS 2
#define BINARY_SEARCH_SIDE_FAILED 3

#define PROBE_INDEX(probe_id) (probe_id % MAX_PROBE_ENTRIES)

enum probe_status {
    PROBE_STATUS_FREE,
    PROBE_STATUS_ALLOCATED,
    PROBE_STATUS_PENDING,
    PROBE_STATUS_SUCCEEDED,
    PROBE_STATUS_FAILED
};

struct probe {
    short id;
    unsigned short source;
    unsigned short target;
    char path[MAX_PATH_SIZE];
    char path_size;
    enum probe_status status;
};

short next_probe_id;
struct probe probes[MAX_PROBE_ENTRIES];

int link_trust_scores[XDIMENSION][YDIMENSION][NUM_LINKS_PER_ROUTER];

enum missing_packet_status {
    MISSING_PACKET_FREE,
    MISSING_PACKET_PENDING,
    MISSING_PACKET_HANDLED
};

struct missing_packet {
    short source;
    short target;
    enum missing_packet_status status;
};

struct missing_packet missing_packets_queue[SIZE_MISSING_PACKETS_QUEUE];
int next_missing_packet_pending, next_missing_packet_slot, missing_packets_pending;

// Binary search parameters
char broken_path[MAX_PATH_SIZE];
int broken_path_size;
unsigned int broken_path_source, broken_path_target;
int enable_binary_search;

// Binary search scope (specifies path to seach)
char *binary_search_path;
int binary_search_path_size;
unsigned int binary_search_source, binary_search_target;

// Binary search division (handles division of the path into left and right halves)
char *binary_search_left_path, *binary_search_right_path;
int binary_search_left_size, binary_search_right_size;
unsigned int binary_search_middle; //middle router address

// Binary search status
int binary_search_left_status, binary_search_right_status;
int binary_search_left_probe_id, binary_search_right_probe_id;

// Binary search result
unsigned int broken_router;
char broken_port;

void print_trust_score_matrix();

void init_probe_master_structures();

int get_new_probe_slot();

void probe_protocol(int last_result);

void report_missing_packet(unsigned int source, unsigned int target);

void check_missing_packets_queue();

void print_search_result();

void start_binary_search(unsigned int source, unsigned int target);

void receive_binary_search_path(unsigned int pkt_source, unsigned int pkt_payload, unsigned int pkt_service);

void send_binary_search_probes();

void receive_binary_search_probe(int probe_id, int result);

void finalize_binary_search();

int send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size);

void handle_probe_results(unsigned int packet_source_field, unsigned int payload);

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result);

#endif
