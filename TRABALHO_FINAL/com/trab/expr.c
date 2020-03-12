#include <stdio.h>

#include "expr.tab.c"

extern FILE *yyin;

int main(int argc, const char* argv[])
{
	yyin = fopen(argv[1], "r");
	// printf("Digite uma express�o:");
	yyparse();
	return 0;
}
