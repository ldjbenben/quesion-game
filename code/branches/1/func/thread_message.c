#include "benben.h"

extern g_client_fds[];

fd_set rfds;
pthread_mutex_t g_recv_msg_queue_mutex = PTHREAD_MUTEX_INITIALIZER;
bpool_id_t lc_message_pool_id;

void thread_message_init()
{
	lc_message_pool_id = bmemory_pool_register(MAX_TEXT, 2000, 1000);
}

void thread_message_destory()
{

}

void* thread_message(void* arg)
{
	FD_ZERO(&rfds);
	maxfd = 0;

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
			bzero(buf, MAX_TEXT+1);
			len = recv(g_client_fds[i], buf, MAX_TEXT, 0);
			if(len < 0)
			{
				printf("recv msg fial. the errno is %d, error info is %s.\n", errno, strerror(errno));
			}
			else if(len > 0)
			{
				pthread_mutex_lock(&g_recv_msg_queue_mutex);
				message_queue_push(get_message(data));
				//bzero(connection_list[i].text, sizeof(connection_list));
				//memcpy(connection_list[i].text, buf+sizeof(message_header), mh.len);
				printf("message header info:\n\ttype:%d\n\tlen:%d\n", mh.type, mh.len);
				printf("message:%s, info len:%d\n", buf+6, htons(*((short*)(buf+4))));
				printf("conection text:%s\n", mhd.text+2);
				pthread_mutex_unlock(&g_recv_msg_queue_mutex);
			}	
		}
	}
	
	return NULL;
}

static bmessage* get_message(char* data)
{
	bmessage* msg = bmemory_get(lc_message_pool_id);
	memcpy(msg, data, MAX_TEXT);
	return msg;
}