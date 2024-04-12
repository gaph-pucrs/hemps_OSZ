#include "probe_protocol_master.h"

void print_path(char *path, int path_size) {
    for(int i = 0; i < path_size; i++) {
        switch(path[i]) {
            case EAST:
                probe_m_puts("E");
                break;
            case WEST:
                probe_m_puts("W");
                break;
            case NORTH:
                probe_m_puts("N");
                break;
            case SOUTH:
                probe_m_puts("S");
                break;
        }
    }
}

void print_sr_path(unsigned int *path, int path_size) {
    for(int i = 0; i < path_size; i++) {
        probe_m_puts(itoh(path[i]));
        probe_m_puts(" ");
    }
}

char get_opposite_direction(char direction) {
    switch(direction) {
        case EAST:
            return WEST;
        case WEST:
            return EAST;
        case NORTH:
            return SOUTH;
        case SOUTH:
            return NORTH;
        default:
            probe_m_puts("[HT] Function get_opposite_direction received invalid parameter\n");
    }
}

//takes a path {NORTH, EAST, SOUTH} and translates to SR routing header 0x7213, returns header size
int path_to_sr_header(char *path, int path_size, unsigned int *header) {

    int word_index = 0;
    int turn_index = 0;

    int hop = 0;
    int total_hops = path_size + 1; //additional last hop is used to indicate end of path

    while(hop < total_hops) {

        int is_last_hop = hop == (total_hops-1);
        int shift = 32 - ((turn_index + 1) * 4);

        //if it's the first turn, initialize the word
        if(turn_index == 0) {
            header[word_index] = 0;
        }

        //the start of each 16-bit flit stars with 0x7 turn to indicate it is a sr header
        if(turn_index == 0 || turn_index == 4) {
            header[word_index] = header[word_index] | (0x7 << shift);
        }

        //the other 4-bit slices contain the actual path hops
        else {
            int turn = is_last_hop ? get_opposite_direction(path[hop-1]) : path[hop];
            header[word_index] = header[word_index] | (turn << shift);
            hop++;
        }

        //increment turn_index
        turn_index++;
        if(turn_index == 8) {
            word_index++;
            turn_index = 0;
        }
    }

    //fill the remaining turns with 0xe to indicate "empty"
    while(turn_index < 8) {
        int shift = 32 - ((turn_index + 1) * 4);
        int turn = (turn_index == 0 || turn_index == 4) ? 0x7 : 0xe;
        header[word_index] = header[word_index] | (turn << shift); 
        turn_index++;
    }

    return word_index + 1; //header size, in words
}

void print_trust_score(int score) {

    //signal
    if(score >= 0) {
        probe_m_puts("+");
    }
    else {
        probe_m_puts("-");
        score *= -1;
    }

    //limit to 2 digits
    if(score > 99)
        score = 99;

    //leading 0
    if(score < 10)
        probe_m_puts("0");
    
    //actual print
        probe_m_puts(itoa(score));
}

void print_trust_score_matrix() {

    for(int link = 0; link < NUM_LINKS_PER_ROUTER; link++) {

        switch(link) {
            case EAST:
                probe_m_puts("EAST:\n");
                break;
            case WEST:
                probe_m_puts("WEST:\n");
                break;
            case NORTH:
                probe_m_puts("NORTH:\n");
                break;
            case SOUTH:
                probe_m_puts("SOUTH:\n");
                break;
        }

        for(int y = PLATFORM_DIMENSION_Y-1; y >= 0; y--) {
            for(int x = 0; x < PLATFORM_DIMENSION_X; x++) {
                print_trust_score(link_trust_scores[x][y][link]);
                probe_m_puts(" ");
            }
            probe_m_puts("\n");
        }
    }
}

void init_probe_master_structures() {
    probe_path_size = 0;
    //init trust scores cube matrix
    for(int x = 0; x < PLATFORM_DIMENSION_X; x++) {
        for(int y = 0; y < PLATFORM_DIMENSION_Y; y++) {
            for(int z = 0; z < NUM_LINKS_PER_ROUTER; z++) {
                link_trust_scores[x][y][z] = 0;
            }
        }
    }
}

void probe_protocol() {

    static int probes_counter = 0;

    //straight route
    if(probes_counter == 0) {
        probe_m_puts("[HT] **** Starting Probe Protocol -- WIP Hardcoded Version ****\n");
        probe_path[0] = EAST;
        probe_path[1] = EAST;
        probe_path[2] = EAST;
        probe_path[3] = EAST;
        probe_path_size = 4;
        send_probe_request(0x0003, 0x0403, probe_path, probe_path_size);
        probes_counter++;
        return;
    }

    //north route
    if(probes_counter == 1) {
        probe_path[0] = NORTH;
        probe_path[1] = EAST;
        probe_path[2] = EAST;
        probe_path[3] = EAST;
        probe_path[4] = EAST;
        probe_path[5] = SOUTH;
        probe_path_size = 6;
        send_probe_request(0x0003, 0x0403, probe_path, probe_path_size);
        probes_counter++;
        return;
    }

    //south route
    if(probes_counter == 2) {
        probe_path[0] = SOUTH;
        probe_path[1] = EAST;
        probe_path[2] = EAST;
        probe_path[3] = EAST;
        probe_path[4] = EAST;
        probe_path[5] = NORTH;
        probe_path_size = 6;
        send_probe_request(0x0003, 0x0403, probe_path, probe_path_size);
        probes_counter++;
        return;
    }
}

void send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size) {

    unsigned int source_routing_path[10];
    int source_routing_length = path_to_sr_header(path, path_size, source_routing_path);

    probe_m_puts("[HT] PROBE REQUEST -- from ");
    probe_m_puts(itoh(source_addr));
    
    probe_m_puts(" to ");
    probe_m_puts(itoh(target_addr));
    
    probe_m_puts(" path: ");
    print_path(path, path_size);

    probe_m_puts(" -- header: ");
    print_sr_path(source_routing_path, source_routing_length);
    probe_m_puts("\n");

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = source_addr;
    p->service = PROBE_REQUEST;
    p->probe_source = source_addr;
    p->probe_target = target_addr;
    p->probe_path_length = source_routing_length;
    p->msg_lenght = source_routing_length;

    //if payload is too small then add padding
    if(source_routing_length == 1) {
        p->msg_lenght++;
        source_routing_path[1] = 0x00000000;
    }

    send_packet(p, source_routing_path, p->msg_lenght);
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

    update_trust_scores(source_probe, source_packet, probe_path, probe_path_size, payload);

    probe_protocol(); //call probe_protocol back to continue with the hardcoded algorithm
}

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result) {
    
    int x = source >> 8;
    int y = source & 0xff;

    for(int i = 0; i < path_size; i++) {

        if(x < 0 || x >= PLATFORM_DIMENSION_X || y < 0 || y >= PLATFORM_DIMENSION_Y) {
            probe_m_puts("[HT] Update scores error: router address is not within platform dimensions\n");
        }
        
        int port = path[i];

        if(probe_result == PROBE_RESULT_SUCCESS)
            link_trust_scores[x][y][port]++;
        else
            link_trust_scores[x][y][port]--;
        
        //jump to next router in the path
        switch(port) {
            case EAST:
                x++;
                break;
            case WEST:
                x--;
                break;
            case NORTH:
                y++;
                break;
            case SOUTH:
                y--;
                break;
            default:
                probe_m_puts("[HT] Update scores error: path contains unknown hop\n");
        }
    }

    //Debug prints
    unsigned int calculated_target = (x << 8) | y;
    if(target != calculated_target) {
        probe_m_puts("[HT] Update scores error: path does not lead to specified target\n");
        probe_m_puts("[HT]     Expected target:  "); probe_m_puts(itoh(target)); probe_m_puts("\n");
        probe_m_puts("[HT]     Calculated target:"); probe_m_puts(itoh(calculated_target)); probe_m_puts("\n");
    }

    print_trust_score_matrix();
}
