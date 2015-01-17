/* dstring.c  acb  20-9-1994
 * heap-allocated dynamic strings
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* concatenate two strings, freeing the originals */

char *
dstrcat(char *a, char *b) {
    char *r;
    int len = (a ? strlen(a) : 0) + (b ? strlen(b) : 0) + 1;

    if (len > (100 * 1024 * 1024)) {
	fprintf(stderr, "mallocing > 1MB\n");
	abort();
    }

    r = (char *) malloc(len);
    strcpy(r, a ? a : "");
    strcat(r, b ? b : "");
    if (a)
	free(a);
    if (b)
	free(b);

    return r;
}

/* vim: set autoindent expandtab sw=4: */
