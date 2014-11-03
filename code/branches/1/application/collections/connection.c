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
	char key[16] = {0};
	itoa(connfd, key, 10);
	key[15] = 0;
	bhashmap_set(connection_id, key, value, sizeof(bconnection));
	bhashmap_report();
}

bconnection* connection_hashmap_get(int connfd)
{
	char key[16] = {0};
	itoa(connfd, key, 10);
	key[15] = 0;
	bhashmap_report();
	//printf("bconnection*:%d\tkey:%s\t%p\n", sizeof(bconnection*), key,(bconnection*)bhashmap_get(connection_id, key));
	bconnection* p = (bconnection*)bhashmap_get(connection_id, key);
	//void* a = p;
	return p;
	//return  (bconnection*)bhashmap_get(connection_id, key);
	//printf("bconnection*:%d\tkey:%s\t%p\n", sizeof(bconnection*), key, pb);
	//return pb;
}