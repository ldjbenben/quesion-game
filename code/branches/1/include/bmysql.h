#ifndef __bmysql_h
#define __bmysql_h

#include "mysql.h"

MYSQL_RES* bmysql_query(const char* query);
MYSQL_RES* bmysql_query_scalar(const char* query, char** v);

int bmysql_execute(const char* query);


#endif