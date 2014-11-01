#ifndef __unp_h
#define __unp_h

#include	<sys/types.h>	/* basic system data types */
#include	<sys/socket.h>	/* basic socket definitions */
#include	<netinet/in.h>	/* sockaddr_in{} and other Internet defns */
#include	<arpa/inet.h>	/* inet(3) functions */
#include	<errno.h>
#include	<fcntl.h>		/* for nonblocking */
#include	<netdb.h>
#include	<signal.h>
#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<sys/stat.h>	/* for S_xxx file mode constants */
#include	<sys/uio.h>		/* for iovec{} and readv/writev */
#include	<unistd.h>
#include	<sys/wait.h>
#include	<sys/un.h>		/* for Unix domain sockets */
#include 	<pthread.h>

/* Following could be derived from SOMAXCONN in <sys/socket.h>, but many
   kernels still #define it as 5, while actually supporting many more */
#define	LISTENQ		1024	/* 2nd argument to listen() */

/* Miscellaneous constants */
#define	MAXLINE		4096	/* max text line length */
#define	BUFFSIZE	8192	/* buffer size for reads and writes */

/* Define some port number that can be used for our examples */
#define	SERV_PORT		 9877			/* TCP and UDP */

#define UNIXSTR_PATH	"/tmp/unixbind"

typedef void Sigfunc(int);

#define	min(a,b)	((a) < (b) ? (a) : (b))
#define	max(a,b)	((a) > (b) ? (a) : (b))

/* Following shortens all the typecasts of pointer arguments: */
#define	SA	struct sockaddr

void err_dump(const char *, ...);
void err_msg(const char *, ...);
void err_quit(const char *, ...);
void err_ret(const char *, ...);
void err_sys(const char *, ...);

int		tcp_listen(const char *, const char *, socklen_t *);

/* prototypes for our Unix wrapper functions: see {Sec errors} */
void Close(int);
ssize_t	 Read(int, void *, size_t);


/* prototypes for our stdio wrapper functions: see {Sec errors} */
void Fclose(FILE *);
FILE *Fdopen(int, const char *);
char *Fgets(char *, int, FILE *);
FILE *Fopen(const char *, const char *);
void Fputs(const char *, FILE *);
pid_t Fork(void);

/* prototypes for our socket wrapper functions: see {Sec errors} */
int	Socket(int, int, int);
void Bind(int, const struct sockaddr*, socklen_t);
void Listen(int, int);
int	 Accept(int, struct sockaddr*, socklen_t *);
void Connect(int fd, const struct sockaddr*, socklen_t);
void Shutdown(int, int);
void Getsockname(int, struct sockaddr*, socklen_t*);
void Setsockopt(int, int, int, const void *, socklen_t);


int	Tcp_connect(const char *, const char *);
/**
 * ����һ���Ѿ��ڼ���״̬���׽���
 * �������ǰѷ������˴����׽��ֵ�һЩ�ظ��Ĳ��輯����һ��
 * �������ǵĴ����д��
 * @param host Ҫ����������
 * @param serv �����Ķ˿ں�
 * @param addrlenp ������ص�Э���ַ��С
 * @return �����´������׽���id
 */
int Tcp_listen(const char* host, const char* serv, socklen_t* addrlenp);
void	*Malloc(size_t);
void *Calloc(size_t n, size_t size);



/**
 * �ڡ����е�ַ���ϰ�һ����ʱ�Ķ˿ں�
 * @param socdfd socket��ʶ
 * @param family Э����
 * @return ������ʱ�˿ں�
 */
int sock_bind_wild(int sockfd, int family);
/**
 * Ϊ�׽��ֵ�ַ�ṹ���ö˿ں�
 * @param sa �׽��ֵ�ַ�ṹָ��
 * @param port �˿ں�
 * @return ������ʱ�˿ں�
 */
void sock_set_port(struct sockaddr* sa, unsigned short int port);
/**
 * ��ȡ�����׽��ֵ�ַ���󶨵Ķ˿ں�
 * @param sa �׽��ֵ�ַ�ṹָ��
 * @return �˿ں�
 */
int sock_get_port(const struct sockaddr* sa);
/**
 * ͨ�����ʮ�����ַ��������׽��ֵ�ֵַ
 * @param sa �׽��ֵ�ַ�ṹָ��
 * @param addr in_addr��in6_addr�ṹָ��
 * @return void
 */
void sock_set_addr(struct sockaddr* sa, const void* addr);
/**
 * ���׽��ֻ������ж�ȡn���ֽ�
 * @param fd �׽�����������ʶ
 * @param ptr �������ݵĵ�ַ
 * @param nbytes ��ȡ���ֽ���
 * @return void
 */
ssize_t	 Readn(int fd, void *ptr, size_t nbytes);
ssize_t Readline(int fd, void *ptr, size_t maxlen);
/**
 * ���׽��ֻ�������д��n���ֽ�
 * @param fd �׽�����������ʶ
 * @param ptr Ҫд������ݵ�ַ
 * @param nbytes д����ֽ���
 * @return void
 */
void Writen(int fd, const void* ptr, size_t nbytes);

int	Select(int, fd_set *, fd_set *, fd_set *, struct timeval *);

void Inet_pton(int, const char *, void *);
char* itoa(int value, char* str, int radix);

void str_echo(int);
void str_cli(FILE *, int);

Sigfunc* Signal(int signo, Sigfunc* func);
void sig_chld(int signo);

#endif	/* __unp_h */