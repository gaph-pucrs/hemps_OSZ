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

// Ways to represent a probe path:
// Path) String of chars in which each char represents a hop. Does NOT include a termination (opposite) hop.
// Compressed path) Used to send paths unsing the brNoC. Each hop is represented using 2 bits, end of path is signaled using an opposite hop. Max length = 24 bits.
// SR Header) Representation used by Hermes to route the packet. Ex: NEEES becomes 0x72007032.

void print_probe_result(int status);

void print_turn(char turn);

void print_path(char *path, int path_size);

void print_sr_header(unsigned int *header, int header_size);

void print_compressed_path(unsigned char *compressed_path);

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

void clear_residual_switching_from_current_path(unsigned int faulty_packet_source, unsigned int faulty_packet_target);

void send_reset_packets_to_routers_in_path(unsigned int source, char *path, int path_size);

#endif
