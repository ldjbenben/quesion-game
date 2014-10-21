#include "benben.h"
#include "bqueue.h"
#include "bmemory.h"
#include <stdlib.h>
#include <stdio.h>

bqueue lc_bqueues[BQUEUE_MAX_NUM] = {{0}};
bmemory_pool_id_t lc_bqueue_pool_id = 0;

static bqueue* get_bqueue(bqueue_id_t);

void bqueue_init()
{
	
}

void bqueue_destroy(void)
{
	int id;

	for(id=0; id<BQUEUE_MAX_NUM; id++)
	{
		if(lc_bqueues[id].capacity != 0)
		{
			bqueue_unregister(id);
		}
	}
}

bqueue_id_t bqueue_register(bqueue_size_t size)
{
	if(lc_bqueue_pool_id == 0)
	{
		lc_bqueue_pool_id = bmemory_pool_register(sizeof(bqueue_node), size, 1000);
	}
	int id;
	
	for(id=0; id<BQUEUE_MAX_NUM; id++)
	{
		if(lc_bqueues[id].capacity == 0)
		{
			break;
		}
	}
	
	if(id == BQUEUE_MAX_NUM)
	{
		printf("bqueue max num is %d\n", BQUEUE_MAX_NUM);
		exit(1);
	}
	
	lc_bqueues[id].capacity = size;
	return id+1;
}

void bqueue_unregister(bqueue_id_t id)
{
	bqueue* bqueue = get_bqueue(id);
	
	if(bqueue == NULL)
	{
		return;
	}

	bqueue_node* node = bqueue->header;

	while(node != NULL)
	{
		bmemory_free(lc_bqueue_pool_id, node);	
		node = node->next;
	}
	
	bqueue->header = bqueue->tail = NULL;
	bqueue->size = bqueue->capacity = 0;
}

void bqueue_node_push(bqueue_id_t id, void* value)
{
	bqueue* bqueue = get_bqueue(id);
	
	if(bqueue == NULL)
	{
		return;
	}
	
	bqueue_node* node = NULL;
	
	if(bqueue->size == bqueue->capacity || bqueue->size == 0)
	{
		node = (bqueue_node*)bmemory_get(lc_bqueue_pool_id, 1);
	}
	else
	{
		node = bqueue->header + sizeof(bqueue_node) * (bqueue->size % bqueue->capacity);
	}
	
	node->pre = bqueue->tail;
	node->next = NULL;
	node->value = value;
	bqueue->size++;
	
	if(bqueue->header == NULL)
	{
		bqueue->header = bqueue->tail = node;
	}
	else
	{
		node->pre = bqueue->tail;
		bqueue->tail->next = node;
		bqueue->tail = node;
	}
}

void* bqueue_node_pop(bqueue_id_t id)
{
	bqueue* bqueue = get_bqueue(id);
	
	if(bqueue == NULL)
	{
		return NULL;
	}
	
	bqueue_node* node = bqueue->header;
	
	
	if(bqueue->size == 0)
	{
		return NULL;
	}
	else if(node->next == NULL)
	{
		bqueue->tail = bqueue->header = NULL;
	}
	else
	{
		bqueue->header = node->next;
		node->next->pre = NULL;
	}
	
	bqueue->size--;
	
	return node->value;
}

void* bqueue_node_front(bqueue_id_t id)
{
	bqueue* bqueue = get_bqueue(id);
	
	if(bqueue == NULL)
	{
		return NULL;
	}
	
	return bqueue->header;
}

bqueue_size_t bqueue_size(bqueue_id_t id)
{
	bqueue* bqueue = get_bqueue(id);
	
	if(bqueue == NULL)
	{
		return 0;
	}
	
	return bqueue->size;
}

bool bqueue_empty(bqueue_id_t id)
{
	bqueue* bqueue = get_bqueue(id);
	
	if(bqueue == NULL)
	{
		return true;
	}
	else
	{
		return bqueue->size == 0;
	}
}

static bqueue* get_bqueue(bqueue_id_t id)
{
	id--;
	bqueue* bqueue = &lc_bqueues[id];
	
	if(bqueue->capacity == 0)
	{
		bqueue = NULL;
	}

	return bqueue;
}

void bqueue_report(void)
{
	int id;
	int i;
	bqueue* bqueue = NULL;
	bqueue_node* node = NULL;
	printf("\n\n===================数据报告=================\n\n");

	for(id=0; id<BQUEUE_MAX_NUM; id++)
	{
		if(lc_bqueues[id].capacity == 0)
		{
			continue;
		}
	
		bqueue = &lc_bqueues[id];
		printf(">>>>>>>>>>>>>>>>>链表(%d)<<<<<<<<<<<<<<<\n", id);
		printf("节点列表：\n");
		node = bqueue->header;
		i = 0;

		while(node != NULL)
		{
			printf("\t%d:%p", i++, node->value);
			node = node->next;
		}
		printf("\n节点容量：%d\t已使用节点数：%d\n", bqueue->capacity, bqueue->size);
	}

	printf("\n==========================================\n");
}
