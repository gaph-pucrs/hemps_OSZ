/* hardware/sc/peripherals/IO_peripheral/sabotage_param.h */

#define T_START         100000  //100000
#define T_END           1000000  //120000
#define PERIOD          1000       //500

#define HEADER_FIX_HI   0x0083  //header  Source: 0203 (usando 12 bits)
#define HEADER_FIX_LO   0x0201  //header 

#define HEADER_ROUT_HI  0x0083  //header  Source: 0203 (usando 12 bits)
#define HEADER_ROUT_LO  0x0201  //header

#define F1_FLIT         0x0000  //f1 //sao as chaves corretas, pra passar pelo AP
#define F2_FLIT         0x0000  //f2 //mas considerar como se o AP fosse aberto

#define SERVICE_FLIT    0x0320  //service

#define SOURCE_FLIT     0x0000