#include "benben.h"

void controller_user_login(int connfd, void* pData)
{
	printf("user login:%s\n", (char*)pData);
}
