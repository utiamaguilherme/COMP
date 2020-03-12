#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include "tokens.h"
#include "lex.yy.c"

#define STACK_SIZE 500
#define EMPTY -9999

void stackInit(int *stack){
    int i;
    for(i=0; i<STACK_SIZE; i++)
    {
        stack[i] = EMPTY;
    }
}

void stackPush(int *stack, int val)
{
    int i;
    for(i=0; i<STACK_SIZE; i++)
    {
        if(stack[i] == EMPTY) break;
    }
    stack[i] = val;
}

int isStackEmpty(int *stack){
    return stack[0] == EMPTY;
}

int stackPop(int *stack)
{
    int i;
    int r;
    if(stack[0] == EMPTY)
    {
        printf("Error stack empty");
        exit(0);
        return EMPTY;
    }
    for(i=0; i<STACK_SIZE; i++)
    {
        if(stack[i] == EMPTY) break;
    }
    r = stack[i-1];
    stack[i-1] = EMPTY;
    return r;
}

void printError(char *str){
    printf("Erro na linha %d\n", lineCounter);
    printf("%s\n",str);
    exit(1);
}

int automataParse()
{
    int state = 0;
    int stack[STACK_SIZE];
    int token;

    stackInit(stack);

    while(1)
    {
        token = yylex();
        if(token == 0){
            if(state == 0){
                if(isStackEmpty(stack)){
                    printf("Sucesso.");
                    exit(0);
                }else{
                    printf("Pilha nao vazia.\n");
                }
            }else{
                printf("Erro. Parou no estado: %d\n", state);
                printf("Linha %d\n", lineCounter);
                exit(1);
            }
        }
        switch(state)
        {
        case 0:
            if(token == T_END)
            {
                if(stackPop(stack) == T_BEGIN)
                {

                }else{
                    printError("Erro ao fechar END.\n");
                }
            }
            else if(token == T_ID)
            {
                state = 2;
            }else if(token == T_IF)
            {
                state = 4;
            }else{
                printError("Erro de sintaxe.\n");
            }
            break;
        case 1:
            if(token == T_SC){
                state = 0;
            }else{
                printError("Erro de sintaxe. Era esperado ';'.\n");
            }
            break;
        case 2:
            if(token == T_EQ){
                state = 3;
            }else{
                printError("Erro de sintaxe. Era esperado ':='.\n");
            }
            break;
        case 3:
            if(token == T_ID){
                state = 1;
            }else{
                printError("Erro de sintaxe. Era esperado um id ou numero\n");
            }
            break;
        case 4:
            if(token == T_ID){
                state = 7;
            }else{
                printError("Erro de sintaxe. Era esperado um id\n");
            }
            break;
        case 7:
            if(token == T_THEN){
                state = 5;
            }else{
                printError("Erro de sintaxe. Era esperado um 'then'\n");
            }
            break;
        case 5:
            if(token == T_BEGIN){
                    stackPush(stack,T_BEGIN);
                state = 0;
            }else{
                printError("Erro de sintaxe. Era esperado um 'begin'\n");
            }
            break;
        default:
            printError("Erro, nenhum estado possivel.\n");
            exit(1);
            break;

        }

    }

}


int main(int argc, char **argv)
{
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;
    automataParse();
    return 0;
}
