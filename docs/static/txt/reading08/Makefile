CC=             gcc
CFLAGS=         -Wall -g -std=gnu99
TARGETS=        sort grep

all:            $(TARGETS)

# TODO: Add rules for sort and grep

test:
	        @$(MAKE) -sk test-all

test-all:	test-sort test-grep

test-sort:	sort
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp25/static/txt/reading08/test_sort.sh
	chmod +x test_sort.sh
	./test_sort.sh

test-grep:	grep
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp25/static/txt/reading08/test_grep.sh
	chmod +x test_grep.sh
	./test_grep.sh

clean:
	rm -f $(TARGETS)

.SUFFIXES:
