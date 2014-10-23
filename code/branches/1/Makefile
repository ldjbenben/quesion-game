VERSION =
EXE = main$(VERSION)
objects = $(EXE).o bmysql.o user.o bmemory.o bqueue.o bhashmap.o message.o blist.o thread_recv.o thread_message_consume.o wrappthread.o unp.o readline.o wraplib.o wrapstdio.o wrapunix.o wrapsock.o error.o tcp_connect.o tcp_listen.o sig_chld_waitpid.o signal.o
CC = gcc
CFLAGS = -Wall -g -lpthread -lmysqlclient -L /usr/local/mysql/lib -I ./lib

$(EXE):$(objects)
	$(CC) $(CFLAGS) -o $(EXE) $(objects)
	
$(EXE).o:$(EXE)$(VERSION).c
	$(CC) $(CFLAGS) -c $(EXE)$(VERSION).c

bmysql.o:./db/mysql/bmysql.c
	$(CC) $(CFLAGS) -c ./db/mysql/bmysql.c -I /usr/local/mysql/include -I ./lib
	
user.o:./controllers/user.c
	$(CC) $(CFLAGS) -c ./controllers/user.c
	
thread_recv.o:./func/thread_recv.c
	$(CC) $(CFLAGS) -c ./func/thread_recv.c
	
thread_message_consume.o:./func/thread_message_consume.c
	$(CC) $(CFLAGS) -c ./func/thread_message_consume.c

message.o:./func/message.c ./lib/message.h
	$(CC) $(CFLAGS) -c ./func/message.c
	
wrappthread.o:./lib/wrappthread.c ./lib/unpthread.h
	$(CC) $(CFLAGS) -c ./lib/wrappthread.c

bmemory.o:./lib/collections/bmemory.c ./lib/bmemory.h
	$(CC) $(CFLAGS) -c ./lib/collections/bmemory.c
	
bqueue.o:./lib/collections/bqueue.c ./lib/bqueue.h
	$(CC) $(CFLAGS) -c ./lib/collections/bqueue.c

blist.o:./lib/collections/blist.c ./lib/blist.h
	$(CC) $(CFLAGS) -c ./lib/collections/blist.c -I ./lib

bhashmap.o:./lib/collections/bhashmap.c ./lib/bhashmap.h
	$(CC) $(CFLAGS) -c ./lib/collections/bhashmap.c -I ./lib

unp.o:./lib/unp.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/unp.c

readline.o:./lib/readline.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/readline.c

wraplib.o:./lib/wraplib.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/wraplib.c

wrapstdio.o:./lib/wrapstdio.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/wrapstdio.c

wrapunix.o:./lib/wrapunix.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/wrapunix.c

wrapsock.o:./lib/wrapsock.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/wrapsock.c

error.o:./lib/error.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/error.c
	
tcp_connect.o:./lib/tcp_connect.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/tcp_connect.c
	
tcp_listen.o:./lib/tcp_listen.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/tcp_listen.c
	
sig_chld_waitpid.o:./lib/sig_chld_waitpid.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/sig_chld_waitpid.c  -I ./lib
	
signal.o:./lib/signal.c ./lib/unp.h
	$(CC) $(CFLAGS) -c ./lib/signal.c

clean:
	rm $(objects)