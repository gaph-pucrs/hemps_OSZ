#include "probe_protocol.h"

void print_probe_result(int status) {
    switch(status) {
        case PROBE_RESULT_SUCCESS:
            probe_puts("SUCCESS");
            break;
        case PROBE_RESULT_FAILURE:
            probe_puts("FAILURE");
            break;
        default:
            probe_puts("UNKNOWN RESULT");
    }
}

void print_turn(char turn) {
    switch(turn) {
        case EAST:
            probe_puts("E");
            return;
        case WEST:
            probe_puts("W");
            return;
        case NORTH:
            probe_puts("N");
            return;
        case SOUTH:
            probe_puts("S");
            return;
    }
    probe_puts("?");
}

void print_path(char *path, int path_size) {
    for(int i = 0; i < path_size; i++)
        print_turn(path[i]);
}

void print_sr_header(unsigned int *header, int header_size) {
    for(int i = 0; i < header_size; i++) {
        probe_puts(itoh(header[i]));
        probe_puts(" ");
    }
}

void print_compressed_path(unsigned char *compressed_path) {
    int byte = 0;
    int turn = 0;
    while(byte < 3) {
        int shift = 8 - ((turn + 1) * 2);
        int turn_val = (compressed_path[byte] >> shift) & 0x3;
        print_turn(turn_val);
        if(++turn == 4) {
            turn = 0;
            byte++;
        }
    }
}

char get_opposite_direction(char direction) {

    if(direction >= 4) //uses the second channel
        direction = direction;

    switch(direction) {
        case EAST:
            return WEST;
        case WEST:
            return EAST;
        case NORTH:
            return SOUTH;
        case SOUTH:
            return NORTH;
    }
    probe_puts("[HT] Function get_opposite_direction received invalid parameter\n");
    return -1;
}

int are_opposite_directions(char direction1, char direction2) {
    switch(direction1) {
        case EAST:
            return (direction2 == WEST);
        case WEST:
            return (direction2 == EAST);
        case NORTH:
            return (direction2 == SOUTH);
        case SOUTH:
            return (direction2 == NORTH);
    }
    probe_puts("[HT] ERROR - are_opposite_directions received invalid input\n");
    probe_puts("[HT] direction1="); probe_puts(itoa(direction1)); probe_puts(" direction2="); probe_puts(itoa(direction2)); probe_puts("\n");
    return 0;
}

unsigned int calculate_target(unsigned int source, char *path, int path_size) {

    int x = source >> 8;
    int y = source & 0xff;

    for(int i = 0; i < path_size; i++) {
        switch(path[i]) {
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
        }
    }

    return (x << 8) | y;
}

int write_xy_path(char *path_buffer, unsigned int source, unsigned int target) {

    int i = 0;

    int current_x = source >> 8;
    int current_y = source & 0xff;

    int target_x = target >> 8;
    int target_y = target & 0xff;

    while(current_x < target_x) {
        path_buffer[i] = EAST;
        current_x++;
        i++;
    }

    while(current_x > target_x) {
        path_buffer[i] = WEST;
        current_x--;
        i++;
    }

    while(current_y < target_y) {
        path_buffer[i] = NORTH;
        current_y++;
        i++;
    }

    while(current_y > target_y) {
        path_buffer[i] = SOUTH;
        current_y--;
        i++;
    }

    return i; //path size
}

void convert_path_to_compressed_path(char *path, int path_size, unsigned char *compressed_path) {

    int cpath_hop = 0;
    int cpath_byte = 0;

    int path_hop, shift;
    for(path_hop = 0; path_hop < path_size; path_hop++) {
        
        shift = 8 - ((cpath_hop + 1) * 2);

        //if it's the first compressed path hop, initialize the byte
        if(cpath_hop == 0)
            compressed_path[cpath_byte] = 0;

        compressed_path[cpath_byte] = compressed_path[cpath_byte] | (path[path_hop] << shift);

        cpath_hop++;
        if(cpath_hop == 4) {
            cpath_byte++;
            cpath_hop = 0;
        }
    }

    //termination hop
    shift = 8 - ((cpath_hop + 1) * 2);
    compressed_path[cpath_byte] = compressed_path[cpath_byte] | (get_opposite_direction(path[path_hop-1]) << shift);
}

int convert_compressed_path_to_path(unsigned char *compressed_path, char *path) {

    int path_hop = 0;

    int cpath_hop = 0;
    int cpath_byte = 0;

    char current_port, next_port;

    do {
        int shift = 8 - ((cpath_hop + 1) * 2);
        current_port = (compressed_path[cpath_byte] >> shift) & 0x3;

        path[path_hop] = current_port;
        path_hop++;

        cpath_hop++;
        if(cpath_hop == 4) {
            cpath_byte++;
            cpath_hop = 0;
        }

        //special case: compressed case has no termination hop
        if(cpath_byte > 2)
            return path_hop;

        int next_shift = 8 - ((cpath_hop + 1) * 2);
        next_port = (compressed_path[cpath_byte] >> next_shift) & 0x3;

    } while(are_opposite_directions(current_port, next_port) == 0);

    return path_hop;
}

int convert_path_to_sr_header(char *path, int path_size, unsigned int *header) {

    //The dual channel path respects the turn model used in Hermes
    char dual_channel_path[MAX_PROBE_PATH_SIZE];
    int dual_channel_path_size = convert_single_channel_path_to_dual_channel_path(path, path_size, dual_channel_path);

    int word_index = 0;
    int turn_index = 0;

    int hop = 0;
    int total_hops = dual_channel_path_size + 1; //additional last hop is used to indicate end of path

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
            int turn = is_last_hop ? get_opposite_direction(dual_channel_path[hop-1]) : dual_channel_path[hop];
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

    //last word was filled completly, return as is:
    if(turn_index == 0)
        return word_index;

    //last word was not filled: complete the remaining turns with 0xe to indicate "empty"
    while(turn_index < 8) {
        int shift = 32 - ((turn_index + 1) * 4);
        int turn = (turn_index == 0 || turn_index == 4) ? 0x7 : 0xe;
        header[word_index] = header[word_index] | (turn << shift); 
        turn_index++;
    }

    return word_index + 1; //header size, in words
}

int convert_sr_header_to_path(unsigned int *header, int header_size, char *path) {

    int path_index = 0;

    int header_word = 0;
    int header_turn = 1; //skips position 0 (sr flit flag)

    int current_hop;
    int next_hop = portToDirection((header[0] >> 24) & 0xf); //use only E W N S turns

    while(header_word < header_size) {

        /* Write current hop into path */

        current_hop = next_hop;

        path[path_index] = current_hop;
        path_index++;

        /* Increment header turn */

        header_turn++;

        if(header_turn == 4)
            header_turn = 5; //skips position 4 (sr flit flag)

        else if(header_turn == 8) {
            header_word++;
            header_turn = 1; //skips position 0 (sr flit flag)
        }

        /* Get next hop and check if path is finished */

        int shift = 32 - ((header_turn + 1) * 4);
        next_hop = portToDirection((header[header_word] >> shift) & 0xf); //use only E W N S turns

        if(are_opposite_directions(current_hop, next_hop))
            return path_index;
    }

    probe_puts("[HT] Error: convert_sr_header_to_path received wrong header_size_value\n");
    return path_index;
}

int convert_compressed_path_to_sr_header(unsigned char *compressed_path, unsigned int *header) {

    probe_puts("[HT] [DEBUG] input compressed path: ");
    print_compressed_path(compressed_path);
    probe_puts("\n");

    char path[MAX_PROBE_PATH_SIZE];
    int path_size = convert_compressed_path_to_path(compressed_path, path);

    probe_puts("[HT] [DEBUG] intermediate path: ");
    print_path(path, path_size);
    probe_puts("\n");

    int header_size = convert_path_to_sr_header(path, path_size, header);

    probe_puts("[HT] [DEBUG] output sr header: ");
    print_sr_header(header, header_size);
    probe_puts("\n");

    return header_size;
}

void convert_sr_header_to_compressed_path(unsigned int *header, int header_size, unsigned char *compressed_path) {

    probe_puts("[HT] [DEBUG] input sr header: ");
    print_sr_header(header, header_size);
    probe_puts("\n");

    char path[MAX_PROBE_PATH_SIZE];
    int path_size = convert_sr_header_to_path(header, header_size, path);

    probe_puts("[HT] [DEBUG] intermediate path: ");
    print_path(path, path_size);
    probe_puts("\n");

    convert_path_to_compressed_path(path, path_size, compressed_path);

    probe_puts("[HT] [DEBUG] output compressed path: ");
    print_compressed_path(compressed_path);
    probe_puts("\n");
}

int convert_single_channel_path_to_dual_channel_path(char *path, int path_size, char *dual_channel_path) {

    const int west_first = 0;
    const int east_first = 1;

    int i;
    int algorithm = west_first;
	
    for(i = 0; i < path_size-1; i++) {
		if(algorithm == west_first) {
            //turns prohibited by WEST FIRST: SW and NW
			if((path[i] == SOUTH || path[i] == NORTH) && path[i+1] == WEST) {
				algorithm = east_first;
			}
            dual_channel_path[i] = path[i]; //channel 0
		}
		else {
            //turns prohibited by EAST FIRST: SE and NE
			if((path[i] == SOUTH || path[i] == NORTH) && path[i+1] == EAST) {
				algorithm = west_first;
			}
            dual_channel_path[i] = path[i] + 4; //channel 1
		}
	}

    //last hop is assigned separately as it does not have to calculate the algorithm for the next hop
    dual_channel_path[i] = (algorithm == west_first) ? path[i] : path[i] + 4;

    return path_size;
}

void clear_residual_switching_from_current_path(unsigned int faulty_packet_source, unsigned int faulty_packet_target) {

    // probe_puts("[ROUTER RST] ** DATA MESSAGE RESET **\n");

    char faulty_path[MAX_PROBE_PATH_SIZE];
    int faulty_path_size;

    int sr_slot = SearchSourceRoutingDestination(faulty_packet_target);
    
    if(sr_slot < 0)
        faulty_path_size = write_xy_path(faulty_path, faulty_packet_source, faulty_packet_target); // Path is XY
    else
        faulty_path_size = convert_sr_header_to_path(SR_Table[sr_slot].path, SR_Table[sr_slot].path_size, faulty_path); // Path is SR
    
    send_reset_packets_to_routers_in_path(faulty_packet_source, faulty_path, faulty_path_size);
}

void send_reset_packets_to_routers_in_path(unsigned int source, char *path, int path_size) {

    // probe_puts("[ROUTER RST] Clearing path from "); probe_puts(itoh(source)); probe_puts("\n");
    // probe_puts("[ROUTER RST] Faulty path: "); print_path(path, path_size); probe_puts("\n");

    // RESET SOURCE LOCAL PORT
    
    unsigned int reset_mask = (1 << PORT_LOCAL0) | (1 << PORT_LOCAL1);
    // probe_puts("[ROUTER RST]   Resetting "); probe_puts(itoh(source)); probe_puts(" L\n");
    Seek(RESET_HERMES_PORT_SERVICE, (MemoryRead(TICK_COUNTER) << 16) | reset_mask, source, 0);

    // RESET INTERMEDIATE HOPS

    int current_x = source >> 8;
    int current_y = source & 0xff;

    for(int i = 0; i < path_size; i++) {

        // Obs: the hops denoted in "faulty_path[]" indicates the OUTPUT direction used to transmit the packet to the next router
        // As the Router Reset needs to clear the INPUT BUFFERS of the routers, we clear the hops OPPOSITE to those in "faulty_path[]"

        switch(path[i]) {
            case EAST:
                current_x += 1;
                reset_mask = (1 << PORT_WEST0) | (1 << PORT_WEST1);
                break;

            case WEST:
                current_x -= 1;
                reset_mask = (1 << PORT_EAST0) | (1 << PORT_EAST1);
                
                break;

            case NORTH:
                current_y +=1;
                reset_mask = (1 << PORT_SOUTH0) | (1 << PORT_SOUTH1);
                break;

            case SOUTH:
                current_y -= 1;
                reset_mask = (1 << PORT_NORTH0) | (1 << PORT_NORTH1);
                break;
            
            default:
                probe_puts("[ROUTER RST] UNRECOGNIZEBLE TURN: "); probe_puts(itoh(path[i])); probe_puts("\n");
        }

        int current_router = (current_x << 8) | current_y;

        // probe_puts("[ROUTER RST]   Resetting "); probe_puts(itoh(current_router)); probe_puts(" "); print_turn(get_opposite_direction(path[i])); probe_puts("\n");
        Seek(RESET_HERMES_PORT_SERVICE, (MemoryRead(TICK_COUNTER) << 16) | reset_mask, current_router, 0);
    }
}
