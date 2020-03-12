/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>
#include "tokens.h"
int linhas = 0;
%}

%option noyywrap

DIGIT    [0-9]*
ID       [a-z][a-z0-9]*

%%

{DIGIT}+    {   return T_INTEGER;    }

{DIGIT}+"."{DIGIT}*        {    return T_FLOAT;            }

if          {   return T_IF; }

then        {   return T_THEN;  }
begin       {   return T_BEGIN; }
end         {   return T_END;   }

{ID}        {   return T_ID;    }

"+"         {   return T_PLUS;  }
"-"         {   return T_MINUS;  }
"*"         {   return T_MUL;  }
"/"         {   return T_DIV;  }
":="        {   return T_EQ; }

";"         {   return T_SC;  }

"{"[^}\n]*"}"     /* eat up one-line comments */

[ \t\r]+          /* eat up whitespace */

"\n"              {linhas++;}

.           {printf( "%d: Unrecognized character: %s\n", linhas, yytext ); }

%%

//main( argc, argv )
//int argc;
//char **argv;
//    {
//    ++argv, --argc;  /* skip over program name */
//    if ( argc > 0 )
//            yyin = fopen( argv[0], "r" );
//    else
//            yyin = stdin;
//
//    printf("%d\n", yylex());
//    }
