import java.util.List;
import java.util.Optional;

/**
 * process xwiki grammar and produce output for all main elements:
 * nl, heading1-6,  
 *
 */
public class MyXWikiParserVisitor extends XWikiParserBaseVisitor<String> {

	@Override
	public String visitContent(XWikiParser.ContentContext ctx) {
		String rc = "";
		for (XWikiParser.FormattedContext c :  ctx.formatted()) {
			rc += visit ( c);
		}
		for (XWikiParser.LinkContext c :  ctx.link()) {
			rc += visit ( c);
		}
		System.out.print(rc);
		return rc;
	}

	/**
	 * handle Empty lines
	 */
	@Override
	public String visitNl(XWikiParser.NlContext ctx) {
		System.out.println("");
		return "";
	}


	@Override
	public String visitFormatted(XWikiParser.FormattedContext ctx) {
		return ctx.getText();
	}

	@Override
	public String visitImage(XWikiParser.ImageContext ctx) {
		return "!(" + ctx.internal_link_ref().getText() + ")";
	}
	@Override
	public String visitHeading1(XWikiParser.Heading1Context ctx) {
		System.out.print( "# " + ctx.plain().getText());
		return "";
	}

	@Override
	public String visitHeading2(XWikiParser.Heading2Context ctx) {
		System.out.print( "## " + ctx.plain().getText());
		return "";
	}

	@Override
	public String visitHeading3(XWikiParser.Heading3Context ctx) {
		System.out.print( "### " + ctx.plain().getText());
		return "";
	}

	@Override
	public String visitHeading4(XWikiParser.Heading4Context ctx) {
		System.out.print( "#### " + ctx.plain().getText());
		return "";
	}

	@Override
	public String visitHeading5(XWikiParser.Heading5Context ctx) {
		System.out.print( "##### " + ctx.plain().getText());
		return "";
	}

	@Override
	public String visitInternal_link(XWikiParser.Internal_linkContext ctx) {
		String rc = String.format("(%s)[%s]", ctx.internal_link_title().getText(),
				ctx.internal_link_ref()!=null? ctx.internal_link_ref().getText() :"");
		return rc ;
	}


	//document>line>list  output
	@Override
	public String visitUnordered_list(XWikiParser.Unordered_listContext ctx) {
		System.out.print( " * " + ctx.content().getText());
		return "";
	}

	@Override
	public String visitOrdered_list(XWikiParser.Ordered_listContext ctx) {
		System.out.print( ctx.ordered_list_id().getText() + " " + ctx.content().getText());
		return "";
	}

	@Override
	public String visitLink(XWikiParser.LinkContext ctx) {
		//System.out.println(ctx.getText());
		return super.visitLink(ctx);
	}

	@Override
	public String visitInfo(XWikiParser.InfoContext ctx) {
		System.out.print( "`" + ctx.getText().substring(8, ctx.getText().length()-9)+  "`" );
		return "";
	}

	@Override
	public String visitCode(XWikiParser.CodeContext ctx) {
		System.out.print( "```" + ctx.body().getText()+  "```"  );
		return "";
	}


	@Override
	public String visitTableline(XWikiParser.TablelineContext ctx) {
		String rc = "";
		boolean header = false;
		for (XWikiParser.TablecolContext c :  ctx.tablecol()) {
			rc += "|" + visit ( c);
		}
		rc += "|" ;
		System.out.println(rc);
		return "";
	}


	@Override
	public String visitTablecol(XWikiParser.TablecolContext ctx) {
		return ctx.getText();
	}
	

}
