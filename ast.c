#include "ast.h"
#include "defs.h"



struct ast *newast(int nodetype, struct ast *l, struct ast *r)
{
    struct ast *a = malloc(sizeof(struct ast));
    if (!a)
    {
        printf("Error en malloc newast\n");
        return NULL;
    }

    a->nodetype = nodetype;
    a->l = l;
    a->r = r;

    return a;
}
struct ast *newdata(int nodetype, struct ast *l, tData d)
{
    struct data *a = malloc(sizeof(struct data));
    if (!a)
    {
        printf("Error en mallo newdata\n");
        return NULL;
    }

    a->nodetype = nodetype;
    a->l = l;
    a->d = d;

    return (struct ast *)a;
}
/*
struct flow* newflow(int flowtype, struct symbol*s, struct ast* l, struct ast* r, struct ast* cond){
    struct flow* f = malloc(sizeof(struct flow));
    if(!f) { printf("Error jaja rip pc\n"); return NULL; }

    f->nodetype = flowtype;
    f->l = l;
    f->r = r;
    f->cond = cond;

    return (struct ast*) f;
} */


int get_type_ast(struct ast* a){
    if(!a){ printf("ast null en get_type_ast");return 0;}

    switch (a->nodetype)
    {
    case LIST: case ADD: case KICK: //TAKE
        return LIST;
    case SET: case UNION: case INTER: case DIFF:
        return SET;
    // case op_arit 
    //case op_rel op_log
    
    default:
        break;
    }
}
int get_type_data(struct data* a){
    if(!a) { printf("ast null en get_type_ast");return 0;}
    return get_tipo(a->d);
}