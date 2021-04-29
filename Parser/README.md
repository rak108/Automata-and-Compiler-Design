# Parser

## Problem Statement

Write a parser to identify the following grammar: 

```
stmts -> stmts stmt | epsilon

stmt -> ;

  | expr ;

  | if (expr) stmt

  | if (expr) stmt else stmt

  | for (expr ; expr ; expr ) stmt

  |  { stmts }

```

## Executing the program

After installing flex & bison (`sudo apt-get install bison flex `), run the program by executing the following commands:

- ` lex lexicalanalyzer.l `
- ` yacc -d parser.y -Wno-yacc `
-  ` gcc lex.yy.c y.tab.c `
-  `  ./a.out `

## Output

The output returns `OK` if the code in the *testing.c* file follows the grammar specified. If not, it prints the errors along with row and column number specifying the symbol near where the error has occured.

 
