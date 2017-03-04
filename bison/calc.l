%option noyywrap
%{
#include <stdio.h>
#include <string>
#define YY_DECL int yylex()

#include "calc.tab.h"

%}

%%

[ \t]	; // ignore all whitespace
\n|;		{return T_NEWLINE;}

[0-9]+\.[0-9]+ 	{yylval.fval = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval.fval = atoi(yytext); return T_FLOAT;}
[pP][iI] {return N_PI;}

"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}

"("		{return T_LEFT;}
")"		{return T_RIGHT;}

"^"   {return T_POW;}
[sS][qQ][rR][tT] {return T_SQRT;}
[aA][bB][sS]  {return T_ABS;}
[lL][oO][gG]_?10  {return T_LOG10;}
[lL][oO][gG]_?2  {return T_LOG2;}
[lL][oO][gG]  {return T_LOG;}
[cC][eE][iI][lL]  {return T_CEIL;}
[fF][lL][oO]{2}[rR] {return T_FLOOR;}
[tT][rR][uU][nN][cC]  {return T_TRUNC;}
[rR][oO][uU][nN][dD]  {return T_ROUND;}

[aA][sS][iI][nN][hH] {return T_ASINH;}
[aA][cC][oO][sS][hH] {return T_ACOSH;}
[aA][tT][aA][nN][hH] {return T_ATANH;}

[aA][sS][iI][nN] {return T_ASIN;}
[aA][cC][oO][sS] {return T_ACOS;}
[aA][tT][aA][nN] {return T_ATAN;}

[sS][iI][nN][hH] {return T_SINH;}
[cC][oO][sS][hH] {return T_COSH;}
[tT][aA][nN][hH] {return T_TANH;}

[sS][iI][nN] {return T_SIN;}
[cC][oO][sS] {return T_COS;}
[tT][aA][nN] {return T_TAN;}

"x" {return T_X;}
"e"   {return N_EXP;}

"=" {return T_EQUAL;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}
[a-z]+ {yylval.sname = strdup(yytext); return T_NAME;}

%%
