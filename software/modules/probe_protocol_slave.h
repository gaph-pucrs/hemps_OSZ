#ifndef PROBE_PROTOCOL_SLAVE_H_
#define PROBE_PROTOCOL_SLAVE_H_

#include "packet.h"

#define probe_puts(argument) puts(argument)
// #define probe_puts(argument)

#define PROBE_MASTER_ADDR 0x0004

#define MAX_PROBE_PATH_SIZE 10

int probe_path_size;
unsigned int probe_path[MAX_PROBE_PATH_SIZE];

void send_probe(unsigned int source, unsigned int target, unsigned int *path, int path_size);

void receive_probe(unsigned int source, unsigned int target);

void receive_probe_control(unsigned int source, unsigned int target, unsigned int payload);

#endif
