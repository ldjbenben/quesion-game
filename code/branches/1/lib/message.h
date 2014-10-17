#ifndef __func_h
#define __func_h

#include "benben.h"

void message_queue_init();
void message_queue_push(bmessage* pMsg);
bmessage* message_queue_pop();

#endif