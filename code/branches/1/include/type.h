#ifndef __type_h
#define __type_h

#define MAX_TEXT	1000
#define MAX_CLIENT	5000

#define TRANS_STR_LEN 254

#define false 0
#define true 1

#ifndef NULL
#define NULL 0
#endif

typedef short word;
typedef int dword;
#ifndef bool
typedef char bool;
#endif
typedef char byte;



typedef struct bconnection_s{
	int fd; // socket id
	struct sockaddr* addr;
	bool is_auth; // connection status
}bconnection;

typedef struct bresponse_s{
	//int client_context_id;
	int code; // 结果码
	char data[MAX_TEXT];
	int cursor;
}bresponse;

typedef struct bmessage_header_s{
	int id;
	int client_context_id;
	int len;
}bmessage_header;

typedef struct bmessage_s{
	bmessage_header header;
	char data[MAX_TEXT];
	int read_cursor;
	bconnection* conn;
}bmessage;

//typedef message_header  message_element_type;

typedef struct bmessage_node_s{
	bmessage data;
	struct bmessage_node_s* next;
}bmessage_node;

typedef struct bmessage_qpointer_s{
	bmessage_node* front;
	bmessage_node* rear;
}bmessage_qpointer;

#endif

