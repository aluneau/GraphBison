/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_CALC_TAB_H_INCLUDED
# define YY_YY_CALC_TAB_H_INCLUDED
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
    T_FLOAT = 258,
    T_VARIABLE = 259,
    T_EQUAL = 260,
    T_PLUS = 261,
    T_MINUS = 262,
    T_MULTIPLY = 263,
    T_DIVIDE = 264,
    T_LEFT = 265,
    T_RIGHT = 266,
    N_EXP = 267,
    T_SIN = 268,
    N_PI = 269,
    T_COS = 270,
    T_TAN = 271,
    T_ACOS = 272,
    T_ASIN = 273,
    T_ATAN = 274,
    T_SINH = 275,
    T_COSH = 276,
    T_TANH = 277,
    T_ACOSH = 278,
    T_ASINH = 279,
    T_ATANH = 280,
    T_NEGATIVE = 281,
    T_SQRT = 282,
    T_X = 283,
    T_ABS = 284,
    T_LOG10 = 285,
    T_LOG2 = 286,
    T_LOG = 287,
    T_ROUND = 288,
    T_TRUNC = 289,
    T_CEIL = 290,
    T_FLOOR = 291,
    T_POW = 292,
    T_NEWLINE = 293,
    T_QUIT = 294,
    T_NAME = 295
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 32 "calc.y" /* yacc.c:1915  */

	int ival;
	double fval;
	char* sname;

#line 101 "calc.tab.h" /* yacc.c:1915  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_CALC_TAB_H_INCLUDED  */
