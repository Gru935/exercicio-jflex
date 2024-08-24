
%%

%standalone
%class AlgumaCoisa
%unicode
%public
%{
    int line = 1;

    void printToken(String tokenType, String lexeme) {
        System.out.printf("Token: %s    Lexeme: %s  Linha: %d%n", tokenType, lexeme, line);
    }
%}

%line
%column


DIGIT = [0-9]
NUMBER = [-+]?{DIGIT}+([.,]{DIGIT}+)?([eE][-+]?{DIGIT}+)?
STRING = \"([^\\\"]|\\[\"\\/bfnrt]|\\u[0-9a-fA-F]{4})*\"


%%

"{" {   printToken("LBRACE", yytext()); }
"}" {   printToken("RBRACE", yytext()); }
"[" {   printToken("LBRACK", yytext()); }
"]" {   printToken("RBRACK", yytext()); }
":" {   printToken("COLON", yytext()); }
"," {   printToken("COMMA", yytext()); }
{STRING}: { printToken("KEY", yytext().replace(":",""));    }
{STRING} {  printToken("STRING", yytext()); }
{NUMBER} {  printToken("NUMBER", yytext()); }
[\t\r ] {}




\n {    line++; }
. { printToken("ANY", yytext()); }