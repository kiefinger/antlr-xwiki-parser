import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.junit.jupiter.api.Test;

public class TestRig {
	
	public static void main(String[] args) {
		
		
	}

	static String [] args = { "XWiki",  "document", "-tokens" , "test.txt"};
	@Test
	public void outputTokens() throws Exception {
		try {
			Class<?> testRigClass = Class.forName("org.antlr.v4.gui.TestRig");
			System.err.println("Warning: TestRig moved to org.antlr.v4.gui.TestRig; calling automatically");
			try {
				Method mainMethod = testRigClass.getMethod("main", String[].class);
				mainMethod.invoke(null, (Object) args);
			} catch (Exception nsme) {
				System.err.println("Problems calling org.antlr.v4.gui.TestRig.main(args)");
			}
		} catch (ClassNotFoundException cnfe) {
			System.err.println("Use of TestRig now requires the use of the tool jar, antlr-4.X-complete.jar");
			System.err.println("Maven users need group ID org.antlr and artifact ID antlr4");
		}
	}
}
