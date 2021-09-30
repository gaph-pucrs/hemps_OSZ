/*!\file utils.h
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Edited by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief This module defines utils functions
 *
 */
#ifndef SOFTWARE_KERNEL_MASTER_UTILS_UTILS_H_
#define SOFTWARE_KERNEL_MASTER_UTILS_UTILS_H_

#define FALSE		0
#define TRUE		1

#define puts(string) MemoryWrite(UART_WRITE, (unsigned int)string);

void set_net_address(unsigned int);

unsigned int get_net_address();

char *itoa(unsigned int);

char *itoh(unsigned int);

int abs(int);

int rand(int, int, int);

int add(int, int);

int sub(int, int);

void *memset(void *, int, unsigned long);

char *fixetoa(int);

char *strcpy(char *, const char *);

int strlen(const char *);

//int puts(char *);

#define putsv(string, value) puts(string); puts(itoa(value)); puts("\n");

#define putsvsv(str1, v1, str2, v2) puts(str1); puts(itoa(v1)); puts(str2); puts(itoa(v2)); puts("\n");

//#define WARD_MODULE

#endif /* SOFTWARE_KERNEL_MASTER_UTILS_UTILS_H_ */
