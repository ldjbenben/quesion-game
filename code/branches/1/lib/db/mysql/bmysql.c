#include "benben.h"
#include "mysql.h"
#include "bmysql.h"

static MYSQL mysql = {{0}};
static bool init = false;
static bool connected = false;

#define MYSQL_HOST "192.168.1.101"
#define MYSQL_USER "root"
#define MYSQL_PASSWD "root"
#define MYSQL_DB "qgame"
#define MYSQL_PORT 3306

void bmysql_connect();

static void bmysql_prepare()
{
	if(!init)
	{
		if(connected == true)
		{
			mysql_ping(&mysql);
		}
		else
		{
			bmysql_connect();
		}
	}
}

void bmysql_connect()
{
	if(mysql_real_connect(&mysql, MYSQL_HOST, MYSQL_USER, MYSQL_PASSWD, MYSQL_DB, MYSQL_PORT, NULL, 0) == NULL)
	{
		err_quit("connect mysql error!\n");
	}
}

void bmysql_query(const char* query)
{
	bmysql_prepare();

	MYSQL_RES *result;
	MYSQL_ROW row;
	unsigned int num_fields;
	unsigned int num_rows;
	unsigned int i;

	 
	if (mysql_query(&mysql,query))
	{
		// error
	}
	else // query succeeded, process any data returned by it
	{
		result = mysql_store_result(&mysql);
		if (result)  // there are rows
		{
			num_fields = mysql_num_fields(result);
			while ((row = mysql_fetch_row(result)))
			{
			   unsigned long *lengths;
			   lengths = mysql_fetch_lengths(result);
			   for(i = 0; i < num_fields; i++)
			   {
				   printf("[%.*s] ", (int) lengths[i], row[i] ? row[i] : "NULL");
			   }
			   printf("\n");
			}
			mysql_free_result(result);
			// retrieve rows, then call mysql_free_result(result)
		}
		else  // mysql_store_result() returned nothing; should it have?
		{
			if (mysql_errno(&mysql))
			{
			   fprintf(stderr, "Error: %s\n", mysql_error(&mysql));
			}
			else if (mysql_field_count(&mysql) == 0)
			{
				// query does not return data
				// (it was not a SELECT)
				num_rows = mysql_affected_rows(&mysql);
			}
		}
	}


}