CC = gcc
CFLAGS = -ansi -pedantic -c
EXE = pruebaSintactico

all: $(EXE)

pruebaSintactico: y.tab.o alfa.o main.o
	$(CC) -o $@ $^

main.o: main.c
	$(CC) -Wall $(CFLAGS) -o $@ $<

alfa.o: lex.yy.c
	$(CC) $(CFLAGS) -o $@ $<

lex.yy.c: alfa.l y.tab.h
	flex $<

y.tab.o: y.tab.c
	$(CC) $(CFLAGS) -o $@ $<

y.tab.c: alfa.y
	bison -dyv $<

y.tab.h: alfa.y
	bison -dyv $<

clean:
	rm -rf *.o
	rm -rf $(EXE)
	rm -rf lex.yy.c
	rm -rf y.tab.h y.tab.c y.output
