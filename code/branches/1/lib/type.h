#ifndef __type_h
#define __type_h

typedef short word;
typedef int dword;
typedef char bool;

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

