%{

# include "defs.h"
# include "error.h"
# include "data.h"
# include "ast.h"
# include "eval.h"

%}
%union{
    struct ast* a;
    tData d;
}
%token <d> NUMBER    
%token ADD KICK FROM
%token UNION INTER DIFF
%type <a> exp lit_struct list_exp 

%start tree-sl
%%

tree-sl: exp    { printf("\n=> "); mostrarData(eval($1)); }
;

exp: 
NUMBER          { $$ = newdata(INT, NULL, $1); }
| lit_struct    {}
| ADD exp FROM exp  { $$ = newast(ADD, $2, $4); } //en que momento llamamos a eval
| KICK exp FROM exp { $$ = newast(KICK, $2, $4); }//definir token kick y en defs
| exp UNION exp { $$ = newast(UNION, $1, $3); } //donde carajeanos resulta union? en la primera lista?
| exp INTER exp { $$ = newast(INTER, $1, $3)}
| exp DIFF exp { $$ = newast(DIFF, %1, $3) }

; 
lit_struct:  
'[' ']'             { $$ = newdata(LIST, NULL, createData(LIST)); }
| '[' list_exp ']'  { $$ = newdata(LIST, $2, createData(LIST)); }
| '{' '}'           { $$ = newdata(SET,NULL, createData(SET)); }
| '{' list_exp '}'  { $$ = newdata(SET, %2, createData(SET)); }
;

list_exp: exp       {}
| exp ',' list_exp  { $$ = newast(LIST_OF_AST, $1, $3); }
; 

%% 

int main() {
    printf("\n=================TESTING TREE-SL=================\n");
    printf("\nNota:\nRecomendamos ingresar el programa en input.txt.\nPara ejecutar ejecute el comando: './tree input.txt' en linux\n\n");

    yyparse();
     
    return 0;
}
