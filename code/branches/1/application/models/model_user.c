#include "model.h"
#include "bhashmap.h"

static pthread_mutex_t user_hashmap_mutex;
static bhashmap_id_t user_hashmap_id = 0;

void model_user_init()
{
	user_hashmap_id = bhashmap_register();
	Pthread_mutex_init(&user_hashmap_mutex, NULL);
}

void model_user_destory()
{
	bhashmap_unregister(user_hashmap_id);
	pthread_mutex_destroy(&user_hashmap_mutex);
}

void model_user_set(int uid, user_t* value)
{
	bhashmap_iset(user_hashmap_id, uid, value, sizeof(user_t));
}

user_t* model_user_get(int uid)
{
	return (user_t*)bhashmap_iget(user_hashmap_id, uid);
}