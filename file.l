%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "file.tab.h"
int condition = 0;
int update = 0;
int delete = 0;
%}

%%

student                 {   
                            if(update)
                            {
                                strcat(yylval.ch, " student set");
                            }
                            else if(delete)
                            {
                                strcat(yylval.ch, " from student");
                            }
                            else
                            {
                                strcat(yylval.ch, " student");
                            }
                            return TABLE;
                        }
all                     {   strcat(yylval.ch, " *");
                            return '*';
                        }
show|give|select	    {   strcat(yylval.ch, " select");
                            return SELECT;
                        }
insert|add              {   strcat(yylval.ch, " insert");
                            return INSERT;
                        }
update|modify           {   strcat(yylval.ch, " update");
                            update = 1;
                            return UPDATE;
                        }
delete|remove           {   strcat(yylval.ch, " delete");
                            delete = 1;
                            return DELETE;
                        }
create                  {   strcat(yylval.ch, " create");
                            return CREATE;
                        }
database                {   strcat(yylval.ch, " database");
                            return DATABASE;
                        }
from|for				{   strcat(yylval.ch, " from");
                            return FROM;
                        }
where|whose|having	    {   strcat(yylval.ch, " where");
                            condition = 1;
                            return WHERE;
                        }
values                  {   strcat(yylval.ch, " values");
                            return VALUES;
                        }
into                    {   strcat(yylval.ch, " into");
                            return INTO;
                        }
and						{   
                            if(condition)
                            {
                                strcat(yylval.ch, " and");
                                return AND;
                            }
                            strcat(yylval.ch, " ,");
                            return ',';
                        }
or                      {   strcat(yylval.ch, " or");
                            return OR;
                        }
set                     {   strcat(yylval.ch, " set");
                            return SET;
                        }
roll                    {   strcat(yylval.ch, " Roll");
                            return ROLL;
                        };
                        
name                    {   strcat(yylval.ch, " Name");
                            return NAME;
                        };
id                      {   strcat(yylval.ch, " id");
                            return ID;
                        };
cpi                     {   strcat(yylval.ch, " cpi");
                            return CPI;
                        };                        
greater|[>]             {   if(condition)
                            {
                                strcat(yylval.ch, " >");
                                return '>';
                            }
                        };
smaller|[<]             {   if(condition)
                            {
                                strcat(yylval.ch, " <");
                                return '<';
                            }
                        };                        
[*]						{   strcat(yylval.ch, " *");
                            return *yytext;
                        }
[,]						{   strcat(yylval.ch, " ,");
                            return *yytext;
                        }

is|[=]|equals|as	    {   if(condition)
                            {
                                strcat(yylval.ch, " =");
                                return '=';
                            }
                        }
to                      {   strcat(yylval.ch, " =");
                            return '=';
                            
                        } 
[.|;]                   {   strcat(yylval.ch, ";\n");
                            return ';';
                        }
[0-9]+|[0-9]*[.][0-9]+                  {   strcat(yylval.ch, " ");
                            strcat(yylval.ch, yytext);
                            return NUMBER;
                        }
\"[a-zA-Z]*\"           {   strcat(yylval.ch, yytext);
                            return WORD;
                        }

\n						return *yytext;
[ \t]+					/* ignore whitespace */;
.                       ;
%%