clear
clear
flex lexer.l
bison -d sl_parser.y
gcc lex.yy.c sl_parser.tab.c -o sl_parser
