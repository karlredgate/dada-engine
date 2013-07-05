/* machine.c  acb  14-2-1995
 * the embedded imperative code interpreter in pb
 * A lot of stuff lifted from rml, also by acb so it's Allowed.
 */

#include <stdio.h>
#include <string.h>

#include "variables.h"
#include "machine.h"
#include "strfunc.h"
#include "rtn.h"
#include "resolve.h"

#ifndef min
#define min(a,b) (((a)<(b))?(a):(b))
#endif

#ifndef max
#define max(a,b) (((a)>(b))?(a):(b))
#endif

#define STACK_SIZE 1024

static Cell stack[STACK_SIZE];
static int sp = 0;

extern pRule rule_base;

#if 0
/* this is not used?? */
static void
push( pCell c ) {
    stack[sp++] = *c;
}
#endif

/* temp_pop is thusly named because it returns a pointer whose contents will
   be later reclaimed */
static pCell
temp_pop() {
    return &(stack[--sp]);
}

static void
push_int( int i ) {
    stack[sp].type = int_t;
    stack[sp++].contents.i = i;
}

static void
push_str( char *s ) {
    stack[sp].type = string_t;
    stack[sp++].contents.s = s;
}

/* find last instruction in list */

pInstr
last( pInstr a ) {
    if (a == NULL)
	return NULL;
    if (a->next == NULL)
	return a;
    return last(a->next);
}

static char *
exec_instr( pInstr s ) {
    pCell tc, tc2;
    char buffer[16];

    switch (s->opcode) {
    case SET:
	/* operand must be a string */
	tc = temp_pop();
	switch (tc->type) {
	case mu:
            fprintf(stderr, "exec_inst/SET: warning - unhandled case mu\n" );
            break;
	case string_t:
	    var_put(s->operand.contents.s, tc->contents.s);
	    break;
	case int_t:
	    var_put_int(s->operand.contents.s, tc->contents.i);
	    break;
	}
	break;
    case EMIT:
	tc = temp_pop();
	switch (tc->type) {
	case mu:
            fprintf(stderr, "exec_inst/EMIT: warning - unhandled case mu\n" );
            break;
	case string_t:
	    return tc->contents.s;
	case int_t:
	    sprintf(buffer, "%i", tc->contents.i);
	    return nstrdup(buffer);
	}
    case PUSHV:
	{
	    struct var *v = var_lookup(vars, s->operand.contents.s);
	    if (v == 0) {
		fprintf(stderr,
			"attempted to use unknown variable \"%s\" in expression.\n",
			s->operand.contents.s);
		push_str("(NULL)");
	    } else {
		switch (v->type) {
	        case mu:
                    fprintf(stderr, "exec_inst/PUSHV: warning - unhandled case mu\n" );
                    break;
		case string_t:
		    push_str(nstrdup(v->value.s));
		    break;
		case int_t:
		    push_int(v->value.i);
		    break;
		}
	    }
	}
	break;
    case INVOKE:
	{
	    pRule r = rule_find(rule_base, s->operand.contents.s);
	    if (r) {
		push_str(resolve_rule(rule_base, r));
	    } else {
		fprintf(stderr,
			"attempted to invoke non-existent rule \"%s\" in expression.\n",
			s->operand.contents.s);
		push_str(NULL);
	    }
	}
	break;
    case PUSH:
	switch (s->operand.type) {
	case mu:
            fprintf(stderr, "exec_inst/PUSH: warning - unhandled case mu\n" );
            break;
	case string_t:
	    push_str(nstrdup(s->operand.contents.s));
	    break;
	case int_t:
	    push_int(s->operand.contents.i);
	    break;
	}
	break;
    case ADD:
	tc = temp_pop();
	tc2 = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int(tc->contents.i + tc2->contents.i);
	} else {
	    char *s0, *s1;
	    /* string concatenation */
	    s0 = ((tc->type ==
		   int_t) ? itoa(tc->contents.i) : (tc->contents.s));
	    s1 = ((tc2->type ==
		   int_t) ? itoa(tc2->contents.i) : (tc2->contents.s));
	    push_str(concat(s1, s0));
	    free(s0);
	    free(s1);
	}
	break;
    case SUB:
	tc = temp_pop();
	tc2 = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int(tc2->contents.i + tc->contents.i);
	}
	break;
    case MUL:
	tc = temp_pop();
	tc2 = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int(tc->contents.i * tc2->contents.i);
	}
	break;
    case DIV:
	tc = temp_pop();
	tc2 = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int(tc2->contents.i / tc->contents.i);
	}
	break;
    case MOD:
	tc = temp_pop();
	tc2 = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int(tc2->contents.i % tc->contents.i);
	}
	break;
    case RANDOM:
	tc2 = temp_pop();
	tc = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int((random() % (tc2->contents.i - tc->contents.i + 1))
		     + tc->contents.i);
	}
	break;
    case LESSER:
	tc2 = temp_pop();
	tc = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int(min(tc->contents.i, tc2->contents.i));
	}
	break;
    case GREATER:
	tc2 = temp_pop();
	tc = temp_pop();
	if ((tc->type == int_t) && (tc2->type == int_t)) {
	    push_int(max(tc->contents.i, tc2->contents.i));
	}
	break;
    }
    return NULL;
}

/*
 * execute a stream of instructions, possibly returning a string
 */
char *
exec_stream( pInstr s ) {
    while ( s != NULL) {
	char *r = exec_instr(s);
	if ( r != NULL ) return r;
	s = s->next;
    }

    return NULL;
}

char *opname[] = {
    "SET", "PUSHV", "PUSH", "ADD", "SUB", "MUL", "DIV", "EMIT", "INVOKE"
};

void
dump_code( pInstr s ) {
    while (s) {
	printf("%s ", opname[s->opcode]);
	switch (s->operand.type) {
	case int_t:
	    printf("%i\n", s->operand.contents.i);
	    break;
	case string_t:
	    printf("\"%s\"\n", s->operand.contents.s);
	    break;
	default:
	    putchar('\n');
	}
	s = s->next;
    }
}

pInstr
icat( pInstr a, pInstr b ) {
    if (a) {
	pInstr l = last(a);
	l->next = b;
	return a;
    } else
	return b;
}

/* return a simple instruction */
pInstr
e_simple( enum opcode op ) {
    pInstr result = (pInstr) malloc(sizeof(Instr));
    result->opcode = op;
    result->operand.type = mu;	/* nothing */
    result->next = NULL;
    return result;
}

pInstr
e_set( char *name ) {
    pInstr result = e_simple(SET);
    result->operand.type = string_t;
    result->operand.contents.s = name;
    return result;
}

pInstr
e_pushv( char *name ) {
    pInstr result = e_simple(PUSHV);
    result->operand.type = string_t;
    result->operand.contents.s = name;
    return result;
}

pInstr
e_push_int( int i ) {
    pInstr result = e_simple(PUSH);
    result->operand.type = int_t;
    result->operand.contents.i = i;
    return result;
}

pInstr
e_push_str( char *s ) {
    pInstr result = e_simple(PUSH);
    result->operand.type = string_t;
    result->operand.contents.s = s;
    return result;
}

pInstr
e_invoke( char *name ) {
    pInstr result = e_simple(INVOKE);
    result->operand.type = string_t;
    result->operand.contents.s = name;
    return result;
}

/*
 * vim:autoindent
 * vim:expandtab
 */
