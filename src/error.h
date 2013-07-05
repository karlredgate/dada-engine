
#ifndef _ERROR_H_
#define _ERROR_H_

void die( char *file, int line, char *message );

#define DIE(msg) die(__FILE__,__LINE__,msg)

#endif
