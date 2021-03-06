/* strfunc.h  acb  12-6-1994
 * string-handling utility functions for rtpp
 */

#ifndef __STRFUNC_H
#define __STRFUNC_H

/* concat() allocates a new string and strcat()s two strings together into it. 
 */

char *concat(char *foo, char *bar);

/* cookstr() goes through the supplied string, converting escape sequences
   to the characters that they represent. Since this never increases the 
   length of the string, it is safe to do in situ. */

int cookstr(char *str);

/* itoa() formats an integer into a string, allocated on the heap */

char *itoa(int i);

#endif
