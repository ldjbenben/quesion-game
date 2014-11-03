#include "benben.h"
#include "unpthread.h"
#include "bmysql.h"
#include "connection.h"

void sig_int(int signo);
void* thread_recv(void*);
void* thread_message_consume(void*);

int	g_client_fds[MAX_CLIENT];
pthread_t thread_recv_tid; 
pthread_t thread_message_consume_tid;
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
	Pthread_create(&thread_recv_tid, NULL, &thread_recv, NULL);
	Pthread_create(&thread_message_consume_tid, NULL, &thread_message_consume, NULL);
	
	Signal(SIGINT, sig_int);
	connection_hashmap_init();
	//bmysql_query("select * from qgame_users");
	
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
				break;
			}
		}
		
		if (i == MAX_CLIENT)
		{
			err_quit("%d is the maxinum of connection", MAX_CLIENT);
		}
		else
		{
			g_client_fds[i] = connfd;
			bconnection conn;
			conn.fd = connfd;
			conn.addr = cliaddr;
			conn.is_auth = false;
			connection_hashmap_set(connfd, &conn);
		}
			
		Pthread_mutex_unlock(&clifd_mutex);
	}
}

void sig_int(int signo)
{
	exit(0);
}