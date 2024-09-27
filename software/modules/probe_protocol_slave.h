#ifndef PROBE_PROTOCOL_SLAVE_H_
#define PROBE_PROTOCOL_SLAVE_H_

#include "probe_protocol.h"
#include "packet.h"
#include "seek.h"

#define MAX_INCOMING_PROBES 10
#define MAX_OUTGOING_PROBES 10
#define MAX_SUSPICIOUS_PATHS 10

#define STATIC_PROBE_THRESHOLD 15000 //150us

unsigned int *probe_mpe_addr_ptr; //points to the cluster_master_address in the kernel_slave

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

enum suspicious_path_status {
    SUS_PATH_BLANK,
    SUS_PATH_ALLOCATED,
    SUS_PATH_XY_PENDING,
    SUS_PATH_XY_SENT,
    SUS_PATH_SR_PENDING,
    SUS_PATH_SR_SENT
};

struct suspicious_path {
    unsigned short target;
    enum suspicious_path_status status;
    unsigned char compressed_sr_path[3];
};

int next_suspicious_path_slot;
struct suspicious_path suspicious_paths[MAX_SUSPICIOUS_PATHS];

int probe_sr_length;
unsigned int probe_sr_header[MAX_PROBE_SR_LENGTH];

int probe_status; // {IDLE, WAITING_CONTROL, WAITING_PROBE}
unsigned int probe_id_timeout;
unsigned int probe_source_address;
unsigned int probe_timestamp;

void init_probe_structures(unsigned int *mpe_addr_ptr);

int get_new_incoming_probe_slot();

int get_new_outgoing_probe_slot();

int get_new_suspicious_path_slot();

int get_incoming_probe_by_id(unsigned int probe_id);

int get_outgoing_probe_by_id(unsigned int probe_id);

int get_suspicious_path_by_target(unsigned int target);

void send_probe(unsigned int probe_id, unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length);

void handle_probe_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void handle_probe_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void receive_probe(unsigned int probe_id, unsigned int source, unsigned int target);

void receive_probe_control(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void send_probe_result(unsigned int probe_id, unsigned int probe_source, int result);

void monitor_probe_timeout();

void report_suspicious_path_to_mpe(unsigned int target);

void handle_broken_path_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void request_to_clear_residual_switching(unsigned int faulty_packet_source);

#endif
