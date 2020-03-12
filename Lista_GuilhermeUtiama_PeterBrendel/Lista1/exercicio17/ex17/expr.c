#include <stdio.h>

#include "expr.tab.c"

extern FILE *yyin;

void ts_inicia(){
	for(int i=0; i<100; i++){
		tabela[i].str = "\0";
		tabela[i].num = 0x3f3f3f3f;
	}
}

void ts_add(char * str, double num){
	int i=0;
	while(!tabela[i++].str);
	tabela[i].str = str;
	tabela[i].num = num;
}

double ts_pesquisa(char * str){
	int i=0;
	while(strcmp(tabela[i++], str) != 0);
	return tabela[i].num;
}

int main()
{
	ts_inicia();
	yyin = stdin;
	printf("Digite uma express�o:");
	yyparse();
	return 0;
}
