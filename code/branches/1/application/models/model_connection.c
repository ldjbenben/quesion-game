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
	bhashmap_iset(connection_id, connfd, value, sizeof(bconnection_t));
}

bconnection_t* connection_hashmap_get(int connfd)
{
	return (bconnection_t*)bhashmap_iget(connection_id, connfd);
}

void connection_remove(int connfd)
{
	//bconnection_t* conn = bhashmap_iget(connection_id, connfd);
	Close(connfd);
	bhashmap_iunset(connection_id, connfd);
}