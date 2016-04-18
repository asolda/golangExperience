/****
 *
 * This is a simple stand-alone testing program for the Pascal lexer defined in
 * PascalLexer.JFLex.  The main method accepts an input file as its first
 * command-line argument.  It then calls the lexer's next_token method with an
 * input reader for that file.  The value of each Symbol returned by next_token
 * is printed to stanard output.
 *                                                                      <p>
 * The following command-line invocation will read in the test program in the
 * file "lexer-test.p" and print out each token found in that file:
 *
 *     java PascalLexerTest lexer-test.p
 *
 */

import java.io.*;
import java.util.HashMap;

import java_cup.runtime.*;

public class PascalLexerTest {

	/* usato solo per poter stampare la coppia <Nome Token, Attributo> */
	private static final Integer[] TOKEN_IDS = new Integer[] { 18, 37, 19, 35, 3, 27, 17, 2, 13, 9, 20, 4, 16, 7, 33, 8,
			0, 26, 1, 10, 23, 22, 34, 25, 32, 36, 15, 31, 5, 30, 28, 24, 12, 6, 21, 29, 14, 11 };
	private static final String[] TOKEN_NAMES = new String[] { "DIVIDE", "CHAR", "SEMI", "INT", "ARRAY", "LESS",
			"MINUS", "AND", "TYPE", "OR", "COMMA", "BEGIN", "PLUS", "IF", "DOT", "OF", "EOF", "GTR", "error", "PROGRAM",
			"LEFT_BRKT", "RT_PAREN", "IDENT", "EQ", "ASSMNT", "REAL", "TIMES", "COLON", "ELSE", "NOT_EQ", "LESS_EQ",
			"RT_BRKT", "THEN", "END", "LEFT_PAREN", "GTR_EQ", "VAR", "PROCEDURE" };

	public static void main(String[] args) {
		HashMap<Integer, String> tokenNames = new HashMap<Integer, String>();
		for (int i = 0; i < TOKEN_IDS.length; i++)
			tokenNames.put(TOKEN_IDS[i], TOKEN_NAMES[i]);

		Symbol sym;
		try {
			PascalLexer lexer = new PascalLexer(new FileReader(args[0]));

			for (sym = lexer.next_token(); sym.sym != 0; sym = lexer.next_token()) {
        /* stampa della coppia <Nome Token, Attributo> e posizione di linea e colonna */
      	System.out.println("<" + tokenNames.get(sym.sym) + (sym.value == null ? "" : "," + sym.value)
						+ ">  at line " + sym.left + ", column " + sym.right);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
