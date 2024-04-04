#include "probe_protocol_master.h"

void print_path(unsigned int *path, int path_size) {
    for(int i = 0; i < path_size; i++) {
        probe_m_puts(itoh(path[i]));
        probe_m_puts(" ");
    }
}

void probe_protocol() {

    static int probes_counter = 0;
    unsigned int probe_route[10], probe_route_size;

    //straight route
    if(probes_counter == 0) {
        probe_m_puts("[HT] **** Starting Probe Protocol -- WIP Hardcoded Version ****\n");
        probe_route[0] = 0x7000701E;
        probe_route[1] = 0x7EEE7EEE;
        probe_route_size = 2;
        send_probe_request(0x0003, 0x0403, probe_route, probe_route_size);
        probes_counter++;
        return;
    }

    //north route
    if(probes_counter == 1) {
        probe_route[0] = 0x72007003;
        probe_route[1] = 0x72EE7EEE;
        probe_route_size = 2;
        send_probe_request(0x0003, 0x0403, probe_route, probe_route_size);
        probes_counter++;
        return;
    }

    //south route
    if(probes_counter == 2) {
        probe_route[0] = 0x73007002;
        probe_route[1] = 0x73EE7EEE;
        probe_route_size = 2;
        send_probe_request(0x0003, 0x0403, probe_route, probe_route_size);
        probes_counter++;
        return;
    }
}

void send_probe_request(unsigned int source_addr, unsigned int target_addr, unsigned int *path, int path_size) {

    probe_m_puts("[HT] PROBE REQUEST -- from ");
    probe_m_puts(itoh(source_addr));
    
    probe_m_puts(" to ");
    probe_m_puts(itoh(target_addr));
    
    probe_m_puts(" path: ");
    print_path(path, path_size);
    probe_m_puts("\n");

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = source_addr;
    p->service = PROBE_REQUEST;
    p->probe_source = source_addr;
    p->probe_target = target_addr;
    p->msg_lenght = path_size;

    send_packet(p, path, path_size);
}

void handle_probe_results(unsigned int source, unsigned int target, unsigned int payload) {

    unsigned int source_probe = source >> 16;
    unsigned int source_packet = source & 0xffff;
    
    probe_m_puts("[HT] PROBE RESULTS -- from ");
    probe_m_puts(itoh(source_probe));
    
    probe_m_puts(" to ");
    probe_m_puts(itoh(source_packet));

    probe_m_puts(" result: ");
    probe_m_puts(itoh(payload));
    probe_m_puts("\n");

    probe_protocol(); //call probe_protocol back to continue with the hardcoded algorithm
}
