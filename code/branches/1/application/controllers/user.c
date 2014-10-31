#include "benben.h"

void controller_user_login(int connfd, void* pData)
{
	printf("user login:%s\n", (char*)pData);
	//int login_id = *(int*)pData;
	//char* pwd = (char*)pData+sizeof(int);
	//int loginId = read_int(pData);
	//char* pwd = read_bytes(pData);
}

void controller_user_list(int connfd, void* pData)
{
	struct _params{
		int num
	};
	
	struct _params* params = (struct _params*)(pData);
	/*
	printf("params:%p\n", pData);
	
	int i=0;
	char* p = pData;
	for(i=0; i<MAX_TEXT; i++)
	{
		printf("%x\t", *(p+i));
	}
	*/
	
	printf("user num:%d\n", ntohl(*(int*)pData));
}