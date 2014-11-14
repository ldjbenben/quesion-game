#ifndef __bmysql_h
#define __bmysql_h

#include "mysql.h"

#ifndef DB_CONNECTOR_NUM
#define DB_CONNECTOR_NUM 2
#endif

typedef struct bmysql_connector_t{
	char status; // 连接状态，0表示空闲，1表示被占用, 2表示连接句柄有异常也不使用
	MYSQL mysql;
}bmysql_connector;


typedef struct BMYSQL_RES_T{
	MYSQL* mysql;
	MYSQL_RES* result;
	int id;
}BMYSQL_RES;

void bmysql_init();
void bmysql_destroy();
void bmysql_free_result(BMYSQL_RES* bresult);

int bmysql_query(const char* query, BMYSQL_RES** bresult);
int bmysql_query_scalar(const char* query, char** v, BMYSQL_RES** bresult);
int bmysql_execute(const char* query);


#endif