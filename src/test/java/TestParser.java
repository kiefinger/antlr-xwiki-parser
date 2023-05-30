import java.nio.file.Files;
import java.nio.file.Paths;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.junit.jupiter.api.Test;

public class TestParser {

	
	@Test
	public void testName() throws Exception {
		String drinkSentence =new String(Files.readAllBytes(Paths.get("test.txt")));
		XWikiLexer lexer = new XWikiLexer(new ANTLRInputStream(drinkSentence));

		// Get a list of matched tokens
		CommonTokenStream tokens = new CommonTokenStream(lexer);

		// Pass the tokens to the parser
		XWikiParser parser = new XWikiParser(tokens);

		// Specify our entry point
		XWikiParser.DocumentContext context = parser.document();


		// Walk it and attach our listener
		ParseTreeWalker walker = new ParseTreeWalker();
		MyXWikiParserVisitor visitor = new MyXWikiParserVisitor();
		visitor.visit(context);
	}
}
