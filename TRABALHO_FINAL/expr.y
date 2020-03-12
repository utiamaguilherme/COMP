%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
%}

%token TADD TMUL TSUB TDIV TAPAR TFPAR TINT
%token TFLO TSTR TVOID TFIM TVIR TID
%token TACHV TFCHV TPV TRET TLITERAL
%token TIF TELSE TWHL TREAD TPRINT TEQ
%token TNUM TMEN TMENEQ TMAI TMAIEQ TEQEQ
%token TNEQ TOR TAND
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
	 | TACHV TFCHV
	 | Comando
	 | TPV
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

PrepareIf: If
		 | Open
		 ;

If: TIF TAPAR Expr TFPAR Bloco TELSE If
	;

Open: TIF Expr Bloco PrepareIf
	| TIF Expr Bloco If TELSE Open

While: TWHL TAPAR Expr TFPAR Bloco
		 ;

Attr: TID TEQ Call
		| TID TEQ Expr TPV
		| TID TEQ TLITERAL TPV
		;

Print: TPRINT TAPAR Expr TFPAR TPV
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

Expr: Exprlo
		;

Exprlo: Exprlo TOR Exprlo2
			| Exprlo2
			;

Exprlo2: Exprlo2 TAND Exprlo3
        | Exprlo3
        ;

Exprlo3:
       | Exprre
       ;

Exprre: Exprre Comp Exprarit
      | Exprarit
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
	| TID
	| TAPAR Exprarit TFPAR {$$ = $2;}
	;

Comp: TMEN
		| TMENEQ
		| TMAI
		| TMAIEQ
		| TEQEQ
		| TNEQ
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
