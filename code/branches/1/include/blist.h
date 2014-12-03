#ifndef __blist_h
#define __blist_h

#include "bmemory.h"

#define BLIST_MAX_NUM 1000 // 允许创建的BLIST最大数

#define BLIST_WHILE(id, item) \
	blist_t* blist = get_blist(id);\
	\
	blist_node_t* node = blist->header;\
	blist_report();\
	while(node != NULL)\
	{\
		*item = node->value;
#define BLIST_WHILEEND() \
	node = node->next;\
	}

typedef int blist_size_t;
typedef int blist_id_t;

typedef struct _blist_node_t{
	void* value;
	struct _blist_node_t* pre;
	struct _blist_node_t* next;
}blist_node_t;

typedef struct _blist_t{
	bmemory_pool_id_t poolId;
	blist_size_t maxSize;
	blist_size_t size;
	int unitSize;
	blist_node_t* header;
	blist_node_t* tail;
}blist_t;

/**
 * blist初始化函数
 * 在使用blist函数前，应该先调用此函数
 * @return void
 */
void blist_init(void);
/**
 * 析构blist
 * 注：当前不在使用blist的时，应该调用此函数，进行内存的释放
 * @return void
 */
void blist_destroy(void);
/**
 * 注册一个链表
 * @param blist_size_t size 链表初始容量大小
 * @param int unitSize 链表项大小
 * @return blist_id_t 返回链表标识
 */
blist_id_t blist_register(int unitSize, blist_size_t size);
/**
 * 反注册一个链表
 * @param blist_id_t id 链表标识
 * @return void
 */
void blist_unregister(blist_id_t id);
blist_t* get_blist(blist_id_t id);
/**
 * 往列表中插入一条数据
 * @param blist_id_t id 链表标识
 * @param void* value 值
 * @return void
 */
void blist_node_insert(blist_id_t id, void* value);
/**
 * 从链表中移除指定值的全部记录
 * @param blist_id_t id 链表标识
 * @param void* value 要移除的值
 * @return void
 */
void blist_node_remove(blist_id_t id, void* value);
/**
 * 获取链表当前记录数
 */
blist_size_t blist_size(blist_id_t id);
/**
 * 对列表中的每一个成员应用用户函数
 * @param blist_id_t id 链表标识
 * @param func 用户函数指针
 * @return void 
 */
void blist_walk(blist_id_t id, void (*func)(void*, void*, void*), void*, void*);
/**
 * 打印报告
 */
void blist_report(void);


#endif