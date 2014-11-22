#include "model.h"
#include "bhashmap.h"

pthread_mutex_t room_mutex;
static bhashmap_id_t lc_hashmap_id;
//static int lc_rooms[ROOM_COUNT] = {0}; 
room_t rooms[ROOM_NUM];

void model_room_init()
{
	lc_hashmap_id = bhashmap_register();
	pthread_mutex_init(&room_mutex, NULL);
}

void model_room_destroy()
{
	bhashmap_unregister(lc_hashmap_id);
	pthread_mutex_destroy(&room_mutex);
}
/*
int room_create(int master, const char* name)
{
	int id = 0;
	int i = -1;
	Pthread_mutex_lock(&room_mutex);
	for(i=0; i<ROOM_NUM; i++)
	{
		if(rooms[i].status == 0)
		{
			id = i;
			room_t room;
			bhashmap_iset(lc_hashmap_id, i, &room, sizeof(room));
			break;
		}
	}
	Pthread_mutex_unlock(&room_mutex);
	
	return id;
}
*/
room_t* room_get(int id)
{
	return NULL;
}

void room_delete(int id)
{

}