%{

#include <stdio.h>
#include <stdlib.h>
#include <cmath>
#include <vector>
#include <stack>
#include <iostream>
#include <iomanip>
#include <string>
#include <string.h>
#include <map>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

using namespace std;

vector<int> postfixe;
vector<double> valeurs;
map<string, pair<vector<int>, vector<double> > > values;
vector<string> variables;
map<string, vector<string> > variablesTable;
double step = 0.1;
//char current[256];
string current;
%}

%union {
	int ival;
	double fval;
	char* sname;
}

%token<fval> T_FLOAT
%token T_VARIABLE T_EQUAL T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT N_EXP T_SIN N_PI T_COS T_TAN T_ACOS T_ASIN T_ATAN T_SINH T_COSH T_TANH T_ACOSH T_ASINH T_ATANH T_NEGATIVE T_SQRT T_X T_ABS T_LOG10 T_LOG2 T_LOG T_ROUND T_TRUNC T_CEIL T_FLOOR
%token T_POW
%token T_NEWLINE T_QUIT
%token<sname> T_NAME
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE
%left T_POW


%type<fval> expression

%start calculation

%%

calculation:
	   | calculation line
;

line: T_NEWLINE
    | T_NAME T_EQUAL expression T_NEWLINE { //printf("\n%.20g 11\n", $1);
				//strcpy(current, $1);
				current = $1;
				//cout << "sname: " << current;
				//cout << postfixe.size() << endl;
				values[current] = make_pair(postfixe, valeurs);
				variablesTable[current] = variables;
				postfixe.clear();
				valeurs.clear();
				variables.clear();
			}
		/*| T_NAME T_LEFT T_X T_RIGHT T_EQUAL expression T_NEWLINE{
			current = $1;
			//cout << "sname: " << current;
			//cout << postfixe.size() << endl;
			values[current] = make_pair(postfixe, valeurs);
			postfixe.clear();
			valeurs.clear();
		}*/
		| expression T_NEWLINE
    | T_QUIT T_NEWLINE { printf("bye!\n"); exit(0); }
;

expression: T_FLOAT                 		 {postfixe.push_back(T_FLOAT); valeurs.push_back($1);}
	  | expression T_PLUS expression	 {$$ = $1+$3; postfixe.push_back(T_PLUS); valeurs.push_back(0);}
	  | T_LEFT expression T_RIGHT		 { $$ = $2; }
	  | expression T_MINUS expression	 	 { $$ = $1 - $3; postfixe.push_back(T_MINUS); valeurs.push_back(0);}
	  | expression T_MULTIPLY expression 	 { $$ = $1 * $3; postfixe.push_back(T_MULTIPLY); valeurs.push_back(0);}
	  | expression T_DIVIDE expression		 { $$ = $1 / (float)$3; postfixe.push_back(T_DIVIDE); valeurs.push_back(0);}
		| expression T_POW expression	{postfixe.push_back(T_POW); valeurs.push_back(0);}
    | T_MINUS expression    {$$ = -$2; postfixe.push_back(T_NEGATIVE); valeurs.push_back(0);}
    | N_EXP {$$=M_E; postfixe.push_back(T_FLOAT); valeurs.push_back(2.71828182846);}
		| T_X {postfixe.push_back(T_X); valeurs.push_back(0);}
		| T_NAME {postfixe.push_back(T_VARIABLE); valeurs.push_back(0); variables.push_back($1);}
		| T_SQRT T_LEFT expression T_RIGHT {$$=sqrt($3); postfixe.push_back(T_SQRT); valeurs.push_back(0);}
		|T_ABS T_LEFT expression T_RIGHT {$$=abs($3); postfixe.push_back(T_ABS); valeurs.push_back(0);}
		|T_LOG10 T_LEFT expression T_RIGHT {$$=log10($3); postfixe.push_back(T_LOG10); valeurs.push_back(0);}
		|T_LOG2 T_LEFT expression T_RIGHT {$$=log2($3); postfixe.push_back(T_LOG2); valeurs.push_back(0);}
		|T_LOG T_LEFT expression T_RIGHT {$$=log($3); postfixe.push_back(T_LOG); valeurs.push_back(0);}
		|T_CEIL T_LEFT expression T_RIGHT {$$=ceil($3); postfixe.push_back(T_CEIL); valeurs.push_back(0);}
		|T_FLOOR T_LEFT expression T_RIGHT {$$=floor($3); postfixe.push_back(T_FLOOR); valeurs.push_back(0);}
		|T_TRUNC T_LEFT expression T_RIGHT {$$=trunc($3); postfixe.push_back(T_TRUNC); valeurs.push_back(0);}
		|T_ROUND T_LEFT expression T_RIGHT {$$=round($3); postfixe.push_back(T_ROUND); valeurs.push_back(0);}
    |T_SIN T_LEFT expression T_RIGHT {$$=sin($3); postfixe.push_back(T_SIN); valeurs.push_back(0);}
    |N_PI {$$ = M_PI; postfixe.push_back(T_FLOAT); valeurs.push_back(M_PI);}
    |T_COS T_LEFT expression T_RIGHT {$$=cos($3); postfixe.push_back(T_COS); valeurs.push_back(0);}
    |T_TAN T_LEFT expression T_RIGHT {$$=tan($3); postfixe.push_back(T_TAN); valeurs.push_back(0);}
    |T_ACOS T_LEFT expression T_RIGHT {$$=acos($3); postfixe.push_back(T_ACOS); valeurs.push_back(0);}
    |T_ASIN T_LEFT expression T_RIGHT {$$=asin($3); postfixe.push_back(T_ASIN); valeurs.push_back(0);}
    |T_ATAN T_LEFT expression T_RIGHT {$$=atan($3); postfixe.push_back(T_ATAN); valeurs.push_back(0);}
		|T_SINH T_LEFT expression T_RIGHT {$$=sinh($3); postfixe.push_back(T_SINH); valeurs.push_back(0);}
		|T_COSH T_LEFT expression T_RIGHT {$$=cosh($3); postfixe.push_back(T_COSH); valeurs.push_back(0);}
		|T_TANH T_LEFT expression T_RIGHT {$$=tanh($3); postfixe.push_back(T_TANH); valeurs.push_back(0);}
		|T_ACOSH T_LEFT expression T_RIGHT {$$=acosh($3); postfixe.push_back(T_ACOSH); valeurs.push_back(0);}
		|T_ASINH T_LEFT expression T_RIGHT {$$=asinh($3); postfixe.push_back(T_ASINH); valeurs.push_back(0);}
		|T_ATANH T_LEFT expression T_RIGHT {$$=atanh($3); postfixe.push_back(T_ATANH); valeurs.push_back(0);}
		|T_NAME T_LEFT expression T_RIGHT {postfixe.push_back(T_NAME); valeurs.push_back(0); variables.push_back($1);}
    ;
%%


double eval(double x, string name){
	stack <double> pile;
	/*cout << "current: "  << current;
	for (int i = 0; i<postfixe.size(); i++){
		cout << "Test: " << postfixe[i]<< endl;

	}*/
	int T_NAME_Counter = 0;
	double a, b;
	for (int i = 0; i < values[name].first.size(); i++){
		switch(values[name].first[i]){
			case T_FLOAT:
				pile.push(values[name].second[i]);
			break;
			case T_X:
				pile.push(x);
			break;
			case T_VARIABLE:
				if(values[variablesTable[name][T_NAME_Counter]].first.size()>1){
					cout << "{ \"error\" : \"" << variablesTable[name][T_NAME_Counter] << " is a function you have to write: " << variablesTable[name][T_NAME_Counter] << "(x)\"  }";
					exit(1);
				}
				pile.push(eval(0, variablesTable[name][T_NAME_Counter]));
				T_NAME_Counter++;
			break;
			case T_NAME:
				a = pile.top(); pile.pop();
				pile.push(eval(a, variablesTable[name][T_NAME_Counter]));
				T_NAME_Counter++;
			break;
			case T_PLUS :
				a = pile.top(); pile.pop();
				b = pile.top(); pile.pop();
				pile.push(a+b);
			break;
			case T_MINUS :
				a = pile.top(); pile.pop();
				b = pile.top(); pile.pop();
				pile.push(b-a);
			break;
			case T_NEGATIVE:
				a = pile.top(); pile.pop();
				pile.push(-a);
			break;
			case T_MULTIPLY :
				a = pile.top(); pile.pop();
				b = pile.top(); pile.pop();
				pile.push(a*b);
			break;
			case T_DIVIDE :
				a = pile.top(); pile.pop();
				b = pile.top(); pile.pop();
				if(abs(a/2)> step){pile.push(b/a);}
				else pile.push(NAN);
			break;
			case T_SQRT:
				a = pile.top(); pile.pop();
				pile.push(sqrt(a));
			break;
			case T_ABS:
				a = pile.top(); pile.pop();
				pile.push(abs(a));
			break;
			case T_LOG10:
				a = pile.top(); pile.pop();
				pile.push(log10(a));
			break;
			case T_LOG2:
				a = pile.top(); pile.pop();
				pile.push(log2(a));
			break;
			case T_LOG:
				a = pile.top(); pile.pop();
				pile.push(log(a));
			break;
			case T_CEIL:
				a = pile.top(); pile.pop();
				pile.push(ceil(a));
			break;
			case T_FLOOR:
				a = pile.top(); pile.pop();
				pile.push(floor(a));
			break;
			case T_TRUNC:
				a = pile.top(); pile.pop();
				pile.push(trunc(a));
			break;
			case T_ROUND:
				a = pile.top(); pile.pop();
				pile.push(round(a));
			break;

			case T_COS:
				a = pile.top(); pile.pop();
				pile.push(cos(a));
			break;
			case T_SIN:
				a = pile.top(); pile.pop();
				pile.push(sin(a));
			break;
			case T_TAN:
				a = pile.top(); pile.pop();
				if((M_PI/2)-0.01<=fmod(abs(a),(M_PI/2)) && fmod(abs(a),(M_PI/2))<=(M_PI/2)+0.01){
					pile.push(NAN);
				}else{
					pile.push(tan(a));
				}
			break;
			case T_ACOS:
				a = pile.top(); pile.pop();
				pile.push(acos(a));
			break;
			case T_ASIN:
				a = pile.top(); pile.pop();
					pile.push(asin(a));
				
			break;
			case T_ATAN:
				a = pile.top(); pile.pop();
				pile.push(atan(a));
			break;

			case T_COSH:
				a = pile.top(); pile.pop();
				pile.push(cosh(a));
			break;
			case T_SINH:
				a = pile.top(); pile.pop();
				pile.push(sinh(a));
			break;
			case T_TANH:
				a = pile.top(); pile.pop();
				pile.push(tanh(a));
			break;
			case T_ACOSH:
				a = pile.top(); pile.pop();
				pile.push(acosh(a));
			break;
			case T_ASINH:
				a = pile.top(); pile.pop();
				pile.push(asinh(a));
			break;
			case T_ATANH:
				a = pile.top(); pile.pop();
				pile.push(atanh(a));
			break;

			case T_POW:
				a = pile.top(); pile.pop();
				b = pile.top(); pile.pop();
				pile.push(pow(b,a));
			break;




		}



		//cout << "Postfix: " << postfixe[i] << " | Valeur: " << valeurs[i] << endl;

	}
	return pile.top();


}

int main( int argc, char **argv ) {
	int xBegin = 0;
	int xEnd = 10;

	if(argc > 2){
		if(atoi(argv[1]) < atoi(argv[2])){
			xBegin = atoi(argv[1]);
			xEnd = atoi(argv[2]);
		}else{
			xBegin = atoi(argv[2]);
			xEnd = atoi(argv[1]);
		}
		step = atof(argv[3]);

		//cout << "XBegin: " << xBegin << "; XEnd: " << xEnd << "; Step" << step << endl;
	}

	yyin = stdin;
	yyparse();

	//check function is correct;
	for (map<string, pair<vector<int>, vector<double> > >::iterator it=values.begin(); it!=values.end(); ++it){
		eval(0, it->first);
	}


		double result;
		cout << "[";
		    for (map<string, pair<vector<int>, vector<double> > >::iterator it=values.begin(); it!=values.end(); ++it){
		        if(it == values.begin()){
							cout<<"\{\"name\": \""<< it->first << "\", \"array\":";
		        }
		        else{
		            cout<<",\{\"name\": \""<< it->first << "\", \"array\":";
		        }
		        cout<<"[";
		      for (double i = xBegin; i<=xEnd; i+=step)    {
		            if(i == xBegin)
		                cout << "[";
		            else
		                cout << ",[";
								result = eval (i, it->first);
								if(isnan(result)){
									cout << i << ", null]" << endl;
								}else{
		            	cout << i << ", " << setprecision(15) <<  result << "]" << endl;
								}
		        }
		        cout<<"]}";
		    }
		    cout << "]";

		return 0;
}

void yyerror(const char* s) {
	//fprintf(stderr, "Parse error: %s\n", s);
	//exit(1);
	cout << "{\"error\" : \"Syntax Error\"}";
	exit(1);
}
