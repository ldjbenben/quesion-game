#include "benben.h"

/*
int read_int(int connfd);
float read_float(int connfd);
double read_double(int connfd);
bool read_bool(int connfd);
byte read_byte(int connfd);
byte* read_bytes(int connfd);
*/

void socket_write_int(bconnection* conn, int value);
void socket_flush(bconnection* conn);
