#include "benben.h"
#include "bsocket.h"
#include "connection.h"
#include "bmysql.h"

void controller_user_login(bmessage* pMsg)
{

	bresponse response = {0};
	socket_write_int(&response, 3);
	socket_flush(pMsg, &response);

/*
	trans_str_size_t len = TRANS_STR_LEN;
	char pwd[TRANS_STR_LEN] = {0};
	int uid = 0;
	char sql[1000] = {0};
	char* username = NULL;
	///char username[50] = {0};
	
	uid = socket_read_int(pMsg);
	socket_read_string(pMsg, pwd, &len);
	
	snprintf(sql, 9999, "select `username` from `qgame_users` where `uid`=%d and `password`=\"%s\"", uid, pwd);
	
	MYSQL_RES* result = bmysql_query_scalar(sql, &username);
	
	if(username == NULL)
	{
		
	}
	socket_write_string(pMsg, username, strlen(username));
	
	mysql_free_result(result);
	
	
	//bmysql_execute("insert qgame_users(`username`,`password`)values(\"ldj\",\"09cca18a30bc34727b0254943811239a\")");
	
	socket_write_int(pMsg, uid);
	socket_write_string(pMsg, pwd, len);
	socket_flush(pMsg);
	*/
}

void controller_user_list(bmessage* pMsg)
{
/*
	struct _params{
		int num;
	};
	
	struct _params* params = (struct _params*)(pData);
*/
	
}