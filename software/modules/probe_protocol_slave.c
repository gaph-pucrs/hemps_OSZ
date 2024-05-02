#include "probe_protocol_slave.h"

void init_probe_structures() {
    probe_sr_length = 0;
    probe_status = PROBE_STATUS_IDLE;
}

void send_probe(unsigned int probe_id, unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length) {

    probe_puts("[HT] SEND PROBE MESSAGE -- probe #");
    probe_puts(itoa(probe_id));

    probe_puts(" src: ");
    probe_puts(itoh(source));
    
    probe_puts(" tgt: ");
    probe_puts(itoh(target));
    
    probe_puts(" sr: ");
    print_sr_header(sr_header, sr_header_length);
    probe_puts("\n");

    /* PROBE CONTROL */

    Seek(PROBE_CONTROL, (probe_id << 16) | (get_net_address() & 0xffff), target, 0);

    /* PROBE MESSAGE */

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = target;
    
    p->service = PROBE_MESSAGE;
    p->probe_id = probe_id;
    p->probe_source = source;
    p->probe_target = target;

    send_packet_through_sr_path(p, 0, 0, sr_header, sr_header_length);
}

void receive_probe(unsigned int probe_id, unsigned int source, unsigned int target) {

    probe_puts("[HT] RECV PROBE MESSAGE -- probe #");
    probe_puts(itoa(probe_id));

    probe_puts(" src: ");
    probe_puts(itoh(source));
    
    probe_puts(" tgt: ");
    probe_puts(itoh(target));
    probe_puts("\n");

    probe_source_address = source; //used when timeout
    probe_id_timeout = probe_id;

    switch(probe_status) {
        case PROBE_STATUS_IDLE:
            probe_timestamp = MemoryRead(TICK_COUNTER);
            probe_status = PROBE_STATUS_WAITING_CONTROL;
            break;

        case PROBE_STATUS_WAITING_CONTROL:
            probe_puts("[HT] ERROR: Received multiple PROBE_MESSAGE packets\n");
            break;

        case PROBE_STATUS_WAITING_MESSAGE:
            probe_status = PROBE_STATUS_IDLE;
            send_probe_result(probe_id, source, PROBE_RESULT_SUCCESS);
            break;
    }
    
}

void receive_probe_control(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {

    unsigned int probe_id = pkt_source >> 16;
    unsigned int source = pkt_source & 0xffff;

    probe_puts("[HT] RECV PROBE CONTROL -- probe #");
    probe_puts(itoa(probe_id));
    
    probe_puts(" src: ");
    probe_puts(itoh(source));

    probe_puts(" tgt: ");
    probe_puts(itoh(pkt_target));
    probe_puts("\n");

    probe_source_address = source; //used when timeout
    probe_id_timeout = probe_id;

    switch(probe_status) {
        case PROBE_STATUS_IDLE:
            probe_timestamp = MemoryRead(TICK_COUNTER);
            probe_status = PROBE_STATUS_WAITING_MESSAGE;
            break;

        case PROBE_STATUS_WAITING_CONTROL:
            probe_status = PROBE_STATUS_IDLE;
            send_probe_result(probe_id, source, PROBE_RESULT_SUCCESS);
            break;

        case PROBE_STATUS_WAITING_MESSAGE:
            probe_puts("[HT] ERROR: Received multiple PROBE_CONTROL packets\n");
            break;
    }
}

void send_probe_result(unsigned int probe_id, unsigned int probe_source, int result) {

    probe_puts("[HT] SEND PROBE RESULTS -- probe #");
    probe_puts(itoa(probe_id));
    
    probe_puts(" src: ");
    probe_puts(itoh(probe_source));

    probe_puts(" tgt: ");
    probe_puts(itoh(get_net_address()));

    probe_puts(" result: ");
    probe_puts(itoh(result));
    probe_puts("\n");

    unsigned int packet_source_field = (probe_id << 16) | (get_net_address() & 0xffff);
    
    Seek(PROBE_RESULT, packet_source_field, PROBE_MASTER_ADDR, result);
}

void monitor_probe_timeout() {
    probe_puts("[HT] Monitoring timeout\n");
    if(probe_status==PROBE_STATUS_WAITING_CONTROL || probe_status==PROBE_STATUS_WAITING_MESSAGE) {
        if((MemoryRead(TICK_COUNTER) - probe_timestamp) >= STATIC_PROBE_THRESHOLD) {
            probe_puts("[HT] PROBE TIMEOUT VIOLATION\n");
            probe_status = PROBE_STATUS_IDLE;
            send_probe_result(probe_id_timeout, probe_source_address, PROBE_RESULT_FAILURE);
        } else {
            probe_puts("[HT] Probe is within threshold\n");
        }
    }
}
