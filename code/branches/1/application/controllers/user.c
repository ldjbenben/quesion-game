#include "benben.h"
#include "bsocket.h"
#include "connection.h"

void controller_user_login(int connfd, void* pData)
{

}

void controller_user_list(int connfd, void* pData)
{
/*
	struct _params{
		int num;
	};
	
	struct _params* params = (struct _params*)(pData);
*/
	bconnection* conn = connection_hashmap_get(connfd);
	write_int(conn, 8);
	//Writen(connfd, conn->send_text, conn->send_cursor);
	
}