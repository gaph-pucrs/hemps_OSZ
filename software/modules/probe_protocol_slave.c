#include "probe_protocol_slave.h"

void print_path(unsigned int *path, int path_size) {
    for(int i = 0; i < path_size; i++) {
        probe_puts(itoh(path[i]));
        probe_puts(" ");
    }
}

void init_probe_structures() {
    probe_path_size = 0;
    probe_status = PROBE_STATUS_IDLE;
}

void send_probe(unsigned int source, unsigned int target, unsigned int *path, int path_size) {

    probe_puts("[HT] SEND PROBE MESSAGE -- from ");
    probe_puts(itoh(source));
    
    probe_puts(" to ");
    probe_puts(itoh(target));
    
    probe_puts(" path: ");
    print_path(path, path_size);
    probe_puts("\n");

    /* PROBE CONTROL */

    Seek(CLEAR_SERVICE, get_net_address(), target, 0);
    Seek(PROBE_CONTROL, get_net_address(), target, 0);

    /* PROBE MESSAGE */

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = target;
    
    p->service = PROBE_MESSAGE;
    p->probe_source = source;
    p->probe_target = target;

    send_packet_through_path(p, 0, 0, path, path_size);
}

void receive_probe(unsigned int source, unsigned int target) {

    probe_puts("[HT] RECV PROBE MESSAGE -- from ");
    probe_puts(itoh(source));
    
    probe_puts(" to ");
    probe_puts(itoh(target));
    probe_puts("\n");

    probe_source_address = source; //used when timeout

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
            send_probe_result(source, PROBE_RESULT_SUCCESS);
            break;
    }
    
}

void receive_probe_control(unsigned int source, unsigned int target, unsigned int payload) {

    probe_puts("[HT] RECV PROBE CONTROL -- from ");
    probe_puts(itoh(source));
    
    probe_puts(" to ");
    probe_puts(itoh(target));
    probe_puts("\n");

    probe_source_address = source; //used when timeout

    switch(probe_status) {
        case PROBE_STATUS_IDLE:
            probe_timestamp = MemoryRead(TICK_COUNTER);
            probe_status = PROBE_STATUS_WAITING_MESSAGE;
            break;

        case PROBE_STATUS_WAITING_CONTROL:
            probe_status = PROBE_STATUS_IDLE;
            send_probe_result(source, PROBE_RESULT_SUCCESS);
            break;

        case PROBE_STATUS_WAITING_MESSAGE:
            probe_puts("[HT] ERROR: Received multiple PROBE_CONTROL packets\n");
            break;
    }
}

void send_probe_result(unsigned int probe_source, unsigned int result) {

    probe_puts("[HT] SEND PROBE RESULTS -- from ");
    probe_puts(itoh(probe_source));

    probe_puts(" to ");
    probe_puts(itoh(get_net_address()));

    probe_puts(" result: ");
    probe_puts(itoh(result));
    probe_puts("\n");

    unsigned int packet_source_field = (probe_source << 16) | (get_net_address() & 0xffff);
    
    Seek(CLEAR_SERVICE, packet_source_field, PROBE_MASTER_ADDR, 0);
    Seek(PROBE_RESULT, packet_source_field, PROBE_MASTER_ADDR, result);
}

void monitor_probe_timeout() {
    probe_puts("[HT] Monitoring timeout\n");
    if(probe_status==PROBE_STATUS_WAITING_CONTROL || probe_status==PROBE_STATUS_WAITING_MESSAGE) {
        if((MemoryRead(TICK_COUNTER) - probe_timestamp) >= STATIC_PROBE_THRESHOLD) {
            probe_puts("[HT] PROBE TIMEOUT VIOLATION\n");
            probe_status = PROBE_STATUS_IDLE;
            send_probe_result(probe_source_address, PROBE_RESULT_FAILURE);
        } else {
            probe_puts("[HT] Probe is within threshold\n");
        }
    }
}
