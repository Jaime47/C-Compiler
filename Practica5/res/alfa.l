%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "alfa.h"
#include "y.tab.h"


long yylin = 1;
long yycol = 1;

int error_id_out_of_range = 0;
int error_not_allowed_symbol = 0;

extern FILE * yyout;
%}

%option noyywrap
ESPACIO 	[ \t]+
SALTOLINEA	\n|\n\r|\r
COMENTARIO  "//"[^\n]*\n

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

TRUE              "true"
FALSE             "false"

IDENTIFICADORERROR     [a-zA-Z]([0-9]|[a-zA-Z]){99,}
IDENTIFICADOR     [a-zA-Z]([0-9]|[a-zA-Z]){0,98}
CONSTANTENTERA   [0-9]+

ERROR		.
%%
{ESPACIO}       { yycol += yyleng; }
{SALTOLINEA}    { yycol=0; yylin++; }
{COMENTARIO}    { yycol=0; yylin++; }

{MAIN}      { yycol += yyleng;fprintf(yyout, ";D:\tmain\n"); return TOK_MAIN; }
{INT}       { yycol += yyleng;fprintf(yyout, ";D:\tint\n"); return TOK_INT; }
{BOOLEAN}   { yycol += yyleng;fprintf(yyout, ";D:\tboolean\n"); return TOK_BOOLEAN; }
{ARRAY}     { yycol += yyleng;fprintf(yyout, ";D:\tarray\n"); return TOK_ARRAY; }
{FUNCTION}  { yycol += yyleng;fprintf(yyout, ";D:\tfunction\n"); return TOK_FUNCTION; }

{IF}        { yycol += yyleng; fprintf(yyout, ";D:\tif\n"); return TOK_IF; }
{ELSE}      { yycol += yyleng; fprintf(yyout, ";D:\telse\n"); return TOK_ELSE; }
{WHILE}     { yycol += yyleng; fprintf(yyout, ";D:\twhile\n"); return TOK_WHILE; }
{SCANF}     { yycol += yyleng; fprintf(yyout, ";D:\tscanf\n"); return TOK_SCANF; }
{PRINTF}    { yycol += yyleng; fprintf(yyout, ";D:\tprintf\n"); return TOK_PRINTF; }
{RETURN}    { yycol += yyleng; fprintf(yyout, ";D:\treturn\n"); return TOK_RETURN; }

{PUNTOYCOMA}            { yycol += yyleng; fprintf(yyout, ";D:\t;\n"); return TOK_PUNTOYCOMA; }
{COMA}                  { yycol += yyleng; fprintf(yyout, ";D:\t,\n"); return TOK_COMA; }
{PARENTESISIZQUIERDO}   { yycol += yyleng; fprintf(yyout, ";D:\t(\n"); return TOK_PARENTESISIZQUIERDO; }
{PARENTESISDERECHO}     { yycol += yyleng; fprintf(yyout, ";D:\t)\n"); return TOK_PARENTESISDERECHO; }
{CORCHETEIZQUIERDO}     { yycol += yyleng; fprintf(yyout, ";D:\t[\n"); return TOK_CORCHETEIZQUIERDO; }
{CORCHETEDERECHO}       { yycol += yyleng; fprintf(yyout, ";D:\t]\n"); return TOK_CORCHETEDERECHO; }
{LLAVEIZQUIERDA}        { yycol += yyleng; fprintf(yyout, ";D:\t{\n"); return TOK_LLAVEIZQUIERDA; }
{LLAVEDERECHA}          { yycol += yyleng; fprintf(yyout, ";D:\t}\n"); return TOK_LLAVEDERECHA; }

{ASIGNACION}            { yycol += yyleng; fprintf(yyout, ";D:\t=\n");  return TOK_ASIGNACION; }
{MAS}                   { yycol += yyleng; fprintf(yyout, ";D:\t+\n"); return TOK_MAS; }
{MENOS}                 { yycol += yyleng; fprintf(yyout, ";D:\t-\n"); return TOK_MENOS; }
{DIVISION}              { yycol += yyleng; fprintf(yyout, ";D:\t/\n"); return TOK_DIVISION; }
{ASTERISCO}             { yycol += yyleng; fprintf(yyout, ";D:\t*\n"); return TOK_ASTERISCO; }
{AND}                   { yycol += yyleng; fprintf(yyout, ";D:\t&&\n"); return TOK_AND; }
{OR}                    { yycol += yyleng; fprintf(yyout, ";D:\t||\n"); return TOK_OR; }
{NOT}                   { yycol += yyleng; fprintf(yyout, ";D:\t!\n"); return TOK_NOT; }
{IGUAL}                 { yycol += yyleng; fprintf(yyout, ";D:\t==\n"); return TOK_IGUAL; }
{DISTINTO}              { yycol += yyleng; fprintf(yyout, ";D:\t!=\n"); return TOK_DISTINTO; }
{MENORIGUAL}            { yycol += yyleng; fprintf(yyout, ";D:\t<=\n"); return TOK_MENORIGUAL; }
{MAYORIGUAL}            { yycol += yyleng; fprintf(yyout, ";D:\t>=\n"); return TOK_MAYORIGUAL; }
{MENOR}                 { yycol += yyleng; fprintf(yyout, ";D:\t<\n"); return TOK_MENOR; }
{MAYOR}                 { yycol += yyleng; fprintf(yyout, ";D:\t>\n"); return TOK_MAYOR; }

{TRUE}      { yycol += yyleng; fprintf(yyout, ";D:\ttrue\n"); return TOK_TRUE; }
{FALSE}     { yycol += yyleng; fprintf(yyout, ";D:\tfalse\n"); return TOK_FALSE; }

{IDENTIFICADORERROR}    { yycol+=yyleng; error_id_out_of_range = 1; return TOK_ERROR; }
{IDENTIFICADOR}         { yycol+=yyleng; strcpy(yylval.atributos.name, yytext); fprintf(yyout, ";D:\t%s\n", yytext); return TOK_IDENTIFICADOR; }
{CONSTANTENTERA}        { yycol+=yyleng; yylval.atributos.integer_value = atoi( yytext ); fprintf(yyout, ";D:\t%s\n", yytext); return TOK_CONSTANTE_ENTERA; }

{ERROR}     { yycol += yyleng; error_not_allowed_symbol = 1; return TOK_ERROR; }
%%
