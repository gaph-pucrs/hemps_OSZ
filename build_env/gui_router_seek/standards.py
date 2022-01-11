class ValPadrao():
    def __init__(self) -> None:
        pass

        self.EAST = 0
        self.WEST = 1
        self.NORTH = 2
        self.SOUTH = 3
        self.LOCAL = 4

        self.AINPUT = 0
        self.AOUTPUT = 1
        self.ALOCAL = 2

        self.IN_ACK = 0
        self.IN_NACK = 1
        self.OUT_REQ = 2
        self.IN_REQ = 3
        self.OUT_NACK = 4
        self.OUT_ACK = 5

services=dict()
services.update({"00000":"NO_SERVICE"})
services.update({"00001":"START_APP_SERVICE"})
services.update({"00010":"TARGET_UNREACHABLE_SERVICE"})
services.update({"00011":"CLEAR_SERVICE"})
services.update({"00100":"BACKTRACK_SERVICE"})
services.update({"00101":"SEARCHPATH_SERVICE"})
services.update({"00110":"END_TASK_SERVICE"})
services.update({"00111":"SET_SECURE_ZONE_SERVICE"})
services.update({"01000":"PACKET_RESEND_SERVICE"})
services.update({"01001":"WARD_SERVICE"})
services.update({"01010":"OPEN_SECURE_ZONE_SERVICE"})
services.update({"01011":"SECURE_ZONE_CLOSED_SERVICE"})
services.update({"01100":"SECURE_ZONE_OPENED_SERVICE"})
services.update({"01101":"FREEZE_TASK_SERVICE"})
services.update({"01110":"UNFREEZE_TASK_SERVICE"})
services.update({"01111":"MASTER_CANDIDATE_SERVICE"})
services.update({"10000":"TASK_ALLOCATED_SERVICE"})
services.update({"10001":"INITIALIZE_SLAVE_SERVICE"})
services.update({"10010":"INITIALIZE_CLUSTER_SERVICE"})
services.update({"10011":"LOAN_PROCESSOR_REQUEST_SERVICE"})
services.update({"10100":"LOAN_PROCESSOR_RELEASE_SERVICE"})
services.update({"10101":"END_TASK_OTHER_CLUSTER_SERVICE"})
services.update({"10110":"WAIT_KERNEL_SERVICE"})
services.update({"10111":"SEND_KERNEL_SERVICE"})
services.update({"11000":"WAIT_KERNEL_SERVICE_ACK"})
services.update({"11001":"FAIL_KERNEL_SERVICE"})
services.update({"11010":"NEW_APP_SERVICE"})
services.update({"11011":"NEW_APP_ACK_SERVICE"})
services.update({"11100":"GMV_READY_SERVICE"})
services.update({"11101":"SET_SZ_RECEIVED_SERVICE"})
services.update({"11110":"SET_EXCESS_SZ_SERVICE"})
services.update({"11111":"RCV_FREEZE_TASK_SERVICE"})

fsm1=dict()
fsm1.update({int("0000",2):"S_INIT_INPUT"})
fsm1.update({int("0001",2):"ARBITRATION_INPUT"})
fsm1.update({int("0010",2):"LOOK_TABLE_INPUT"})
fsm1.update({int("0011",2):"TEST_SPACE_AVAIL"})
fsm1.update({int("0100",2):"SERVICE_INPUT"})
fsm1.update({int("0101",2):"TABLE_WRITE_INPUT"})
fsm1.update({int("0110",2):"WRITE_BACKTRACK_INPUT"})
fsm1.update({int("0111",2):"TEST_SEND_LOCAL"})
fsm1.update({int("1000",2):"WRITE_CLEAR_INPUT"})
fsm1.update({int("1001",2):"WAIT_REQ_DOWN"})
fsm1.update({int("1010",2):"WAIT_REQ_DOWN_NACK"})
fsm1.update({int("1011",2):"SEND_NACK"})

wrapper_color=dict()
wrapper_color.update({"0":"green"})
wrapper_color.update({"1":"red"})

opmode_color=dict()
opmode_color.update({"0":"green"})
opmode_color.update({"1":"red"})

fsm2=dict()
fsm2.update({int("0000",2): "S_INIT"})
fsm2.update({int("0001",2): "ARBITRATION"})
fsm2.update({int("0010",2): "TEST_SERVICE"})
fsm2.update({int("0011",2): "SERVICE_BACKTRACK"})
fsm2.update({int("0100",2): "BACKTRACK_PROPAGATE"})
fsm2.update({int("0101",2): "INIT_BACKTRACK"})
fsm2.update({int("0110",2): "PREPARE_NEXT"})
fsm2.update({int("0111",2): "BACKTRACK_MOUNT"})
fsm2.update({int("1000",2): "CLEAR_TABLE"})
fsm2.update({int("1001",2): "COMPARE_TARGET"})
fsm2.update({int("1010",2): "SEND_LOCAL"})
fsm2.update({int("1011",2): "PROPAGATE"})
fsm2.update({int("1100",2): "WAIT_ACK_PORTS"})
fsm2.update({int("1101",2): "INIT_CLEAR"})
fsm2.update({int("1110",2): "END_BACKTRACK"})
fsm2.update({int("1111",2): "COUNT"})
## model
# class 
vzz = (lambda i,j:i*j)
sub = (lambda i,j:i-j)
sub_tup = lambda a,b : tuple([sub (*a) for a in zip(a,b) ])
soma_tup = lambda a,b : tuple(map(sum,zip(a,b)))
mult_tup = lambda a,b : tuple([vzz (*a) for a in zip(a,b) ] )

real_to_int = lambda x,y,w,h: (int(w*x), int(h*y))


global stds
stds:ValPadrao=ValPadrao()
