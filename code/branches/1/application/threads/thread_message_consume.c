#include "benben.h"
#include "message.h"
#include "controller.h"

extern pthread_mutex_t message_mutex;
extern pthread_cond_t message_consume_cond;

void thread_message_consume_init()
{
	
}

void thread_message_consume_destory()
{

}

void* thread_message_consume(void* arg)
{
	bmessage* pMsg;
	
	while(true)
	{
		pthread_mutex_lock(&message_mutex);
		pthread_cond_wait(&message_consume_cond, &message_mutex);
		pthread_mutex_unlock(&message_mutex);
		pMsg = message_queue_pop();

		if(pMsg != NULL)
		{
			switch(pMsg->header.id)
			{
				case 1:
					controller_user_login(pMsg);
					break;
				case 2:
					controller_user_list(pMsg);
					break;
				default:
					printf("Have not controller %d!\n", pMsg->header.id);
					break;
			}
			message_free(pMsg);
		}
	}
	
	return NULL;
}