#ifndef PROBE_PROTOCOL_MASTER_H_
#define PROBE_PROTOCOL_MASTER_H_

#include "packet.h"

#define probe_m_puts(argument) puts(argument)
// #define probe_m_puts(argument) 

void probe_protocol();

void handle_probe_results(unsigned int source, unsigned int target, unsigned int payload);

#endif
