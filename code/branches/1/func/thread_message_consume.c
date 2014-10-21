#include "benben.h"
#include "message.h"
#include "controller.h"

void* thread_message_consume(void* arg)
{
	bmessage* pMsg;
	void* pData;
	
	while(true)
	{
		pMsg = message_queue_pop();
		if(pMsg != NULL)
		{
			pData = pMsg->data;
			int i=0;
			char* p = pData;
			for(i=0; i<MAX_TEXT; i++)
			{
				if(*(p+i) == 0) break;
				printf("%x\t", *(p+i));
			}
			switch(pMsg->header.id)
			{
				case 1:
					controller_user_login(pData);
				break;
				default:
					printf("Have not controller %d!\n", pMsg->header.id);
				break;
			}
		}
	}
	
	return NULL;
}