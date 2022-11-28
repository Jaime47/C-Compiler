CC=gcc
CFLAGS= -g -ansi -pedantic -std=c99 -Wall -c
EXE = test

all: $(EXE)

test: hashing.o main.o
	$(CC) -o $@ $^

hashing.o: hashing.c hashing.h
	$(CC) $(CFLAGS) -o $@ $<

main.o: main.c hashing.h
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -r -f *.o
	rm test