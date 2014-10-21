#include "benben.h"
#include "bmysql.h"

static MYSQL mysql = {{0}};
static bool init = false;
static bool connected = false;

static const char* mysql_host = "192.168.1.101";
static const char* mysql_user = "root";
static const char* mysql_passwd = "root";
static const char* mysql_db = "qgame";
static unsigned int mysql_port = 3306;

static bool bmysql_prepare()
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
	if(mysql_real_connect(&mysql, mysql_host, mysql_user, mysql_passwd, mysql_db, mysql_port, NULL, 0) == NULL)
	{
		err_quit("connect mysql error!\n");
	}
}

bool bmysql_query(const char* query)
{
	bmysql_prepare();

	MYSQL_ROW row;
	unsigned int num_fields;
	unsigned int i;
	
	mysql_query(&mysql, query);
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

}