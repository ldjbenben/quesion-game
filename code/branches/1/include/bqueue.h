#ifndef __bqueue_h
#define __bqueue_h

#ifndef BQUEUE_MAX_NUM
#define BQUEUE_MAX_NUM 1000 // ��������bqueue�����
#endif

typedef int bqueue_size_t;
typedef int bqueue_id_t;

typedef struct bqueue_node_t{
	void* value;
	struct bqueue_node_t* next;
	struct bqueue_node_t* pre;
}bqueue_node;

typedef struct bqueue_t{
	bqueue_size_t capacity; // ������ʼ����
	bqueue_size_t size; // ��ǰԪ����Ŀ
	bqueue_node* header;
	bqueue_node* tail;
}bqueue;

/**
 * ����bqueue
 * ע����ǰ����ʹ��bqueue��ʱ��Ӧ�õ��ô˺����������ڴ���ͷ�
 * @return void
 */
void bqueue_destroy(void);
/**
 * ע��һ������
 * @param bqueue_size_t size �����С
 * @return bqueue_id_t ���������ʶ
 */
bqueue_id_t bqueue_register(bqueue_size_t size);
/**
 * ��ע��һ������
 * @param bqueue_id_t id �����ʶ
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