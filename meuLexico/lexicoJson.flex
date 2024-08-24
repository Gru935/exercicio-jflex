import java.io.InputStreamReader;
%%


%public
%class LexicoJson
%integer
%unicode
%line


%{

public static int STRING  = 257;
  public static int NUMBER  = 258;
  public static int TRUE    = 259;
  public static int FALSE   = 260;
  public static int NULL    = 261;
  public static int LBRACE  = 262;
  public static int RBRACE  = 263;
  public static int LBRACK  = 264;
  public static int RBRACK  = 265;
  public static int COMMA   = 266;
  public static int COLON   = 267;


/**
   * Runs the scanner on input files.
   *
   * This is a standalone scanner, it will print any unmatched
   * text to System.out unchanged.
   *
   * @param argv   the command line, contains the filenames to run
   *               the scanner on.
   */
  public static void main(String argv[]) {
    LexicoJson scanner;
    if (argv.length == 0) {
      try {        
          // scanner = new LexicoJson( System.in );
          scanner = new LexicoJson( new InputStreamReader(System.in) );
          while ( !scanner.zzAtEOF ) 
	        System.out.println("token: "+scanner.yylex()+"\t<"+scanner.yytext()+">");
        }
        catch (Exception e) {
          System.out.println("Unexpected exception:");
          e.printStackTrace();
        }
        
    }
    else {
      for (int i = 0; i < argv.length; i++) {
        scanner = null;
        try {
          scanner = new LexicoJson( new java.io.FileReader(argv[i]) );
          while ( !scanner.zzAtEOF ) 	
                System.out.println("token: "+scanner.yylex()+"\t<"+scanner.yytext()+">");
        }
        catch (java.io.FileNotFoundException e) {
          System.out.println("File not found : \""+argv[i]+"\"");
        }
        catch (java.io.IOException e) {
          System.out.println("IO error scanning file \""+argv[i]+"\"");
          System.out.println(e);
        }
        catch (Exception e) {
          System.out.println("Unexpected exception:");
          e.printStackTrace();
        }
      }
    }
  }


%}

%%

\"([^\\\"]|\\[\"\\/bfnrt]|\\u[0-9a-fA-F]{4})*\" { return STRING; }
[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)? { return NUMBER; }
"true" { return TRUE; }
"false" { return FALSE; }
"null" { return NULL; }

"{" { return LBRACE; }
"}" { return RBRACE; }
"[" { return LBRACK; }
"]" { return RBRACK; }
"," { return COMMA; }
":" { return COLON; }

[ \t\r\n]+ { /* Ignore whitespace */ }
. { System.out.println(yyline + ": Invalid character: " + yytext()); }