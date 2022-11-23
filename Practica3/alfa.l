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

/* Sección de reglas */
programa: TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones funciones sentencias TOK_LLAVEDERECHA {fprintf(out, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }");}
        ;

declaraciones: declaracion                  {fprintf(out, ";R2:\t<declaraciones> ::= <declaracion>\n");}
             | declaracion declaraciones    {fprintf(out, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
             ;

declaracion: clase identificadores TOK_PUNTOYCOMA {fprintf(out, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");}
           ;

clase: clase_escalar    {fprintf(out, ";R5:\t<clase> ::= <clase_escalar>\n");}
     | clase_vector     {fprintf(out, ";R7:\t<clase> ::= <clase_vector>\n");}
     ;

clase_escalar: tipo {fprintf(out, ";R9:\t<clase_escalar> ::= <tipo>\n");}
             ;

tipo: TOK_INT       {fprintf(out, ";R10:\t<tipo> ::= int\n");}
    | TOK_BOOLEAN   {fprintf(out, ";R11:\t<tipo> ::= boolean\n");}
    ;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {fprintf(out, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");}
            ;

identificadores: identificador                          {fprintf(out, ";R18:\t<identificadores> ::= <identificador>\n");}
               | identificador TOK_COMA identificadores {fprintf(out, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
               ;

funciones: funcion funciones    {fprintf(out, ";R20:\t<funciones> ::= <funcion> <funciones>\n");}
         | /* vacio */          {fprintf(out, ";R21:\t<funciones> ::=\n");}
         ;

funcion: TOK_FUNCTION tipo identificador TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA declaraciones_funcion sentencias TOK_LLAVEDERECHA {fprintf(out, ";R22:\t<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }\n");}
       ;

parametros_funcion: parametro_funcion resto_parametros_funcion  {fprintf(out, ";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
                  | /* vacio */                                 {fprintf(out, ";R24:\t<parametros_funcion> ::=\n");}
                  ;

resto_parametros_funcion: TOK_PUNTOYCOMA parametro_funcion resto_parametros_funcion {fprintf(out, ";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
                        | /* vacio */                                               {fprintf(out, ";R26:\t<resto_parametros_funcion> ::=\n");}
                        ;

parametro_funcion: tipo identificador   {fprintf(out, ";R27:\t<parametro_funcion> ::= <tipo> <identificador>\n");}
                 ;

declaraciones_funcion: declaraciones    {fprintf(out, ";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
                     | /* vacío */      {fprintf(out, ";R29:\t<declaraciones_funcion> ::=\n");}
                     ;

sentencias: sentencia           {fprintf(out, ";R30:\t<sentencias> ::= <sentencia>\n");}
         | sentencia sentencias {fprintf(out, ";R31:\t<sentencias> ::= <sentencia> <sentencias>\n");}
         ;

sentencia: sentencia_simple TOK_PUNTOYCOMA  {fprintf(out, ";R32:\t<sentencia> ::= <sentencia_simple> ;\n");}
         | bloque                           {fprintf(out, ";R33:\t<sentencia> ::= <bloque>\n");}
         ;

sentencia_simple: asignacion        {fprintf(out, ";R34:\t<sentencia_simple> ::= <asignacion>\n");}
                | lectura           {fprintf(out, ";R35:\t<sentencia_simple> ::= <lectura>\n");}
                | escritura         {fprintf(out, ";R36:\t<sentencia_simple> ::= <escritura>\n");}
                | retorno_funcion   {fprintf(out, ";R38:\t<sentencia_simple> ::= <retorno_funcion>\n");}
                ;

bloque: condicional     {fprintf(out, ";R40:\t<bloque> ::= <condicional>\n");}
      | bucle           {fprintf(out, ";R41:\t<bloque> ::= <bucle>\n");}
      ;

asignacion: identificador TOK_ASIGNACION exp     {fprintf(out, ";R43:\t<asignacion> ::= <identificador> = <exp>\n");}
          | elemento_vector TOK_ASIGNACION exp   {fprintf(out, ";R44:\t<asignacion> ::= <elemento_vector> = <exp>\n");}

elemento_vector: identificador TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO {fprintf(out, ";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");}
               ;

condicional: TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA                                                            {fprintf(out, ";R50:\t<condicional> ::= if ( <exp> ) { <sentencias> }\n");}
           | TOK_IF TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA TOK_ELSE TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA    {fprintf(out, ";R51:\t<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }\n");}
           ;

bucle: TOK_WHILE TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA {fprintf(out, ";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");}
     ;

lectura: TOK_SCANF identificador    {fprintf(out, ";R54:\t<lectura> ::= scanf <identificador>\n");}
       ;

escritura: TOK_PRINTF exp           {fprintf(out, ";R56:\t<escritura> ::= printf <exp>\n");}
         ;

retorno_funcion: TOK_RETURN exp     {fprintf(out, ";R61:\t<retorno_funcion> ::= return <exp>\n");}
               ;
               exp: exp TOK_MAS exp                                    {fprintf(out, ";R72:\t<exp> ::= <exp> + <exp>\n");}
   | exp TOK_MENOS exp                                  {fprintf(out, ";R73:\t<exp> ::= <exp> - <exp>\n");}
   | exp TOK_DIVISION exp                               {fprintf(out, ";R74:\t<exp> ::= <exp> / <exp>\n");}
   | exp TOK_ASTERISCO exp                              {fprintf(out, ";R75:\t<exp> ::= <exp> * <exp>\n");}
   | TOK_MENOS exp                                      {fprintf(out, ";R76:\t<exp> ::= - <exp>\n");}
   | exp TOK_AND exp                                    {fprintf(out, ";R77:\t<exp> ::= <exp> && <exp>\n");}
   | exp TOK_OR exp                                     {fprintf(out, ";R78:\t<exp> ::= <exp> || <exp>\n");}
   | TOK_NOT exp                                        {fprintf(out, ";R79:\t<exp> ::= ! <exp>\n");}
   | identificador                                      {fprintf(out, ";R80:\t<exp> ::= <identificador>\n");}
   | constante                                          {fprintf(out, ";R81:\t<exp> ::= <constan>\n");}
   | TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO  {fprintf(out, ";R82:\t<exp> ::= ( <exp> )\n");}
   | TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO  {fprintf(out, ";R83:\t<exp> ::= ( <comparacion> )\n");}
   | elemento_vector                                            {fprintf(out, ";R85:\t<exp> ::= <elemento_vector>\n");}
   | identificador TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO {fprintf(out, ";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n");}
   ;

lista_expresiones: exp resto_lista_expresiones  {fprintf(out, ";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");}
                 | /*vacio*/                    {fprintf(out, ";R90:\t<lista_expresiones> ::=\n");}
                 ;

resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones   {fprintf(out, ";R91:\t<resto_lista_expresiones> ::= , <exp> <resto_lista_expresiones>\n");}
                       | /*vacio*/                              {fprintf(out, ";R92:\t<resto_lista_expresiones> ::=\n");}
                       ;

comparacion: exp TOK_IGUAL exp      {fprintf(out, ";R93:\t<comparacion> ::= <exp> == <exp>\n");}
           | exp TOK_DISTINTO exp   {fprintf(out, ";R94:\t<comparacion> ::= <exp> != <exp>\n");}
           | exp TOK_MENORIGUAL exp {fprintf(out, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");}
           | exp TOK_MAYORIGUAL exp {fprintf(out, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");}
           | exp TOK_MENOR exp      {fprintf(out, ";R97:\t<comparacion> ::= <exp> < <exp>\n");}
           | exp TOK_MAYOR exp      {fprintf(out, ";R98:\t<comparacion> ::= <exp> > <exp>\n");}
           ;

constante: constante_logica {fprintf(out, ";R99:\t<constante> ::= <constante_logica>\n");}
         | constante_entera {fprintf(out, ";R100:\t<constante> ::= <constante_entera>\n");}
         ;

constante_logica: TOK_TRUE  {fprintf(out, ";R102:\t<constante_logica> ::= true\n");}
                | TOK_FALSE {fprintf(out, ";R103:\t<constante_logica> ::= false\n");}
                ;

constante_entera: TOK_CONSTANTE_ENTERA {fprintf(out, ";R104:\t<constante> ::= <numero>\n");}
                ;

identificador: TOK_IDENTIFICADOR {fprintf(out, ";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");}
             ;

%%

void yyerror(const char * s) {
    if(error_long_id == 1) {
        printf("****Error en [lin %ld, col %ld]: identificador demasiado largo (%s)\n", yylin, yycol, yytext);
    } else if (error_simbolo == 1) {
        printf("****Error en [lin %ld, col %ld]: simbolo no permitido (%s)\n", yylin, yycol, yytext);
    } else {
        printf("****Error sintactico en [lin %ld, col %ld]\n", yylin, yycol);
    }
}