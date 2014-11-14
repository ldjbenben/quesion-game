#include "benben.h"
#include "bmysql.h"
#include "bmemory.h"

static bmysql_connector connectors[DB_CONNECTOR_NUM];
static bmemory_pool_id_t lc_pool_id = 0;
static pthread_mutex_t lc_mutex;
static pthread_cond_t lc_cond;

static void _error(const char* err)
{
	printf("mysql error:%s\n", err);
}

/**
 * 此函数只能被调用一次
 */
void bmysql_init()
{
	lc_pool_id = bmemory_pool_register(sizeof(BMYSQL_RES), DB_CONNECTOR_NUM, DB_CONNECTOR_NUM);
	pthread_mutex_init(&lc_mutex, NULL);
	pthread_cond_init(&lc_cond, NULL);
	
	int i = 0;
	
	for(i=0; i<DB_CONNECTOR_NUM; i++)
	{
		if(mysql_real_connect(&connectors[i].mysql, MYSQL_HOST, MYSQL_USER, MYSQL_PASSWD, MYSQL_DB, MYSQL_PORT, NULL, 0) == NULL)
		{
			connectors[i].status = 2;
			_error(mysql_error(&connectors[i].mysql));
		}
		else
		{
			connectors[i].status = 0;
		}
	}
	
}

void bmysql_destroy()
{
	int i = 0;
	
	for(i=0; i<DB_CONNECTOR_NUM; i++)
	{
		mysql_close(&connectors[i].mysql);
	}
	
	pthread_mutex_destroy(&lc_mutex);
	pthread_cond_destroy(&lc_cond);
}

static MYSQL* get_connnector(int* id)
{
	MYSQL* mysql = NULL;
	int i=0;
	
	for(i=0; i<DB_CONNECTOR_NUM; i++)
	{
		if(connectors[i].status == 0)
		{
			*id = i;
			connectors[i].status = 1;
			mysql = &connectors[i].mysql;
			break;
		}
	}
	//printf("i:%d\n", i);
	
	return mysql;
}

/**
 * 获取一个数据库连接指针。
 * 如果当前连接池中没有闲置的连接可供使用，此函数将会等待
 * 直到有闲置的连接可供使用或超时为止。
 * @param id [out] 返回连接标识，释放连接(db_release_connector)时会使用到
 */
static MYSQL* bmysql_get_connector(int* id)
{
	MYSQL* mysql = NULL;
	
	Pthread_mutex_lock(&lc_mutex);
	
	mysql = get_connnector(id);
	
	if(mysql == NULL)
	{
		//printf("mysql wait timeout\n");
		struct timespec t;
		struct timeval now;
		
		gettimeofday(&now, NULL);
		t.tv_sec = now.tv_sec + 15;
		t.tv_nsec = now.tv_usec*1000;
		
		int ret = Pthread_cond_timedwait(&lc_cond, &lc_mutex, &t);
		
		if(ret != ETIMEDOUT)
		{
			//printf("after mysql wait timeout then get connector again\n");
			mysql = get_connnector(id);
			//printf("after mysql wait timeout then get connector succee id:%d\n", *id);
		}
	}
	
	Pthread_mutex_unlock(&lc_mutex);

	return mysql;
}

/**
 * 释放数据库连接
 * 把此连接调整为可使用状态
 * @param id 连接标识,通过db_get_connector的id参数进行返回
 */
static void release_connector(int id)
{
	connectors[id].status = 0;
}

/**
 * 执行非查询语句
 * @param query 被执行的语句
 * @return 返回受影响的行数
 */
int bmysql_execute(const char* query)
{
	int id;
	MYSQL* mysql = bmysql_get_connector(&id);

	MYSQL_RES* result = NULL;

	unsigned int num_rows = 0;

	if (mysql_query(mysql,query)) // error
	{
		_error(mysql_error(mysql));
	}
	else // query succeeded, process any data returned by it
	{
		result = mysql_store_result(mysql);
		
		if(result != 0) // 执行了查询语句, 释放资源
		{
			mysql_free_result(result);
		}
		else
		{
		
			if (mysql_errno(mysql))
			{
				_error(mysql_error(mysql));
			}
			else if (mysql_field_count(mysql) == 0)
			{
				// query does not return data
				// (it was not a SELECT)
				num_rows = mysql_affected_rows(mysql);
			}
		}
	}
	
	release_connector(id);
	
	return num_rows;
}

int bmysql_query(const char* query, BMYSQL_RES** bresult)
{
	int ret = 0;
	int id = 0;
	MYSQL_RES* result = NULL;
	MYSQL* mysql = bmysql_get_connector(&id);
	
	if(mysql == NULL)
	{
		ret = 1;
	}
	else
	{
		if (mysql_query(mysql,query))
		{
			_error(mysql_error(mysql));
		}
		else // query succeeded, process any data returned by it
		{
			result = mysql_store_result(mysql);
			
			if (!result && mysql_errno(mysql))
			{
			   _error(mysql_error(mysql));
			}

			*bresult = (BMYSQL_RES*)bmemory_get(lc_pool_id, 1);
			(*bresult)->result = result;
			(*bresult)->mysql = mysql;
			(*bresult)->id = id;
		}
	}
	
	return ret;
}

int bmysql_query_scalar(const char* query, char** v, BMYSQL_RES** bresult)
{
	int ret = bmysql_query(query, bresult);
	
	if(ret == 0)
	{
		MYSQL_ROW row;
		
		while ((row = mysql_fetch_row((*bresult)->result)))
		{
			*v = row[0];
			break;
		}
	}
	
	return ret;
}

void bmysql_free_result(BMYSQL_RES* bresult)
{
	mysql_free_result(bresult->result);
	release_connector(bresult->id);
	bmemory_free(lc_pool_id, bresult);
	pthread_cond_signal(&lc_cond);
}