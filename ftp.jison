/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
"ftp://"         return 'PROTOCOL';
[0-9]+\b         return 'PORT';
[a-zA-Z0-9-_.]+  return 'WORD';
':'              return ':';
'@'              return '@';
<<EOF>>          return 'EOF';
.                return 'INVALID';
 
/lex
 
/* operator associations and precedence */
 
//phpOption parserClass:GFtpParser
//phpOption lexerClass:GFtpLexer
//phpOption fileName:GFtpParser.php

%start expressions
 
%left'@'
 
%% /* language grammar */
 
expressions
    : PROTOCOL e EOF
        {
			$$ = $2;
			return $2;
		}
    ;
 
e
    : host
      { 
        $$ = $1; 
      }
    | user host
      { 
        $$ = jQuery.extend({}, $1, $2); //js
		//php $$ = array_merge($1,$2);
      }
    ;
 
host
    : WORD 
      { 
        $$ = jQuery.extend({}, {host:$1}) //js
		//php $$ = array('host' => $1);
      }
    | WORD ':' PORT
      { 
        $$ = jQuery.extend({}, {host:$1,port:$3}) //js
		//php $$ = array('host' => $1, 'port' => $3);
      }
    ;
 
user
    : WORD '@'
      { 
        $$ = jQuery.extend({}, {user:$1,pass:''}) //js
		//php $$ = array('user' => $1, 'pass' => '');
      }
    | WORD ':' WORD '@'
 
      { 
        $$ = jQuery.extend({}, {user:$1,pass:$3}) //js
		//php $$ = array('user' => $1, 'pass' => $3);
      }
    ;
    