#include "probe_protocol.h"

void print_path(char *path, int path_size) {
    for(int i = 0; i < path_size; i++) {
        switch(path[i]) {
            case EAST:
                probe_puts("E");
                break;
            case WEST:
                probe_puts("W");
                break;
            case NORTH:
                probe_puts("N");
                break;
            case SOUTH:
                probe_puts("S");
                break;
        }
    }
}

void print_sr_header(unsigned int *header, int header_size) {
    for(int i = 0; i < header_size; i++) {
        probe_puts(itoh(header[i]));
        probe_puts(" ");
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
    }
    probe_puts("[HT] Function get_opposite_direction received invalid parameter\n");
    return -1;
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
