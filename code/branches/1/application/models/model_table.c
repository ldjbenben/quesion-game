#include "model.h"
#include "bhashmap.h"

static pthread_mutex_t lc_mutex_tables;
static bhashmap_id_t lc_hashmap_id;
static game_table_t lc_tables[TABLE_COUNT] = {{0}}; 

void model_table_init()
{
	lc_hashmap_id = bhashmap_register();
	Pthread_mutex_init(&lc_mutex_tables, NULL);
}

void model_table_destroy()
{
	bhashmap_unregister(lc_hashmap_id);
	pthread_mutex_destroy(&lc_mutex_tables);
}

int table_create(int master, const char* name)
{
	int id = 0;
	int i = -1;
	
	for(i=0; i<TABLE_COUNT; i++)
	{
		if(lc_tables[i].status == 0)
		{
			id = i;
			game_table_t table;
			bhashmap_iset(lc_hashmap_id, i, &table, sizeof(table));
			break;
		}
	}
	
	return id;
}

game_table_t* table_get(int id)
{
	return NULL;
}

void table_delete(int id)
{

}