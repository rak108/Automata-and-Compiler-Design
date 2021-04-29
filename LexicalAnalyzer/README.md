# Lexical Analyzer

## Problem Statement

Write an lexical analyzer using lex/flex to identify tokens of a typical C program.
The program should be able to print series of token-ids for every lexical pattern that it recognizes.

## Executing the program

After installing flex (`sudo apt-get install flex `), run the program by executing the following commands:

- ` lex lexicalanalyzer.l `
- ` cc lex.yy.c -efl `
-  `  ./a.out `

## Output

The lexer is run for the *LexicalAnalyzerTest.c* file, and the output written into the file *LexicalAnalyzerOutput.txt*. It contains the Lexeme, token and line number where the lexeme was found in tabular form. 
 
