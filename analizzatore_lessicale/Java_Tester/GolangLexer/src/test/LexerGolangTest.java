package test;

import java.io.FileReader;
import java_cup.runtime.Symbol;
import lexer.Lexer;

public class LexerGolangTest {
	public static void main(String[] args) {
		Symbol sym;

		try {
			Lexer l = new Lexer(new FileReader(args[0]));
			for(sym = l.next_token(); sym.sym != 0; sym = l.next_token()) {
					System.out.println("< " + sym.sym +" > at line " + (sym.left+1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
