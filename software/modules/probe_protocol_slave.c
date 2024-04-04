#include "probe_protocol_slave.h"

void print_path(unsigned int *path, int path_size) {
    for(int i = 0; i < path_size; i++) {
        probe_puts(itoh(path[i]));
        probe_puts(" ");
    }
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

    send_probe_result(source, 0x50); //dummy result
}

void receive_probe_control(unsigned int source, unsigned int target, unsigned int payload) {

    probe_puts("[HT] RECV PROBE CONTROL -- from ");
    probe_puts(itoh(source));
    
    probe_puts(" to ");
    probe_puts(itoh(target));
    probe_puts("\n");
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
