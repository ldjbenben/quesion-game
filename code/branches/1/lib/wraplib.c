/*
 * Wrapper functions for our own library functions.
 * Most are included in the source file for the function itself.
 */

#include	"unp.h"
#include <math.h>

const char* Inet_ntop(int family, const void *addrptr, char *strptr, size_t len)
{
	const char	*ptr;

	if (strptr == NULL)		/* check for old code */
	{
		err_quit("NULL 3rd argument to inet_ntop");
	}
	if ( (ptr = inet_ntop(family, addrptr, strptr, len)) == NULL)
	{
		err_sys("inet_ntop error");		/* sets errno */
	}
	return(ptr);
}

void Inet_pton(int family, const char *strptr, void *addrptr)
{
	int		n;

	if ( (n = inet_pton(family, strptr, addrptr)) < 0)
	{
		err_sys("inet_pton error for %s", strptr);	/* errno set */
	}
	else if (n == 0)
	{
		err_quit("inet_pton error for %s", strptr);	/* errno not set */
	}

	/* nothing to return */
}

/**
 * 获取最高阶
 */
static int _get_order_num(int value, int* ret)
{
	int order = 1;

	while((value=value/10) > 10)
	{
		order++;
	}
	*(ret) = value%10;
	return order;
}

char* itoa(int value, char* str, int radix)
{
	int i = 0;
	int order = 0;
	int ret = 0;
	
	while(value>=10 && (order = _get_order_num(value, &ret)))
	{		
		value -= ret * pow(10, order);
		str[i] = 48 + ret;
		order = 0;
		i++;
	}
	
	str[i] = 48+value;
	return str;
}