#include "benben.h"
#include "bsocket.h"
#include "connection.h"

void controller_user_login(bmessage* pMsg)
{
	trans_str_size_t len = TRANS_STR_LEN;
	char pwd[TRANS_STR_LEN] = {0};
	int uid = 0;
	
	uid = socket_read_int(pMsg);
	socket_read_string(pMsg, pwd, &len);
	
	printf("uid:%d\tpwd:%s\n", uid, pwd);
	
	socket_write_int(pMsg, 8);
	socket_write_string(pMsg, pwd, len);
	socket_flush(pMsg);
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