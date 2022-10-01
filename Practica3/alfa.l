%{
#include <stdio.h>
#include "tokens.h"
#include "y.tab.h"
long yylin = 1;
long yycol = 1;
extern FILE * out;
int error_id_out_of_range = 0;
int error_not_allowed_symbol = 0;
%}
%option noyywrap

MAIN        "main"
INT         "int"
BOOLEAN     "boolean"
ARRAY       "array"
FUNCTION    "function"
IF          "if"
ELSE        "else"
WHILE       "while"
SCANF       "scanf"
PRINTF      "printf"
RETURN      "return"

PUNTOYCOMA  ";"
COMA        ","
PARENTESISIZQUIERDO "("
PARENTESISDERECHO ")"
CORCHETEIZQUIERDO "["
CORCHETEDERECHO   "]"
LLAVEIZQUIERDA    "{"
LLAVEDERECHA      "}"
ASIGNACION        "="
MAS               "+"
MENOS             "-"
DIVISION          "/"
ASTERISCO         "*"
AND               "&&"
OR                "||"
NOT               "!"
IGUAL             "=="
DISTINTO          "!="
MENORIGUAL        "<="
MAYORIGUAL        ">="
MENOR             "<"
MAYOR             ">"

IDENTIFICADOR     [a-zA-Z]([0-9]|[a-zA-Z]){0,98}

CONSTANTENTERA   [0-9]+
TRUE              "true"
FALSE             "false"

IDENTIFICADORERROR     [a-zA-Z]([0-9]|[a-zA-Z]){99,}
ERROR		.

ESPACIO 	[ \t]+
SALTOLINEA	\n|\n\r|\r
COMENTARIO  "//"[^\n]*\n

%%
{MAIN}      { yycol += yyleng; return TOK_MAIN; }
{INT}       { yycol += yyleng; return TOK_INT; }
{BOOLEAN}   { yycol += yyleng; return TOK_BOOLEAN; }
{ARRAY}     { yycol += yyleng; return TOK_ARRAY; }
{FUNCTION}  { yycol += yyleng; return TOK_FUNCTION; }
{IF}        { yycol += yyleng; return TOK_IF; }
{ELSE}      { yycol += yyleng; return TOK_ELSE; }
{WHILE}     { yycol += yyleng; return TOK_WHILE; }
{SCANF}     { yycol += yyleng; return TOK_SCANF; }
{PRINTF}    { yycol += yyleng; return TOK_PRINTF; }
{RETURN}    { yycol += yyleng; return TOK_RETURN; }

{PUNTOYCOMA}            { yycol += yyleng; return TOK_PUNTOYCOMA; }
{COMA}                  { yycol += yyleng; return TOK_COMA; }
{PARENTESISIZQUIERDO}   { yycol += yyleng; return TOK_PARENTESISIZQUIERDO; }
{PARENTESISDERECHO}     { yycol += yyleng; return TOK_PARENTESISDERECHO; }
{CORCHETEIZQUIERDO}     { yycol += yyleng; return TOK_CORCHETEIZQUIERDO; }
{CORCHETEDERECHO}       { yycol += yyleng; return TOK_CORCHETEDERECHO; }
{LLAVEIZQUIERDA}        { yycol += yyleng; return TOK_LLAVEIZQUIERDA; }
{LLAVEDERECHA}          { yycol += yyleng; return TOK_LLAVEDERECHA; }

{ASIGNACION}            { yycol += yyleng; return TOK_ASIGNACION; }
{MAS}                   { yycol += yyleng; return TOK_MAS; }
{MENOS}                 { yycol += yyleng; return TOK_MENOS; }
{DIVISION}              { yycol += yyleng; return TOK_DIVISION; }
{ASTERISCO}             { yycol += yyleng; return TOK_ASTERISCO; }
{AND}                   { yycol += yyleng; return TOK_AND; }
{OR}                    { yycol += yyleng; return TOK_OR; }
{NOT}                   { yycol += yyleng; return TOK_NOT; }
{IGUAL}                 { yycol += yyleng; return TOK_IGUAL; }
{DISTINTO}              { yycol += yyleng; return TOK_DISTINTO; }
{MENORIGUAL}            { yycol += yyleng; return TOK_MENORIGUAL; }
{MAYORIGUAL}            { yycol += yyleng; return TOK_MAYORIGUAL; }
{MENOR}                 { yycol += yyleng; return TOK_MENOR; }
{MAYOR}                 { yycol += yyleng; return TOK_MAYOR; }

{IDENTIFICADOR}         { yycol+=yyleng; return TOK_IDENTIFICADOR; }

{CONSTANTENTERA}       { yycol+=yyleng; return TOK_CONSTANTE_ENTERA; }
{TRUE}      { yycol += yyleng; return TOK_TRUE; }
{FALSE}     { yycol += yyleng; return TOK_FALSE; }

{IDENTIFICADORERROR}    { yycol+=yyleng; error_id_out_of_range = 1; return TOK_ERROR; }
{ERROR}     { yycol += yyleng; error_not_allowed_symbol = 1; ;return TOK_ERROR; }

{ESPACIO}       { yycol += yyleng; }
{SALTOLINEA}    { yycol=0; yylin++; }
{COMENTARIO}    { yycol=0; yylin++; }
%%
