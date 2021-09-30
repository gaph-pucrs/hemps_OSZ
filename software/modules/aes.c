#include "aes.h"

/*************************** AES SOURCE CODE ************************/

/*********************************************************************
* Filename:   aes.c
* Author:     Brad Conte (brad AT bradconte.com)
* Copyright:
* Disclaimer: This code is presented "as is" without any guarantees.
* Details:    This code is the implementation of the AES algorithm and
              the CTR, CBC, and CCM modes of operation it can be used in.
               AES is, specified by the NIST in in publication FIPS PUB 197,
              availible at:
               * http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf .
              The CBC and CTR modes of operation are specified by
              NIST SP 800-38 A, available at:
               * http://csrc.nist.gov/publications/nistpubs/800-38a/sp800-38a.pdf .
              The CCM mode of operation is specified by NIST SP80-38 C, available at:
               * http://csrc.nist.gov/publications/nistpubs/800-38C/SP800-38C_updated-July20_2007.pdf
*********************************************************************/


//void ccm_prepare_first_ctr_blk(BYTE counter[], const BYTE nonce[], int nonce_len, int payload_len_store_size);
//void ccm_prepare_first_format_blk(BYTE buf[], int assoc_len, int payload_len, int payload_len_store_size, int mac_len, const BYTE nonce[], int nonce_len);
//void ccm_format_assoc_data(BYTE buf[], int *end_of_buf, const BYTE assoc[], int assoc_len);
//void ccm_format_payload_data(BYTE buf[], int *end_of_buf, const BYTE payload[], int payload_len);



/*********************** FUNCTION DEFINITIONS ***********************/
// XORs the in and out buffers, storing the result in out. Length is in bytes.
//void xor_buf(const BYTE in[], BYTE out[], unsigned int len)
//{
//    unsigned int idx;
//
//    for (idx = 0; idx < len; idx++)
//        out[idx] ^= in[idx];
//}

/*******************
* AES
*******************/
/////////////////
// KEY EXPANSION
/////////////////

// Substitutes a word using the AES S-Box.
WORD SubWord(WORD word)
{
    unsigned int result;

    result = (int)aes_sbox[(word >> 4) & 0x0000000F][word & 0x0000000F];
    result += (int)aes_sbox[(word >> 12) & 0x0000000F][(word >> 8) & 0x0000000F] << 8;
    result += (int)aes_sbox[(word >> 20) & 0x0000000F][(word >> 16) & 0x0000000F] << 16;
    result += (int)aes_sbox[(word >> 28) & 0x0000000F][(word >> 24) & 0x0000000F] << 24;
    return(result);
}

// Performs the action of generating the keys that will be used in every round of
// encryption. "key" is the user-supplied input key, "w" is the output key schedule,
// "keysize" is the length in bits of "key", must be 128, 192, or 256.
void aes_key_setup(const BYTE key[], WORD w[], int keysize)
{
    int Nb=4,Nr,Nk,idx;
    volatile WORD temp,Rcon[]={0x01000000,0x02000000,0x04000000,0x08000000,0x10000000,0x20000000,
                      0x40000000,0x80000000,0x1b000000,0x36000000,0x6c000000,0xd8000000,
                      0xab000000,0x4d000000,0x9a000000};

    switch (keysize) {
        case 128: Nr = 10; Nk = 4; break;
        case 192: Nr = 12; Nk = 6; break;
        case 256: Nr = 14; Nk = 8; break;
        default: return;
    }

    for (idx=0; idx < Nk; ++idx) {
        w[idx] = ((key[4 * idx]) << 24) | ((key[4 * idx + 1]) << 16) |
                   ((key[4 * idx + 2]) << 8) | ((key[4 * idx + 3]));
    }

    for (idx = Nk; idx < Nb * (Nr+1); ++idx) {
        temp = w[idx - 1];
        if ((idx % Nk) == 0)
            temp = SubWord(KE_ROTWORD(temp)) ^ Rcon[(idx-1)/Nk];
        else if (Nk > 6 && (idx % Nk) == 4)
            temp = SubWord(temp);
        w[idx] = w[idx-Nk] ^ temp;
    }
}

/////////////////
// ADD ROUND KEY
/////////////////

// Performs the AddRoundKey step. Each round has its own pre-generated 16-byte key in the
// form of 4 integers (the "w" array). Each integer is XOR'd by one column of the state.
// Also performs the job of InvAddRoundKey(); since the function is a simple XOR process,
// it is its own inverse.
void AddRoundKey(BYTE state[][4], const WORD w[])
{
#ifdef debug_aes_on 
    int i, j;
#endif
    BYTE subkey[4];

    // memcpy(subkey,&w[idx],4); // Not accurate for big endian machines
    // Subkey 1
    subkey[0] = (w[0] >> 24) & 0xFF;
    subkey[1] = (w[0] >> 16) & 0xFF;
    subkey[2] = (w[0] >> 8) & 0xFF;
    subkey[3] = (w[0]) & 0xFF;
    
    //puts(" \n");
    //puts("subkey\n");
    //for(j=0; j<4;j++){
    //  puts(itoh(subkey[j]));      
    //}
    //puts(" \n");    
    //
    //puts(" \n");
    //puts("state\n");
    //for(j=0; j<4;j++){
    //  puts(itoh(state[j][0]));        
    //}
    //puts(" \n");    
        
    state[0][0] ^= subkey[0];
    state[1][0] ^= subkey[1];
    state[2][0] ^= subkey[2];
    state[3][0] ^= subkey[3];
    // Subkey 2
    subkey[0] = (w[1] >> 24) & 0xFF;
    subkey[1] = (w[1] >> 16) & 0xFF;
    subkey[2] = (w[1] >> 8) & 0xFF;
    subkey[3] = (w[1]) & 0xFF;
    state[0][1] ^= subkey[0];
    state[1][1] ^= subkey[1];
    state[2][1] ^= subkey[2];
    state[3][1] ^= subkey[3];
    // Subkey 3
    subkey[0] = (w[2] >> 24) & 0xFF;
    subkey[1] = (w[2] >> 16) & 0xFF;
    subkey[2] = (w[2] >> 8) & 0xFF;
    subkey[3] = (w[2]) & 0xFF;
    state[0][2] ^= subkey[0];
    state[1][2] ^= subkey[1];
    state[2][2] ^= subkey[2];
    state[3][2] ^= subkey[3];
    // Subkey 4
    subkey[0] = (w[3] >> 24) & 0xFF;
    subkey[1] = (w[3] >> 16) & 0xFF;
    subkey[2] = (w[3] >> 8) & 0xFF;
    subkey[3] = (w[3]) & 0xFF;
    state[0][3] ^= subkey[0];
    state[1][3] ^= subkey[1];
    state[2][3] ^= subkey[2];
    state[3][3] ^= subkey[3];

#ifdef debug_aes_on 
    puts(" \n");
    puts("AddRoundKey\n");
    for(i=0; i<4;i++){
        for(j=0; j<4;j++){
            puts(itoh(state[j][i]));        
        }
    }
    puts(" \n");      
#endif
    
}

/////////////////
// (Inv)SubBytes
/////////////////

// Performs the SubBytes step. All bytes in the state are substituted with a
// pre-calculated value from a lookup table.
void SubBytes(BYTE state[][4])
{
#ifdef debug_aes_on 
    int i, j;
#endif
    state[0][0] = aes_sbox[state[0][0] >> 4][state[0][0] & 0x0F];
    state[0][1] = aes_sbox[state[0][1] >> 4][state[0][1] & 0x0F];
    state[0][2] = aes_sbox[state[0][2] >> 4][state[0][2] & 0x0F];
    state[0][3] = aes_sbox[state[0][3] >> 4][state[0][3] & 0x0F];
    state[1][0] = aes_sbox[state[1][0] >> 4][state[1][0] & 0x0F];
    state[1][1] = aes_sbox[state[1][1] >> 4][state[1][1] & 0x0F];
    state[1][2] = aes_sbox[state[1][2] >> 4][state[1][2] & 0x0F];
    state[1][3] = aes_sbox[state[1][3] >> 4][state[1][3] & 0x0F];
    state[2][0] = aes_sbox[state[2][0] >> 4][state[2][0] & 0x0F];
    state[2][1] = aes_sbox[state[2][1] >> 4][state[2][1] & 0x0F];
    state[2][2] = aes_sbox[state[2][2] >> 4][state[2][2] & 0x0F];
    state[2][3] = aes_sbox[state[2][3] >> 4][state[2][3] & 0x0F];
    state[3][0] = aes_sbox[state[3][0] >> 4][state[3][0] & 0x0F];
    state[3][1] = aes_sbox[state[3][1] >> 4][state[3][1] & 0x0F];
    state[3][2] = aes_sbox[state[3][2] >> 4][state[3][2] & 0x0F];
    state[3][3] = aes_sbox[state[3][3] >> 4][state[3][3] & 0x0F];
    
#ifdef debug_aes_on 
    puts(" \n");
    puts("SubBytes\n");
    for(i=0; i<4;i++){
        for(j=0; j<4;j++){
            puts(itoh(state[j][i]));        
        }
    }
    puts(" \n");      
#endif  
    
}

void InvSubBytes(BYTE state[][4])
{
#ifdef debug_aes_on 
    int i, j;
#endif
    state[0][0] = aes_invsbox[state[0][0] >> 4][state[0][0] & 0x0F];
    state[0][1] = aes_invsbox[state[0][1] >> 4][state[0][1] & 0x0F];
    state[0][2] = aes_invsbox[state[0][2] >> 4][state[0][2] & 0x0F];
    state[0][3] = aes_invsbox[state[0][3] >> 4][state[0][3] & 0x0F];
    state[1][0] = aes_invsbox[state[1][0] >> 4][state[1][0] & 0x0F];
    state[1][1] = aes_invsbox[state[1][1] >> 4][state[1][1] & 0x0F];
    state[1][2] = aes_invsbox[state[1][2] >> 4][state[1][2] & 0x0F];
    state[1][3] = aes_invsbox[state[1][3] >> 4][state[1][3] & 0x0F];
    state[2][0] = aes_invsbox[state[2][0] >> 4][state[2][0] & 0x0F];
    state[2][1] = aes_invsbox[state[2][1] >> 4][state[2][1] & 0x0F];
    state[2][2] = aes_invsbox[state[2][2] >> 4][state[2][2] & 0x0F];
    state[2][3] = aes_invsbox[state[2][3] >> 4][state[2][3] & 0x0F];
    state[3][0] = aes_invsbox[state[3][0] >> 4][state[3][0] & 0x0F];
    state[3][1] = aes_invsbox[state[3][1] >> 4][state[3][1] & 0x0F];
    state[3][2] = aes_invsbox[state[3][2] >> 4][state[3][2] & 0x0F];
    state[3][3] = aes_invsbox[state[3][3] >> 4][state[3][3] & 0x0F];

#ifdef debug_aes_on 
    puts(" \n");
    puts("InvSubBytes\n");
    for(i=0; i<4;i++){
        for(j=0; j<4;j++){
            puts(itoh(state[j][i]));        
        }
    }
    puts(" \n");      
#endif      
    
}

/////////////////
// (Inv)ShiftRows
/////////////////

// Performs the ShiftRows step. All rows are shifted cylindrically to the left.
void ShiftRows(BYTE state[][4])
{
    int t;
#ifdef debug_aes_on 
    int i, j;
#endif

    // Shift left by 1
    t = state[1][0];
    state[1][0] = state[1][1];
    state[1][1] = state[1][2];
    state[1][2] = state[1][3];
    state[1][3] = t;
    // Shift left by 2
    t = state[2][0];
    state[2][0] = state[2][2];
    state[2][2] = t;
    t = state[2][1];
    state[2][1] = state[2][3];
    state[2][3] = t;
    // Shift left by 3
    t = state[3][0];
    state[3][0] = state[3][3];
    state[3][3] = state[3][2];
    state[3][2] = state[3][1];
    state[3][1] = t;

#ifdef debug_aes_on 
    puts(" \n");
    puts("ShiftRows\n");
    for(i=0; i<4;i++){
        for(j=0; j<4;j++){
            puts(itoh(state[j][i]));        
        }
    }
    puts(" \n");      
#endif      

    
}

// All rows are shifted cylindrically to the right.
void InvShiftRows(BYTE state[][4])
{
    int t;
#ifdef debug_aes_on 
    int i, j;
#endif
    // Shift right by 1
    t = state[1][3];
    state[1][3] = state[1][2];
    state[1][2] = state[1][1];
    state[1][1] = state[1][0];
    state[1][0] = t;
    // Shift right by 2
    t = state[2][3];
    state[2][3] = state[2][1];
    state[2][1] = t;
    t = state[2][2];
    state[2][2] = state[2][0];
    state[2][0] = t;
    // Shift right by 3
    t = state[3][3];
    state[3][3] = state[3][0];
    state[3][0] = state[3][1];
    state[3][1] = state[3][2];
    state[3][2] = t;

#ifdef debug_aes_on 
    puts(" \n");
    puts("InvShiftRows\n");
    for(i=0; i<4;i++){
        for(j=0; j<4;j++){
            puts(itoh(state[j][i]));        
        }
    }
    puts(" \n");      
#endif          
        
}

/////////////////
// (Inv)MixColumns
/////////////////

// Performs the MixColums step. The state is multiplied by itself using matrix
// multiplication in a Galios Field 2^8. All multiplication is pre-computed in a table.
// Addition is equivilent to XOR. (Must always make a copy of the column as the original
// values will be destoyed.)
void MixColumns(BYTE state[][4])
{
    BYTE col[4];
#ifdef debug_aes_on 
    int i, j;
#endif
    // Column 1
    col[0] = state[0][0];
    col[1] = state[1][0];
    col[2] = state[2][0];
    col[3] = state[3][0];
    state[0][0] = gf_mul[col[0]][0];
    state[0][0] ^= gf_mul[col[1]][1];
    state[0][0] ^= col[2];
    state[0][0] ^= col[3];
    state[1][0] = col[0];
    state[1][0] ^= gf_mul[col[1]][0];
    state[1][0] ^= gf_mul[col[2]][1];
    state[1][0] ^= col[3];
    state[2][0] = col[0];
    state[2][0] ^= col[1];
    state[2][0] ^= gf_mul[col[2]][0];
    state[2][0] ^= gf_mul[col[3]][1];
    state[3][0] = gf_mul[col[0]][1];
    state[3][0] ^= col[1];
    state[3][0] ^= col[2];
    state[3][0] ^= gf_mul[col[3]][0];
    // Column 2
    col[0] = state[0][1];
    col[1] = state[1][1];
    col[2] = state[2][1];
    col[3] = state[3][1];
    state[0][1] = gf_mul[col[0]][0];
    state[0][1] ^= gf_mul[col[1]][1];
    state[0][1] ^= col[2];
    state[0][1] ^= col[3];
    state[1][1] = col[0];
    state[1][1] ^= gf_mul[col[1]][0];
    state[1][1] ^= gf_mul[col[2]][1];
    state[1][1] ^= col[3];
    state[2][1] = col[0];
    state[2][1] ^= col[1];
    state[2][1] ^= gf_mul[col[2]][0];
    state[2][1] ^= gf_mul[col[3]][1];
    state[3][1] = gf_mul[col[0]][1];
    state[3][1] ^= col[1];
    state[3][1] ^= col[2];
    state[3][1] ^= gf_mul[col[3]][0];
    // Column 3
    col[0] = state[0][2];
    col[1] = state[1][2];
    col[2] = state[2][2];
    col[3] = state[3][2];
    state[0][2] = gf_mul[col[0]][0];
    state[0][2] ^= gf_mul[col[1]][1];
    state[0][2] ^= col[2];
    state[0][2] ^= col[3];
    state[1][2] = col[0];
    state[1][2] ^= gf_mul[col[1]][0];
    state[1][2] ^= gf_mul[col[2]][1];
    state[1][2] ^= col[3];
    state[2][2] = col[0];
    state[2][2] ^= col[1];
    state[2][2] ^= gf_mul[col[2]][0];
    state[2][2] ^= gf_mul[col[3]][1];
    state[3][2] = gf_mul[col[0]][1];
    state[3][2] ^= col[1];
    state[3][2] ^= col[2];
    state[3][2] ^= gf_mul[col[3]][0];
    // Column 4
    col[0] = state[0][3];
    col[1] = state[1][3];
    col[2] = state[2][3];
    col[3] = state[3][3];
    state[0][3] = gf_mul[col[0]][0];
    state[0][3] ^= gf_mul[col[1]][1];
    state[0][3] ^= col[2];
    state[0][3] ^= col[3];
    state[1][3] = col[0];
    state[1][3] ^= gf_mul[col[1]][0];
    state[1][3] ^= gf_mul[col[2]][1];
    state[1][3] ^= col[3];
    state[2][3] = col[0];
    state[2][3] ^= col[1];
    state[2][3] ^= gf_mul[col[2]][0];
    state[2][3] ^= gf_mul[col[3]][1];
    state[3][3] = gf_mul[col[0]][1];
    state[3][3] ^= col[1];
    state[3][3] ^= col[2];
    state[3][3] ^= gf_mul[col[3]][0];

#ifdef debug_aes_on 
    puts(" \n");
    puts("MixColumns\n");
    for(i=0; i<4;i++){
        for(j=0; j<4;j++){
            puts(itoh(state[j][i]));        
        }
    }
    puts(" \n");      
#endif      
    
}

void InvMixColumns(BYTE state[][4])
{
    BYTE col[4];
#ifdef debug_aes_on 
    int i, j;
#endif
    // Column 1
    col[0] = state[0][0];
    col[1] = state[1][0];
    col[2] = state[2][0];
    col[3] = state[3][0];
    state[0][0] = gf_mul[col[0]][5];
    state[0][0] ^= gf_mul[col[1]][3];
    state[0][0] ^= gf_mul[col[2]][4];
    state[0][0] ^= gf_mul[col[3]][2];
    state[1][0] = gf_mul[col[0]][2];
    state[1][0] ^= gf_mul[col[1]][5];
    state[1][0] ^= gf_mul[col[2]][3]; 
    state[1][0] ^= gf_mul[col[3]][4];
    state[2][0] = gf_mul[col[0]][4];
    state[2][0] ^= gf_mul[col[1]][2];
    state[2][0] ^= gf_mul[col[2]][5];
    state[2][0] ^= gf_mul[col[3]][3];
    state[3][0] = gf_mul[col[0]][3];
    state[3][0] ^= gf_mul[col[1]][4];
    state[3][0] ^= gf_mul[col[2]][2];
    state[3][0] ^= gf_mul[col[3]][5];
    // Column 2
    col[0] = state[0][1];
    col[1] = state[1][1];
    col[2] = state[2][1];
    col[3] = state[3][1];
    state[0][1] = gf_mul[col[0]][5];
    state[0][1] ^= gf_mul[col[1]][3];
    state[0][1] ^= gf_mul[col[2]][4];
    state[0][1] ^= gf_mul[col[3]][2];
    state[1][1] = gf_mul[col[0]][2];
    state[1][1] ^= gf_mul[col[1]][5];
    state[1][1] ^= gf_mul[col[2]][3];
    state[1][1] ^= gf_mul[col[3]][4];
    state[2][1] = gf_mul[col[0]][4];
    state[2][1] ^= gf_mul[col[1]][2];
    state[2][1] ^= gf_mul[col[2]][5];
    state[2][1] ^= gf_mul[col[3]][3];
    state[3][1] = gf_mul[col[0]][3];
    state[3][1] ^= gf_mul[col[1]][4];
    state[3][1] ^= gf_mul[col[2]][2];
    state[3][1] ^= gf_mul[col[3]][5];
    // Column 3
    col[0] = state[0][2];
    col[1] = state[1][2];
    col[2] = state[2][2];
    col[3] = state[3][2];
    state[0][2] = gf_mul[col[0]][5];
    state[0][2] ^= gf_mul[col[1]][3];
    state[0][2] ^= gf_mul[col[2]][4];
    state[0][2] ^= gf_mul[col[3]][2];
    state[1][2] = gf_mul[col[0]][2];
    state[1][2] ^= gf_mul[col[1]][5];
    state[1][2] ^= gf_mul[col[2]][3];
    state[1][2] ^= gf_mul[col[3]][4];
    state[2][2] = gf_mul[col[0]][4];
    state[2][2] ^= gf_mul[col[1]][2];
    state[2][2] ^= gf_mul[col[2]][5];
    state[2][2] ^= gf_mul[col[3]][3];
    state[3][2] = gf_mul[col[0]][3];
    state[3][2] ^= gf_mul[col[1]][4];
    state[3][2] ^= gf_mul[col[2]][2];
    state[3][2] ^= gf_mul[col[3]][5];
    // Column 4
    col[0] = state[0][3];
    col[1] = state[1][3];
    col[2] = state[2][3];
    col[3] = state[3][3];
    state[0][3] = gf_mul[col[0]][5];
    state[0][3] ^= gf_mul[col[1]][3];
    state[0][3] ^= gf_mul[col[2]][4];
    state[0][3] ^= gf_mul[col[3]][2];
    state[1][3] = gf_mul[col[0]][2];
    state[1][3] ^= gf_mul[col[1]][5];
    state[1][3] ^= gf_mul[col[2]][3];
    state[1][3] ^= gf_mul[col[3]][4];
    state[2][3] = gf_mul[col[0]][4];
    state[2][3] ^= gf_mul[col[1]][2];
    state[2][3] ^= gf_mul[col[2]][5];
    state[2][3] ^= gf_mul[col[3]][3];
    state[3][3] = gf_mul[col[0]][3];
    state[3][3] ^= gf_mul[col[1]][4];
    state[3][3] ^= gf_mul[col[2]][2];
    state[3][3] ^= gf_mul[col[3]][5];
#ifdef debug_aes_on 
    puts(" \n");
    puts("InvMixColumns\n");
    for(i=0; i<4;i++){
        for(j=0; j<4;j++){
            puts(itoh(state[j][i]));        
        }
    }
    puts(" \n");      
#endif      
    
}

/////////////////
// (En/De)Crypt
/////////////////

void aes_encrypt(const BYTE in[], BYTE out[], const WORD key[], int keysize)
{
    BYTE state[4][4];

#ifdef debug_aes_on 
    int i, j;
#endif

    // Copy input array (should be 16 bytes long) to a matrix (sequential bytes are ordered
    // by row, not col) called "state" for processing.
    // *** Implementation note: The official AES documentation references the state by
    // column, then row. Accessing an element in C requires row then column. Thus, all state
    // references in AES must have the column and row indexes reversed for C implementation.
    
    //puts(" \n");
    //puts("in\n");
    //for(i=0; i<AES_BLOCK_SIZE;i++){
    //  puts(itoh(in[i]));      
    //}
    //puts(" \n");
    
    state[0][0] = in[0];
    state[1][0] = in[1];
    state[2][0] = in[2];
    state[3][0] = in[3];
    state[0][1] = in[4];
    state[1][1] = in[5];
    state[2][1] = in[6];
    state[3][1] = in[7];
    state[0][2] = in[8];
    state[1][2] = in[9];
    state[2][2] = in[10];
    state[3][2] = in[11];
    state[0][3] = in[12];
    state[1][3] = in[13];
    state[2][3] = in[14];
    state[3][3] = in[15];
    
    //puts(" \n");
    //puts("state\n");
    //for(i=0; i<4;i++){
    //  for(j=0; j<4;j++){
    //      puts(itoh(state[j][i]));        
    //  }
    //}
    //puts(" \n");

    // Perform the necessary number of rounds. The round key is added first.
    // The last round does not perform the MixColumns step.
    AddRoundKey(state,&key[0]);
//    puts("ROUND 0 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[4]);
    //puts("ROUND 1 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[8]);
    //puts("ROUND 2 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[12]);
    //puts("ROUND 3 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[16]);
    //puts("ROUND 4 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[20]);
    //puts("ROUND 5 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[24]);
    //puts("ROUND 6 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[28]);
    //puts("ROUND 7 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[32]);
    //puts("ROUND 8 finished.\n");
    SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[36]);
    //puts("ROUND 9 finished.\n");
    if (keysize != 128) {
        SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[40]);
        //puts("ROUND 10 finished.\n");
        SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[44]);
        //puts("ROUND 11 finished.\n");
        if (keysize != 192) {
            SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[48]);
            //puts("ROUND 12 finished.\n");
            SubBytes(state); ShiftRows(state); MixColumns(state); AddRoundKey(state,&key[52]);
            //puts("ROUND 13 finished.\n");
            SubBytes(state); ShiftRows(state); AddRoundKey(state,&key[56]);
        }
        else {
            SubBytes(state); ShiftRows(state); AddRoundKey(state,&key[48]);
        }
    }
    else {
        SubBytes(state); ShiftRows(state); AddRoundKey(state,&key[40]);
    }
//    puts("ROUND Final finished.\n");
    // Copy the state to the output array.
    out[0] = state[0][0];
    out[1] = state[1][0];
    out[2] = state[2][0];
    out[3] = state[3][0];
    out[4] = state[0][1];
    out[5] = state[1][1];
    out[6] = state[2][1];
    out[7] = state[3][1];
    out[8] = state[0][2];
    out[9] = state[1][2];
    out[10] = state[2][2];
    out[11] = state[3][2];
    out[12] = state[0][3];
    out[13] = state[1][3];
    out[14] = state[2][3];
    out[15] = state[3][3];
    
    //puts(" \n");
    //puts("out\n");
    //for(i=0; i<AES_BLOCK_SIZE;i++){
    //  puts(itoh(out[i]));     
    //}
}


void aes_decrypt(const BYTE in[], BYTE out[], const WORD key[], int keysize)
{
    BYTE state[4][4];

    // Copy the input to the state.
    state[0][0] = in[0];
    state[1][0] = in[1];
    state[2][0] = in[2];
    state[3][0] = in[3];
    state[0][1] = in[4];
    state[1][1] = in[5];
    state[2][1] = in[6];
    state[3][1] = in[7];
    state[0][2] = in[8];
    state[1][2] = in[9];
    state[2][2] = in[10];
    state[3][2] = in[11];
    state[0][3] = in[12];
    state[1][3] = in[13];
    state[2][3] = in[14];
    state[3][3] = in[15];

    // Perform the necessary number of rounds. The round key is added first.
    // The last round does not perform the MixColumns step.
    if (keysize > 128) {
        if (keysize > 192) {
            AddRoundKey(state,&key[56]);
//            puts("ROUND 0 finished.\n");
            InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[52]);InvMixColumns(state);
            InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[48]);InvMixColumns(state);
        }
        else {
            AddRoundKey(state,&key[48]);
//            puts("ROUND 0 finished.\n");
        }
        InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[44]);InvMixColumns(state);
        InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[40]);InvMixColumns(state);
    }
    else {
        AddRoundKey(state,&key[40]);
//        puts("ROUND 0 finished.\n");
    }
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[36]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[32]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[28]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[24]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[20]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[16]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[12]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[8]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[4]);InvMixColumns(state);
    InvShiftRows(state);InvSubBytes(state);AddRoundKey(state,&key[0]);
//    puts("ROUND Final finished.\n");

    // Copy the state to the output array.
    out[0] = state[0][0];
    out[1] = state[1][0];
    out[2] = state[2][0];
    out[3] = state[3][0];
    out[4] = state[0][1];
    out[5] = state[1][1];
    out[6] = state[2][1];
    out[7] = state[3][1];
    out[8] = state[0][2];
    out[9] = state[1][2];
    out[10] = state[2][2];
    out[11] = state[3][2];
    out[12] = state[0][3];
    out[13] = state[1][3];
    out[14] = state[2][3];
    out[15] = state[3][3];
}



