#include "bsocket.h"

int socket_read_int(bmessage* pMsg)
{
	void* p = ( (void*)(pMsg->data) ) + pMsg->read_cursor;
	pMsg->read_cursor += sizeof(int);
	return ntohl(*(int*)p);
}

char* socket_read_string(bmessage* pMsg, char* recv, trans_str_size_t* len)
{
	void* p = ( (void*)(pMsg->data) ) + pMsg->read_cursor;
	*len = ntohs(*(trans_str_size_t*)p);
	printf("str len:%d\n", *len);
	memcpy(recv, p + sizeof(trans_str_size_t), *len);
	
	pMsg->read_cursor += sizeof(trans_str_size_t) + *len;
	
	return recv;
}

void socket_write_int(bmessage* pMsg, int value)
{
	void* p = ( (void*)(pMsg->conn->send_text) ) + pMsg->conn->write_cursor;
	*((int*)p) = htonl(value);
	
	pMsg->conn->write_cursor += sizeof(int);
}

void socket_write_short(bmessage* pMsg, short value)
{
	void* p = ( (void*)(pMsg->conn->send_text) ) + pMsg->conn->write_cursor;
	*((short*)p) = htons(value);
	
	pMsg->conn->write_cursor += sizeof(short);
}

void socket_write_string(bmessage* pMsg, const char* str, trans_str_size_t len)
{
	socket_write_short(pMsg, len); // 写入字符长度
	
	void* p = ( (void*)(pMsg->conn->send_text) ) + pMsg->conn->write_cursor;
	memcpy(p, str, len);
	
	pMsg->conn->write_cursor += len;
}

void socket_flush(bmessage* pMsg)
{
	*((int*)(pMsg->conn->send_text)) = pMsg->header.client_context_id;
	Writen(pMsg->conn->fd, pMsg->conn->send_text, pMsg->conn->write_cursor);
	
	pMsg->conn->write_cursor = SENDBUF_RESERVED_SPACE;
	printf("%d\ttext:%s\tid:%d\n", pMsg->header.client_context_id, pMsg->conn->send_text, *((int*)(pMsg->conn->send_text)));
}