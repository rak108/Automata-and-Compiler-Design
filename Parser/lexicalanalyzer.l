%{
#include <stdio.h> 
#include <stdlib.h> 
#include "y.tab.h" 
extern int yycolumn;
extern int yyleng;
int yylinenumber=1;
%}

PREPROCESSOR 		#(include<.*>|define.*|ifdef|endif|ifndef|undef|"include <.*>")
MAINFUNCTION 		"main"
KEYWORD-DATATYPE 	char|int|float|double|long|short|signed|unsigned|void
IDENTIFIER 			[a-zA-Z_]([a-zA-Z0-9_])*
NUMERICAL_CONSTANT	([0-9]+|[0-9]+\.[0-9]+)
OPERATOR			\+|\-|\/|\*|\%|>=|>|<|<=|==|!=|&&|\|\||!|=|\+=|\-=|\*=|\/=|\%=|<<=|>>=|&=|\^=|\|=
OPERATOR-UNARY		(\+\+|\-\-)	
CHARACTER			[=(){};]
WHITESPACE			[ \t\v\f]

%%

\n 					 { yycolumn = 0; yylinenumber++; }
{PREPROCESSOR}		 { yycolumn += yyleng; return PP; }
{MAINFUNCTION}  	 {yycolumn += 4; return MF; }
{KEYWORD-DATATYPE}   {yycolumn += yyleng; return KW;}
"if"            	 { yycolumn += 2; return IF; }
"for"           	 { yycolumn += 3; return FOR; }
"else"          	 { yycolumn += 4; return ELSE; }
{IDENTIFIER}		 { yycolumn += yyleng; return ID; }
{NUMERICAL_CONSTANT} { yycolumn += yyleng; return NUM; }
{OPERATOR}			 { yycolumn += yyleng; return OP; }
{OPERATOR-UNARY}     { yycolumn += yyleng; return OP_UNARY; }
{CHARACTER}   	     { yycolumn++; return yytext[0]; }
{WHITESPACE}    	 { yycolumn += yyleng; }
.					 { yycolumn += 1; return yytext[0];}

%%
  
int yywrap() {  
	return -1;  
}
