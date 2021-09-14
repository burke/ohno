CC = gcc
CFLAGS = -std=gnu99 -Wall -Wextra -pedantic -O3

all: test

test: test.c
	$(CC) $(CFLAGS) -I/ptrace_do -L/ptrace_do -o test test.c -lptrace_do

clean:
	rm test
