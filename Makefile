# Build config vars
CC=g++
CFLAGS=-Wall -std=c++17 -O2

all: directories build/search

directories: build

build:
	mkdir -p build

# .PHONY tells Make to not watch for any changes to a file named 'clean'
.PHONY: clean create_build_dir
clean:
	rm -f build/*

# `make debug` builds the executable with debug flags
debug: CFLAGS += -g
debug: all

headers: include/document.h include/query.h include/index.h

# Build buildects
build/document.o: src/document.cpp headers
	$(CC) -c $(CFLAGS) src/document.cpp -o build/document.o

build/datasource.o: src/datasource.cpp headers
	$(CC) -c $(CFLAGS) src/datasource.cpp -o build/datasource.o

build/index.o: src/index.cpp headers
	$(CC) -c $(CFLAGS) src/index.cpp -o build/index.o

build/query.o: src/query.cpp headers
	$(CC) -c $(CFLAGS) src/query.cpp -o build/query.o

build/main.o: src/main.cpp headers
	$(CC) -c $(CFLAGS) src/main.cpp -o build/main.o

# Build buildary rule
build/search: build/document.o build/datasource.o build/index.o build/query.o build/main.o
	$(CC) $(CFLAGS) build/document.o build/datasource.o build/index.o build/query.o build/main.o -o build/search
