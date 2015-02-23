%{
%}

%option noyywrap

%%

%.*$           {;}
[1-9]*[0-9]*(\.)?[0-9]*     {return VALUE;}
"+"                     {return PLUS;}
"-"                     {return MINUS;}
"/"                     {return DIVIDE;}
"*"                     {return MULTIPLY;}
"<"                     {return LESS_THAN;}
">"                     {return GREATER_THAN;}
"<="                    {return LESS_THAN_OR_EQUAL;}
">="                    {return GREATER_THAN_OR_EQUAL;}
"=="                    {return EQUAL;}
"!="                    {return NOT_EQUAL;}
"&&"                    {return AND;}
"||"                    {return OR;}
"!"                     {return NOT;}
";"                     {return SEMICOLON;}
":="                    {return SET_EQUAL;}
"("                     {return OPEN_PARENS;}
")"                     {return CLOSE_PARENS;}
"begin"                 {return START;}
"end"                   {return END;}
"if"                    {return IF;}
"then"                  {return THEN;}
"else"                  {return ELSE;}
"while"                 {return DO;}
"print"                 {return PRINT;}
"input"                 {return INPUT;}
[ \t\n]                 {;}
[_a-zA-Z0-9]*[a-zA-Z0-9]*         {return IDENTIFIER;}
.                       {printf("unexpected character\n");}
%%

int main(int argc, char* argv[])
{
	stdin = fopen(argv[1], "r");	
	int token;
	do {
    		token = yylex( );
    		printf("%d\n",token);
    		/* handle each type of token */

  	} while(token != 0);
        return 0;
}
