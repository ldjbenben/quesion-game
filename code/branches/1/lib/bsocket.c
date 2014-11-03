#include "bsocket.h"

void write_int(bconnection* conn, int value)
{
	*((int*)((void*)conn->send_text + conn->send_cursor)) = htonl(value);
	conn->send_cursor += sizeof(int);
}

/*
int read_int(int connfd, int value)
{
	bconnection* conn = connection_hashmap_get(connfd);
	//conn->
}
*/