%{
#include <stdio.h>
#include <stdlib.h>

typedef struct atttrib {
	char * str;
	double num;
} ATRIBUTO;

ATRIBUTO tabela[100];

void ts_inicia();
void ts_add(char * str, double num);
double ts_pesquisa(char * str);

#define YYSTYPE ATRIBUTO
%}

%token TADD TMUL TSUB TDIV TAPAR TFPAR TNUM TFIM TVAR TEQU TSC

%%
Linha : Atri TFIM {exit(0);}
	| Atri Expr TFIM {printf("\nResultado:printf(%lf\n", $2.num);exit(0);}
	;
Atri : TVAR TEQU TNUM TSC {ts_add($1.str, $3.num);}
	;
Expr: Expr TADD Termo {printf("+"); $$.num = $1.num + $3.num;}
	| Expr TSUB Termo {printf("-"); $$.num = $1.num - $3.num;}
	| Termo
	;
Termo: Termo TMUL Fator {printf("*"); $$.num = $1.num * $3.num;}
	| Termo TDIV Fator {printf("/"); $$.num = $1.num / $3.num;}
	| Fator
	;
Fator: TNUM {printf("%.f", $1.num);}
	| TAPAR Expr TFPAR {$$.num = $2.num;}
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
