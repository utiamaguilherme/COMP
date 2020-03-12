%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
%}

%token TADD TMUL TSUB TDIV TAPAR TFPAR TINT
%token TFLO TSTR TVOID TFIM TVIR TID
%token TACHV TFCHV TPV TRET TLITERAL
%token TIF TELSE TWHL TREAD TPRINT TEQ
%token TNUM
%%

Programa: ListaFuncoes BlocoPrincipal
				| BlocoPrincipal
				;

ListaFuncoes: ListaFuncoes Funcao
						| Funcao
						;

Funcao: TipoRetorno TID TAPAR DeclParametros TFPAR BlocoPrincipal
			| TipoRetorno TID TAPAR TFPAR BlocoPrincipal
			;

TipoRetorno: Tipo
					 | TVOID
					 ;

DeclParametros: DeclParametros TVIR Parametro
							| Parametro
							;

Parametro: Tipo TID
				 ;

BlocoPrincipal: TACHV Declaracoes ListaCmd TFCHV
							| TACHV ListaCmd TFCHV
							;

Declaracoes: Declaracoes Declaracao
					 | Declaracao
					 ;

Declaracao: Tipo ListaId TPV
					;

Tipo: TINT
		| TFLO
		| TSTR
		;

ListaId: ListaId TVIR TID
			 | TID
			 ;

Bloco: TACHV ListaCmd TFCHV
		 ;

ListaCmd: ListaCmd Comando
				| Comando
				;

Comando: If
			 | While
			 | Attr
			 | Print
			 | Read
			 | Call
			 | Return
			 ;

Return: TRET Exprarit TPV
			| TRET TLITERAL TPV
			;

If: TIF TAPAR Expr TFPAR Bloco
	| TIF TAPAR Expr TFPAR Bloco TELSE Bloco

While: TWHL TAPAR Exprlo TFPAR Bloco

Attr: TID TEQ Exprlo TPV
		| TID TEQ TLITERAL TPV
		;

Print: TPRINT TAPAR Exprarit TFPAR TPV
		 | TPRINT TAPAR TLITERAL TFPAR TPV
		 ;

Read: TREAD TAPAR TID TFPAR TPV
		;

Call: Chamadafuncao TPV
		;

Chamadafuncao: TID TAPAR Listaparametro TFPAR
						 | TID TAPAR TFPAR
						 ;

Listaparametro: Listaparametro TVIR Exprarit
							| Listaparametro TVIR TLITERAL
							| Exprarit
							| TLITERAL
							;

Expr: Exprarit
		| Exprlo
		;

Exprlo:
			;

Exprarit: Exprarit TADD Termo {$$ = $1 + $3;}
	| Exprarit TSUB Termo {$$ = $1 - $3;}
	| Termo
	;

Termo: Termo TMUL Fator {$$ = $1 * $3;}
	| Termo TDIV Fator {$$ = $1 / $3;}
	| Fator
	;

Fator: TNUM
	| TAPAR Exprarit TFPAR {$$ = $2;}
	;

%%
#include "lex.yy.c"

int yyerror (char *str)
{
	printf("%s - antes %s\n", str, yytext);

}

int yywrap()
{
	return 1;
}
