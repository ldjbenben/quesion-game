VERSION =
EXE = main$(VERSION)
OBJECTS = $(EXE).o bsocket.o model_connection.o bmysql.o controller_user.o bmemory.o bqueue.o bhashmap.o model_message.o blist.o thread_recv.o thread_message_consume.o wrappthread.o unp.o readline.o wraplib.o wrapstdio.o wrapunix.o wrapsock.o error.o tcp_connect.o tcp_listen.o sig_chld_waitpid.o signal.o
INCLUDE_DIR =  -I ./include -I ./application/include -I /usr/local/mysql/include
LIB_DIR =  -L /usr/local/mysql/lib
LIBS =  -lpthread -lmysqlclient
CC = gcc
CFLAGS = -Wall -Werror -g $(LIBS) $(LIB_DIR) $(INCLUDE_DIR)

$(EXE):$(OBJECTS)
	$(CC) $(CFLAGS) -o $(EXE) $(OBJECTS)
	
$(EXE).o:$(EXE)$(VERSION).c
	$(CC) $(CFLAGS) -c $(EXE)$(VERSION).c
bsocket.o:./lib/bsocket.c
	$(CC) $(CFLAGS) -c ./lib/bsocket.c -I ./include
	
wrappthread.o:./lib/wrappthread.c ./include/unpthread.h
	$(CC) $(CFLAGS) -c ./lib/wrappthread.c
	
bmysql.o:./lib/db/mysql/bmysql.c wrappthread.o
	$(CC) $(CFLAGS) -c ./lib/db/mysql/bmysql.c -I /usr/local/mysql/include -I ./include

model_message.o:./application/models/model_message.c ./application/include/model.h
	$(CC) $(CFLAGS) -c ./application/models/model_message.c
	
model_connection.o:./application/models/model_connection.c ./application/include/model.h
	$(CC) $(CFLAGS) -c ./application/models/model_connection.c
	
controller_user.o:./application/controllers/controller_user.c ./application/include/controller.h
	$(CC) $(CFLAGS) -c ./application/controllers/controller_user.c -I /usr/local/mysql/include
	
thread_recv.o:./application/threads/thread_recv.c
	$(CC) $(CFLAGS) -c ./application/threads/thread_recv.c
	
thread_message_consume.o:./application/threads/thread_message_consume.c
	$(CC) $(CFLAGS) -c ./application/threads/thread_message_consume.c

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
	rm $(OBJECTS)