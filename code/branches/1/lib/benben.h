#ifndef __benben_h
#define __benben_h

#include "unp.h"
#include "bmemory.h"
#include "blist.h"
#include "bhashmap.h"
#include "type.h"

#define false 0
#define true 1

#ifndef NULL
#define NULL 0
#endif

#define MAX_TEXT	1000
#define MAX_CLIENT	5000

void* thread_message(void* arg);

#endif