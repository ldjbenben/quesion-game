#include "message.h"
#include "bqueue.h"

pthread_mutex_t g_recv_msg_queue_mutex = PTHREAD_MUTEX_INITIALIZER;
bqueue_id_t messages_qid;

void message_queue_init()
{
	bqueue_init();
	messages_qid = bqueue_register(1000);
}

void message_queue_push(bmessage* pMsg)
{
	pthread_mutex_lock(&g_recv_msg_queue_mutex);
	bqueue_node_push(messages_qid, pMsg);
	pthread_mutex_unlock(&g_recv_msg_queue_mutex);
}

bmessage* message_queue_pop()
{
	pthread_mutex_lock(&g_recv_msg_queue_mutex);
	bmessage* pMsg = (bmessage*)bqueue_node_pop(messages_qid);
	pthread_mutex_unlock(&g_recv_msg_queue_mutex);
	return pMsg;
}