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
	"&"	{ return symbol(sym.AND);} 
	"+="	{ return symbol(sym.PLUSEQ);}
	"&="	{ return symbol(sym.ANDEQ);}
	"&&"	{ return symbol(sym.ANDAND);}
	"!="	{ return symbol(sym.NOTEQ);}
	"("	{ return symbol(sym.RO); }    
	")"	{ return symbol(sym.RC); }
	"|"	{ return symbol(sym.OR); }     
	"-="	{ return symbol(sym.MINUSEQ); }    
	"|="	{ return symbol(sym.OREQ); }     
	"||"	{ return symbol(sym.OROR); }    
	"<"	{ return symbol(sym.AO); }     
	"<="	{ return symbol(sym.MINUSEQ); }    
	"["	{ return symbol(sym.AS); }    
	"]"	{ return symbol(sym.CS); }
	"^"	{ return symbol(sym.CAP); }     
	"*="	{ return symbol(sym.TIMEEQ); }    
	"^="	{ return symbol(sym.CAPEQ); }     
	"<-"	{ return symbol(sym.AOMINUS); }    
	">"	{ return symbol(sym.AC); }     
	">="	{ return symbol(sym.AOEQUALS); }    
	"{"	{ return symbol(sym.BRACEO); }    
	"}"	{ return symbol(sym.BRACEC); }
	"/"	{ return symbol(sym.DIV); }    
	"<<"	{ return symbol(sym.AOAO); }    
	"/="	{ return symbol(sym.DIVEQ); }    
	"<<="	{ return symbol(sym.AOAOEQ); }    
	"++"	{ return symbol(sym.PLUSPLUS); }    
	":="	{ return symbol(sym.TPEQ); }    
	","	{ return symbol(sym.COMMA); }    
	";"	{ return symbol(sym.SEMICOLON); }
	"%"	{ return symbol(sym.PERC); }    
	">>"	{ return symbol(sym.ACAC); }    
	"%="	{ return symbol(sym.PERCEQ); }    
	">>="	{ return symbol(sym.ACACEQ); }    
	"--"	{ return symbol(sym.MINUSMINUS); }    
	"!"	{ return symbol(sym.NOT); }     
	"..."	{ return symbol(sym.POINTPOINTPOINT); }   
	"."	{ return symbol(sym.POINT); }    
	":"	{ return symbol(sym.TP); }
	"&^"	{ return symbol(sym.ANDCAP); }          
	"&^="	{ return symbol(sym.ANDCAPEQ); }

      /* comments */
      {Comment}                      { /* ignore */ }
     
      /* whitespace */
      {WhiteSpace}                   { /* ignore */ }
      /* KEYWORDS */	
	"break" 	{return symbol(sym.BREAK); }      
	"default" 	{return symbol(sym.DEFAULT);}
	"func" 		{return symbol(sym.FUNC); }      
	"interface" 	{return symbol(sym.INTERFACE); }   
	"select" 	{return symbol(sym.SELECT); }
	"case" 		{return symbol(sym.CASE); }
	"defer" 	{return symbol(sym.DEFER); }
	"go" 		{return symbol(sym.GO);}
	"map" 		{return symbol(sym.MAP); }
	"struct" 	{return symbol(sym.TIME); }
	"chan" 		{return symbol(sym.CHAN); }         
	"else" 		{return symbol(sym.ELSE); }
	"goto" 		{return symbol(sym.GOTO); }
	"package"	{return symbol(sym.PACKAGE); }      
	"switch"	{return symbol(sym.SWITCH); }
	"const"		{return symbol(sym.CONST); }        
	"fallthrough"	{return symbol(sym.FALLTHROUGH); }  	
	"if"		{return symbol(sym.IF); }
	"range"		{return symbol(sym.RANGE); }        
	"type"		{return symbol(sym.TYPE); }
	"continue"	{return symbol(sym.CONTINUE); }     
	"for"		{return symbol(sym.FOR); }          
	"import"	{return symbol(sym.IMPORT); }       
	"return"	{return symbol(sym.RETURN); }
	"var"		{return symbol(sym.VAR); }
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
