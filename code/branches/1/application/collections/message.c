#include "message.h"
#include "bqueue.h"

pthread_mutex_t g_recv_msg_queue_mutex = PTHREAD_MUTEX_INITIALIZER;
bqueue_id_t messages_qid = 0;

void message_queue_init()
{
	if(messages_qid == 0)
	{
		messages_qid = bqueue_register(1000);
	}
}

void message_queue_push(bmessage* pMsg)
{
	pthread_mutex_lock(&g_recv_msg_queue_mutex);
	bqueue_node_push(messages_qid, pMsg);
	pthread_mutex_unlock(&g_recv_msg_queue_mutex);
}

bmessage* message_queue_pop()
{
	bmessage* pMsg = NULL;
	if(messages_qid != 0)
	{
		pthread_mutex_lock(&g_recv_msg_queue_mutex);
		pMsg = (bmessage*)bqueue_node_pop(messages_qid);
		pthread_mutex_unlock(&g_recv_msg_queue_mutex);
	}
	return pMsg;
}

bool message_queue_empty()
{
	pthread_mutex_lock(&g_recv_msg_queue_mutex);
	bool ret = bqueue_empty(messages_qid);
	pthread_mutex_unlock(&g_recv_msg_queue_mutex);
	return ret;
}