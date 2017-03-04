%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <vector>
#include <stack>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

using namespace std;

vector<int> postfixe;
vector<double> valeurs;

%}

%union {
	int ival;
	double fval;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT N_EXP T_SIN N_PI T_COS T_TAN T_ACOS T_ASIN T_ATAN
%token T_NEWLINE T_QUIT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> expression
%type<fval> mixed_expression

%start calculation

%%

calculation:
	   | calculation line
;

line: T_NEWLINE
    | mixed_expression T_NEWLINE { printf("\n%.20g\n", $1);}
    | expression T_NEWLINE { printf("%i\n", $1); }
    | T_QUIT T_NEWLINE { printf("bye!\n"); exit(0); }
;

mixed_expression: T_FLOAT                 		 { postfixe.push_back(T_FLOAT); valeurs.push_back($1);}
	  | mixed_expression T_PLUS mixed_expression	 {postfixe.push_back(T_PLUS); valeurs.push_back(0);}
	  | mixed_expression T_MINUS mixed_expression	 { $$ = $1 - $3; printf("- ");}
		| mixed_expression T_MULTIPLY mixed_expression { $$ = $1 * $3; printf("* ");}
	  | mixed_expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; printf("/ ");}
	  | T_LEFT mixed_expression T_RIGHT		 { $$ = $2; }
	  | expression T_PLUS mixed_expression	 	 { postfixe.push_back(T_PLUS); valeurs.push_back(0); }
	  | expression T_MINUS mixed_expression	 	 { $$ = $1 - $3; }
	  | expression T_MULTIPLY mixed_expression 	 { $$ = $1 * $3; }
	  | expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
	  | mixed_expression T_PLUS expression	 	 { $$ = $1 + $3; }
	  | mixed_expression T_MINUS expression	 	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY expression 	 { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE expression	 { $$ = $1 / $3; }
	  | expression T_DIVIDE expression		 { $$ = $1 / (float)$3; }
    | T_MINUS expression    {$$ = -$2; }
    | N_EXP {$$=2.71828182846; }
      |T_SIN T_LEFT mixed_expression T_RIGHT {$$=sin($3);}
      |N_PI {$$ = M_PI;}
      |T_COS T_LEFT mixed_expression T_RIGHT {$$=cos($3);}
      |T_TAN T_LEFT mixed_expression T_RIGHT {$$=tan($3);}
      |T_ACOS T_LEFT mixed_expression T_RIGHT {$$=acos($3);}
      |T_ASIN T_LEFT mixed_expression T_RIGHT {$$=asin($3);}
      |T_ATAN T_LEFT mixed_expression T_RIGHT {$$=atan($3);}
      ;

expression: T_INT				{ $$ = $1; printf("%d ", $1);}
	  | expression T_PLUS expression	{ $$ = $1 + $3; printf("+");}
	  | expression T_MINUS expression	{ $$ = $1 - $3; printf("-");}
	  | expression T_MULTIPLY expression	{ $$ = $1 * $3; printf("*");}
	  | T_LEFT expression T_RIGHT		{ $$ = $2; printf("/");}
	  | T_SIN T_LEFT expression T_RIGHT		 { $$ = sin($3);}
      |T_COS T_LEFT expression T_RIGHT {$$=cos($3);}
      |T_TAN T_LEFT expression T_RIGHT {$$=tan($3);}
      |T_ACOS T_LEFT expression T_RIGHT {$$=acos($3);}
      |T_ASIN T_LEFT expression T_RIGHT {$$=asin($3);}
      |T_ATAN T_LEFT expression T_RIGHT {$$=atan($3);}
      ;

%%


double eval(double x){
	stack <double> pile;

	double a, b,

	for (int i = 0; i < postfixe.size(); i++){

		switch(postfixe[i]){
			T_FLOAT:
						pile.push(valeurs[i]);
				break;
			T_PLUS :
				a = pile.top(); pile.pop();
				b = pile.top(); pile.pop();
				pile.push(a+b);
			break;

	}


return pile.top();

	}


}

int main() {
	yyin = stdin;

	yyparse();

  for (int i = 0; i<10; i++)
	 cout << eval (i) << endl;

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
