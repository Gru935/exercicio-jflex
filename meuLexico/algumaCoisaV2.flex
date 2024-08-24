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
MEMBERS = STRING ":" VALUE
OBJECT = "{"MEMBERS"}"

%%

