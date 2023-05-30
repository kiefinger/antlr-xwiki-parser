
lexer grammar XWikiLexer;

HRLINE: '---' '-'+;

H2: '==';
H3: '===';
H4: '====';
H5: '=====';
H6: '======';

ITALIC: '//';

NL: '\r'?'\n' ;
NLXD: '&#xD;' -> skip ;


BOX_OPEN              : '{{box' .*? '}}'      -> skip;
BOX_CLOSE             : '{{/box}}'            -> skip;
TOC_OPEN              : '{{toc';
BLOCK_CLOSE           : '/'? '}}';
	
OPEN_DSQBRACE         : '[['                  -> pushMode(LINK);
CHAR_PIPE             : '|';
CHAR_STAR             : '*';
CHAR_EQUAL            : '=';
CHAR_DOT              : '.';
SPACE				  : ' ' | '\t';

INFO_OPEN
     :  '{{info}}'   
     ;

INFO_END
    :  '{{/info}}'   
    ;         

CODE_OPEN
	:    '{{code}}'   ->pushMode(CODE) 
	;                


TABLE_OPEN
     : NL CHAR_PIPE   -> pushMode(TABLE)     
     ;

STRING
    : '"' (~'"')* '"'
    ;

ID                    : (ID_LETTER | DIGIT) (ID_LETTER | DIGIT)* ; // From C language
CHARACTER             : ID_LETTER | DIGIT | CHARS | CHAR_EQUAL | CHAR_STAR | CHAR_DOT | CHAR_PIPE; // From C language
fragment ID_LETTER    : 'a'..'z'|'A'..'Z'|'_' ;
fragment DIGIT        : '0'..'9' ;
fragment CHARS        :  '!' | '"' | '#' | '$' | '%' | '&'
                |       '*' | '+' | ',' | '-' | '/' 
                |       ':' | ';' | '?' | '@' | '\\' | '^' | '_' | '`' | '~'
                |       '0'..'9' | 'A'..'Z' |'a'..'z' 
                |       '\u0080'..'\u7fff'
                |       '(' | ')'
                |       '\'' | '<' | '>' | '=' | '[' | ']' | '|' | '{' | '}' 
                ;


/*
 * extra mode CODE, because of extra character and multiline fragment  
 */
mode CODE;

CODE_NLXD
	: '&#xD;'          -> skip ;  

CODE_CHAR
	: ID_LETTER | DIGIT | CHARS | CHAR_EQUAL | CHAR_STAR | CHAR_DOT | CHAR_PIPE | NL | SPACE ; 

CODE_END
	:   '{{/code}}'    -> popMode
	;
	     

/*
 * extra mode link, because of extra character 
 */
mode LINK;

LINKID                : ID_LETTER+; 
LINKCHAR_PIPE         : '||';
LINKCHARACTER         : ID_LETTER  | CHARS | CHAR_EQUAL | CHAR_DOT ; 
LINKDSHIFTRIGHT       : ('>>' | '&gt;&gt;');
LINKSPACE             : ' ' | '\t';
LINKTEXT_IMAGE        : 'image:';
                
CLOSE_DSQBRACE
    : ']]'            -> popMode
    ;     

/*
 * extra table mode, because a table element can span multiple lines
 */
mode TABLE;

TABLEID               : ID_LETTER+; 
TABLECHAR_EQUAL       : '=' ;
TABLECHAR_PIPE        : '|';
TABLECHARACTER        : ID_LETTER  | CHARS | CHAR_EQUAL | CHAR_STAR | CHAR_DOT ; 
TABLESPACE            : ' ' | '\t';

TABLE_NLXD
	: '&#xD;'         -> skip ;  

TABLE_NEWLINE
    : TABLE_NL TABLECHAR_PIPE
    ;

TABLE_END
    : TABLE_NL        -> popMode
    ;  
    
TABLE_NL
    :   '\r'?'\n' ; 

    

