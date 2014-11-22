#ifndef __model_h
#define __model_h

#include "benben.h"

#define ROOM_NUM 100 // 房间数数量
#define ROOM_TABLE_NUM 50 // 房间桌位数量
#define TABLE_PLAYER_COUNT 2
#define ROOM_NAME_LEN 50 // maxinum of room's name length of bytes

#ifndef TABLE_COUNT
#define TABLE_COUNT 100	// maxinum of room
#endif

typedef struct game_table_s{
	char status; // 0:free; 1:waiting; 2:playing
	int num; // current player count
	int master; // room master
	int players[TABLE_PLAYER_COUNT];
	char* name[ROOM_NAME_LEN];
}game_table_t;

typedef struct room_s{
	game_table_t tables[ROOM_TABLE_NUM];
}room_t;

void model_connection_init();

void connection_hashmap_init(void);
void connection_hashmap_set(int connfd, bconnection_t* value);
bconnection_t* connection_hashmap_get(int connfd);

void message_init();
void message_destroy();
void message_queue_push(bmessage_t* pMsg);
bmessage_t* message_queue_pop();
bool message_queue_empty();
bmessage_t* message_malloc();
void message_free(bmessage_t* pMsg);

void model_table_list(char* dest);

void model_user_init();
void model_user_destory();
void model_user_set(int uid, user_t* value);
user_t* model_user_get(int uid);

#endif