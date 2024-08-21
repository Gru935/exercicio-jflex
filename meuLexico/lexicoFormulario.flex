import java.io.InputStreamReader;

%%

%public
%class AnalisadorLexico
%unicode
%line
%column
%integer
%{
  public static final int NOME_AVALIACAO = 257;
  public static final int NUMERO = 258;
  public static final int OPERADOR = 259;
  public static final int TIPO_SUBSTITUICAO = 260;
  public static final int NOME_SUBSTITUICAO = 261;

  public static void main(String[] args) {
    AnalisadorLexico scanner;
    if (args.length == 0) {
      try {
        scanner = new AnalisadorLexico(new InputStreamReader(System.in));
        while (!scanner.zzAtEOF) 
          System.out.println("token: " + scanner.yylex() + "\t<" + scanner.yytext() + ">");
      } catch (Exception e) {
        System.out.println("Unexpected exception:");
        e.printStackTrace();
      }
    } else {
      for (String arg : args) {
        scanner = null;
        try {
          scanner = new AnalisadorLexico(new java.io.FileReader(arg));
          while (!scanner.zzAtEOF) 
            System.out.println("token: " + scanner.yylex() + "\t<" + scanner.yytext() + ">");
        } catch (java.io.FileNotFoundException e) {
          System.out.println("File not found : \"" + arg + "\"");
        } catch (java.io.IOException e) {
          System.out.println("IO error scanning file \"" + arg + "\"");
          System.out.println(e);
        } catch (Exception e) {
          System.out.println("Unexpected exception:");
          e.printStackTrace();
        }
      }
    }
  }
%}

%%

"([A-Za-z][A-Za-z0-9]*)" { return NOME_AVALIACAO; }
[0-9]+(\.[0-9]+)? { return NUMERO; }
"+"|"-"|"*"|"/" { return OPERADOR; }
"0"|"1"|"2" { return TIPO_SUBSTITUICAO; }
[ \t\r\n]+ { /* Ignorar espaços em branco e quebras de linha */ }
"(" | ")" | "{" | "}" | "," | ":" { /* Se precisar reconhecer caracteres especiais como parênteses, chaves, etc. */ }
. { System.out.println("Caracter inválido: " + yytext()); }
