#include "bsocket.h"

void socket_write_int(bconnection* conn, int value)
{
	void* p = ( (void*)(conn->send_text) ) + conn->send_cursor;
	printf("conn->send_text:%p\tsend_cursor:%d\tp:%p\n", conn->send_text, conn->send_cursor, p);
	*((int*)p) = htonl(value);
	conn->send_cursor += sizeof(int);
}

void socket_flush(bconnection* conn)
{
	Writen(conn->fd, conn->send_text, conn->send_cursor);
}

/*
int read_int(int connfd, int value)
{
	bconnection* conn = connection_hashmap_get(connfd);
	//conn->
}
*/