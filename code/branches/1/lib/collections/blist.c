#include "blist.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

static blist_t lc_blists[BLIST_MAX_NUM] = {{0}};
static bmemory_pool_id_t lc_node_pool_id = 0;

//static blist_t* get_blist(blist_id_t);

void blist_init()
{
	lc_node_pool_id = bmemory_pool_register(sizeof(blist_node_t), 3000, 1000);
}

void blist_destroy(void)
{
	int id;

	for(id=0; id<BLIST_MAX_NUM; id++)
	{
		if(lc_blists[id].maxSize != 0)
		{
			blist_unregister(id);
		}
	}
}

blist_id_t blist_register(int unitSize, blist_size_t size)
{
	bmemory_pool_id_t poolId = bmemory_pool_register(unitSize, size, 1000);
	
	int id;
	
	for(id=0; id<BLIST_MAX_NUM; id++)
	{
		if(lc_blists[id].unitSize == 0)
		{
			break;
		}
	}
	
	if(id == BLIST_MAX_NUM)
	{
		printf("blist max num is %d\n", BLIST_MAX_NUM);
		exit(1);
	}
	
	bzero(&lc_blists[id], sizeof(size_t));
	
	lc_blists[id].poolId = poolId;
	lc_blists[id].maxSize = 0;
	lc_blists[id].unitSize = unitSize;

	return id+1;
}

void blist_unregister(blist_id_t id)
{
	blist_t* blist = get_blist(id);
	
	if(blist == NULL)
	{
		return;
	}

	bmemory_pool_unregister(blist->poolId);	
	
	blist->header = blist->tail = NULL;
	blist->size = blist->maxSize = 0;
}

void blist_node_insert(blist_id_t id, void* value)
{
	blist_t* blist = get_blist(id);
	
	if(blist == NULL)
	{
		return;
	}

	blist_node_t* node = (blist_node_t*)bmemory_get(lc_node_pool_id, 1);
	
	void* pData = (blist_node_t*)bmemory_get(blist->poolId, 1);
	memcpy(pData, value, blist->unitSize);
	node->next = NULL;
	node->pre = NULL;
	node->value = pData;
	blist->size++;
	printf("blist->header:%p\n", blist->header);
	if(blist->header == NULL)
	{
		blist->header = blist->tail = node;
	}
	else
	{
		node->pre = blist->tail;
		blist->tail->next = node;
		blist->tail = node;
	}
	printf("node:%p\n", node);
}

void blist_node_remove(blist_id_t id, void* value)
{
	blist_t* blist = get_blist(id);
	
	if(blist == NULL)
	{
		return;
	}
	
	blist_node_t* node = blist->header;
	blist_node_t* tmp = NULL;
	
	while(node!=NULL)
	{
		if(node->value == value)
		{
			if(node->pre != NULL)
			{
				node->pre->next = node->next;
			}
			if(node->next != NULL)
			{
				node->next->pre = node->pre;
			}
			
			blist->size--;
			tmp = node;
			node = node->next;
			bmemory_free(blist->poolId, tmp->value);
			bmemory_free(lc_node_pool_id, tmp);
		}
		else
		{
			node = node->next;
		}
	}
}

blist_size_t blist_size(blist_id_t id)
{
	blist_t* blist = get_blist(id);
	
	if(blist == NULL)
	{
		return 0;
	}
	
	return blist->size;
}

void blist_walk(blist_id_t id, void (*func)(void*, void*, void*), void* lparam, void* rparam)
{
	blist_t* blist = get_blist(id);
	
	if(blist == NULL)
	{
		return;
	}
	
	blist_node_t* node = blist->header;
	blist_report();
	while(node != NULL)
	{
		printf("node:%p\n", node);
		(*func)(node->value, lparam, rparam);
		node = node->next;
	}
}

blist_t* get_blist(blist_id_t id)
{
	id--;
	blist_t* blist = &lc_blists[id];
	
	if(blist->unitSize == 0)
	{
		blist = NULL;
	}

	return blist;
}

void blist_report(void)
{
	int id;
	int i;
	blist_t* blist = NULL;
	blist_node_t* node = NULL;
	printf("\n\n===================数据报告=================\n\n");

	for(id=0; id<BLIST_MAX_NUM; id++)
	{
		if(lc_blists[id].maxSize == 0)
		{
			continue;
		}
	
		blist = &lc_blists[id];
		printf(">>>>>>>>>>>>>>>>>链表(%d)<<<<<<<<<<<<<<<\n", id);
		printf("节点列表：\n");
		node = blist->header;
		i = 0;

		while(node != NULL)
		{
			printf("\t%d:%p", i++, node->value);
			node = node->next;
		}
		printf("\n节点容量：%d\t已使用节点数：%d\n", blist->maxSize, blist->size);
	}

	printf("\n============================================\n");
}
