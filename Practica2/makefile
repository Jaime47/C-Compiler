CC = gcc
CFLAGS = -c
EXE = pruebaMorfo

all: $(EXE)

pruebaMorfo: main.o alfa.o
	$(CC) -o $@ $^

main.o: main.c
	$(CC) $(CFLAGS) $< -o $@

alfa.o: lex.yy.c
	$(CC) $(CFLAGS) $< -o $@

lex.yy.c: alfa.l
	flex $<

clean:
	rm *.o
	rm $(EXE)
	rm lex.yy.c
