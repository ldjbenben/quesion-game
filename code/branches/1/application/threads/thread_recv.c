#include "benben.h"
#include "bmemory.h"
#include "bqueue.h"
#include "message.h"

extern int g_client_fds[];

fd_set rfds;
bmemory_pool_id_t lc_message_pool_id;

static bmessage* get_message(int, char*);

void thread_message_init()
{
	if(lc_message_pool_id == 0)
	{
		lc_message_pool_id = bmemory_pool_register(MAX_TEXT, 2000, 1000);
	}
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
	message_queue_init();
	
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
					message_queue_push(get_message(g_client_fds[i], buf));
				}	
			}
		}
	}
	
	return NULL;
}

static bmessage* get_message(int connfd, char* data)
{
	bmessage* msg = bmemory_get(lc_message_pool_id, 1);
	msg->connfd = connfd;
	memcpy((void*)msg+sizeof(int), data, MAX_TEXT);
	msg->header.id = ntohs(msg->header.id);
	return msg;
}