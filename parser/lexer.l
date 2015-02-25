%{
#include "sl_parser.tab.h"
%}

%option noyywrap

%%

%.*$                      { ;}
[1-9]*[0-9]*(\.)?[0-9]*   { return VALUE;}
"+"                       { return PLUS;}
"-"                       { return MINUS;}
"/"                       { return DIVIDE;}
"*"                       { return TIMES;}
"<"                       { return LESS;}
">"                       { return GREATER;}
"<="                      { return LESSEQ;}
">="                      { return GREATEREQ;}
"=="                      { return EQUALS;}
"!="                      { return NEQUALS;}
"&&"                      { return AND;}
"||"                      { return OR;}
"!"                       { return NOT;}
";"                       { return SEMICOLON;}
":="                      { return ASSIGN;}
"("                       { return OPEN_PARENS;}
")"                       { return CLOSE_PARENS;}
"begin"                   { return START;}
"end"                     { return END;}
"if"                      { return IF;}
"then"                    { return THEN;}
"else"                    { return ELSE;}
"while"                   { return DO;}
"print"                   { return PRINT;}
"input"                   { return INPUT;}
[ \t\n]                   { ;}
[_a-zA-Z0-9]*[a-zA-Z0-9]* { return IDENTIFIER;}
.                         { printf("unexpected character\n");}
%%

/*
int main(int argc, char* argv[])
{
	stdin = fopen(argv[1], "r");	
	int token;
	do {
    		token = yylex( );
    		printf("%d\n",token);
//    		 handle each type of token 

  	} while(token != 0);
        return 0;
} */
