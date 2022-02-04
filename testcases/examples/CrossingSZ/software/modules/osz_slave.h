/*!\file osz.h
 * HEMPS VERSION - 8.5 - support for OSZ
 *
 * Distribution:  August 2020
 *
 * Created by: Luciano Caimi - contact: lcaimi@gmail.com
 *             Rafael Faccenda - contact: faccendarafael@gmail.com
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief This module implements functions to open and close Opaque Secure Zones
 *
 */
#include "../../include/kernel_pkg.h"

void Set_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE);
/*  Origem: seek.c
    Instância: SeekInterruptHandler > kernel_slave.c
    Variáveis Globais:
        wrapper_value > seek.c
*/

void Unset_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE);
/*  Origem: seek.c
    Instância: SeekInterruptHandler > kernel_slave.c
    Variáveis Globais:
        wrapper_value > seek.c
*/