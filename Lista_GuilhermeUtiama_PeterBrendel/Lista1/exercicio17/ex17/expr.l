%{
#include "expr.tab.h"
%}

delim	[ \t]
ws	{delim}+
digito	[0-9]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?
letra	[a-zA-Z_]
var	{letra}({letra}|{num})*

%%
{ws}	{}
"+"	{return TADD;}
"-"	{return TSUB;}
"*"	{return TMUL;}
"/"	{return TDIV;}
"("	{return TAPAR;}
")"	{return TFPAR;}
\n	{return TFIM;}
"="	{return TEQU;}
";"	{return TSC;}
{var}	{yylval.str=strdup(yytext);return TVAR;}
{num}	{yylval.num=atof(yytext); return TNUM;}
