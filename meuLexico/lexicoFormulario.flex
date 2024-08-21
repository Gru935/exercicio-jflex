import java.io.InputStreamReader;

%%

%public
%class LexicoFormulario
%unicode
%line
%column
%integer
%{
  public static final int NOME_AVALIACAO = 257;
  public static final int NUMERO = 258;
  public static final int OPERADOR = 259;
  public static final int TIPO_SUBSTITUICAO = 260;
  public static final int PARENTESES_ABERTO = 261;
  public static final int PARENTESES_FECHADO = 262;
  public static final int VIRGULA = 263;
  public static final int FIM_LINHA = 264;

  public static void main(String[] args) {
    LexicoFormulario scanner;
    if (args.length == 0) {
      try {
        scanner = new LexicoFormulario(new InputStreamReader(System.in));
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
          scanner = new LexicoFormulario(new java.io.FileReader(arg));
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

// Reconhecimento de nomes de avaliações
[A-Za-z]([A-Za-z0-9]?) { return NOME_AVALIACAO; }

// Reconhecimento de números inteiros e de ponto flutuante
[0-9]+(\.[0-9]+)? { return NUMERO; }

// Operadores aritméticos
"+"|"-"|"*"|"/" { return OPERADOR; }

// Parênteses
"(" { return PARENTESES_ABERTO; }
")" { return PARENTESES_FECHADO; }

// Vírgula para separar nomes de avaliações
"," { return VIRGULA; }

// Tipo de substituição (0, 1, 2)
"0"|"1"|"2" { return TIPO_SUBSTITUICAO; }

// Ignorar espaços em branco e quebras de linha
[ \t\r]+ { /* Ignorar */ }

// Fim de linha
\n { return FIM_LINHA; }

// Qualquer outro caractere inválido
. { System.out.println("Caracter inválido: " + yytext()); }
