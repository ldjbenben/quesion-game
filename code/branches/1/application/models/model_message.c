#include "message.h"
#include "bmemory.h"
#include "bqueue.h"

static bmemory_pool_id_t lc_message_pool_id = 0;
static bqueue_id_t lc_messages_qid = 0;
static bool lc_init = false;
pthread_mutex_t message_mutex;
pthread_cond_t message_consume_cond;

void message_init()
{
	if(!lc_init)
	{
		pthread_mutex_init(&message_mutex, NULL);
		pthread_cond_init(&message_consume_cond, NULL);
		lc_message_pool_id = bmemory_pool_register(sizeof(bmessage), 2000, 1000);
		lc_messages_qid = bqueue_register(1000);
		lc_init = true;
	}
}

void message_destroy()
{
	if(lc_init)
	{
		pthread_mutex_destroy(&message_mutex);
		pthread_cond_destroy(&message_consume_cond);
	}
}

void message_queue_push(bmessage* pMsg)
{
	pthread_mutex_lock(&message_mutex);
	bqueue_node_push(lc_messages_qid, pMsg);
	pthread_mutex_unlock(&message_mutex);
	pthread_cond_signal(&message_consume_cond);
}

bmessage* message_queue_pop()
{
	bmessage* pMsg = NULL;
	if(lc_messages_qid != 0)
	{
		pthread_mutex_lock(&message_mutex);
		pMsg = (bmessage*)bqueue_node_pop(lc_messages_qid);
		pthread_mutex_unlock(&message_mutex);
	}
	return pMsg;
}

bool message_queue_empty()
{
	pthread_mutex_lock(&message_mutex);
	bool ret = bqueue_empty(lc_messages_qid);
	pthread_mutex_unlock(&message_mutex);
	return ret;
}

bmessage* message_malloc()
{
	return (bmessage*)bmemory_get(lc_message_pool_id, 1);
}

void message_free(bmessage* pMsg)
{
	bmemory_free(lc_message_pool_id, pMsg);
}

