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

#define MAX_SHAPES     13

//Estruturas
typedef struct 
{
  int processors;
  int X_size, Y_size;
  union{
    int valid;
    int occuped;
  };
  int excess;
  int used;
  int cut;
  unsigned int position;
} Shapes;

//Variáveis
Shapes shapes[MAX_SHAPES];
Shapes Secure_Zone[MAX_SHAPES];

//Funções
void init_Secure_Zone();
/*  Origem: processors.c
    Variáveis Globais:
        Secure_Zone  > processors.h
*/

int get_static_SZ();
/*  Origem: cluster_scheduler.c
    Instância: handle_new_app() > kernel_master.c
    Variáveis Globais:
        shapes  > kernel_master.c
        app_id_counter > cluster_scheduler.c
    Dependências:
*/

int create_shapes(int task_pe, int tasks_app); //processor.c - 733
/*  Origem: processors.c
    Instância: handle_new_app() > kernel_master.c
    Variáveis Globais:
    Dependências:
        create_valid_shapes()
*/

int create_valid_shapes(int PEs, int cont); //processor.c - 587
/*  Origem: processors.c
    Instância: create_shapes()
    Variáveis Globais:
        shapes  > kernel_master.c
    Dependências:
*/

void print_shapes_found(int nb_shapes);
/*  Origem: processors.c
    Instância: handle_new_app() > kernel_master.c
    Variáveis Globais:
        shapes  > kernel_master.c
*/

int search_shape(int valid_shapes);
/*  Origem: processors.c
    Instância: handle_new_app() > kernel_master.c
    Variáveis Globais:
        shapes  > kernel_master.c
    Dependências:
        search_shape_in_cluster()
        shapes_invert_order()
*/

void shapes_invert_order(Shapes shapes[], int nb_valid_shapes);
/*  Origem: processors.c
    Instância: search_shape
    Variáveis Globais:
        shapes  > kernel_master.c
*/


int search_shape_in_cluster(int X_size, int Y_size, Shapes shape[], int cont, int used_looking );
/*  Origem: processors.c
    Instância: search_shape()
    Dependências:
        shape_recog()
*/

int shape_recog(int X_size, int Y_size, int X_init, int Y_init);
/*  Origem: processors.c
    Instância: search_shape_in_cluster()
    Variáveis Globais:
        processors  > processors.c
*/

void set_Secure_Zone(int shape_index);
/*  Origem: processors.c
    Instância: handle_new_app() > kernel_master.c
    Variáveis Globais:
        Secure_Zone  > processors.h
    Dependências:
        set_SZ_migrations()
        freeze_application()
*/

int set_SZ_migrations(int SZ_index);
/*  Origem: processors.c
    Instância: set_Secure_Zone()
    Variáveis Globais:
        migration_list  > processors.h
*/

void set_RH_Address(int App_ID, int Address);
/*  Origem: applications.c
    Instância: SeekInterruptHandler > kernel_master.c
    Variáveis Globais:
        applications  > applications.c
*/

int get_AppID_with_RH_Address(int Address);
/*  Origem: applications.c
    Instância: SeekInterruptHandler > kernel_master.c
    Variáveis Globais:
        applications  > applications.c
*/

int get_Secure_Zone_index(int RH_address);
/*  Origem: processors.c
    Instância: SeekInterruptHandler > kernel_master.c
    Variáveis Globais:
        Secure_Zone[] > processors.c
*/

void unset_Secure_Zone(int RH_address); 
/*  Origem: processors.c
    Instância: SeekInterruptHandler > kernel_master.c
    Variáveis Globais:
        Secure_Zone > processors.c
*/

int PE_belong_SZ(int PE_x, int PE_y);
/*  Origem: processors.c
    Instância: map_task.c > cluster_scheduler.c
    Variáveis Globais:
        Secure_Zone > processors.c
*/