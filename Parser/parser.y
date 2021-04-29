%{ 
    #include <stdio.h> 
    #include <string.h>    
    #include <stdlib.h> 
    extern int yylex(void);
    int yyerror(const char *errormessage);
    int noerrors = 1; 
    int errors = 0;
    int yycolumn = 0;   
%} 
    
%token PP MF KW IF FOR ID OP_UNARY OP NUM
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%
STATEMENTS      :   STATEMENTS STATEMENT
                |   %empty
                ;

STATEMENT       :   PP
                |   KW MF'('')'
                |   ';'
                |   EXPRESSIONS ';'
                |   IF '('EXPRESSIONS')' STATEMENT  %prec LOWER_THAN_ELSE
                |   IF '('EXPRESSIONS')' STATEMENT ELSE STATEMENT
                |   FOR '('EXPRESSIONS';'EXPRESSIONS';'EXPRESSIONS')' STATEMENT
                |   '{'STATEMENTS'}'
                ;
   
EXPRESSIONS     :  TERM
                |  ID OP_UNARY
                |  KW ID
                |  KW ID'['NUM']'
                |  OP_UNARY ID
                |  TERM OP EXPRESSIONS
                |  ID '=' EXPRESSIONS
                |  EXPRESSIONS','EXPRESSIONS
                |  error
                ;
   
TERM            :  ID
                |  NUM
                ;
%% 
  
int main() {
    extern int yylinenumber;
    freopen("testing.c", "r", stdin);
    yyparse();
    if(noerrors) {
        printf("\nOK\n\n");
    }
    else {
        printf("\n\033[0mCOMPILATION ERROR: \033[31mParsing failed due to %d error(s)\n\n\033[0m", errors);
    }
    return 0;
}

int yyerror(const char *errormessage) {
    extern char* yytext;
    extern int yylinenumber;
    extern int yycolumn;
    printf("\n\033[0mtesting.c:%d:%d: Problem occurred near '%s'\n\033[31mError: %s\n", yylinenumber, yycolumn, yytext, errormessage);
    errors++;
    noerrors = 0;
    return 1;
}
