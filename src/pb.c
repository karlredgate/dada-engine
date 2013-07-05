/* pb.c  acb  11-7-1995
 * main part of the Dada Engine pb interpreter
 * before 11-7-1995, this was in parser.y
 */

#include <sys/time.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "rtn.h"
#include "check.h"
#include "map.h"
#include "transform.h"
#include "resolve.h"
#include "dump.h"
#include "dada_util.h"

extern int yyparse(void);

static char *start_symbol = NULL;	/* to override the default start symbol */
pRule rule_base;
extern pRule initial_rule;

int dump_rtn = 0;
int inhibit = 0;
int verbose = 0;
int trace = 0;
int old_probability = 0;
int wrapwidth = 80;

FILE *outfile;
extern int yydebug;

/* resolve a RTN */
void
use_rtn( pRule rtn ) {
    if (!rtn)
	return;

    if (dump_rtn) {
	dump_rules(rtn);
	dump_mappings(mappings);
	dump_transformations(transformations);
    }

    check_rtn(rtn);
    rule_base = rtn;

    if (start_symbol) {
	initial_rule = rule_find(rtn, start_symbol);
	if (!initial_rule) {
	    fprintf(stderr, "rule \"%s\" does not exist.\n", start_symbol);
	    exit(1);
	}
    }

    if (!inhibit) {
	if (wrapwidth) {
	    print_wrapped(outfile, resolve_rule(rtn, initial_rule),
			  wrapwidth);
	    putc('\n', outfile);
	} else {
	    fprintf( outfile, "%s\n", resolve_rule(rtn, initial_rule) );
	}
    }
}

int
strtoseed( char *s ) {
    int r = 0;

    if (atoi(s))
	return atoi(s);

    while (*s) {
	r += *(s++);
    }
    return r;
}

void
initrandom( int seed ) {
    struct timeval tv;

    gettimeofday(&tv, NULL);

    if (seed == 0) {
	seed = tv.tv_usec;
    }

    srandom(seed);
}

int
main( int argc, char **argv ) {
    int i;
    char *rseed = NULL;		/* a random seed, in string form */
    char *columns = getenv("COLUMNS");

    outfile = stdout;

    /* read environment variables as needed */
    if ( columns != NULL ) {
	wrapwidth = atoi(columns);
    }

    /* check command-line arguments */

    for (i = 1; i < argc; i++) {
	if (*(argv[i]) == '-') {
	    switch (argv[i][1]) {
	    case 'd':
		dump_rtn = 1;
	    case 'i':
		inhibit = 1;
		break;
	    case 'o':
		outfile = fopen(argv[++i], "w");
		break;
	    case 'p':
		old_probability = 1;
		break;
	    case 'r':
		rseed = argv[++i];
		break;
	    case 's':
		start_symbol = argv[++i];
		break;
	    case 't':
		trace = 1;
		break;
	    case 'v':
		verbose = 1;
		break;
	    case 'w':
		wrapwidth = atoi(argv[++i]);
		break;
	    case 'y':
		yydebug = 1;
		break;
	    }
	}
    }

    /* srandom(rseed?strtoseed(rseed):time(NULL)); */
    initrandom( rseed ? strtoseed(rseed) : 0 );
    yyparse();

    return 0;
}

/*
 * vim:autoindent
 * vim:expandtab
 */
