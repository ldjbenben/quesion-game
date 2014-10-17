#ifndef __type_h
#define __type_h

#define MAX_TEXT	1000
#define MAX_CLIENT	5000

typedef short word;
typedef int dword;
#ifndef bool
typedef char bool;
#endif

typedef struct bconnection_s{
	int fd; // socket id
	struct sockaddr_in addr;
	bool is_auth; // connection status
}bconnection;

typedef struct bmessage_header_s{
	word id;
	word type;
	word len;
}bmessage_header;

typedef struct bmessage_s{
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

