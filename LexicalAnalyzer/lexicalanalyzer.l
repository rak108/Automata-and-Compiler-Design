%{
int linenumber = 0;
int identifierscount = 0;
int numberscount = 0;
int numberofcomments = 0;
int numberofkeywords = 0;
%}

PREPROCESSOR #(include<.*>|define.*|ifdef|endif|ifndef|undef|"include <.*>")
MAINFUNCTION "main"
INBUILT_FUNCTIONS-STDIO printf|scanf|fopen|getc|gets|putc|puts|fclose|fgets|fputs(?#)
KEYWORD auto|const|enum|extern|register|sizeof|static|struct|typedef|union|volatile
KEYWORD-CONTROL_STATEMENT break|continue|do|else|if|while|for|switch|case|default|goto|"return"
KEYWORD-DATATYPE char|int|float|double|long|short|signed|unsigned|void
INVALID_IDENTIFIER [0-9]+[a-zA-Z_]+|[a-zA-Z0-9_\$\#:?]+[\$\#:?]*[a-zA-Z0-9_\$\#:?]
IDENTIFIER [_a-zA-Z][_a-zA-Z0-9]*
STRING \"[^\n]*\"
CHARACTER \'[a-zA-Z0-9]\'
NUMERICAL_CONSTANT [0-9]+(\.[0-9])?|0(\.[0-9]+)?
OPERATOR-UNARY (\+\+|\-\-)
OPERATOR-ARITHMETIC \+|\-|\/|\*|\%
OPERATOR-RELATIONAL >=|>|<|<=|==|!=
OPERATOR-LOGICAL &&|\|\||!
OPERATOR-BITWISE &|~|\||\^|<<|>>
OPERATOR-ASSIGNMENT =|\+=|\-=|\*=|\/=|\%=|<<=|>>=|&=|\^=|\|=
COMMENT-SINGLELINE \/\/.*
COMMENT-MULTILINE (\/\*)(.|\n)+?(\*\/)
PARENTHESIS \(|\)|\[|\]|\{|\}
SEMICOLON ;
COMMA ,
PERIOD \.

%option noyywrap

%%


\n linenumber++;
[\t ] ;
{PREPROCESSOR} {fprintf(yyout,"%30s \t--->\tPREPROCESSOR \t%30d\n", yytext,linenumber+1);}
{MAINFUNCTION} {fprintf(yyout,"%30s \t--->\tMAIN FUNCTION \t%30d\n", yytext,linenumber+1);}
{INBUILT_FUNCTIONS-STDIO} {fprintf(yyout,"%30s \t--->\tINBUILT LIBRARY FUNCTION: STDIO \t%7d\n", yytext,linenumber+1);}
{KEYWORD} {fprintf(yyout,"%30s \t--->\tKEYWORD \t%30d\n", yytext,linenumber+1); numberofkeywords++;}
{KEYWORD-CONTROL_STATEMENT} {fprintf(yyout,"%30s \t--->\tKEYWORD: CONTROL STATEMENT \t%15d\n", yytext,linenumber+1); numberofkeywords++;}
{KEYWORD-DATATYPE} {fprintf(yyout,"%30s \t--->\tKEYWORD: DATATYPE \t%22d\n", yytext,linenumber+1); numberofkeywords++;}
{IDENTIFIER} {fprintf(yyout,"%30s \t--->\tIDENTIFIER \t%30d\n", yytext,linenumber+1); identifierscount++;}
{NUMERICAL_CONSTANT} {fprintf(yyout,"%30s \t--->\tNUMERICAL CONSTANT \t%22d\n", yytext,linenumber+1); numberscount++;}
{INVALID_IDENTIFIER} {fprintf(yyout,"%30s \t--->\t✖✖✖ INVALID IDENTIFIER ✖✖✖ \t%7d\n", yytext,linenumber+1);}
{STRING} {fprintf(yyout,"%30s \t--->\tSTRING \t%30d\n", yytext,linenumber+1);}
{CHARACTER} {fprintf(yyout,"%30s \t--->\tCHARACTER \t%30d\n", yytext,linenumber+1);}
{OPERATOR-UNARY} {fprintf(yyout,"%30s \t--->\tOPERATOR: UNARY \t%22d\n", yytext,linenumber+1);}
{OPERATOR-ARITHMETIC} {fprintf(yyout,"%30s \t--->\tOPERATOR: ARITHMETIC \t%22d\n", yytext,linenumber+1);}
{OPERATOR-RELATIONAL} {fprintf(yyout,"%30s \t--->\tOPERATOR: RELATIONAL \t%22d\n", yytext,linenumber+1);}
{OPERATOR-LOGICAL} {fprintf(yyout,"%30s \t--->\tOPERATOR: LOGICAL \t%23d\n", yytext,linenumber+1);}
{OPERATOR-BITWISE} {fprintf(yyout,"%30s \t--->\tOPERATOR: BITWISE \t%23d\n", yytext,linenumber+1);}
{OPERATOR-ASSIGNMENT} {fprintf(yyout,"%30s \t--->\tOPERATOR: ASSIGNMENT \t%22d\n", yytext,linenumber+1);}
{COMMENT-SINGLELINE} {fprintf(yyout,"%30s \t--->\tSINGLELINE COMMENT \t%22d\n", yytext,linenumber+1); numberofcomments++;}
{COMMENT-MULTILINE} {fprintf(yyout,"%s \n%30s \t--->\tMULTILINE COMMENT \t%22d\n", yytext," ",linenumber+1); numberofcomments++;
                     for(int i=0;i<yyleng;i++){
                       if (yytext[i]=='\n'){
                         linenumber++; }}}
{PARENTHESIS} {fprintf(yyout,"%30s \t--->\tPARENTHESIS \t%30d\n", yytext,linenumber+1);}
{SEMICOLON} {fprintf(yyout,"%30s \t--->\tSEMICOLON \t%30d\n", yytext,linenumber+1);}
{COMMA} {fprintf(yyout,"%30s \t--->\tCOMMA \t%38d\n", yytext,linenumber+1);}
{PERIOD} {fprintf(yyout,"%30s \t--->\tFULL STOP/DOT \t%30d\n", yytext,linenumber+1);}

%%


int main(){

    yyin=fopen("LexicalAnalyzerTest.c","r");
    yyout=fopen("LexicalAnalyzerOutput.txt","w");
    printf("\nStarting Lexical Analyzer...");
    fprintf(yyout,"\n-------------------------------------------------------------------------------------------------------\n");
    fprintf(yyout,"%30s \t--->\t %s \t%30s", "Lexeme", "Token","Line Number");
    fprintf(yyout,"\n-------------------------------------------------------------------------------------------------------\n");
    yylex();
    fprintf(yyout,"\n-------------------------------------------------------------------------------------------------------\n");
    fprintf(yyout,"\nNumber of lines: %d \n\n", linenumber+1);
    fprintf(yyout,"\nNumber of Identifiers: %d \n\n", identifierscount);
    fprintf(yyout,"\nNumber of Keywords: %d \n\n", numberofkeywords);
    fprintf(yyout,"\nNumber of Numerical Constants: %d\n\n", numberscount);
    fprintf(yyout,"\nNumber of Comments: %d\n\n", numberofcomments);
    printf("\nLexical Analyzing done! Check 'LexicalAnalyzerOutput.txt' file for output.\n\n");
    return 0;
}
