#include "benben.h"
#include "bsocket.h"
#include "model.h"

extern pthread_mutex_t room_mutex;
extern room_t rooms[ROOM_NUM];

void controller_hall_enter(bmessage_t* pMsg)
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

void controller_hall_sitdown(bmessage_t* pMsg)
{
	int roomId = bsocket_read_int(pMsg);
	int tableId = bsocket_read_int(pMsg);
	byte pos = bsocket_read_byte(pMsg); // 0表示左边,1表示右边
	bresponse_t response = {0};
	
	bsocket_flush(pMsg, &response);
	
	Pthread_mutex_lock(&room_mutex);
	
	if(roomId < ROOM_NUM && tableId < ROOM_TABLE_NUM 
		&& (rooms[roomId].tables[tableId].status & 0x05) != 5)
	{
		bresponse_t broadcastResponse = {0};
		broadcastResponse.client_context_id = 100;
		
		if(pos == 0 && (rooms[roomId].tables[tableId].status & 0x01) == 0)
		{
			rooms[roomId].tables[tableId].status |= 0x03;
		}
		else if(pos == 1 && (rooms[roomId].tables[tableId].status & 0x04) == 0)
		{
			rooms[roomId].tables[tableId].status |= 0x0c;
		}
		
		pMsg->conn->user->roomId = roomId;
		pMsg->conn->user->tableId = tableId;
		
		bsocket_write_int(&broadcastResponse, tableId);
		bsocket_write_byte(&broadcastResponse, rooms[roomId].tables[tableId].status);
		
		broadcast_to_room(roomId, &broadcastResponse);
	}
	
	Pthread_mutex_unlock(&room_mutex);
}