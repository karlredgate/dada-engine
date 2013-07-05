/* dstring.c  acb  20-9-1994
 * heap-allocated dynamic strings
 */

#ifndef __DSTRING_C
#define __DSTRING_C

#ifndef __GNUC__
#define inline			/* mu */
#endif

/* concatenate two strings, freeing the originals */

char *dstrcat(char *a, char *b);

#endif
