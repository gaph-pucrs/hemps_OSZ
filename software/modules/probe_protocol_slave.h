#ifndef PROBE_PROTOCOL_SLAVE_H_
#define PROBE_PROTOCOL_SLAVE_H_

#include "packet.h"

#define probe_puts(argument) puts(argument)
// #define probe_puts(argument)

#define PROBE_MASTER_ADDR 0x0004

#define MAX_PROBE_PATH_SIZE 10

#define PROBE_STATUS_IDLE 1
#define PROBE_STATUS_WAITING_CONTROL 2
#define PROBE_STATUS_WAITING_MESSAGE 3

#define PROBE_RESULT_SUCCESS 10
#define PROBE_RESULT_FAILURE 20

#define STATIC_PROBE_THRESHOLD 15000 //150us

int probe_path_size;
unsigned int probe_path[MAX_PROBE_PATH_SIZE];

int probe_status; // {IDLE, WAITING_CONTROL, WAITING_PROBE}
unsigned int probe_source_address;
unsigned int probe_timestamp;

void init_probe_structures();

void send_probe(unsigned int source, unsigned int target, unsigned int *path, int path_size);

void receive_probe(unsigned int source, unsigned int target);

void receive_probe_control(unsigned int source, unsigned int target, unsigned int payload);

#endif
