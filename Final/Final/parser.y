%defines "parser.h"

%{
	#include <cmath>
	#include "c_def.h"

	int yylex(void);

	int yyerror (char *s)
	{
	  printf ("--%s--\n", s);
	  return 0;
	}
            
	int yywrap()  
	{  
	  return 1;  
	}
%}

%union{
	int entero;
	double decimal;
	char *cadena;
	bool booleano;
}

%token <entero> ENTERO
%token <decimal> DECIMAL
%token <booleano> BOOLEAN
%type <booleano> expb
%type <decimal> expd
%type <entero> exp

%left '+' '-'
%left '*' '/' and or not
%right M R

%%

input: /* Nada */
	| input line
	;

line: '\n'
    | exp '\n'  { printf ("\t\tresultado: %d\n", $1); }
    | expd '\n'  { printf ("\t\tresultado: %f\n", $1); }
	| expb '\n'  { printf ("\t\tresultado: %s\n", $1); }
	;

exp: ENTERO { $$ = $1; }
	| exp '+' exp        { $$ = $1 + $3;}
	| '-' exp            { $$ = -$2;}
	| '+' exp            { $$ = $2;}  
	| exp '-' exp        { $$ = $1 - $3;}
;

expd: DECIMAL	{ $$ = $1; }
  | '-' expd            { $$ = -$2;    }
  | '+' expd            { $$ = $2;    }
  | expd '+' expd        { $$ = $1 + $3;    }
  | expd '-' expd        { $$ = $1 - $3;    }
  | exp '+' expd        { $$ = $1 + $3;    }
  | exp '-' expd        { $$ = $1 - $3;    }
  | expd '+' exp        { $$ = $1 + $3;    }
  | expd '-' exp        { $$ = $1 - $3;    }
;

expb: BOOLEAN
	| expb or expb   { if($1==1||$3 ==1){$$=1;}else{$$=0;} }
	| expb and expb   { $$ = $1 * $3;}
	| not expb        { if($2==1){ $$=0; }else{ $$=1;} } 
	| '(' expb ')'    { $$ = $2; }
;

%%

int main() {
  yyparse();
}