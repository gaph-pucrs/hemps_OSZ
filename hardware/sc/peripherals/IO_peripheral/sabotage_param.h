/* hardware/sc/peripherals/IO_peripheral/sabotage_param.h */

// #define T_START         500000  //100000
// #define T_END           1000000  //120000
// #define PERIOD          2000       //500

// #define HEADER_FIX_HI   0x6001  //header  Source: 0203 (usando 12 bits)
// #define HEADER_FIX_LO   randAddr  //header 

// #define HEADER_ROUT_HI  0x1083  //header  Source: 0203 (usando 12 bits)
// // #define HEADER_ROUT_LO  0x0301 //header (rand() % 0xf0) + 0x657F
// #define HEADER_ROUT_LO  randAddr // X de 5 a 7, Y de 0 a 5

// #define F1_FLIT         0x0000  //f1 //sao as chaves corretas, pra passar pelo AP
// #define F2_FLIT         0x0000  //f2 //mas considerar como se o AP fosse aberto

// #define SERVICE_FLIT    0x0320  //service

// #define SOURCE_FLIT     0x0000

// #define RAND_ADDR_EQ    ((rand() % 0x3 + 5) << 8) + (rand() % 0x6)

// 666 - DoS
// 777 - Spoof

// #define T_START         (io_id == 666 ? 500000        :       (io_id == 777 ? 500000 : 1000000000))
// #define T_END           (io_id == 666 ? 1000000       :       (io_id == 777 ? 1000000 : 1000000000))     
#define T_START         500000  //100000
#define T_END           1000000  //120000

#define PERIOD          io_id == 666 ? 2000          :       (io_id == 777 ? 5000 : 1000000000)

#define HEADER_FIX_HI   io_id == 666 ? 0x6001        :       (io_id == 777 ? (0x6000 + (f1 & 0xfff)) : 0xFFFF)
#define HEADER_FIX_LO   io_id == 666 ? randAddr      :       (io_id == 777 ? 0x0705 : 0xFFFF)  

#define HEADER_ROUT_HI  io_id == 666 ? 0x1083        :       (io_id == 777 ? 0x7332 : 0xFFFF)
#define HEADER_ROUT_LO  io_id == 666 ? randAddr      :       (io_id == 777 ? 0x7EEE : 0xFFFF)  

#define F1_FLIT         io_id == 666 ? 0x0000        :       (io_id == 777 ? (f1 & 0xffff) : 0xFFFF)
#define F2_FLIT         io_id == 666 ? 0x0000        :       (io_id == 777 ? 0x0000 : 0xFFFF)  //header


#define SERVICE_FLIT    0x0320  
#define SOURCE_FLIT     0x0000
#define RAND_ADDR_EQ    ((rand() % 0x3 + 5) << 8) + (rand() % 0x6)
