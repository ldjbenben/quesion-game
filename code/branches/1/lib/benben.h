#ifndef __benben_h
#define __benben_h

#include "unp.h"
#include "type.h"

#define false 0
#define true 1

#ifndef NULL
#define NULL 0
#endif

void* thread_message(void* arg);

#endif