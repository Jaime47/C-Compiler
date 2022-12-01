
####################################################
CC=gcc
CFLAGS= -g -I./src -I./include -I./object
####################################################
.PHONY: clean

all:
	mkdir -p ./include
	mkdir -p ./object
	@make alfa

alfa: y.tab.o lex.yy.o hashing.o
	$(CC) $(CFLAGS) ./src/main.c ./object/y.tab.o ./object/lex.yy.o ./object/hashing.o ./src/generacion.c -o alfa

hashing.o: ./src/hashing.c ./include/hashing.h
	$(CC) $(CFLAGS) -c ./src/hashing.c
	mv hashing.o ./object

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c -o ./object/lex.yy.o ./src/lex.yy.c

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) -c -o ./object/y.tab.o ./src/y.tab.c

y.tab.c: ./res/alfa.y
	bison -dyv ./res/alfa.y
	mv y.tab.c ./src
	mv y.tab.h ./include

lex.yy.c: ./res/alfa.l ./include/y.tab.h ./include/alfa.h ./include/generacion.h ./include/hashing.h
	flex ./res/alfa.l
	mv lex.yy.c ./src

clean:
	@rm -rf ./object/lex.yy.o
	@rm -rf ./object/y.tab.o
	@rm -rf ./object/hashing.o
	@rm -rf ./object/generacion.o
	@rm -rf ./include/y.tab.h
	@rm -rf ./src/y.tab.c
	@rm -rf ./src/lex.yy.c
	@rm -rf y.output
	@rm -rf alfa