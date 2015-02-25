/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SL_PARSER_TAB_H_INCLUDED
# define YY_YY_SL_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFIER = 100,
    VALUE = 101,
    PLUS = 102,
    MINUS = 103,
    DIVIDE = 104,
    TIMES = 105,
    LESS = 106,
    GREATER = 107,
    LESSEQ = 108,
    GREATEREQ = 109,
    EQUALS = 110,
    NEQUALS = 111,
    AND = 112,
    OR = 113,
    NOT = 114,
    SEMICOLON = 115,
    ASSIGN = 116,
    OPEN_PARENS = 117,
    CLOSE_PARENS = 118,
    START = 119,
    END = 120,
    IF = 121,
    THEN = 122,
    ELSE = 123,
    WHILE = 124,
    DO = 125,
    PRINT = 126,
    INPUT = 127
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 64 "sl_parser.y" /* yacc.c:1909  */
 char* char_array; struct Node * node; double Double;

#line 88 "sl_parser.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SL_PARSER_TAB_H_INCLUDED  */
