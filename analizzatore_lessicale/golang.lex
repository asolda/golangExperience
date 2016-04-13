/* JFlex for go example */

import java_cup.runtime.*;

%%

%class Lexer
%unicode
%cup
%line
%column

%{
    StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
     }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*

Letter = "a" ... "z" | "A" ... "Z" | "_"

Decimal_digit = "0" ... "9"
Octal_digit   = "0" ... "7"
Hex_digit     = "0" ... "9" | "A" ... "F" | "a" ... "f"

Unicode_digit = {Decimal_digit} | {Octal_digit} | {Hex_digit}

Identifier = Letter {Letter}+ | {Unicode_digit}+

Int_lit     = decimal_lit | octal_lit | hex_lit
Decimal_lit = ( "1" … "9" ) {Decimal_digit}*
Octal_lit   = "0" {Octal_digit}*
Hex_lit     = "0" ("x" | "X") Hex_digit {Hex_digit}*

%state STRING

%%

/* keywords */

<YYINITIAL> "package"                { return symbol(sym.PACKAGE); }

 <YYINITIAL> {
      /* identifiers */ 
      {Identifier}                   { return symbol(sym.IDENTIFIER); }
     
      /* literals */
      {Int_lit}                      { return symbol(sym.INTEGER_LITERAL); }
      {Decimal_lit}                  { return symbol(sym.DECIMAL_LITERAL); }
      {Octal_lit}                    { return symbol(sym.OCTAL_LITERAL); }
      {Hex_lit}                      { return symbol(sym.HEX_LITERAL); }
      \"                             { string.setLength(0); yybegin(STRING); }

      /* operators */
      "="                            { return symbol(sym.EQ); }
      "=="                           { return symbol(sym.EQEQ); }
      "+"                            { return symbol(sym.PLUS); }
      "-"                            { return symbol(sym.MINUS); }
      "*"                            { return symbol(sym.TIME); }

      /* comments */
      {Comment}                      { /* ignore */ }
     
      /* whitespace */
      {WhiteSpace}                   { /* ignore */ }
    }

<STRING> {
    \"                             { yybegin(YYINITIAL); 
                                        return symbol(sym.STRING_LITERAL, string.toString()); }
    [^\n\r\"\\]+                   { string.append( yytext() ); }
    \\t                            { string.append('\t'); }
    \\n                            { string.append('\n'); }

    \\r                            { string.append('\r'); }
    \\\"                           { string.append('\"'); }
    \\                             { string.append('\\'); }
}

    /* error fallback */
    [^]                            { throw new Error("Illegal character <"+ yytext()+">"); }
