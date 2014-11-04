#include "benben.h"
#include "bsocket.h"
#include "connection.h"

void controller_user_login(bmessage* pMsg)
{

}

void controller_user_list(bmessage* pMsg)
{
/*
	struct _params{
		int num;
	};
	
	struct _params* params = (struct _params*)(pData);
*/
	socket_write_int(pMsg->conn, 8);
	socket_flush();
}