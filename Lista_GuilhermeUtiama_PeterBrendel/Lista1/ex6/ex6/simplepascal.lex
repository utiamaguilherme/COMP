/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>
int linhas = 0;
%}

%option noyywrap

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

%%

{DIGIT}+    {
            printf( "%d: An integer: %s (%d)\n", linhas, yytext,
                    atoi( yytext ) );

            }

{DIGIT}+"."{DIGIT}*        {
            printf( "%d: A float: %s (%g)\n", linhas, yytext,
                    atof( yytext ) );

            }

if|then|begin|end        {
            printf( "%d: A keyword: %s\n", linhas, yytext );

            }

{ID}        {printf( "%d: An identifier: %s\n", linhas, yytext );
			}

"+"|"-"|"*"|"/"|":="   {printf( "%d: An operator: %s\n", linhas, yytext ); }

";"               {printf("%d: An terminal: %s\n", linhas, yytext ); }

"{"[^}\n]*"}"     /* eat up one-line comments */

[ \t\r]+          /* eat up whitespace */

"\n"              {linhas++;}

.           {printf( "%d: Unrecognized character: %s\n", linhas, yytext ); }

%%

main( argc, argv )
int argc;
char **argv;
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yylex();
    }
