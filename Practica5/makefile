CC=gcc
CFLAGS= -g -I./src -I./include -I./object

all:
	mkdir -p ./include
	mkdir -p ./object

	@make alfa

alfa: y.tab.o lex.yy.o hashing.o
	$(CC) $(CFLAGS) ./src/alfa.c ./object/y.tab.o ./object/lex.yy.o ./object/hashing.o ./src/generacion.c -o alfa

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) -c -o ./object/y.tab.o ./src/y.tab.c

y.tab.c: ./alfa/alfa.y
	bison -dyv ./alfa/alfa.y
	mv y.tab.c ./src
	mv y.tab.h ./include

lex.yy.c: ./alfa/alfa.l ./include/y.tab.h ./include/alfa.h ./include/generacion.h ./include/hashing.h
	flex ./alfa/alfa.l
	mv lex.yy.c ./src

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c -o ./object/lex.yy.o ./src/lex.yy.c

hashing.o: ./src/hashing.c ./include/hashing.h
	$(CC) $(CFLAGS) -c ./src/hashing.c
	mv hashing.o ./object

