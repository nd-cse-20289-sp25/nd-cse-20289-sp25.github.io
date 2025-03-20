/* allocations.c */

#include <stdio.h>
#include <stdlib.h>

typedef struct {
    double x;
    double y;
} Point;

typedef union {
    char   c;
    int    i;
    float  f;
    double d;
} Block;

double GD = 3.14;

int main(int argc, char *argv[]) {
    int    a[]	= {5, 7, 4};
    char  *sp	= "Video Games";
    char   sa[]	= "Runescape";
    Block  b    = {0};

    Point   p0	= {0, 0};
    Point  *p1	= NULL;
    Point  *p2	= malloc(sizeof(Point));
    Point  *p3	= malloc(5*sizeof(Point));
    Point **p4	= malloc(5*sizeof(Point *));

    printf("Size of GD: %lu\n", sizeof(GD));
    printf("Size of  a: %lu\n", sizeof(a));
    printf("Size of sp: %lu\n", sizeof(sp));
    printf("Size of sa: %lu\n", sizeof(sa));
    printf("Size of  b: %lu\n", sizeof(b));
    printf("Size of p0: %lu\n", sizeof(p0));
    printf("Size of p1: %lu\n", sizeof(p1));
    printf("Size of p2: %lu\n", sizeof(p2));
    printf("Size of p3: %lu\n", sizeof(p3));
    printf("Size of p4: %lu\n", sizeof(p4));

    return 0;
}
