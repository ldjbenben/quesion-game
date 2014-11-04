#include "benben.h"
#include "message.h"
#include "controller.h"

void* thread_message_consume(void* arg)
{
	bmessage* pMsg;
	
	while(true)
	{
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