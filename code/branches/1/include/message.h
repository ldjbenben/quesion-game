#ifndef __message_h
#define __message_h

#include "benben.h"

void message_init();
void message_destroy();
void message_queue_push(bmessage_t* pMsg);
bmessage_t* message_queue_pop();
bool message_queue_empty();
bmessage_t* message_malloc();
void message_free(bmessage_t* pMsg);

#endif