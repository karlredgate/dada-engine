/* check.c  acb  21-9-1994
 * routines for checking RTNs for undefined and unuse symbols.
 */

#include <stdlib.h>
#include <stdio.h>
#include "rtn.h"
#include "map.h"
#include "transform.h"

extern pListNode transformations;

/* a rule closure; the symbolic environment of a rule */

struct rule_closure {
    pRule rules;		/* other rules */
    pRule rule;			/* this rule */
};

static int errors = 0;

static int
undef_iter2(pNode a, struct rule_closure *closure) {
    switch ( a->type ) {
    case deref:
        fprintf( stderr, "undef_iter2: unhandled type 'deref'\n" );
	break;
    case literal:
        fprintf( stderr, "undef_iter2: unhandled type 'literal'\n" );
	break;
    case choice:
        fprintf( stderr, "undef_iter2: unhandled type 'choice'\n" );
	break;
    case star:
        fprintf( stderr, "undef_iter2: unhandled type 'star'\n" );
	break;
    case plus:
        fprintf( stderr, "undef_iter2: unhandled type 'plus'\n" );
	break;
    case repeat_const:
        fprintf( stderr, "undef_iter2: unhandled type 'repeat_const'\n" );
	break;
    case repeat_var:
        fprintf( stderr, "undef_iter2: unhandled type 'repeat_var'\n" );
	break;
    case var_conddef:
        fprintf( stderr, "undef_iter2: unhandled type 'var_conddef'\n" );
	break;
    case var_def:
        fprintf( stderr, "undef_iter2: unhandled type 'var_def'\n" );
	break;
    case var_ref:
        fprintf( stderr, "undef_iter2: unhandled type 'var_ref'\n" );
	break;
    case code:
        fprintf( stderr, "undef_iter2: unhandled type 'code'\n" );
	break;
    case silence:
        fprintf( stderr, "undef_iter2: unhandled type 'silence'\n" );
	break;
    case symbol:{
	    if (param_indexof(closure->rule->params, a->data) == -1) {
		/* this node is not a parameter */
		if (rule_find(closure->rules, a->data) == NULL) {
		    fprintf(stderr, "undefined symbol '%s' in rule '%s'\n",
			    a->data, closure->rule->symbol);
		    errors++;
		}
		/* check any parameters passed */
		if (a->params)
		    undef_iter2(a->params, closure);
	    }
	}
	break;
    case mapping:{
	    /* I have been lazy and used global variables. Please forgive me. */
	    if ((map_lookup(mappings, a->data) == NULL) &&
		(trans_lookup(transformations, a->data) == NULL)) {
		fprintf(stderr,
			"undefined mapping or transformation '%s' in rule '%s'\n",
			a->data, closure->rule->symbol);
		errors++;
	    }
	    /* recurse into what this mapping applies to */
	    undef_iter2(a->params, closure);
	}
    }

    return 0;
}

static int
undef_iter1(pOption o, struct rule_closure *closure) {
    node_map(o->atoms, (NodeIterator) & undef_iter2, closure);
    return 0;
}

static int
undef_iter0(pRule r, pRule rules) {
    struct rule_closure closure;
    closure.rules = rules;
    closure.rule = r;
    option_map(r->options, (OptionIterator) & undef_iter1, &closure);
    return 0;
}

static void
check_for_undefined(pRule rules) {
    errors = 0;
    rule_inorder_traverse(rules, (RuleIterator) & undef_iter0, rules);
    if (errors > 0)
	exit(1);
}

static void
check_for_unused(pRule rules) {
}

void
check_rtn(pRule rules) {
    check_for_undefined(rules);
    check_for_unused(rules);
}

/*
 * vim:autoindent
 * vim:expandtab
 */
