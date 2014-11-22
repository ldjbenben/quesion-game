#include "benben.h"
#include "message.h"
#include "controller.h"

extern pthread_mutex_t message_mutex;
extern pthread_cond_t message_consume_cond;

#define THREAD_MESSAGE_CONSUME_COUNT 10 // 线程数量

static pthread_t lc_threads[THREAD_MESSAGE_CONSUME_COUNT];
static void* thread_message_consume(void* arg);


void threadpool_message_consume_init()
{
	int i = 0;
	
	for(i=0; i<THREAD_MESSAGE_CONSUME_COUNT; i++)
	{
		Pthread_create(&lc_threads[i], NULL, &thread_message_consume, NULL);
	}
}

void thread_message_consume_destory()
{

}

static void* thread_message_consume(void* arg)
{
	bmessage_t* pMsg;
	
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
				case 100:
					controller_room_tables(pMsg);
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