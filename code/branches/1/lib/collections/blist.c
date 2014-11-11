#include "blist.h"
#include "bmemory.h"
#include <stdlib.h>
#include <stdio.h>

static blist_t lc_blists[BLIST_MAX_NUM] = {{0}};
static bmemory_pool_id_t lc_pool_id = 0;

static blist_t* get_blist(blist_id_t);

void blist_init()
{
	
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

blist_id_t blist_register(blist_size_t size)
{
	if(lc_pool_id == 0)
	{
		lc_pool_id = bmemory_pool_register(sizeof(blist_node_t), 2000, 1000);
	}
	
	int id;
	
	for(id=0; id<BLIST_MAX_NUM; id++)
	{
		if(lc_blists[id].maxSize == 0)
		{
			break;
		}
	}
	
	if(id == BLIST_MAX_NUM)
	{
		printf("blist max num is %d\n", BLIST_MAX_NUM);
		exit(1);
	}
	
	lc_blists[id].maxSize = 0;

	return id+1;
}

void blist_unregister(blist_id_t id)
{
	blist_t* blist = get_blist(id);
	
	if(blist == NULL)
	{
		return;
	}

	blist_node_t* node = blist->header;

	while(node != NULL)
	{
		bmemory_free(lc_pool_id, node);	
		node = node->next;
	}
	
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
	
	blist_node_t* node = (blist_node_t*)bmemory_get(lc_pool_id, 1);
	node->next = NULL;
	node->pre = NULL;
	node->value = value;
	blist->size++;
	
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
			bmemory_free(lc_pool_id, tmp); // 释放内存
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

static blist_t* get_blist(blist_id_t id)
{
	id--;
	blist_t* blist = &lc_blists[id];
	
	if(blist->maxSize == 0)
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

	printf("\n==========================================\n");
}
