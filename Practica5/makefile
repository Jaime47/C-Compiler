CC=gcc
CFLAGS= -g -I./src -I./include -I./object

TEST_DIR=./ejemplos

all:
	mkdir -p ./include
	mkdir -p ./object
	@make alfa

alfa: y.tab.o lex.yy.o hashing.o
	$(CC) $(CFLAGS) ./src/alfa.c ./object/y.tab.o ./object/lex.yy.o ./object/hashing.o ./src/generacion.c -o alfa

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

#####
# CASOS DE TEST PARA DIFERENTES FUNCIONALIDADES
#####


factorial:
	./alfa $(TEST_DIR)/factorial.alfa $(TEST_DIR)/factorial.asm
	nasm -g -o $(TEST_DIR)/factorial.o -f elf32 $(TEST_DIR)/factorial.asm
	gcc -Wall -g -m32 -o $(TEST_DIR)/factorial $(TEST_DIR)/factorial.o alfalib.o
	./$(TEST_DIR)/factorial

condicionales:
	./alfa $(TEST_DIR)/condicionales.alfa $(TEST_DIR)/condicionales.asm
	nasm -g -o $(TEST_DIR)/condicionales.o -f elf32 $(TEST_DIR)/condicionales.asm
	gcc -Wall -g -m32 -o $(TEST_DIR)/condicionales $(TEST_DIR)/condicionales.o alfalib.o
	./$(TEST_DIR)/condicionales

funciones:
	./alfa $(TEST_DIR)/funciones.alfa $(TEST_DIR)/funciones.asm
	nasm -g -o $(TEST_DIR)/funciones.o -f elf32 $(TEST_DIR)/funciones.asm
	gcc -Wall -g -m32 -o $(TEST_DIR)/funciones $(TEST_DIR)/funciones.o alfalib.o
	./$(TEST_DIR)/funciones

fibonacci:
	./alfa $(TEST_DIR)/fibonacci.alfa $(TEST_DIR)/fibonacci.asm
	nasm -g -o $(TEST_DIR)/fibonacci.o -f elf32 $(TEST_DIR)/fibonacci.asm
	gcc -Wall -g -m32 -o $(TEST_DIR)/fibonacci $(TEST_DIR)/fibonacci.o alfalib.o
	./$(TEST_DIR)/fibonacci

funciones_vectores:
	./alfa $(TEST_DIR)/funciones_vectores.alfa $(TEST_DIR)/funciones_vectores.asm
	nasm -g -o $(TEST_DIR)/funciones_vectores.o -f elf32 $(TEST_DIR)/funciones_vectores.asm
	gcc -Wall -g -m32 -o $(TEST_DIR)/funciones_vectores $(TEST_DIR)/funciones_vectores.o alfalib.o
	./$(TEST_DIR)/funciones_vectores

clean:
	@rm -rf ./include/y.tab.h
	@rm -rf ./src/y.tab.c
	@rm -rf ./src/lex.yy.c
	@rm -rf ./object/lex.yy.o
	@rm -rf ./object/y.tab.o
	@rm -rf ./object/hashing.o
	@rm -rf ./object/generacion.o
	@rm -rf y.output
	@rm -rf alfa