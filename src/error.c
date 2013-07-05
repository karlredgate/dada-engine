
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

void
die( char *file, int line, char *message ) {
    int err = errno;

    char buffer[80];
    strerror_r( err, buffer, sizeof(buffer) );

    fprintf( stderr, "dada: %s\n", message );
    fprintf( stderr, "      %s\n", buffer );

    exit( -err );
}
