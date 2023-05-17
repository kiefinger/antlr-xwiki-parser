parser grammar XWikiParser;

options {
  tokenVocab=XWikiLexer;
}

document: line? (NL line? | info)* ;
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

/**box
    :  BOX_OPEN BOX_BODY
    ;
    */
/* Paragraph */
paragraph: content;

content: (formatted | link)+;

/* links */
link: external_link | internal_link;

external_link: OPEN_SQBRACE external_link_uri (CHAR_PIPE external_link_title)? CLOSE_SQBRACE;
internal_link: OPEN_DSQBRACE internal_link_ref (CHAR_PIPE internal_link_title)? CLOSE_DSQBRACE ;

external_link_uri: CHARACTER+;
external_link_title: plain;
internal_link_ref: plain;
internal_link_title: plain;

/* bold & italic */
formatted: bold_italic | bold | italic | plain;

bold_italic: BOLD_ITALIC plain BOLD_ITALIC;
bold: BOLD plain BOLD;
italic: ITALIC plain ITALIC;

/* Plain text */
plain: (ID | STRING | CHARACTER | SPACE)+;


