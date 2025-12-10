#ifndef PROBE_PROTOCOL_H_
#define PROBE_PROTOCOL_H_

#include "packet.h"
#include "seek.h"
#include "probe_defines.h"

// #define probe_puts(argument) puts(argument)
#define probe_puts(argument)
#define probe_logs_puts(argument) puts(argument)

#define probe_debug_puts(argument) puts(argument)
// #define probe_debug_puts(argument)

#define GET_X(argument) (argument >> 8)
#define GET_Y(argument) (argument & 0xFF)

#define MAX_PROBE_SR_LENGTH 2
#define MAX_PROBE_PATH_SIZE 11

#define PROBE_RESULT_SUCCESS 10
#define PROBE_RESULT_FAILURE 20

#define PORT_EAST0  0
#define PORT_EAST1  1
#define PORT_WEST0  2
#define PORT_WEST1  3
#define PORT_NORTH0 4
#define PORT_NORTH1 5
#define PORT_SOUTH0 6
#define PORT_SOUTH1 7
#define PORT_LOCAL0 8
#define PORT_LOCAL1 9 

#define MAX_INCOMING_PROBES 20
#define MAX_OUTGOING_PROBES 20

#define MAX_INCOMING_BATCHES 3
#define MAX_OUTGOING_BATCHES 3

#define UNIFORM_BATCH_CODE 0

#define STATIC_PROBE_THRESHOLD 15000 //150us

#define MAX_PROBE_PAYLOAD_SIZE 210
// #define PROBE_PACKET_SIZE 200 // em flits

#define FARTHEST_PE 0x40

//Freeze protocol - probe
// #define FREEZE_APP_TO_SEARCH 

// Ways to represent a probe path:
// Path) String of chars in which each char represents a hop. Does NOT include a termination (opposite) hop.
// Compressed path) Used to send paths unsing the brNoC. Each hop is represented using 2 bits, end of path is signaled using an opposite hop. Max length = 24 bits.
// SR Header) Representation used by Hermes to route the packet. Ex: NEEES becomes 0x72007032.

unsigned int *probe_mpe_addr_ptr; //points to the cluster_master_address in the kernel_slave

unsigned int probe_message_buffer[MAX_PROBE_PAYLOAD_SIZE]; // reads insignificant data from the probe message, this value is never used

/**** PROBE API TABLE ****/

enum incoming_probe_status {
    INCOMING_PROBE_BLANK,
    INCOMING_PROBE_ALLOCATED,
    INCOMING_PROBE_WAITING_CONTROL,
    INCOMING_PROBE_WAITING_MESSAGE,
    INCOMING_PROBE_SUCCEEDED,
    INCOMING_PROBE_FAILED
};

struct incoming_probe {
    short id;
    unsigned short source;
    unsigned int timestamp;
    enum incoming_probe_status status;
    unsigned short batch_config;
};

int next_incoming_probe_slot;
struct incoming_probe incoming_probes[MAX_INCOMING_PROBES];

enum outgoing_probe_status {
    OUTGOING_PROBE_BLANK,
    OUTGOING_PROBE_ALLOCATED,
    OUTGOING_PROBE_WAITING_REQUEST,
    OUTGOING_PROBE_WAITING_PATH,
    OUTGOING_PROBE_SENT,
    OUTGOING_PROBE_BATCH_CONFIGURED
};

struct outgoing_probe {
    short id;
    unsigned short target;
    unsigned char compressed_path[3];
    enum outgoing_probe_status status;
    unsigned short batch_config;
};

int next_outgoing_probe_slot;
struct outgoing_probe outgoing_probes[MAX_OUTGOING_PROBES];

/**** PROBE BATCH STRUCTURES ****/

enum incoming_batch_status {
    INCOMING_BATCH_BLANK,
    INCOMING_BATCH_ALLOCATED,
    INCOMING_BATCH_RECEIVING,
    INCOMING_BATCH_RECEIVED    
};

struct incoming_batch {
    enum incoming_batch_status status;
    short initial_id;

    unsigned short source;

    int batch_size;
    int failed_probes;
    int finished_probes;
};

struct incoming_batch incoming_batches[MAX_INCOMING_BATCHES];

enum outgoing_batch_status {
    OUTGOING_BATCH_BLANK,
    OUTGOING_BATCH_ALLOCATED,
    OUTGOING_BATCH_SENDING,
    OUTGOING_BATCH_SENT
};

enum outgoing_batch_distribution {
    UNIFORM_DISTRIBUTION
};

struct outgoing_batch {
    enum outgoing_batch_status status;
    short initial_id;

    unsigned short target;
    unsigned int sr_header[MAX_PROBE_SR_LENGTH];
    int sr_header_size;

    unsigned short batch_config;

    enum outgoing_batch_distribution distribution;
    int batch_size;
    int sent_probes;
    unsigned int next_probe_timestamp;

    int uniform_distribution_delay;
};

struct outgoing_batch outgoing_batches[MAX_OUTGOING_BATCHES];

/**** FUNCTION SIGNATURES ****/

void init_probe_structures(unsigned int *mpe_addr_ptr);

void report_suspicious_path_to_mpe(unsigned int target);

/**** PRINT ****/

void print_probe_result(int status);

void print_turn(char turn);

void print_turn_logs(char turn);

void print_path(char *path, int path_size);

void print_path_logs(char *path, int path_size);

void print_sr_header(unsigned int *header, int header_size);

void print_sr_header_logs(unsigned int *header, int header_size);

void print_compressed_path(unsigned char *compressed_path);

/**** PATH LOGIC ****/

int get_turn_integer(char turn);

char get_opposite_direction(char direction);

int are_opposite_directions(char direction1, char direction2);

unsigned int calculate_target(unsigned int source, char *path, int path_size);

int write_xy_path(char *path_buffer, unsigned int source, unsigned int target);

void convert_path_to_compressed_path(char *path, int path_size, unsigned char *compressed_path);

int convert_compressed_path_to_path(unsigned char *compressed_path, char *path);

int convert_path_to_sr_header(char *path, int path_size, unsigned int *header);

int convert_sr_header_to_path(unsigned int *header, int header_size, char *path);

int convert_compressed_path_to_sr_header(unsigned char *compressed_path, unsigned int *header);

void convert_sr_header_to_compressed_path(unsigned int *header, int header_size, unsigned char *compressed_path);

int convert_single_channel_path_to_dual_channel_path(char *path, int path_size, char *dual_channel_path);

/**** FAULTY PACKETS ****/

void clear_residual_switching_from_current_path(unsigned int faulty_packet_source, unsigned int faulty_packet_target);

void send_reset_packets_to_routers_in_path(unsigned int source, char *path, int path_size);

void request_to_clear_residual_switching(unsigned int faulty_packet_source);

/**** PROBE API ****/

int get_new_incoming_probe_slot();

int get_new_outgoing_probe_slot();

int get_incoming_probe_by_id(unsigned int probe_id);

int get_outgoing_probe_by_id(unsigned int probe_id);

void send_probe(unsigned int probe_id, unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length, unsigned int batch_config);

void handle_probe_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void handle_probe_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void receive_probe(unsigned int probe_id, unsigned int source, unsigned int target);

void receive_probe_control(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void finalize_incoming_probe(struct incoming_probe *in_probe, int probe_result);

void send_probe_result(unsigned int probe_id, unsigned int probe_source, int result);

void monitor_probe_timeout();

/**** PROBE BATCHES ****/

int get_new_incoming_batch_slot();

int get_new_outgoing_batch_slot();

int find_incoming_batch_by_probe_id(int probe_id);

void configure_new_outgoing_batch(struct outgoing_probe *out_probe);

void monitor_outgoing_batches();

void send_probe_from_outgoing_batch(struct outgoing_batch *out_batch);

void update_outgoing_batch_timestamp(struct outgoing_batch *out_batch);

void register_result_to_incoming_batch(struct incoming_probe *in_probe, int probe_result);

int configure_new_incoming_batch(struct incoming_probe *in_probe);

void init_freeze();
#endif
