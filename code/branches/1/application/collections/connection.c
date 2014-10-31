#include "connection.h"
#include "bhashmap.h"

pthread_mutex_t g_recv_connection_hashmap_mutex = PTHREAD_MUTEX_INITIALIZER;
bhashmap_id_t connection_id = 0;

void connection_hashmap_init()
{
	if(connection_id == 0)
	{
		connection_id = bhashmap_register();
	}
}

void connection_hashmap_set(int connfd, bconnection* value)
{
	char key[12];
	//itoa(connfd, key);
	sprintf(key, "%s", connfd);
	bhashmap_set(connection_id, key, value, sizeof(bconnection));
}