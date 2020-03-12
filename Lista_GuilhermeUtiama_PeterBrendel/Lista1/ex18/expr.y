%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
%}

%token TADD TMUL TSUB TDIV TAPAR TFPAR TNUM TFIM TVAR TEQU TSC

%%
Linha : TVAR TEQU TNUM TSC {printf("%s = %.f\n", $1, $3);}
	| Expr TFIM {printf("Resultado:%lf\n", $1);exit(0);}
	; 
Expr: Expr TADD Termo {printf("+");}
	| Expr TSUB Termo {printf("-");}//Expr TSUB Termo {$$ = $1 - $3;}
	| Termo
	;
Termo: Termo TMUL Fator {printf("*");}//Termo TMUL Fator {$$ = $1 * $3;}
	| Termo TDIV Fator {printf("/");}//Termo TDIV Fator {$$ = $1 / $3;}
	| Fator
	;
Fator: TNUM {printf("%.f", $1);}
	| TAPAR Expr TFPAR {$$ = $2;}
	;
%%
#include "lex.yy.c"

int yyerror (char *str)
{
	printf("\n%s - antes %s\n", str, yytext);
	
} 		 

int yywrap()
{
	return 1;
}
