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
%token T_ADD T_KICK FROM
%token T_UNION T_INTER T_DIFF
%type <a> exp lit_struct list_exp 

%left T_UNION 
%left T_

%start tree-sl
%%

tree-sl: exp    { printf("\n=> "); mostrarData(eval($1)); }
;

exp: 
NUMBER          { $$ = newdata(INT, NULL, $1); }
| lit_struct    {}
| T_ADD exp FROM exp  { $$ = newast(ADD, $2, $4); } //en que momento llamamos a eval
| T_KICK exp FROM exp { $$ = newast(KICK, $2, $4); }//definir token kick y en defs
| exp T_UNION exp { $$ = newast(UNION, $1, $3); } //donde carajeanos resulta union? en la primera lista?
| exp T_INTER exp { $$ = newast(INTER, $1, $3);}
| exp T_DIFF exp { $$ = newast(DIFF, $1, $3); }

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
