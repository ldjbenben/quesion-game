#include "benben.h"
#include "bsocket.h"
#include "connection.h"
#include "bmysql.h"

void controller_user_login(bmessage* pMsg)
{
	bresponse response = {0};
	trans_str_size_t len = TRANS_STR_LEN;
	char pwd[TRANS_STR_LEN] = {0};
	int uid = 0;
	char sql[200] = {0};
	char* username = NULL;
	BMYSQL_RES* bresult = NULL;
	int ret = 0;
	
	uid = socket_read_int(pMsg);
	socket_read_string(pMsg, pwd, &len);
	
	snprintf(sql, 199, "select `username` from `qgame_users` where `uid`=%d and `password`=\"%s\"", uid, pwd);
	//printf("before bmysql_query_scalar\n");
	ret = bmysql_query_scalar(sql, &username, &bresult);
	
	if(ret == 0)
	{
		//printf("user login bresult->id:%d\tpMsg:%p\n", bresult->id, pMsg);

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
	else
	{
		printf("mysql query error:%d\n", ret);
	}
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