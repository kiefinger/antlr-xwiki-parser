public class MyXWikiParserListener extends XWikiParserBaseListener {

	@Override
	public void enterDocument(XWikiParser.DocumentContext ctx) {
		System.out.println("document");
		// TODO Auto-generated method stub
		super.enterDocument(ctx);
	}

	@Override
	public void enterHeading1(XWikiParser.Heading1Context ctx) {
		// TODO Auto-generated method stub
		super.enterHeading1(ctx);
	}

	@Override
	public void enterParagraph(XWikiParser.ParagraphContext ctx) {
		// TODO Auto-generated method stub
		super.enterParagraph(ctx);
	}

	@Override
	public void enterPlain(XWikiParser.PlainContext ctx) {
		// TODO Auto-generated method stub
		super.enterPlain(ctx);
	}

	@Override
	public void enterHeading(XWikiParser.HeadingContext ctx) {
		System.out.println("header: " + ctx.getText());
		super.enterHeading(ctx);
	}

	@Override
	public void enterHeading2(XWikiParser.Heading2Context ctx) {
		System.out.println("header 2: " + ctx.getText());
		super.enterHeading2(ctx);
	}

	
	
	
//	@Override
//	public void exitJson(JSONParser.JsonContext ctx) {
//		// TODO Auto-generated method stub
//		super.exitJson(ctx);
//		//System.out.println("sonar:" + ctx);
//	}
//
//	@Override
//	public void enterSonarrule(JSONParser.SonarruleContext ctx) {
//		//System.out.println("rule:" + ctx.getText());
//		int n = ctx.getRuleContext().getChildCount();
//		String key = "";
//		String name = "";
//		String html = "";
//		String severity = "";
//		String type = "";
//		
//		for ( int i =0; i<n; i++ ) {
//			ParseTree t = ctx.getRuleContext().getChild(i);
//			if ( t instanceof JSONParser.KeypairContext) {
//				key = t.getText().substring(7).replaceAll("\"", "");
//			}
//			if ( t instanceof JSONParser.NamepairContext) {
//				name = t.getText().substring(8).replaceAll("\"", "").replace('\\', '/').replaceAll("/", "");
//			}
//			if ( t instanceof JSONParser.HtmlpairContext) {
//				html = t.getText().substring(12,t.getText().length()-1);
//			}
//			if ( t instanceof JSONParser.SeveritypairContext) {
//				severity = t.getText().substring(11,t.getText().length()-1).replaceAll("\"", "");
//			}
//			if ( t instanceof JSONParser.SonartypepairContext) {
//				type = t.getText().substring(7,t.getText().length()-1).replaceAll("\"", "");
//			}
//		}
//		System.out.println("==" + name + "==");
//		System.out.println("**Key:** " + key);
//		System.out.println("**Severity:** " + severity) ;
//		System.out.println("**Type:** " + type) ;
//		System.out.println("");
//		System.out.println("{{html wiki=\"true\"}}");
//		System.out.println("");
//		// replace pre by wiki code so that the code highlither will be used.
//		
//		html = html.replaceAll("<pre>", "{{code}}").replaceAll("</pre>", "{{/code}}");
//		
//		
//		System.out.println(html);
//		System.out.println("");
//		System.out.println("{{/html}}");
//		System.out.println("");
//	}
//
//	@Override
//	public void enterKeypair(JSONParser.KeypairContext ctx) {
//		//System.out.println("key:" + ctx.getText());
//		super.enterKeypair(ctx);
//	}
//
//	@Override
//	public void enterHtmlpair(JSONParser.HtmlpairContext ctx) {
//		//System.out.println("html:" + ctx.getText());
//		super.enterHtmlpair(ctx);
//	}
//
//	@Override
//	public void enterPair(JSONParser.PairContext ctx) {
//		//System.out.println("pair:" + ctx.getText());
//		super.enterPair(ctx);
//	}


}
