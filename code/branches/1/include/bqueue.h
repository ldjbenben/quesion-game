#ifndef __bqueue_h
#define __bqueue_h

#ifndef BQUEUE_MAX_NUM
#define BQUEUE_MAX_NUM 1000 // 允许创建的bqueue最大数
#endif

typedef int bqueue_size_t;
typedef int bqueue_id_t;

typedef struct bqueue_node_t{
	void* value;
	struct bqueue_node_t* next;
	struct bqueue_node_t* pre;
}bqueue_node;

typedef struct bqueue_t{
	bqueue_size_t capacity; // 容器初始容量
	bqueue_size_t size; // 当前元素数目
	bqueue_node* header;
	bqueue_node* tail;
}bqueue;

/**
 * 析构bqueue
 * 注：当前不在使用bqueue的时，应该调用此函数，进行内存的释放
 * @return void
 */
void bqueue_destroy(void);
/**
 * 注册一个链表
 * @param bqueue_size_t size 链表大小
 * @return bqueue_id_t 返回链表标识
 */
bqueue_id_t bqueue_register(bqueue_size_t size);
/**
 * 反注册一个链表
 * @param bqueue_id_t id 链表标识
 * @return void
 */
void bqueue_unregister(bqueue_id_t id);

/**
 * Adds an element to the back of the queue
 */
void bqueue_node_push(bqueue_id_t id, void* value);
/**
 * Removes an element from the front of the queue
 */
void* bqueue_node_pop(bqueue_id_t id);
/**
 * Returns the first element at the front of the queue.
 */
void* bqueue_node_front(bqueue_id_t id);
/**
 * Tests if the queue is empty.
 */
bool bqueue_empty(bqueue_id_t id);
/**
 * Returns the number of elements in the queue.
 */
bqueue_size_t bqueue_size(bqueue_id_t id);
/**
 * print report
 */
void bqueue_report(void);
#endif