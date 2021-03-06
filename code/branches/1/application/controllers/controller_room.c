#include "benben.h"
#include "bsocket.h"
#include "model.h"

extern pthread_mutex_t room_mutex;
extern room_t rooms[ROOM_NUM];

void controller_room_enter(bmessage_t* pMsg)
{
	bresponse_t response = {0};
	char tables[ROOM_TABLE_NUM] = {0};
	int i = 0;
	int roomId = 0;
	
	Pthread_mutex_lock(&room_mutex);
	
	for(i=0; i<ROOM_TABLE_NUM; i++)
	{
		tables[i] = rooms[roomId].tables[i].status;
	}
	
	blist_node_insert(rooms[roomId].connListId, &(pMsg->conn->fd));
	
	Pthread_mutex_unlock(&room_mutex);
	
	bsocket_write_string(&response, tables, ROOM_TABLE_NUM);
	bsocket_flush(pMsg, &response);
}