#ifndef __type_h
#define __type_h

#define MAX_TEXT	1000
#define MAX_CLIENT	5000

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
	char recv_text[MAX_TEXT];
	int recv_cursor;
	char send_text[MAX_TEXT];
	int send_cursor;
}bconnection;

typedef struct bmessage_header_s{
	int id;
	int type;
	int len;
}bmessage_header;

typedef struct bmessage_s{
	int connfd;
	bmessage_header header;
	char data[MAX_TEXT];
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

