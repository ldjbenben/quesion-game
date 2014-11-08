#include "benben.h"

typedef unsigned short trans_str_size_t; // 网络传输的字符长度类型，也就限定了最大的字符长度

/*
int read_int(int connfd);
float read_float(int connfd);
double read_double(int connfd);
bool read_bool(int connfd);
byte read_byte(int connfd);
byte* read_bytes(int connfd);
*/

/**
 * 从给定的bmessage结构中读取一整数
 */
int socket_read_int(bmessage* pMsg);
/**
 * 从给定的bmessage结构中读取字符串
 
 * @param pMsg bmessage结构体指针, 会用到其中的recv_txt和read_cursor成员
 * 并会修改read_cursor成员.
 
 * @param recv [out] 由用户分配空间，传入此空间的指针，程序会填充此空间，注意不会填充\0.
 
 * @param len [in out] recv被填充的最大字符长度，防止溢出操作
 * 程序最后会通过此参数返回最终填充的字节数.
 */
char* socket_read_string(bmessage* pMsg, char* recv, trans_str_size_t* len);
/**
 * 往给定的bmessage结构中写入一个整数
 */
void socket_write_int(bresponse* response, int value);
/**
 * 往给定的bmessage结构中写入一个短整数
 */
void socket_write_short(bresponse* response, short value);
/**
 * 往给定的bmessage结构中写入字符串
 * @param str 指向源字符串地址
 * @param len 字符串长度
 */
void socket_write_string(bresponse* response, const char* str, trans_str_size_t len);
/**
 * 刷新缓冲发送数据
 */
void socket_flush(bmessage* msg, bresponse* response);
