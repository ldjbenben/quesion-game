#include "model.h"
#include "bhashmap.h"

pthread_mutex_t room_mutex;
static bhashmap_id_t lc_hashmap_id;
//static int lc_halls[ROOM_COUNT] = {0}; 
hall_t halls[ROOM_NUM];

void model_room_init()
{
	lc_hashmap_id = bhashmap_register();
	pthread_mutex_init(&room_mutex, NULL);
	
	int i = 0;
	
	for(i = 0; i < ROOM_NUM; i++)
	{
		halls[i].connListId = blist_register(5000, sizeof(int));
	}
}

void model_room_destroy()
{
	bhashmap_unregister(lc_hashmap_id);
	pthread_mutex_destroy(&room_mutex);
}

void model_room_insert_user(int room_id, int conn)
{
	blist_node_insert(halls[room_id].connListId, &conn);
}

/*
int room_create(int master, const char* name)
{
	int id = 0;
	int i = -1;
	Pthread_mutex_lock(&room_mutex);
	for(i=0; i<ROOM_NUM; i++)
	{
		if(halls[i].status == 0)
		{
			id = i;
			hall_t room;
			bhashmap_iset(lc_hashmap_id, i, &room, sizeof(room));
			break;
		}
	}
	Pthread_mutex_unlock(&room_mutex);
	
	return id;
}
*/
hall_t* room_get(int id)
{
	return NULL;
}

void room_delete(int id)
{

}

void room_remove_player(int connfd, int roomId, int roomId)
{
	if(halls[roomId].rooms[roomId].status != 0)
	{
		if(halls[roomId].rooms[roomId].players[0] == connfd)
		{
			halls[roomId].rooms[roomId].players[0] = 0;
			halls[roomId].rooms[roomId].status &= 0xFC;
		}
		else if(halls[roomId].rooms[roomId].players[1] == connfd)
		{
			halls[roomId].rooms[roomId].players[1] = 0;
			halls[roomId].rooms[roomId].status &= 0xF3;
		}
	}
}

void send_to_client(void* pConn, void* lparam, void* rparam)
{
	printf("pConn:%d\n", *(int*)pConn);
	Writen(*(int*)pConn, lparam, *(int*)rparam);
}

void broadcast_to_room(int roomId, bresponse_t* response)
{
	int cursor = 0;
	char data[MAX_TEXT] = {0};
	
	response->type = 1;
	*(char*)data = response->type;
	cursor += 1;
	
	*(int*)((void*)data + cursor) = htonl(response->client_context_id);
	cursor += sizeof(int);
	
	*(int*)( (void*)data + cursor ) = htonl(0);
	cursor += sizeof(int);
	
	memcpy((void*)data + cursor, response->data, response->cursor);
	cursor += response->cursor;
	
	void* item = NULL;
	BLIST_WHILE(halls[roomId].connListId, &item);
		printf("pConn:%d\n", *(int*)item);
		Writen(*(int*)item, data, cursor);
	BLIST_WHILEEND();
	//blist_walk(halls[roomId].connListId, send_to_client, data, &cursor);
}