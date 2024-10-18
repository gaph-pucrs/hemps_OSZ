#ifndef PROBE_PROTOCOL_H_
#define PROBE_PROTOCOL_H_

#include "packet.h"
#include "seek.h"

#define probe_puts(argument) puts(argument)
// #define probe_puts(argument)

#define probe_debug_puts(argument) puts(argument)
// #define probe_debug_puts(argument)

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

#define MAX_INCOMING_PROBES 10
#define MAX_OUTGOING_PROBES 10

#define STATIC_PROBE_THRESHOLD 15000 //150us

// Ways to represent a probe path:
// Path) String of chars in which each char represents a hop. Does NOT include a termination (opposite) hop.
// Compressed path) Used to send paths unsing the brNoC. Each hop is represented using 2 bits, end of path is signaled using an opposite hop. Max length = 24 bits.
// SR Header) Representation used by Hermes to route the packet. Ex: NEEES becomes 0x72007032.

unsigned int *probe_mpe_addr_ptr; //points to the cluster_master_address in the kernel_slave

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
};

int next_incoming_probe_slot;
struct incoming_probe incoming_probes[MAX_INCOMING_PROBES];

enum outgoing_probe_status {
    OUTGOING_PROBE_BLANK,
    OUTGOING_PROBE_ALLOCATED,
    OUTGOING_PROBE_WAITING_REQUEST,
    OUTGOING_PROBE_WAITING_PATH,
    OUTGOING_PROBE_SENT
};

struct outgoing_probe {
    short id;
    unsigned short target;
    unsigned char compressed_path[3];
    enum outgoing_probe_status status;
};

int next_outgoing_probe_slot;
struct outgoing_probe outgoing_probes[MAX_OUTGOING_PROBES];

void init_probe_structures(unsigned int *mpe_addr_ptr);

void report_suspicious_path_to_mpe(unsigned int target);

/**** PRINT ****/

void print_probe_result(int status);

void print_turn(char turn);

void print_path(char *path, int path_size);

void print_sr_header(unsigned int *header, int header_size);

void print_compressed_path(unsigned char *compressed_path);

/**** PATH LOGIC ****/

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

/**** PROBE API TABLE ****/

int get_new_incoming_probe_slot();

int get_new_outgoing_probe_slot();

int get_incoming_probe_by_id(unsigned int probe_id);

int get_outgoing_probe_by_id(unsigned int probe_id);

/**** PROBE API ****/

void send_probe(unsigned int probe_id, unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length);

void handle_probe_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void handle_probe_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void receive_probe(unsigned int probe_id, unsigned int source, unsigned int target);

void receive_probe_control(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void send_probe_result(unsigned int probe_id, unsigned int probe_source, int result);

void monitor_probe_timeout();

#endif
