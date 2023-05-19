parser grammar XWikiParser;

options {
  tokenVocab=XWikiLexer;
}

document: line? (NL line? | info | code | table)* ;
line: macro | horizontal_line | list | heading | paragraph ;


/* horizontal line */
horizontal_line: HRLINE;

/* lists */
list: unordered_list | ordered_list;

unordered_list: CHAR_STAR+ content;
ordered_list: CHAR_HASH+ content;

/* Headings */
heading: heading1 | heading2 | heading3 | heading4 | heading5 | heading6;
heading1: CHAR_EQUAL plain CHAR_EQUAL;
heading2: H2 plain H2;
heading3: H3 plain H3;
heading4: H4 plain H4;
heading5: H5 plain H5;
heading6: H6 plain H6;

/* Macros */
macro:  toc;

toc:  TOC_OPEN keyvalues BLOCK_CLOSE;

keyvalues: keyvalue (SPACE+ keyvalue)* ;
keyvalue: SPACE* key CHAR_EQUAL value SPACE*;
key: ID;
value: ID | STRING;

info
    :  INFO_OPEN INFO_BODY
    ;
    

code
    :  CODE_OPEN CODE_BODY
    ;    

/**box
    :  BOX_OPEN BOX_BODY
    ;
    */
/* Paragraph */
paragraph: content;

content: (formatted | link)+;

/* links */
link:  internal_link;

internal_link: OPEN_DSQBRACE internal_link_title LINKDSHIFTRIGHT internal_link_ref (LINKCHAR_PIPE internal_link_anchor)? CLOSE_DSQBRACE ;
internal_link_title: (LINKID |  LINKCHARACTER | LINKSPACE)+;
internal_link_ref: (LINKID |  LINKCHARACTER)+;
internal_link_anchor: (LINKID |  LINKCHARACTER | LINKSPACE);
linkplain: (LINKID |  LINKCHARACTER | LINKSPACE)+;

/* bold & italic */
formatted: bold | italic | plain;

bold: BOLD plain BOLD;
italic: ITALIC plain ITALIC;

/* Plain text */
plain: (ID | STRING | CHARACTER | SPACE)+;

table: TABLE_OPEN tableline+ ;
tableline:  tablecol (TABLECHAR_PIPE tablecol)* (TABLE_NEWLINE|TABLE_END);
tablecol:  table_plain ;
table_plain: (TABLEID | TABLECHARACTER | TABLESPACE | TABLE_NL )+;



