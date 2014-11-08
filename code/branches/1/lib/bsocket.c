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

void socket_write_int(bresponse* response, int value)
{
	void* p = ( (void*)(response->data) ) + response->cursor;
	*((int*)p) = htonl(value);
	
	response->cursor += sizeof(int);
}

void socket_write_short(bresponse* response, short value)
{
	void* p = ( (void*)(response->data) ) + response->cursor;
	*((short*)p) = htons(value);
	
	response->cursor += sizeof(short);
}

void socket_write_string(bresponse* response, const char* str, trans_str_size_t len)
{
	socket_write_short(response, len); // 写入字符长度
	
	void* p = ( (void*)(response->data) ) + response->cursor;
	memcpy(p, str, len);
	
	response->cursor += sizeof(len);
}


void socket_flush(bmessage* msg, bresponse* response)
{
	int cursor = 0;
	char data[MAX_TEXT] = {0};
	
	*(int*)data = msg->header.client_context_id;
	cursor += sizeof(int);
	
	*(int*)( (void*)data + cursor ) = response->code;
	cursor += sizeof(int);
	
	memcpy((void*)data + cursor, response->data, response->cursor);
	
	Writen(msg->conn->fd, data, response->cursor + cursor);
}