
/*
 *
 * The input is from right to left. 
 * The rightmost byte is the least significant byte.
 * The leftmost byte is the most significant byte.
 */

#ifndef PRESENT_H
#define PRESENT_H

#include <stdint.h>

#define PRESENT_BLOCK_SIZE   (64)  /* block size in bits */
#define PRESENT_KEY_SIZE_80  (80)  /* key size in bits */
#define PRESENT_KEY_SIZE_128 (128) /* key size in bits */
#define PRESENT_ROUNDS       (31)  /* rounds */

typedef  uint8_t  u8;
typedef  uint16_t u16;
typedef  uint32_t u32;
typedef  uint64_t u64;


/*
 * rotate shift right n-bit on x(a 64-bit block)
 */
static inline uint64_t ror64(uint64_t x, int n) { return x>>n | x<<(64-n); }

/*
 * rotate shift left x by n bits
 */
static inline uint32_t rol32(uint32_t x, int n) { return x<<n | x>>(32-n); }

/*
 * rotate shift right x by n bits
 */
static inline uint32_t ror32(uint32_t x, int n) { return x>>n | x<<(32-n); }


/*
 * key schedule
 * inputKey: the original keys
 * keys: round keys
 */
void present_64_80_key_schedule(const u8 * inputKey, u8 * keys );

void present_64_128_key_schedule(const u8 * inputKey, u8 * keys );

/*
 * encrypt
 * plainText: plainText has just one block.
 * keys: round keys
 */
void present_encrypt(u8 * plainText, const u8 * keys );

/*
 * decrypt
 * cipherText: cipherText has just one block.
 * keys: round keys
 */
void present_decrypt(u8 * cipherText, const u8 * keys );

#endif