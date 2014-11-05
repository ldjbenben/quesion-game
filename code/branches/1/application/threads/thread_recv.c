#include "benben.h"
#include "bmemory.h"
#include "bqueue.h"
#include "message.h"
#include "connection.h"

extern int g_client_fds[];

fd_set rfds;


static bmessage* _create_message(int connfd, char* data);

void thread_message_init()
{
	message_init();
}

void thread_message_destory()
{

}

void* thread_recv(void* arg)
{
	int maxfd = 0;
	int i;
	struct timeval tv;
	int retval;
	char buf[MAX_TEXT];
	int len = 0;
	
	thread_message_init();
	
	FD_ZERO(&rfds);
	
	while(true)
	{
		for(i = 0; i < MAX_CLIENT; i++)
		{
			if(g_client_fds[i] > 0)
			{
				FD_SET(g_client_fds[i], &rfds);
				if(g_client_fds[i] > maxfd) maxfd = g_client_fds[i];
			}
		}	
		
		tv.tv_sec = 1;
		tv.tv_usec = 0;

		if(maxfd < 1) continue;
		retval = select(maxfd+1, &rfds, NULL, NULL, &tv);

		if(retval < 0)
		{
			printf("select error, error code:%d, error message:%s\n", errno, strerror(errno));
			break;
		}
		else if(!retval)
		{
			continue;
		}
	
		for(i = 0; i < MAX_CLIENT; i++)
		{
			if(FD_ISSET(g_client_fds[i], &rfds))
			{
				bzero(buf, MAX_TEXT);
				len = recv(g_client_fds[i], buf, MAX_TEXT, 0);
				
				if(len < 0)
				{
					printf("recv msg fial. the errno is %d, error info is %s.\n", errno, strerror(errno));
				}
				else if(len > 0)
				{
					message_queue_push(_create_message(g_client_fds[i], buf));
				}	
			}
		}
	}
	
	return NULL;
}

static bmessage* _create_message(int connfd, char* data)
{
	/* 
		此处获取了conn的指针，以后的操作也会用到此指针，后期考虑下能否
		传递过去，以后的相关操作不需要重新获取.
	*/
	bconnection* conn = connection_hashmap_get(connfd);
	bmessage* msg = message_malloc();
	
	memcpy((void*)msg, data, MAX_TEXT);
	msg->header.id = ntohl(msg->header.id);
	msg->header.client_context_id = ntohl(msg->header.client_context_id);
	msg->header.len = ntohl(msg->header.len);
	msg->conn = conn;
	
	printf("%d\t%d\t%d\t\n", msg->header.id, msg->header.client_context_id, msg->header.len);
	
	return msg;
}