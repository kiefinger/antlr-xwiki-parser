import java.nio.file.Files;
import java.nio.file.Paths;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

public class Main {

	public static void main(String[] args) throws Exception {
		
		if (args.length <1) {
			System.out.println(("usage: java -jar antlr-wiki-parser <filename>"));
		}

		String drinkSentence = new String(Files.readAllBytes(Paths.get(args[0])));
		XWikiLexer lexer = new XWikiLexer(new ANTLRInputStream(drinkSentence));

		// Get a list of matched tokens
		CommonTokenStream tokens = new CommonTokenStream(lexer);

		// Pass the tokens to the parser
		XWikiParser parser = new XWikiParser(tokens);

		// Specify our entry point
		ParseTree context = parser.document();

		MyXWikiParserVisitor visitor = new MyXWikiParserVisitor();
		visitor.visit(context);
	}
}
