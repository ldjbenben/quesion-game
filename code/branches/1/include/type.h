#ifndef __type_h
#define __type_h

#define MAX_TEXT	1000
#define MAX_CLIENT	5000

#define TRANS_STR_LEN 254

#ifndef USERNAME_LEN
#define USERNAME_LEN 30
#endif

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



typedef struct user_s{
	char username[USERNAME_LEN];
}user_t;

typedef struct bconnection_s{
	int fd; // socket id
	struct sockaddr* addr;
	bool is_auth; // connection status
	user_t* user;
}bconnection_t;

typedef struct bresponse_s{
	//int client_context_id;
	int code; // 结果码
	char data[MAX_TEXT];
	int cursor;
}bresponse_t;

typedef struct bmessage_header_s{
	int id;
	int client_context_id;
	int len;
}bmessage_header_t;

typedef struct bmessage_s{
	bmessage_header_t header;
	char data[MAX_TEXT];
	int read_cursor;
	bconnection_t* conn;
}bmessage_t;

//typedef message_header  message_element_type;

typedef struct bmessage_node_s{
	bmessage_t data;
	struct bmessage_node_s* next;
}bmessage_node_t;

typedef struct bmessage_qpointer_s{
	bmessage_node_t* front;
	bmessage_node_t* rear;
}bmessage_qpointer_t;


#endif

