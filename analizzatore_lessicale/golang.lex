/* JFlex for go example */

import java_cup.runtime.*;
import java.util.Set;
import java.util.Hashtable;
%%

%class Lexer
%unicode
%cup
%line
%column
%debug

%eofval{
  
    switch(zzLexicalState) {
		case YYINITIAL:
		break;
		case COMMENT:
		yybegin(YYINITIAL);
		return symbol(sym.ERROR, "EOF in comment");
		case STRING:
		yybegin(YYINITIAL);
		return symbol(sym.ERROR, "EOF in string constant");
	}

	System.out.println("symTable:");
	Set<Integer> keys = Tables.symTable.keySet();
        for(Integer key: keys){
            System.out.println("Value of "+key+" is: "+Tables.symTable.get(key));
        }
	System.out.println("numTable:");
	keys = Tables.numTable.keySet();
        for(Integer key: keys){
            System.out.println("Value of "+key+" is: "+Tables.numTable.get(key));
        }
	System.out.println("stringTable:");
	keys = Tables.stringTable.keySet();
        for(Integer key: keys){
            System.out.println("Value of "+key+" is: "+Tables.stringTable.get(key));
        }
    return symbol(sym.EOF);
%eofval}


%{
     
        StringBuffer buff = new StringBuffer();
        int countNum = 0;
	int countID = 0;
	int countString = 0;
	int comment_nesting = 0;


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

Letter = [a-zA-Z_]

Decimal_digit = [0-9]
Octal_digit   = [0-7]
Hex_digit     = [0-9a-fA-F]



Hex_lit     = "0" [xX] [0-9a-fA-F] {Hex_digit}*
Decimal_lit = [1-9] {Decimal_digit}* | "0"
Octal_lit   = "0" {Octal_digit}*
Float_lit = ({Decimal_lit} "." {Decimal_lit})
Pointer = (\*{Identifier})
Imaginary_lit = {Decimal_lit } "i" | {Float_lit} "i" 
Identifier = [a-zA-Z_] {Letter}*

%state COMMENT, STRING

%%

/* keywords */

<YYINITIAL> "package"                { return symbol(sym.PACKAGE); }


 <YYINITIAL> {
     
         string_buf.setLength(0);

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
	"uint8"		{return symbol(sym.UINT8); }
	"uint16"	{return symbol(sym.UINT16); }
	"uint32"	{return symbol(sym.UINT32); }
	"uint64"	{return symbol(sym.UINT64); }
	"int8"		{return symbol(sym.INT8); }
	"int16"		{return symbol(sym.INT16); }
	"int32"		{return symbol(sym.INT32); }
	"int64"		{return symbol(sym.INT64); }
	"float32"	{return symbol(sym.FLOAT32); }
	"float64"	{return symbol(sym.FLOAT64); }
	"complex64"	{return symbol(sym.COMPLEX64); }
	"complex128"	{return symbol(sym.COMPLEX128); }
	"byte"		{return symbol(sym.BYTE); }
	"rune"		{return symbol(sym.RUNE); }
	"uint"		{return symbol(sym.UINT); }
	"int"		{return symbol(sym.INT); }
	"uintptr"	{return symbol(sym.UINTPTR); }
	"string"	{return symbol(sym.STRING); }

      /* operators */

         \'     { return symbol(sym.SINGLEQUOTE); }
        "="     { return symbol(sym.EQ); }
        "=="    { return symbol(sym.EQEQ); }
        "+"     { return symbol(sym.PLUS); }
        "-"     { return symbol(sym.MINUS); }
        "*"     { return symbol(sym.TIME); }
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
	"["	{ return symbol(sym.OS); }    
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
      {Comment}                      { return symbol(sym.COMMENT); }
     
      /* whitespace */
      {WhiteSpace}                   { /* ignore */ }

 
     
      /* literals */

      {Imaginary_lit}                { return symbol(sym.IMAGINARY_LITERAL); }
      {Hex_lit}                      { return symbol(sym.HEX_LITERAL); }
      {Decimal_lit}                  {return symbol(sym.DECIMAL_LITERAL); }
      {Octal_lit}                    {  return symbol(sym.OCTAL_LITERAL); } 
      {Float_lit}                    { return symbol(sym.FLOAT_LITERAL); }
      
      
     
      \"                             {  buff.setLength(0); yybegin(STRING);  yybegin(STRING); }

/* identifiers */ 
      {Pointer}                      { return symbol(sym.POINTER);}
      {Identifier}                   { Tables.symTable.put(countID, yytext());int c = countID; countID++; return symbol(sym.IDENTIFIER); }

    }

<STRING> {
    \u000A	                   { yybegin(YYINITIAL); return symbol(sym.ERROR_STRING,"EOF in string constant");}
   // \"                             { yybegin(YYINITIAL); return symbol(sym.STRING_LITERAL, string.toString()); string_buf.append(yytext());   }
      \"                             {Tables.stringTable.put(countString, buff);int c = countString; countString++; System.out.println("buffer: " + buff); return symbol(sym.STRING,c); }
    [^\n\r\"\\]+                   { buff.append(yytext()); }
    \\t                            { buff.append('\t'); }
    \\n                            { buff.append('\n'); }
    \\r                            { buff.append('\r'); }
    \\\"                           { buff.append('\"'); }
    \\                             { buff.append('\\'); }
}

    /* error fallback */
    [^]                            { throw new Error("Illegal character <"+ yytext()+">"); }
