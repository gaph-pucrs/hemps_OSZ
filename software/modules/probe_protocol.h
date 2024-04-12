#ifndef PROBE_PROTOCOL_H_
#define PROBE_PROTOCOL_H_

#include "packet.h"

#define probe_puts(argument) puts(argument)
// #define probe_puts(argument)

#define PROBE_RESULT_SUCCESS 10
#define PROBE_RESULT_FAILURE 20

void print_path(char *path, int path_size);

void print_sr_header(unsigned int *header, int header_size);

char get_opposite_direction(char direction);

int path_to_sr_header(char *path, int path_size, unsigned int *header);

#endif
