#include "bsocket.h"

void socket_write_int(bmessage* pMsg, int value)
{
	void* p = ( (void*)(pMsg->conn->send_text) ) + pMsg->conn->send_cursor;
	//printf("pMsg->connection->send_text:%p\tsend_cursor:%d\tp:%p\n", pMsg->connection->send_text, pMsg->connection->send_cursor, p);
	*((int*)p) = htonl(value);
	pMsg->conn->send_cursor += sizeof(int);
}

void socket_flush(bmessage* pMsg)
{
	*((int*)(pMsg->conn->send_text)) = pMsg->header.client_context_id;
	printf("%d\ttext:%s\tid:%d\n", pMsg->header.client_context_id, pMsg->conn->send_text, *((int*)(pMsg->conn->send_text)));
	Writen(pMsg->conn->fd, pMsg->conn->send_text, pMsg->conn->send_cursor);
}

/*
int read_int(int connfd, int value)
{
	bconnection* conn = connection_hashmap_get(connfd);
	//conn->
}
*/