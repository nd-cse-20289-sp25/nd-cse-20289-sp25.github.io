CC=             gcc
CFLAGS=         -Wall -g -std=gnu99
TARGETS=        walk

all:            $(TARGETS)

# TODO: Add rule for walk

test:
	        @$(MAKE) -sk test-all

test-all:	test-walk

test-walk:	walk
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp25/static/txt/reading11/walk.test.sh
	chmod +x walk.test.sh
	./walk.test.sh

clean:
	rm -f $(TARGETS)

.SUFFIXES:
