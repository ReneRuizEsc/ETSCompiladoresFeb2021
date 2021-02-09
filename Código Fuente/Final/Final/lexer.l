%{ 
	#include <iostream>
	#include <cmath>

	#include "parser.h"
    #include "c_def.h"

%}

NOT return not;
AND return and;
OR return or;

NUM [0-9]+
DEC [0-9]*"."[0-9]+

%%

[\n]			{ return '\n'; }

{NUM}           {
                printf("\tNumero entero %s\n",yytext);
                yylval.entero = atoi(yytext);
                return (ENTERO);
                }

[0-1]+          {
                yylval = atoi(yytext);
                return(BOOLEAN)
                }

{DEC}           {
                printf("\tNumero decimal %s\n",yytext);
                yylval.decimal = atof(yytext);
                return (DECIMAL);
                }

"and"           {
                printf("\tAnd\n");
                return (yytext[0]);
                }

"or"           {
                printf("\tOr\n");
                return (yytext[0]);
                }

"not"           {
                printf("\tNot\n");
                return (yytext[0]);
                }

">"             {
                printf("\tOperador mayor que\n");
                return (yytext[0]);
                }

"<"             {
                printf("\tOperador menor que\n");
                return (yytext[0]);
                }

"=="            {
                printf("\tOperador igual\n");
                return (yytext[0]);
                }

"concat"        {
                printf("\tOperador menos\n");
                return (yytext[0]);
                }

"+"             {
                printf("\tOperador mas\n");
                return (yytext[0]);
                }

"-"             {
                printf("\tOperador menos\n");
                return (yytext[0]);
                }

"="             {
                printf("\tOperador asignacion\n");
                return (yytext[0]);
                }

";"             {
                printf("\tFin de expresion\n");
                return (yytext[0]);
                }

"("             {
                printf("\tParentesis Izquierdo\n");
                return (yytext[0]);
                }

")"             {
                printf("\tParentesis Derecho\n");
                return (yytext[0]);
                }

" "             {
                printf("\tEspacio\n");
                return (yytext[0]);
                }

"exit"			{ yyterminate(); 
                }
.               ;
%%