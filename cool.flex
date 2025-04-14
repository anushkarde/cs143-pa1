/*
 * The scanner definition for COOL.
 */
%option noyywrap
/*
 * Stuff enclosed in %{ %} in the first section is copied verbatim to the
 * output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include "cool-parse.h"

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

%}

/*
 * Define names for regular expressions here.
 */

DARROW =>

/*
 * Integer values
 */
INTEGER [0-9]+
/*
 * Keywords
 */
CLASS      [cC][lL][aA][sS][sS]
ELSE       [eE][lL][sS][eE]
FI         [fF][iI]
IF         [iI][fF]
IN         [iI][nN]
INHERITS   [iI][nN][hH][eE][rR][iI][tT][sS]
ISVOID     [iI][sS][vV][oO][iI][dD]
LET        [lL][eE][tT]
LOOP       [lL][oO][oO][pP]
POOL       [pP][oO][oO][lL]
THEN       [tT][hH][eE][nN]
WHILE      [wW][hH][iI][lL][eE]
CASE       [cC][aA][sS][eE]
ESAC       [eE][sS][aA][cC]
NEW        [nN][eE][wW]
OF         [oO][fF]
NOT        [nN][oO][tT]
TRUE       [t][rR][uU][eE]
FALSE      [f][aA][lL][sS][eE]

/*
 * Identifiers
 */
TYPE_IDENTIFIER   ([A-Z])([A-Z]|[a-z]|[0-9]|_)*
OBJECT_IDENTIFIER ([a-z])([A-Z]|[a-z]|[0-9]|_)*

/*
 * Single Characters/Special Characters 
 */ 
ASSIGN <-
LE <=
SINGLE_CHAR [{}();:+/-=@<~.,\*]

/* 
 * Parsing for whitespace
 */
WHITESPACE [ \t\n\r\f\v]

%x string 
%x string_transient


%%

 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */
{DARROW}		{ return (DARROW); }

{INTEGER} { 
  cool_yylval.symbol = inttable.add_string(yytext); 
  return INT_CONST; 
}

{ASSIGN} { return ASSIGN; }
{LE} { return LE; }

{WHITESPACE} {
  if (*yytext == '\n') {
    curr_lineno++;
  }
}

{SINGLE_CHAR} { return (int)(yytext[0]); }

{CLASS} { return CLASS; }
{ELSE} { return ELSE; }
{FI} { return FI; }
{IF} { return IF; }
{IN} { return IN; }
{INHERITS} { return INHERITS; }
{ISVOID} { return ISVOID; }
{LET} { return LET; }
{LOOP} { return LOOP; }
{POOL} { return POOL; }
{THEN} { return THEN; }
{WHILE} { return WHILE; }
{CASE} { return CASE; }
{ESAC} { return CLASS; }
{NEW} { return NEW; }
{OF} { return OF; }
{NOT} { return NOT; }

{TRUE} {
  cool_yylval.boolean = true;
  return BOOL_CONST;
}
{FALSE} {
  cool_yylval.boolean = false;
  return BOOL_CONST;
}
{TYPE_IDENTIFIER} {
  cool_yylval.symbol = idtable.add_string(yytext);
  return TYPEID;
}

{OBJECT_IDENTIFIER} {
  cool_yylval.symbol = idtable.add_string(yytext);
  return OBJECTID;
}

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


 /*
  *  String constants (C syntax, taken from lexdoc(1) )
  *  Escape sequence \c is accepted for all characters c. Except for
  *  \n \t \b \f, the result is c.
  *  (but note that 'c' can't be the NUL character)
  *
  */

\" string_buf_ptr = string_buf; BEGIN(string);

<string>\" { 
    BEGIN(INITIAL);
    string_buf_ptr = "\0";
    cool_yylval.symbol = stringtable.add_string(string_buf);
    return STR_CONST; 
  }

<string><<EOF>> {
  
}



%%
