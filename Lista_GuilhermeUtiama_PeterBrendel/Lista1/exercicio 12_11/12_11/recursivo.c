
/**
E  -> T E_

E_ -> + T E_
      | e

T  -> F T_

T_ -> * F T_
      | e

F  -> (E)
      | T_INTEGER
      | T_FLOAT
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tokens.h"
#include "lex.yy.c"


#define FALSE 0
#define TRUE 1

char derivacoes[1000];

int E();
int E_();
int T();
int T_();
int F();

int E()
{
    //E  -> T E_
    int l;
    l=strlen(derivacoes);
    strcat(derivacoes, "E -> T E_\n");
    // printf("l = %d dewriva = %s\n",l, derivacoes);
    if(T())
    {
        if(E_())
        {

            return TRUE;
        }
    }
    derivacoes[l] = '\0';
    return FALSE;
}
int E_()
{
    int token;
    int l;
    l=strlen(derivacoes);
    //E_ -> + T E_
    //  | e
    if(FINAL_TOTAL){
        strcat(derivacoes, "E_ -> e\n");
        return TRUE;
    } // producao vazia
    token = yylex();
    //if(FINAL_TOTAL) return TRUE; // producao vazia
    if(token == T_PLUS)
    {
        strcat(derivacoes, "E_ -> + T E_\n");
        if(T())
        {
            if(E_())
            {
                printf("ADD\n", yytext);
                return TRUE;
            }
        }
        derivacoes[l]='\0';
        return FALSE;
    }
    else if(token == T_MINUS)
    {
        strcat(derivacoes, "E_ -> - T E_\n");
        if(T())
        {
            if(E_())
            {
                printf("SUB\n", yytext);
                return TRUE;
            }
        }
        derivacoes[l]='\0';
        return FALSE;
    }
    else
    {
        unput(*(yytext));

    }
    //unput(*(yytext+1));

    token = yylex();
    if(token == T_END)
    {
        strcat(derivacoes, "E_ -> e\n");
        return TRUE;
    }
    unput(*(yytext));


    strcat(derivacoes, "E_ -> e\n");
    return TRUE; //producao vazia aceita
}

int T_()
{
    int token;
    int l;
    l=strlen(derivacoes);
    //T_ -> * F T_
    //  | e
    if(FINAL_TOTAL){
        return TRUE; // producao vazia
    }
    token = yylex();
   // if(FINAL_TOTAL) return TRUE; // producao vazia
    if(token == T_MUL)
    {
        strcat(derivacoes, "T_ -> * F T_\n");
        if(F())
        {
            if(T_())
            {
                printf("MUL\n", yytext);
                return TRUE;
            }
        }
        derivacoes[l] = '\0';
        return FALSE;
    }
    else if(token == T_DIV)
    {
        strcat(derivacoes, "T_ -> / F T_\n");
        if(F())
        {
            if(T_())
            {
                printf("DIV\n", yytext);
                return TRUE;
            }
        }
        derivacoes[l] = '\0';
        return FALSE;
    }
    else
    {
       unput(*(yytext));
    }
    token = yylex();
    if(token == T_END)
    {
        strcat(derivacoes, "T_ -> e\n");
        return TRUE;
    }
    unput(*(yytext));
    strcat(derivacoes, "T_ -> e\n");
    return TRUE; //producao vazia aceita
}

int T()
{
    //T  -> F T_
    int l;
    l=strlen(derivacoes);
    strcat(derivacoes, "T -> F T_\n");
    if(F())
    {
        if(T_())
        {

            return TRUE;
        }
    }
    derivacoes[l]='\0';
    return FALSE;
}

int F()
{
    int token;
    int l;
    l=strlen(derivacoes);
    //F  -> (E)
    //  | T_INTEGER
    //  | T_FLOAT
    token = yylex();
    if(token == T_AP)
    {
        strcat(derivacoes, "F -> (E)\n");
        if(E())
        {
            token = yylex();
            if(token == T_FP)
            {

                return TRUE;
            }
        }
        derivacoes[l]='\0';
    }
    else if(token == T_INTEGER)
    {
        strcat(derivacoes, "F -> (INTEGER)\n");
        printf("LOAD %s\n", yytext);
        return TRUE;
    }
    else if(token == T_FLOAT)
    {
        strcat(derivacoes, "F -> (FLOAT)\n");
        printf("LOAD %s\n", yytext);
        return TRUE;
    }
    else
    {
        printf("NAO RECONHECIDO: '%s'\n", yytext);
    }
    unput(*(yytext+1));
    return FALSE;
}


int main(int argc, char **argv)
{
    int r,token;
    derivacoes[0] = '\0';
    printf("Digite uma expressao terminando com ';'\n--> ");
    yyin = stdin;

    r = E();

    if(r && FINAL_TOTAL)
    {
        printf("\nSUCESSO\n\nArvore (derivacao mais a esquerda)\n");
        printf("%s", derivacoes);
    }
    else {printf("ERRO\n"); return -1;}

    printf("Qualquer entrada para sair...");
    scanf(derivacoes,"%s");

    return 0;
}
