#ifndef __bmemory_h
#define __bmemory_h

#define BPOOL_MAX_NUM 100 

typedef int bmemory_size_t; // 内存单位数量大小类型
typedef short bmemory_unit_size_t; // 内存单位大小类型
typedef int bmemory_pool_id_t; // 内存池标识类型


typedef struct bmemory_units_t{
	void* pData; // 指向实际内存数据地址
	bmemory_size_t size; // 连续的内存单位数量
	struct bmemory_units_t* pPre; // 指向前一个内存单位
	struct bmemory_units_t* pNext; // 指向下一个内存单位
}bmemory_units;

typedef struct bmemory_block_t{
	void* pMemory; // 事个内存块所占的内存开头地址, 返回给系统时用到(free(pMemory))
	void* pData; // 指向实际保存数据内存数据地址
	bmemory_size_t size; // 内存单元数量
	bmemory_units* pUnitsHeader; // 内存单元头地址
	bmemory_units* pFreeHeader; // 空闲内存链表头地址
	bmemory_units* pUsedHeader; // 已使用内存链表头地址
	//bmemory_units* pUsedTail;	// 已使用内存链表尾地址
	struct bmemory_block_t* pNext; // 指向下一个内存块
}bmemory_block;

typedef struct bmemory_pool_t{
	bmemory_unit_size_t nUnitSize; // 内存单位大小
	bmemory_size_t nUnitCount; // 初始内存块单位数量
	bmemory_size_t nStep; // 步长，需要申请新的内存块时，包含的内存单位数量
	bmemory_block* pBlockHeader; // 内存块链表头
	bmemory_block* pBlockTail; // 内存块链表尾
}bmemory_pool;

// 内存湖数据结构
typedef struct bmemory_lake_t{
	bmemory_pool* pPoolHeader; // 内存池链表头
}bmemory_lake;


// 操作方法

/**
 * 内存湖初始化
 * @return void
 */
void bmemory_lake_init(void);
/**
 * 析构内存湖
 * @return void
 */
void bmemory_lake_destroy(void);
/**
 * 返注册内存池
 * 程序会释放掉此内存池所占用的内存空间
 * @param bmemory_pool_id_t id 内存池标识
 * @return void
 */
void bmemory_pool_unregister(bmemory_pool_id_t id);
/**
 * 注册一个内存池
 * @param bmemory_unit_size_t unitSize 内存单位大小
 * @param bmemory_size_t num 内存块分配的单位数量
 * @param bmemory_size_t step 步长，需要申请新的内存块时，包含的内存单位数量
 * @return bmemory_pool_id_t 内存池标识
 */
bmemory_pool_id_t bmemory_pool_register(bmemory_unit_size_t unitSize, bmemory_size_t num, bmemory_size_t step);
/**
 * 获取内存
 * @param bmemory_pool_id_t id 内存池标识
 * @param bmemory_size_t num 内存块分配的单位数量
 * @return void* 内存地址
 */
void* bmemory_get(bmemory_pool_id_t id, bmemory_size_t num);

/**
 * 释放内存
 * 注：虽然调用过此函数后，程序并不会真正立刻释放内存给系统，外部程序
 * 绝不应该利用这一特性在调用完此函数后某种情况下为了方便继续使用已经
 * 释放的内存地址。这有背程序编码逻辑问题, 随着代码的更新变动也不能保
 * 证以后在多线程的情况下会不会有可能此地址值已经变得不可用。
 * @param bmemory_pool_id_t id 内存池标识
 * @param void* data 内存地址
 * @return void
 */
void bmemory_free(bmemory_pool_id_t id, void* data);
/**
 * 打印出内存使用报表
 */
void bmemory_report(void);

#endif