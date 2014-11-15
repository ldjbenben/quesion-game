#include "model.h"
#include "bhashmap.h"

static pthread_mutex_t lc_mutex_tables;
static bhashmap_id_t lc_hashmap_id;
static game_table_t lc_tables[TABLE_COUNT] = {0}; 

void model_table_init()
{
	lc_hashmap_id = bhashmap_register();
	Pthread_mutex_init(&lc_mutex_tables);
}

void model_table_destroy()
{
	bhashmap_unregister(lc_hashmap_id);
	Pthread_mutex_destroy(&lc_mutex_tables);
}

int table_create(int master, const char* name)
{
	int id = 0;
	int i = -1;
	
	for(i=0; i<TABLE_COUNT; i++)
	{
		if(lc_tables[i] == 0)
		{
			id = i;
			game_table table;
			bhashmap_iset(lc_hashmap_id, i, &table, sizeof(table));
			break;
		}
	}
	
	return id;
}

void model_table_list(char* dest)
{
	Pthread_mutex_lock(&lc_mutex_tables);
	
	for(i=0; i<TABLE_COUNT; i++)
	{
		dest[i] = lc_mutex_tables[i].status;
	}
	
	Pthread_mutex_unlock(&lc_mutex_tables);
}

table_t* table_get(int id)
{

}

void table_delete(int id)
{

}