/* scanner for a toy Pascal-like language */

%{
/* need this for the call to atof() below */
#include <math.h>

int FINAL_TOTAL=0;
%}

%option noyywrap

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

%%

{DIGIT}+    {return T_INTEGER;}

{DIGIT}+"."{DIGIT}*        {return T_FLOAT;}

"+"   {return T_PLUS;}
"-"   {return T_MINUS;}
"*"   {return T_MUL;}
"/"   {return T_DIV;}
"("   {return T_AP;}
")"   {return T_FP;}
";"   {FINAL_TOTAL = 1; return T_END;}


[ \t\n]+          /* eat up whitespace */

.           {printf( "Unrecognized character: '%s' (%d)\n", yytext, *(yytext) ); }

%%


