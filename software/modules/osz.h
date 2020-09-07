
//Variáveis
extern Shapes shapes[MAX_SHAPES];
extern Shapes Secure_Zone[MAX_SHAPES];
Processor processors[MAX_CLUSTER_PEs];	//!<Processor array
Migrations migration_list[MAX_MIGRATIONS];


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

typedef struct {
	int address;						//!<Processor address in XY
	int free_pages;						//!<Number of free memory pages // FOCHI MODIFICAR
	int slack_time;						//!<Slack time (idle time), represented in percentage
	unsigned int total_slack_samples;	//!<Number of slack time samples
	int task[MAX_LOCAL_TASKS]; 			//!<Array with the ID of all task allocated in a given processor
} Processor;

typedef struct 
{
  int status;
  int actual_address;
  int actual_taskID;
  int new_address;
} Migrations;

//Funções
int get_static_SZ(); //cluster_scheduler.c
/*  Origem: handle_new_app() > kernel_master.c
    Variáveis Globais:
        shapes  > kernel_master.c
        app_id_counter > cluster_scheduler.c
    Dependências:
*/

int create_shapes(int task_pe, int tasks_app); //processor.c - 733
/*  Origem: handle_new_app() > kernel_master.c
    Variáveis Globais:
    Dependências:
        create_valid_shapes()
*/

int create_valid_shapes(int PEs, int cont); //processor.c - 587
/*  Origem: create_shapes()
    Variáveis Globais:
        shapes  > kernel_master.c
    Dependências:
*/

void print_shapes_found(int nb_shapes);
/*  Origem: handle_new_app() > kernel_master.c
    Variáveis Globais:
        shapes  > kernel_master.c
*/

int search_shape(int valid_shapes);
/*  Origem: handle_new_app() > kernel_master.c
    Variáveis Globais:
        shapes  > kernel_master.c
    Dependências:
        search_shape_in_cluster()
*/

int search_shape_in_cluster(int X_size, int Y_size, Shapes shape[], int cont, int used_looking );
/*  Origem: search_shape()
    Dependências:
        shape_recog()
*/

int shape_recog(int X_size, int Y_size, int X_init, int Y_init);
/*  Origem: search_shape_in_cluster()
    Variáveis Globais:
        processors  > processors.c
*/

void set_Secure_Zone(int shape_index);
/*  Origem: handle_new_app() > kernel_master.c
    Variáveis Globais:
        Secure_Zone  > processors.h
    Dependências:
        set_SZ_migrations()
        freeze_application()
*/

int set_SZ_migrations(int SZ_index);
/*  Origem: set_Secure_Zone()
    Variáveis Globais:
        migration_list  > processors.h
*/

void freeze_application(); // Secure API?
/*  Origem: set_Secure_Zone()
    Variáveis Globais:
        migration_list  > processors.h
*/

void print_migrating_list();
/*  Origem: handle_new_app() > kernel_master.c
    Variáveis Globais:
        migration_list  > processors.h
*/

void set_RH_Address(int App_ID, int Address){
/*  Origem: handle_new_app() > kernel_master.c
    Variáveis Globais:
        applications  > applications.c
*/