#include "bsocket.h"


byte bsocket_read_byte(bmessage_t* pMsg)
{
	void* p = ( (void*)(pMsg->data) ) + pMsg->read_cursor;
	pMsg->read_cursor += sizeof(byte);
	return *(byte*)p;
}

int bsocket_read_int(bmessage_t* pMsg)
{
	void* p = ( (void*)(pMsg->data) ) + pMsg->read_cursor;
	pMsg->read_cursor += sizeof(int);
	return ntohl(*(int*)p);
}

char* bsocket_read_string(bmessage_t* pMsg, char* recv, trans_str_size_t* len)
{
	void* p = ( (void*)(pMsg->data) ) + pMsg->read_cursor;
	*len = ntohs(*(trans_str_size_t*)p);
	memcpy(recv, p + sizeof(trans_str_size_t), *len);
	pMsg->read_cursor += sizeof(trans_str_size_t) + *len;
	
	return recv;
}

void bsocket_write_byte(bresponse_t* response, byte value)
{
	void* p = ( (void*)(response->data) ) + response->cursor;
	*((byte*)p) = value;
	
	response->cursor += sizeof(byte);
}

void bsocket_write_int(bresponse_t* response, int value)
{
	void* p = ( (void*)(response->data) ) + response->cursor;
	*((int*)p) = htonl(value);
	
	response->cursor += sizeof(int);
}

void bsocket_write_short(bresponse_t* response, short value)
{
	void* p = ( (void*)(response->data) ) + response->cursor;
	*((short*)p) = htons(value);
	
	response->cursor += sizeof(short);
}

void bsocket_write_string(bresponse_t* response, const char* str, trans_str_size_t len)
{
	bsocket_write_short(response, len); // 写入字符长度
	
	void* p = ( (void*)(response->data) ) + response->cursor;
	memcpy(p, str, len);
	
	response->cursor += len;
}


void bsocket_flush(bmessage_t* msg, bresponse_t* response)
{
	int cursor = 0;
	char data[MAX_TEXT] = {0};
	
	*(char*)data = response->type;
	cursor += 1;
	
	*(int*)((void*)data + cursor) = htonl(msg->header.client_context_id);
	cursor += sizeof(int);
	
	*(int*)( (void*)data + cursor ) = htonl(response->code);
	cursor += sizeof(int);
	
	memcpy((void*)data + cursor, response->data, response->cursor);
	
	Writen(msg->conn->fd, data, response->cursor + cursor);
}