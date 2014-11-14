#include "model.h"
#include "bhashmap.h"

static pthread_mutex_t lc_mutex;
static bhashmap_id_t lc_hashmap_id;
static int lc_rooms[ROOM_COUNT] = {0}; 

void model_room_init()
{
	lc_hashmap_id = bhashmap_register();
	pthread_mutex_init(&lc_mutex);
}

void model_room_destroy()
{
	bhashmap_unregister(lc_hashmap_id);
	pthread_mutex_destroy(&lc_mutex);
}

int room_create(int master, const char* name)
{
	int id = 0;
	int i = -1;
	
	for(i=0; i<ROOM_COUNT; i++)
	{
		if(lc_rooms[i] == 0)
		{
			id = i;
			game_room room;
			bhashmap_iset(lc_hashmap_id, i, &room, sizeof(room));
			break;
		}
	}
	
	return id;
}

room* room_get(int id)
{

}

void room_delete(int id)
{

}