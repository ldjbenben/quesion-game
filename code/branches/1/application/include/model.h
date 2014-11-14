#ifndef __model_h
#define __model_h

#include "benben.h"

#define ROOM_PLAYER_COUNT 2
#define ROOM_NAME_LEN 50 // maxinum of room's name length of bytes

#ifndef ROOM_COUNT
#define ROOM_COUNT 100	// maxinum of room
#endif

typedef struct game_room_s{
	int id;
	int num; // current player count
	int master; // room master
	int players[ROOM_PLAYER_COUNT];
	char* name[ROOM_NAME_LEN];
}game_room;



void connection_hashmap_init(void);
void connection_hashmap_set(int connfd, bconnection* value);
bconnection* connection_hashmap_get(int connfd);

void message_init();
void message_destroy();
void message_queue_push(bmessage* pMsg);
bmessage* message_queue_pop();
bool message_queue_empty();
bmessage* message_malloc();
void message_free(bmessage* pMsg);

#endif