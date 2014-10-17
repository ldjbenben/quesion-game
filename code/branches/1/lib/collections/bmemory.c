#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "bmemory.h"

bmemory_pool lc_pools[BPOOL_MAX_NUM] = {{0}}; // 保存内存池集

static void bmemory_alloc_block(bmemory_pool*);

/**
 * 内存池是否存在
 * @param bmemory_pool_id_t id 内存池标识
 * @return bool
 */
static bmemory_pool* get_bmemory_pool(bmemory_pool_id_t id)
{
	id--;
	bmemory_pool* pPool = &lc_pools[id];
	
	if(pPool->nUnitSize == 0)
	{
		pPool = NULL;
	}

	return pPool;
}

/**
 * 注册一个内存池
 * @param bmemory_unit_size_t unitSize 内存单位大小
 * @param bmemory_size_t num 内存块分配的单位数量
 * @param bmemory_size_t step 步长，需要申请新的内存块时，包含的内存单位数量
 * @return bmemory_pool_id_t 内存池标识
 */
bmemory_pool_id_t bmemory_pool_register(bmemory_unit_size_t unitSize, bmemory_size_t num, bmemory_size_t step)
{
	int id;
	
	for(id=0; id<BPOOL_MAX_NUM; id++)
	{
		if(lc_pools[id].nUnitSize == 0)
		{
			break;
		}
	}
	
	// 内存池数量是否已经饱和
	if(id == BPOOL_MAX_NUM)
	{
		printf("bmemory max num is %d\n", BPOOL_MAX_NUM);
		exit(1);
	}
	
	lc_pools[id].nUnitSize = unitSize;
	lc_pools[id].nUnitCount = num;
	lc_pools[id].nStep = step;
	lc_pools[id].pBlockHeader = NULL;
	lc_pools[id].pBlockTail = NULL;
	
	return id+1;
}

static void* bmemory_find(bmemory_pool* pPool, bmemory_size_t num)
{	
	// 查找空闲内存单元
	bmemory_block* block = pPool->pBlockHeader;
	bmemory_units* units = NULL;
	bmemory_units* tmp = NULL;
	void* data = NULL;
	bool find = false;

	while(block != NULL && !find)
	{
		units = block->pFreeHeader;
	
		while(units != NULL)
		{
			if(units->size >= num) // 如果找到了足够大的空间
			{
				data = units->pData;
				// 挂载进已使用内存单元链表, 并空闲链表中移出
				if(units->size == num) // 此空闲块被全部使用
				{
					// 空闲链表中移出
					if(units->pPre == NULL && units->pNext == NULL)
					{
						block->pFreeHeader = NULL;
					}
					else
					{
						if(units->pPre != NULL)
						{
							units->pPre->pNext = units->pNext;
						}
						if(units->pNext != NULL)
						{
							units->pNext->pPre = units->pPre;
						}
					}
					
					if(units == block->pFreeHeader)
					{
						block->pFreeHeader = units->pNext;
					}
				}
				else
				{
					// 调整空闲链表
					tmp = units + num;
					tmp->size = units->size - num;
					tmp->pPre = units->pPre;
					tmp->pNext = units->pNext;
					
					if(units->pPre == NULL && units->pNext == NULL)
					{
						block->pFreeHeader = tmp;
					}
					else
					{
						if(units->pPre != NULL)
						{
							units->pPre->pNext = tmp;
						}
						if(units->pNext != NULL)
						{
							units->pNext->pPre = tmp;
						}
					}
					
					if(units == block->pFreeHeader)
					{
						block->pFreeHeader = tmp;
					}
				}

				// 挂载进已使用内存单元链表
				units->size = num;
				if(block->pUsedHeader == NULL)
				{
					block->pUsedHeader = units;
					units->pNext = units->pPre = NULL;
				}
				else
				{
					block->pUsedHeader->pPre = units;
					units->pNext = block->pUsedHeader;
					units->pPre = NULL;
					block->pUsedHeader = units;
				}
				find = true;
				break;
			}
			else
			{
				units = units->pNext;
			}
		}
		block = block->pNext;
	}
	
	return data;
}

/**
 * 获取内存
 * @param bmemory_pool_id_t id 内存池标识
 * @param bmemory_size_t num 内存块分配的单位数量
 * @return void* 内存地址
 */
void* bmemory_get(bmemory_pool_id_t id, bmemory_size_t num)
{
	bmemory_pool* pPool = get_bmemory_pool(id);
	
	// 内存池是否存在
	if(pPool == NULL)
	{
		exit(1);
	}
	
	void* data = bmemory_find(pPool, num);
	
	if(data == NULL)
	{
		bmemory_alloc_block(pPool);
		data = bmemory_find(pPool, num);
	}
	
	return data;
}

/**
 * 申请内存块
 * @param bmemory_pool* pPool 内存池描述结构
 * @return void
 */
static void bmemory_alloc_block(bmemory_pool* pPool)
{
	bmemory_size_t size = 0;
	
	if(pPool->pBlockHeader == NULL)
	{
		size = pPool->nUnitCount;
	}
	else
	{
		size = pPool->nStep;
	}
	
	// 追加上相关的描述数据需要的空间
	size_t total = ( sizeof(bmemory_units) + pPool->nUnitSize ) * size + sizeof(bmemory_block);
	
	void* p = malloc(total);
	
	if(NULL == p)
	{
		// 暂不做处理
		printf("bmemory_alloc_block failed!\n");
		exit(10);
	}
	
	void* pData = p + sizeof(bmemory_block) + sizeof(bmemory_units)*size;
	bmemory_block* pBlock= (bmemory_block*)p;
	bmemory_units* pUnitsHeader = p + sizeof(bmemory_block);
	
	pBlock->pMemory = p;
	pBlock->pData = pData;
	pBlock->size = size;
	pBlock->pUnitsHeader = pUnitsHeader;
	pBlock->pFreeHeader = pUnitsHeader;
	pBlock->pUsedHeader = NULL;
	pBlock->pNext = NULL;
	
	// 挂载内存块
	if(pPool->pBlockHeader == NULL)
	{
		pPool->pBlockHeader = pBlock;
		pPool->pBlockTail = pBlock;
	}
	else
	{
		pPool->pBlockTail->pNext = pBlock;
		pPool->pBlockTail = pBlock;
	}
	
	// 挂载内存单元
	bmemory_units* pTmp = pUnitsHeader;
	pTmp->size = size;
	pTmp->pData = pData;
	pTmp->pPre = NULL;
	pTmp->pNext = NULL;
	
	int i;
	for(i=1; i<size; i++) // 此处求地址值时，刻意采用了加法的形式，因为乘法效率上要比加法低
	{
		pTmp = pTmp + 1;
		pTmp->pNext = NULL;
		pTmp->pPre = NULL;
		pTmp->pData = (pTmp-1)->pData + pPool->nUnitSize;
	}
}

void bmemory_free(bmemory_pool_id_t id, void* data)
{
	bmemory_pool* pPool = get_bmemory_pool(id);
	
	// 内存池是否存在
	if(pPool == NULL)
	{
		exit(1);
	}
	
	bmemory_block* block = pPool->pBlockHeader;

	while(block != NULL)
	{
		if( data < block->pData || (block->pData + block->size*pPool->nUnitSize - data) <= 0)
		{
			block = block->pNext;
			continue;
		}
		break;
	}
	
	if(block != NULL)
	{
		bmemory_size_t index = (data - block->pData) / pPool->nUnitSize;
		bmemory_units* unit = block->pUnitsHeader + index;
		
		// 从已使用链表中移除
		if(unit->pPre == NULL && unit->pNext == NULL)
		{
			block->pUsedHeader = NULL;
		}
		else
		{
			if(unit->pPre != NULL)
			{
				unit->pPre->pNext = unit->pNext;
			}
		
			if(unit->pNext != NULL)
			{
				unit->pNext->pPre = unit->pPre;
			}
			
			if(unit == block->pUsedHeader)
			{
				block->pUsedHeader = unit->pNext;
			}
		}
		
		// 挂载进未使用内存单元链表
		bmemory_units* unitTmp = block->pFreeHeader;
		bmemory_units* preUnit = NULL;
		bmemory_units* nextUnit = NULL;
		
		if(unitTmp == NULL)
		{
			unit->pPre = unit->pNext = NULL;
			block->pFreeHeader = unit;
		}
		else
		{
			while(unitTmp != NULL)
			{
				if((unitTmp->pData) < data)
				{
					preUnit = unitTmp;
				}
				else if(unitTmp->pData > data)
				{
					nextUnit = unitTmp;
					break;
				}

				unitTmp = unitTmp->pNext;
			}

			if(preUnit != NULL)
			{
				if(preUnit->pData + preUnit->size*pPool->nUnitSize == data)
				{
					preUnit->size += unit->size;
					unit = preUnit;
				}
				else
				{
					unit->pPre = preUnit;
					unit->pNext = preUnit->pNext;
					preUnit->pNext = unit;
					// 这不需要设置pPre->pNext->pPre
				}
			}
			else
			{
				unit->pPre = NULL;
				unit->pNext = block->pFreeHeader;
				block->pFreeHeader = unit;
			}

			if(nextUnit != NULL)
			{
				if((unit->pData + unit->size*pPool->nUnitSize) == nextUnit->pData)
				{
					unit->size += nextUnit->size;
					if(nextUnit->pNext != NULL)
					{
						nextUnit->pNext->pPre = unit;
					}
					unit->pNext = nextUnit->pNext;
				}
				else
				{
					unit->pNext = nextUnit;
					nextUnit->pPre = unit;
				}
			}
			else
			{
				unit->pNext = NULL;
			}
printf("\n");
		}
	}
}

/**
 * 内存湖初始化
 * @return void
 */
void bmemory_lake_init(void)
{
//	printf("bmemory_lake_init()\n");
}

/**
 * 析构内存湖
 * @return void
 */
void bmemory_lake_destroy(void)
{
	bmemory_size_t i;

	for(i=0; i<BPOOL_MAX_NUM; i++)
	{
		bmemory_pool_unregister(i);
	}
}

/**
 * 返注册内存池
 * 程序会释放掉此内存池所占用的内存空间
 * @param bmemory_pool_id_t id 内存池标识
 * @return void
 */
void bmemory_pool_unregister(bmemory_pool_id_t id)
{
	bmemory_pool* pPool = get_bmemory_pool(id);
	
	if(pPool == NULL)
	{
		return;
	}
	
	bmemory_block* block = pPool->pBlockHeader;
	bmemory_block* tmp = block;

	while(block != NULL) 
	{
		tmp = block;
		block = block->pNext;
		free(tmp->pMemory);
	}
	
	memset(pPool, 0, sizeof(bmemory_pool));
}

/**
 * 打印出内存使用报表
 */
void bmemory_report(void)
{
	bmemory_pool_id_t poolSize = 0; 
	bmemory_pool_id_t i;
	bmemory_pool* pPool = NULL;
	bmemory_block* block = NULL;
	bmemory_units* units = NULL;
	bmemory_unit_size_t total = 0;
	bmemory_unit_size_t total2 = 0;
	int j = 1;
	printf("======内存湖使用情况报告======\n");
	for(i=0; i<BPOOL_MAX_NUM; i++)
	{
		pPool = &lc_pools[i];
	
		if(pPool->nUnitSize != 0)
		{
			poolSize++;
			printf(">>>>>>>>>>>>>>池(%d)<<<<<<<<<<<<<\n", i);
			printf("内存单元大小：0x%x\n", pPool->nUnitSize);
			printf("初始内存单元数：%d\n", pPool->nUnitCount);
			printf("内存单元增长步数：%d\n", pPool->nStep);
			block = pPool->pBlockHeader;
			j = 0;
			while(block != NULL)
			{
				printf("\n-------块%d-------\n", j);	
				printf("内存地址:%p\t数据内存地址：%p\n", block->pMemory, block->pData);
				printf("内存单元数：%d\n", block->size);

				units = block->pUsedHeader;
				printf("已使用内存单元列表：\n");
				while(units != NULL)
				{
					total++;
					total2 += units->size;
					printf("\t[单元地址:%p\t数量:%3d\t数据地址:%p\t Next:%p\tPre:%p]\n",
						 units, units->size, units->pData, units->pNext, units->pPre);
					units = units->pNext;
				}
				printf("已使用链表头：%p\t", block->pUsedHeader);
				printf("已使用单元数：%d\t", total2);
				printf("已使用单元划分数：%d\n", total);

				total = 0;
				total2 = 0;
				units = block->pFreeHeader;
				printf("空闲单元列表：\n");
				while(units != NULL)
				{
					total++;
					total2 += units->size;
					printf("\t[单元地址:%p\t数量:%3d\t数据地址:%p\t Next:%p\tPre:%p]\n",
						 units, units->size, units->pData, units->pNext, units->pPre);
					units = units->pNext;	
				}
				printf("空闲链表头：%p\t", block->pFreeHeader);
				printf("空闲单元数：%d\t", total2);
				printf("空闲单元划分数：%d\n", total);

				j++;
				total = total2 = 0;
				block = block->pNext;
			}
		}
	}
	printf("===============================\n\n\n");
}
