#include "benben.h"
#include "bsocket.h"
#include "connection.h"
#include "bmysql.h"

void controller_user_login(bmessage* pMsg)
{
	printf("user_login\n");
	bresponse response = {0};
	trans_str_size_t len = TRANS_STR_LEN;
	char pwd[TRANS_STR_LEN] = {0};
	int uid = 0;
	char sql[200] = {0};
	char* username = NULL;
	
	uid = socket_read_int(pMsg);
	socket_read_string(pMsg, pwd, &len);
	
	snprintf(sql, 199, "select `username` from `qgame_users` where `uid`=%d and `password`=\"%s\"", uid, pwd);
	
	BMYSQL_RES* bresult = bmysql_query_scalar(sql, &username);
	printf("user login bresult->id:%d\n", bresult->id);
	if(bresult->id == 0)
	{
		printf("sleeping...\n");
		sleep(10);
	}
	if(bresult->id == 0)
	{
		printf("wake up\n");
	}
	if(username == NULL)
	{
		response.code = ERROR_USER_LOGIN_FAIL;
	}
	else
	{
		socket_write_string(&response, username, strlen(username));
		socket_write_int(&response, uid);
		socket_write_string(&response, pwd, len);
	}

	socket_flush(pMsg, &response);
	bmysql_free_result(bresult);
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