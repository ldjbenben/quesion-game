#include "connection.h"
#include "bhashmap.h"

pthread_mutex_t g_recv_connection_hashmap_mutex = PTHREAD_MUTEX_INITIALIZER;
bhashmap_id_t connection_id = 0;

void model_connection_init()
{
	connection_id = bhashmap_register();
}

void model_connection_destory()
{
	bhashmap_unregister(connection_id);
}

void connection_hashmap_set(int connfd, bconnection_t* value)
{
	char key[16] = {0};
	itoa(connfd, key, 10);
	key[15] = 0;
	
	bhashmap_set(connection_id, key, value, sizeof(bconnection_t));
}

bconnection_t* connection_hashmap_get(int connfd)
{
	char key[16] = {0};
	itoa(connfd, key, 10);
	key[15] = 0;

	return (bconnection_t*)bhashmap_get(connection_id, key);
}