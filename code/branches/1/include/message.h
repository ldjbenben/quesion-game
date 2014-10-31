#ifndef __message_h
#define __message_h

#include "benben.h"

void message_queue_init();
void message_queue_push(bmessage* pMsg);
bmessage* message_queue_pop();
bool message_queue_empty();

#endif