#include "message.h"
#include "bmemory.h"
#include "bqueue.h"

static pthread_mutex_t g_recv_msg_queue_mutex = PTHREAD_MUTEX_INITIALIZER;
static bmemory_pool_id_t lc_message_pool_id = 0;
static bqueue_id_t lc_messages_qid = 0;

static bool init = false;

void message_init()
{
	if(!init)
	{
		lc_message_pool_id = bmemory_pool_register(MAX_TEXT, 2000, 1000);
		lc_messages_qid = bqueue_register(1000);
		init = true;
	}
}

/*
void message_queue_init()
{
	if(lc_messages_qid == 0)
	{
		lc_messages_qid = bqueue_register(1000);
	}
}
*/

void message_queue_push(bmessage* pMsg)
{
	pthread_mutex_lock(&g_recv_msg_queue_mutex);
	bqueue_node_push(lc_messages_qid, pMsg);
	pthread_mutex_unlock(&g_recv_msg_queue_mutex);
}

bmessage* message_queue_pop()
{
	bmessage* pMsg = NULL;
	if(lc_messages_qid != 0)
	{
		pthread_mutex_lock(&g_recv_msg_queue_mutex);
		pMsg = (bmessage*)bqueue_node_pop(lc_messages_qid);
		pthread_mutex_unlock(&g_recv_msg_queue_mutex);
	}
	return pMsg;
}

bool message_queue_empty()
{
	pthread_mutex_lock(&g_recv_msg_queue_mutex);
	bool ret = bqueue_empty(lc_messages_qid);
	pthread_mutex_unlock(&g_recv_msg_queue_mutex);
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

