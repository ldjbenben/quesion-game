#include "benben.h"
#include "bsocket.h"
#include "connection.h"

void controller_user_login(bmessage* pMsg)
{
	int uid = socket_read_int();
	const char* pwd = socket_read_string();
	socket_write_int(pMsg, 8);
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