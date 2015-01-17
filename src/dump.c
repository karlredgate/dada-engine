/* dump.c  acb  (9|10)-9-1994
 * code for dumping rules, etc.
 */

#include <stdlib.h>
#include "rtn.h"
#include "map.h"
#include "transform.h"
#include "machine.h"

static int dump_atoms(pNode atoms);

static void
dump_node( pNode node ) {
    switch (node->type) {
    case var_ref:
        fprintf(stderr, "ERROR - dump_node unhandled type 'var_ref'\n" );
        break;
    case silence:
        fprintf(stderr, "ERROR - dump_node unhandled type 'silence'\n" );
        break;
    case choice:
        fprintf(stderr, "ERROR - dump_node unhandled type 'choice'\n" );
        break;
    case star:
        fprintf(stderr, "ERROR - dump_node unhandled type 'star'\n" );
        break;
    case plus:
        fprintf(stderr, "ERROR - dump_node unhandled type 'plus'\n" );
        break;
    case repeat_const:
        fprintf(stderr, "ERROR - dump_node unhandled type 'repeat_const'\n" );
        break;
    case repeat_var:
        fprintf(stderr, "ERROR - dump_node unhandled type 'repeat_var'\n" );
        break;

    case literal:
	printf("\"%s\"", node->data);
	break;
    case symbol:
	printf("{%s", node->data);
	if (node->params) {
	    printf("(");
	    dump_atoms(node->params);
	    printf(")");
	}
	printf("}");
	break;
    case mapping:
	dump_node(node->params);
	printf(" > %s", node->data);
	break;
    case deref:
	printf("DEREF(");
	dump_node(node->params);
	printf(")");
	break;
    case var_conddef:
	printf("%s << ", node->data);
	dump_node(node->params);
	break;
    case var_def:
	printf("%s = ", node->data);
	dump_node(node->params);
	break;
    case code:
	printf("code:");
	dump_code( (pInstr)(node->data) );
	break;
    }
}

static int
node_iterator( pNode node, int param ) {
    dump_node(node);
    printf(", ");
    return 0;
}

static int
dump_atoms( pNode atoms ) {
    node_map(atoms, (NodeIterator) & node_iterator, NULL);
    return 0;
}

static int
option_iter( pOption opt, int param ) {
    printf("\t\t");
    dump_atoms(opt->atoms);
    printf("\n");
    return 0;
}

static void
dump_options( pOption opt ) {
    option_map(opt, (OptionIterator) & option_iter, NULL);
}

void
dump_params( pParam params ) {
    if ( params == NULL ) return;
    char *p = (char *)(params->data);
    printf( "%s ", p );
    dump_params( params->next );
}

static int
rule_iter( pRule r, int param ) {
    printf("%s", r->symbol);

    if (r->params) {
	printf(" ( ");
	dump_params(r->params);
	printf(")");
    }
    printf(" : (%d options)\n", option_length(r->options));
    dump_options(r->options);
    return 0;
}

void
dump_rules( pRule r ) {
    rule_inorder_traverse(r, (RuleIterator) & rule_iter, NULL);
}

/*
 *  code for dumping mappings
 */

static void
dump_mapopt( pMapOpt opt ) {
    printf("    \"%s\" ", opt->key);
    switch (opt->action->mode) {
    case replace:
	printf("-> \"%s\"\n", opt->action->out);
	break;
    case subst:
	printf(">> \"%s\"/\"%s\"\n", opt->action->key, opt->action->out);
	break;
    default:
	printf("?\n");
    }
}

static void
dump_mapping( pMapping m ) {
    pMapOpt o = m->options;
    printf("%s : \n", m->name);

    while (o) {
	dump_mapopt(o);
	o = o->next;
    }
}

void
dump_mappings( pMapping m ) {
    while (m) {
	dump_mapping(m);
	m = m->next;
    }
}

/*
 *    code for dumping transformations
 */

static int
print_param_iter( char *param, void *foo ) {
    printf("/%s", param);
    return 0;
}

static void
dump_transcmd( pTransCmd cmd ) {
    if (cmd->addr) {
    }
    printf("%s", cmd->cmdname);
    if (cmd->params) {
	list_mapcar(cmd->params, (ListIterator) print_param_iter, NULL);
    }
}

static int
dump_transopt_iter( pTransOpt opt, void *beable ) {
    printf(" \"%s\" -> ", opt->key);
    dump_transcmd(opt->cmds);
    putchar('\n');
    return 0;
}

static int
dump_xform_iter( pTransformation xform, void *blah ) {
    printf("transformation: \"%s\"\n", xform->name);
    list_mapcar(xform->options, (ListIterator) dump_transopt_iter, NULL);
    return 0;
}

void
dump_transformations( pListNode list ) {
    list_mapcar(list, (ListIterator) dump_xform_iter, NULL);
}

/* vim: set autoindent expandtab sw=4: */
