/* hardware/sc/peripherals/IO_peripheral/sabotage_param.h */

#define T_START         100000  // 1 ms
#define T_END           500000  // 7 ms
#define PERIOD          2000       //500

// #define HEADER_FIX_HI   0x6C77  //header  Source: 0203 (usando 12 bits)
// #define HEADER_FIX_LO   0x0001  //header 

// #define HEADER_ROUT_HI  0x6C77  //header  Source: 0203 (usando 12 bits)
// #define HEADER_ROUT_LO  0x0001  //header

#define HEADER_FIX_HI   0x6083  //header  Source: 0203 (usando 12 bits)
#define HEADER_FIX_LO   0x0202  //header 

#define HEADER_ROUT_HI  0x6083  //header  Source: 0203 (usando 12 bits)
#define HEADER_ROUT_LO  0x0202  //header

#define F1_FLIT         0x0000  //f1 
#define F2_FLIT         0x2345  //f2

#define SERVICE_FLIT    0x0320  //service

#define SOURCE_FLIT     0x0000
