CC=             gcc
CFLAGS=         -Wall -g -std=gnu99
TARGETS=        str_counts

all:            $(TARGETS)

#-------------------------------------------------------------------------------
# TODO: Add rule for str_counts
#-------------------------------------------------------------------------------

str_counts:     

#-------------------------------------------------------------------------------
# DO NOT MODIFY BELOW
#-------------------------------------------------------------------------------

test:
	        @$(MAKE) -sk test-all

test-all:	test-str

test-str:	str_counts
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp25/static/txt/reading10/str_counts.test.sh
	chmod +x str_counts.test.sh
	./str_counts.test.sh

clean:
	rm -f $(TARGETS)

.SUFFIXES:
