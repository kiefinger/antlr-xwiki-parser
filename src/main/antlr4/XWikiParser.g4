parser grammar XWikiParser;

options {
  tokenVocab=XWikiLexer;
}

document
	: 		(line | nl | info | code | table)* ;
	
line
	: 		macro 
	| 		horizontal_line 
	| 		list 
	| 		heading 
	| 		paragraph 
	;

nl
	: 		NL
	;

/* horizontal line */

horizontal_line
	: 		HRLINE
	;

/* Headings */

heading
	: 		heading1 
	| 		heading2 
	| 		heading3 
	| 		heading4 
	| 		heading5 
	| 		heading6
	;
	
heading1
	: 		CHAR_EQUAL plain CHAR_EQUAL
	;

heading2
	: 		H2 plain (H2)
	;
	
heading3
	: 		H3 plain (H3)
	;
	
heading4
	: 		H4 plain (H4)
	;
	
heading5	
	: 		H5 plain (H5)
	;
	
heading6
	: 		H6 plain (H6)
	;

/* Macros */
macro
	:  toc
	;

toc
	:  		TOC_OPEN keyvalues BLOCK_CLOSE
	;

keyvalues
	: 		keyvalue (SPACE+ keyvalue)* 
	;
	
keyvalue
	: 		SPACE* key CHAR_EQUAL value SPACE*
	;
	
key	: 		ID
	;

value
	: 		ID 
	| 		STRING;

/* text blocks: info */
info 
	:  		INFO_OPEN document INFO_END 
	;

/* special blocks: code */
code 
	:  		CODE_OPEN body CODE_END
	;   

body 
	:  		(CODE_CHAR)+? ; 


/* Paragraph */
paragraph
	: 		content
	;
	
content
	: 		(formatted | link)+
	;

/* bold & italic */
formatted
	: 		bold | italic | plain
	;
	
bold
	: 		CHAR_STAR CHAR_STAR plain CHAR_STAR CHAR_STAR
	;

italic
	: 		ITALIC plain ITALIC
	;

/* Plain text */
plain
	: 		(ID | STRING | CHARACTER | CHAR_DOT | CHAR_EQUAL | CHAR_PIPE | SPACE | H2 | H3 | H4 | ITALIC)+
	;

/* lists */
list
	: 		unordered_list | ordered_list 
	;
	
unordered_list
	: 		CHAR_STAR+ content
	;
	
ordered_list
	: 		ordered_list_id CHAR_DOT content 
	;
	
ordered_list_id
	: 		ID+
	;

/* links */
link
	:  		internal_link 
	| 		image
	;

internal_link
	: 		OPEN_DSQBRACE internal_link_title LINKDSHIFTRIGHT internal_link_ref? (LINKCHAR_PIPE internal_link_anchor)? CLOSE_DSQBRACE 
	;
	
internal_link_title
	: 		(LINKID |  LINKCHARACTER | LINKSPACE)+
	;
	
internal_link_ref
	: 		(LINKID |  LINKCHARACTER | LINKSPACE )+
	;

internal_link_anchor
	: 		(LINKID |  LINKCHARACTER | LINKSPACE)+
	;

image
	: 		OPEN_DSQBRACE LINKTEXT_IMAGE internal_link_ref CLOSE_DSQBRACE 
	;

/* table */
table
	: 		TABLE_OPEN tableline+ 
	;

tableline
	:  		tablecol (TABLECHAR_PIPE tablecol)* (TABLE_NEWLINE|TABLE_END)
	;

tablecol
	:  		head? table_plain 
	;
	
head		
	: 		TABLECHAR_EQUAL
	;

table_plain
	: 			(TABLEID 
	| 			TABLECHARACTER 
	| 			TABLESPACE 
	| 			TABLE_NL )+
	;

