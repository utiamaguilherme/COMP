%{
// TODO
// literal com problema

#include "expr.tab.h"
%}

delim	[ \t\v\n\f\r]
ws	{delim}+
digito	[0-9]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?
letra	[a-zA-Z_]
var	{letra}({letra}|{num})*
literal letra?\"(\\.|[^\\"])*\"


%%
{ws}	{}
"+"	{return TADD;}
"-"	{return TSUB;}
"*"	{return TMUL;}
"/"	{return TDIV;}
"("	{return TAPAR;}
")"	{return TFPAR;}
"," {return TVIR;}
"int" {return TINT;}
"float" {return TFLO;}
"string" {return TSTR;}
"void" {return TVOID;}
"{" {return TACHV;}
"}" {return TFCHV;}
";" {return TPV;}
"return" {return TRET;}
"if" { return TIF; }
"else" { return TELSE; }
"while" { return TWHL; }
"print" { return TPRINT; }
"read" { return TREAD; }
"=" { return TEQ; }
literal { return TLITERAL; }
var {return TID;}
{num}	{yylval=atof(yytext); return TNUM;}
ws { }
