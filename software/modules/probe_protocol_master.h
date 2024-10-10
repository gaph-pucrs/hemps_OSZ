#ifndef PROBE_PROTOCOL_MASTER_H_
#define PROBE_PROTOCOL_MASTER_H_

#include "probe_protocol.h"
#include "packet.h"
#include "seek.h"
#include "../../include/kernel_pkg.h"

#define NUM_LINKS_PER_ROUTER 4
#define MAX_PROBE_ENTRIES 50
#define MAX_BINARY_SEARCH_PROBES MAX_PROBE_PATH_SIZE+1 //maximum possible number of parallel path segments + 1 slot used during configuration
#define MAX_BINARY_SEARCH_HTS MAX_PROBE_PATH_SIZE //maximum possible number of hts in a searched path
#define SIZE_MISSING_PACKETS_QUEUE 10
#define SUSPICIOUS_PATH_TABLE_SIZE 40
#define BSA_QUEUE_SIZE 5

#define PROBE_INDEX(probe_id) (probe_id % MAX_PROBE_ENTRIES)

/**** PROBE TABLE ****/

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
    char path[MAX_PROBE_PATH_SIZE];
    char path_size;
    enum probe_status status;
};

short next_probe_id;
struct probe probes[MAX_PROBE_ENTRIES];

/**** SUSPICIOUS PATH TABLE ****/

struct suspicious_path {
    unsigned short used; // set to 1 or 0
    unsigned short source;
    unsigned short target;
    char path[MAX_PROBE_PATH_SIZE];
    int path_size;
    unsigned short path_addrs[MAX_PROBE_PATH_SIZE]; //address of each pe contained in the suspicious path path, used for optimization
};

struct suspicious_path suspicious_path_table[SUSPICIOUS_PATH_TABLE_SIZE];

/**** BINARY SEARCH DATA ****/

struct binary_search_probe {
    short id;
    enum {BSA_PROBE_USED, BSA_PROBE_UNUSED} status;
};

struct binary_search_ht {
    unsigned short router;
    char port;
};

struct binary_search {
    enum {BSA_BUSY, BSA_IDLE} status;
    
    struct suspicious_path path;
    struct suspicious_path path_queue[BSA_QUEUE_SIZE];

    struct binary_search_probe bsa_probes[MAX_BINARY_SEARCH_PROBES];

    struct binary_search_ht hts[MAX_BINARY_SEARCH_HTS];
    int ht_counter;
};

struct binary_search bsa_data;

/**** NOC HEALTH MATRIX  ****/

enum link_status {HEALTHY, SUSPICIOUS, INFECTED};

struct link_health {
    enum link_status status;
    short total_probes;
    short failed_probes;
    short intersections; //number of suspicious paths intersecting the link
};

struct router_health {
    struct link_health links[NUM_LINKS_PER_ROUTER];
};

struct router_health noc_health[XDIMENSION][YDIMENSION];

/**** FUNCTION SIGNATURES ****/

void init_probe_master_structures();

int get_new_probe_slot();

int get_new_binary_search_probe_slot();

int get_binary_search_probe_by_id(int id);

int is_binary_search_probes_empty();

int get_new_suspicious_path_slot();

void handle_report_suspicious_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void release_suspicious_path_by_slot(int slot);

void fill_suspicious_path_pe_addrs(int slot);

void start_binary_search(unsigned int source, unsigned int target);

void receive_binary_search_path(unsigned int pkt_source, unsigned int pkt_payload, unsigned int pkt_service);

void binary_search_divide(unsigned int source, unsigned int target, char *path, int path_size);

void receive_binary_search_probe(int probe_id, int result);

void register_binary_search_ht(unsigned int router, char port);

void print_binary_search_result();

void finalize_binary_search();

int send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size);

void handle_probe_results(unsigned int packet_source_field, unsigned int payload);

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result);

void clear_residual_switching(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload, unsigned int pkt_service);

void clear_residual_switching_from_probe_id(int probe_id);

void set_suspicious_health(unsigned int source_address, char *path, int path_size);

void set_infected_health(unsigned int ht_address, char ht_link);

void set_healthy_health(unsigned int source_address, char *path, int path_size);

void print_noc_health_status();

void print_noc_health_intersections();

#endif
