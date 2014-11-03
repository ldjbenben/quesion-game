VERSION =
EXE = main$(VERSION)
objects = $(EXE).o bsocket.o connection.o bmysql.o user.o bmemory.o bqueue.o bhashmap.o message.o blist.o thread_recv.o thread_message_consume.o wrappthread.o unp.o readline.o wraplib.o wrapstdio.o wrapunix.o wrapsock.o error.o tcp_connect.o tcp_listen.o sig_chld_waitpid.o signal.o
CC = gcc
CFLAGS = -Wall -Werror -g -lpthread -lmysqlclient -L /usr/local/mysql/lib -I ./include

$(EXE):$(objects)
	$(CC) $(CFLAGS) -o $(EXE) $(objects)
	
$(EXE).o:$(EXE)$(VERSION).c
	$(CC) $(CFLAGS) -c $(EXE)$(VERSION).c
bsocket.o:./lib/bsocket.c
	$(CC) $(CFLAGS) -c ./lib/bsocket.c -I ./include
	
bmysql.o:./lib/db/mysql/bmysql.c
	$(CC) $(CFLAGS) -c ./lib/db/mysql/bmysql.c -I /usr/local/mysql/include -I ./include
	
connection.o:./application/collections/connection.c ./include/connection.h
	$(CC) $(CFLAGS) -c ./application/collections/connection.c
	
user.o:./application/controllers/user.c
	$(CC) $(CFLAGS) -c ./application/controllers/user.c
	
thread_recv.o:./application/threads/thread_recv.c
	$(CC) $(CFLAGS) -c ./application/threads/thread_recv.c
	
thread_message_consume.o:./application/threads/thread_message_consume.c
	$(CC) $(CFLAGS) -c ./application/threads/thread_message_consume.c

message.o:./application/collections/message.c ./include/message.h
	$(CC) $(CFLAGS) -c ./application/collections/message.c
	
wrappthread.o:./lib/wrappthread.c ./include/unpthread.h
	$(CC) $(CFLAGS) -c ./lib/wrappthread.c

bmemory.o:./lib/collections/bmemory.c ./include/bmemory.h
	$(CC) $(CFLAGS) -c ./lib/collections/bmemory.c
	
bqueue.o:./lib/collections/bqueue.c ./include/bqueue.h
	$(CC) $(CFLAGS) -c ./lib/collections/bqueue.c

blist.o:./lib/collections/blist.c ./include/blist.h
	$(CC) $(CFLAGS) -c ./lib/collections/blist.c -I ./include

bhashmap.o:./lib/collections/bhashmap.c ./include/bhashmap.h
	$(CC) $(CFLAGS) -c ./lib/collections/bhashmap.c -I ./include

unp.o:./lib/unp.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/unp.c

readline.o:./lib/readline.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/readline.c

wraplib.o:./lib/wraplib.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/wraplib.c

wrapstdio.o:./lib/wrapstdio.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/wrapstdio.c

wrapunix.o:./lib/wrapunix.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/wrapunix.c

wrapsock.o:./lib/wrapsock.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/wrapsock.c

error.o:./lib/error.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/error.c
	
tcp_connect.o:./lib/tcp_connect.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/tcp_connect.c
	
tcp_listen.o:./lib/tcp_listen.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/tcp_listen.c
	
sig_chld_waitpid.o:./lib/sig_chld_waitpid.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/sig_chld_waitpid.c  -I ./include
	
signal.o:./lib/signal.c ./include/unp.h
	$(CC) $(CFLAGS) -c ./lib/signal.c

clean:
	rm $(objects)