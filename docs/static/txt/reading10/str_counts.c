/* str_counts.c: Count letters in string */

#include <stdio.h>
#include <stdlib.h>

int *str_counts(const char *s) {
    int counts[1<<8];

    for (const char *c = s; c; c++) {
        counts[*c]++;
    }

    return counts;
}
                                                              
int main(int argc, char *argv[]) {
    char *buffer = "";

    while (fgets(buffer, BUFSIZ, stdin)) {
        int *counts = str_counts(buffer);
        for (int c = 'A'; c <= 'z'; c++) {
            if (counts[*c]) printf("%7d %c\n", counts[*c], c);
        }
    }

    return EXIT_SUCCESS;
}
