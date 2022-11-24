CC = gcc
CFLAGS = -g -ansi -pedantic -std=c99 -Wall -c
EXE = test_hash_table

all: $(EXE)

test_hash_table: hash.o main.o
	$(CC) -o $@ $^

hash.o: hash.c hash.h
	$(CC) $(CFLAGS) -o $@ $<

main.o: main.c hash.h
	$(CC) $(CFLAGS) -o $@ $<

run: test_hash_table
	./test_hash_table entrada.txt turbo-salida.txt
	diff -bB salida.txt turbo-salida.txt

run_valgrind: test_hash_table
	valgrind --leak-check=full ./test_hash_table entrada.txt turbo-salida.txt
	diff -bB salida.txt turbo-salida.txt

clean:
	rm -r -f *.o
	rm test_hash_table