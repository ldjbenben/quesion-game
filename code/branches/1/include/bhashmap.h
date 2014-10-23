#ifndef _hashmap_h
#define _hashmap_h 1

#define BHASHMAP_MAX_NUM 1000 // 最多可以注册的bhashmap数
#define BHASHMAP_INIT_CAPACITY 10 // 初始容量大小
#define LOAD_FACTOR 75 // 加载因子百分比(暂时没用到)

typedef int bhashmap_id_t;
typedef int bhashmap_size_t;
typedef int bhashmap_value_size_t;

typedef struct _bhashmap_entry_t{
	const char* key;
	void* value;
	struct _bhashmap_entry_t* pre;
	struct _bhashmap_entry_t* next;
}bhashmap_entry_t;

typedef struct _bhashmap_t{
	bhashmap_size_t capacity;// 初始容量大小
	bhashmap_size_t size;	// 当前大小
	bhashmap_entry_t** table;
}bhashmap_t;

/**
 * bhashmap初始化函数
 * 在使用bhashmap函数前，应该先调用此函数
 */
void bhashmap_init(void);
/**
 * 析构bhashmap
 * 注：当前不在使用bhashmap的时，应该调用此函数，进行内存的释放
 * @return void
 */
void bhashmap_destroy(void);
/**
 * 注册一个bhashmap
 * @return bhashmap_id_t bhashmap标识
 */
bhashmap_id_t bhashmap_register(void);
/**
 * 对bhashmap进行反注册
 * @param bhashmap_id_t id bhashmap标识
 * @return void
 */
void bhashmap_unregister(bhashmap_id_t id);
/**
 * 设置一个键值对
 * @param bhashmap_id_t id bhashmap标识
 * @param const char* key 键名
 * @param bhashmap_value_size_t type_len 值类型长度
 * @param void* value 值
 * @return void
 */
void bhashmap_set(bhashmap_id_t id, const char* key, void* value, bhashmap_value_size_t _len);
/**
 * 获取键对应的值
 * @param bhashmap_id_t id bhashmap标识
 * @param const char* key 键名
 * @param bhashmap_value_size_t type_len 值类型长度
 * @return void* 如果对应的键不存在返回NULL
 */
void* bhashmap_get(bhashmap_id_t id, const char* key);
/**
 * 删除键值对
 * @param bhashmap_id_t id bhashmap标识
 * @param const char* key 键名
 * @param bhashmap_value_size_t type_len 值类型长度
 * @return void
 */
void bhashmap_unset(bhashmap_id_t id, const char* key);

/**
 * 打印报告
 */
void bhashmap_report(void);

#endif
