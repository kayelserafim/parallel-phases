LAD_ENV := $(shell command -v ladcomp 2> /dev/null)

S_DIR = ./src

CC = gcc
MPI = mpicc
LAD_CMD = ladcomp -env mpicc

CFLAGS = -Wall -g -lm

all: sequential.o parallel.o

sequential.o: $(S_DIR)/sequential.c
	$(CC) -o $@ $< $(CFLAGS)
	
parallel.o: $(S_DIR)/parallel.c
ifdef LAD_ENV
	$(LAD_CMD) -o $@ $< $(CFLAGS)
else
	$(MPI) -o $@ $< $(CFLAGS)
endif

.PHONY: clean

clean:
	rm -rf *.o *~ all