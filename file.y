%{

#include <stdio.h>
#include <stdlib.h>

void yyerror (const char *str) {
	fprintf(stderr, "error: %s\n", str);
}
int yylex();
%}

%union
{
    int num;
    char* ch;
}

%%

%token SELECT CREATE DATABASE DELETE INSERT INTO FROM TABLE WHERE AND SET UPDATE IDENTIFIER OR VALUES SEMI;
%token ROLL NAME CPI NUMBER WORD ID;



line: SELECT fields FROM TABLE ';' '\n' { printf("%s", yylval.ch);exit(0);};
line: SELECT fields FROM TABLE WHERE nested ';' '\n' { printf("%s", yylval.ch);exit(0);};
line: UPDATE TABLE update_nested WHERE nested ';' '\n' { printf("%s", yylval.ch);exit(0);};
line: DELETE TABLE  WHERE nested ';' '\n' { printf("%s", yylval.ch);exit(0);};



fields: field | field ',' field| '*';
field : ROLL | CPI | NAME| ID;
name_value: NAME '=' WORD | ROLL '=' NUMBER | CPI '=' NUMBER | ID '=' NUMBER;
update_nested: name_value ',' name_value | name_value;

nested: condition | condition AND condition;
condition: ROLL '=' NUMBER | ROLL '>' NUMBER| ROLL '<' NUMBER | CPI '=' NUMBER | CPI '<' NUMBER | CPI '>' NUMBER | ID '=' NUMBER | ID '<' NUMBER | ID '>' NUMBER | NAME '=' WORD ;


%%

int yywrap() {
	return 1;
}

int main() 
{
	yylval.ch = (char*)calloc(100, sizeof(char));
	freopen("input.txt", "r", stdin);
	freopen("out.txt", "w", stdout);
	yyparse();
}



