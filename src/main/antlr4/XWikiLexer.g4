
lexer grammar XWikiLexer;

HRLINE: '---' '-'+;

H2: '==';
H3: '===';
H4: '====';
H5: '=====';
H6: '======';

ITALIC: '//';

NL: '\r'?'\n' ;


BOX_OPEN              : '{{box' .*? '}}'      -> skip;
BOX_CLOSE             : '{{/box}}'            -> skip;
TOC_OPEN              : '{{toc';
BLOCK_CLOSE           : '/'? '}}';

OPEN_DSQBRACE         : '[['                  -> pushMode(LINK);
OPEN_SQBRACE          : '[';
CLOSE_SQBRACE         : ']';
CHAR_PIPE             : '|';

CHAR_STAR             : '*';
CHAR_EQUAL            : '=';
CHAR_DOT              : '.';

     
INFO_OPEN
     :  '{{info}}'    -> pushMode(INFO)
     ;

CODE_OPEN
     :  '{{code}}'    -> pushMode(CODE)
     ;
     
TABLE_OPEN
     : NL CHAR_PIPE   -> pushMode(TABLE)     
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
                |       '\'' | '<' | '>' | '=' | '[' | ']' | '|' | '{' | '}' 
                ;

SPACE: ' ' | '\t';


mode INFO;

INFO_BODY
    : .*? '{{/info}}' -> popMode
    ;     

mode CODE;

CODE_BODY
    : .*? '{{/code}}' -> popMode
    ;     
    
    
mode LINK;

LINKID                : ID_LETTER+; 
LINKCHARACTER         : ID_LETTER  | CHARS ; 
LINKCHAR_PIPE         : '|';
LINKDSHIFTRIGHT       : '>>';
LINKSPACE             : ' ' | '\t';
LINKTEXT_IMAGE        : 'image:';
                
CLOSE_DSQBRACE
    : ']]'        -> popMode
    ;     

/*
 * extra table mode, because a table element can span multiple lines
 */
mode TABLE;

TABLEID               : ID_LETTER+; 
TABLECHAR_EQUAL       : '='            -> skip;
TABLECHAR_PIPE        : '|';
TABLECHARACTER        : ID_LETTER  | CHARS ; 
TABLESPACE            : ' ' | '\t';

TABLE_NEWLINE
    : TABLE_NL TABLECHAR_PIPE
    ;

TABLE_NL
    :   '\r'?'\n' ; 

    
TABLE_END
    : NL NL -> popMode
    ;  
    
