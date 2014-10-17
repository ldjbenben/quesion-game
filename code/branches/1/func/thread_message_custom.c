#include "benben.h"

extern client_fds[];

fd_set rfds;

void* thread_message(void* arg)
{
	FD_ZERO(&rfds);
	maxfd = 0;

	for(i = 0; i < MAX_CLIENT; i++)
	{
		if(client_fds[i] > 0)
		{
			FD_SET(client_fds[i], &rfds);
			if(client_fds[i] > maxfd) maxfd = client_fds[i];
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
		if(FD_ISSET(client_fds[i], &rfds))
		{
			bzero(buf, MAX_TEXT+1);
			len = recv(client_fds[i], buf, MAX_TEXT, 0);
			if(len < 0)
			{
				printf("recv msg fial. the errno is %d, error info is %s.\n", errno, strerror(errno));
			}
			else if(len > 0)
			{
				pthread_mutex_lock(&g_recv_msg_queue_mutex);
				bzero(&mh, sizeof(message_header));
				bzero(&mhd, sizeof(message_data));
				mh.type = *((word*)buf);
				mh.len = *((word*)(buf+2)); // 中文注释
				memcpy(mhd.text, buf+sizeof(message_header), mh.len);
				mhd.header = mh;
				message_queue_push(&mqp, mhd);
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