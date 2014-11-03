#ifndef __connection_h
#define __connection_h

#include "benben.h"

void connection_hashmap_init(void);
void connection_hashmap_set(int connfd, bconnection* value);
bconnection* connection_hashmap_get(int connfd);

#endif