#ifndef __model_h
#define __model_h

#include "benben.h"
#include "blist.h"

#define ROOM_NUM 10 // 房间数数量
#ifndef ROOM_TABLE_NUM
#define ROOM_TABLE_NUM 50 // 房间桌位数量
#endif
#define TABLE_PLAYER_COUNT 2
#define ROOM_NAME_LEN 50 // maxinum of room's name length of bytes


typedef struct game_table_s{
/*  
	只用到了低4位
	第1位表示坐位1是否有人
	第2位表示性别
	第3位表示坐位2是否有人
	第4位表示性别
*/
	char status;
	int num; // current player count
	int master; // room master
	int players[TABLE_PLAYER_COUNT];
	char* name[ROOM_NAME_LEN];
}game_table_t;

typedef struct room_s{
	game_table_t tables[ROOM_TABLE_NUM];
	blist_id_t connListId;
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

void model_room_init();
void broadcast_to_room(int roomId, bresponse_t* response);

#endif