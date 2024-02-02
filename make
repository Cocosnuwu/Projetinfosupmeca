CC = gcc
CFLAGS = -Wall -Wextra -Wpedantic

all: programme1 programme2 programme3 programme4

programme1: programme1.c
	$(CC) $(CFLAGS) -o $@ $^

programme2: programme2.c
	$(CC) $(CFLAGS) -o $@ $^

programme3: programme3.c
	$(CC) $(CFLAGS) -o $@ $^

programme4: programme4.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f programme1 programme2 programme3 programme4
