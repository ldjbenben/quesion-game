#include "benben.h"
#include "unpthread.h"

void sig_int(int signo);

int	g_client_fds[MAX_CLIENT];
pthread_t thread_message_tid; 
pthread_mutex_t clifd_mutex = PTHREAD_MUTEX_INITIALIZER;

int main(int argc, char** argv)
{
	int listenfd, connfd;
	socklen_t addrlen, clilen;
	struct sockaddr* cliaddr = NULL;
	
	if(argc == 2)
	{
		listenfd = Tcp_listen(NULL, argv[1], &addrlen);
	}
	else if(argc == 3)
	{
		listenfd = Tcp_listen(argv[1], argv[2], &addrlen);
	}
	
	// 创建message线程
	Pthread_create(&thread_message_tid, NULL, &thread_message, NULL);
	
	Signal(SIGINT, sig_int);
	
	int i=0;

	while(true)
	{
		clilen = addrlen;
		connfd = Accept(listenfd, cliaddr, &clilen);

		Pthread_mutex_lock(&clifd_mutex);
		
		for(i=0; i<MAX_CLIENT; i++)
		{
			if(g_client_fds[i] == 0)
			{
				g_client_fds[i] = connfd;
			}
		}
		
		if (i == MAX_CLIENT)
		{
			err_quit("%d is the maxinum of connection", MAX_CLIENT);
		}
		else
		{
			g_client_fds[i] = connfd;
		}
			
		Pthread_mutex_unlock(&clifd_mutex);
	}
}

void sig_int(int signo)
{
	exit(0);
}