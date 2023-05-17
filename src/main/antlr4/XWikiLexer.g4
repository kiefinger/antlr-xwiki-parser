
lexer grammar XWikiLexer;

HRLINE: '---' '-'+;

H2: '==';
H3: '===';
H4: '====';
H5: '=====';
H6: '======';

BOLD_ITALIC: '\'\'\'\'\'';
BOLD: '\'\'\'';
ITALIC: '\'\'';

NL: '\r'?'\n' ;

BOX_OPEN              : '{{box' .*? '}}'      -> skip;
BOX_CLOSE             : '{{/box}}'            -> skip;
TOC_OPEN              : '{{toc';
BLOCK_CLOSE           : '}}';

OPEN_DSQBRACE         : '[[';
CLOSE_DSQBRACE        : ']]';
OPEN_SQBRACE          : '[';
CLOSE_SQBRACE         : ']';

CHAR_STAR             : '*';
CHAR_HASH             : '#';
CHAR_PIPE             : '|';
CHAR_EQUAL            : '=';

     
INFO_OPEN
     :  '{{info}}'    -> pushMode(INFO)
     ;

STRING
    : '"' (~'"')* '"'
    ;

ID                    : (ID_LETTER | DIGIT) (ID_LETTER | DIGIT)* ; // From C language
CHARACTER             : ID_LETTER | DIGIT | CHARS ; // From C language
fragment ID_LETTER    : 'a'..'z'|'A'..'Z'|'_' ;
fragment DIGIT        : '0'..'9' ;
fragment CHARS        :  '!' | '"' | '#' | '$' | '%' | '&'
                |       '*' | '+' | ',' | '-' | '.' | '/'
                |       ':' | ';' | '?' | '@' | '\\' | '^' | '_' | '`' | '~'
                |       '0'..'9' | 'A'..'Z' |'a'..'z' 
                |       '\u0080'..'\u7fff'
                |       '(' | ')'
                |       '\'' | '<' | '>' | '=' | '[' | ']' | '|' 
                ;

SPACE: ' ' | '\t';


mode INFO;

INFO_BODY
    : .*? '{{/info}}' -> popMode
    ;     



