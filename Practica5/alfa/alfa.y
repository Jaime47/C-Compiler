%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hashing.h"
#include "generacion.h"
#include "alfa.h"

void yyerror();
int yylex();

// Incializacion de variables alfa

extern long yylin;
extern long yycol;

extern char * yytext;

extern int error_id_out_of_range;
extern int error_not_allowed_symbol;

extern FILE * out;

int f_return = 0;

// Inicializacion de variables hash

extern int current_size = 0;
ElementCathegory current_cathegory;
DataType current_data_type;
DataComplexity current_data_complexity;
ArgsInfo current_args_info;
ArgsInfo current_local_args_info;
Table * table;

%}

%union {
    infoAtr atributos;
}

%token TOK_MAIN
%token TOK_INT
%token TOK_BOOLEAN
%token TOK_ARRAY
%token TOK_FUNCTION
%token TOK_IF
%token TOK_ELSE
%token TOK_WHILE
%token TOK_SCANF
%token TOK_PRINTF
%token TOK_RETURN

%token TOK_PUNTOYCOMA
%token TOK_COMA
%token TOK_PARENTESISIZQUIERDO
%token TOK_PARENTESISDERECHO
%token TOK_CORCHETEIZQUIERDO
%token TOK_CORCHETEDERECHO
%token TOK_LLAVEIZQUIERDA
%token TOK_LLAVEDERECHA
%token TOK_ASIGNACION
%token TOK_MAS
%token TOK_MENOS

%token TOK_DIVISION
%token TOK_ASTERISCO
%token TOK_AND
%token TOK_OR
%token TOK_NOT
%token TOK_IGUAL
%token TOK_DISTINTO
%token TOK_MENORIGUAL
%token TOK_MAYORIGUAL
%token TOK_MENOR
%token TOK_MAYOR

%token <atributos> TOK_IDENTIFICADOR
%token <atributos> TOK_CONSTANTE_ENTERA
%token TOK_TRUE
%token TOK_FALSE
%token TOK_ERROR

%type <atributos> identificador
%type <atributos> constante
%type <atributos> constante_logica
%type <atributos> constante_entera
%type <atributos> elemento_vector

%type <atributos> exp
%type <atributos> comparacion
%type <atributos> condicional
%type <atributos> if_exp
%type <atributos> if_else_exp

%type <atributos> bucle
%type <atributos> while_exp
%type <atributos> while

%type <atributos> idf_llamada_funcion
%type <atributos> funcion
%type <atributos> fn_declaration
%type <atributos> fn_name


%left TOK_IGUAL TOK_MENORIGUAL TOK_MENOR TOK_MAYORIGUAL TOK_MAYOR TOK_DISTINTO
%left TOK_MAS TOK_MENOS
%left TOK_ASTERISCO TOK_DIVISION
%left TOK_AND TOK_OR
%left TOK_NOT

%%

programa: iniciarTablaHash TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones funciones sentencias TOK_LLAVEDERECHA {fprintf(out, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }");
escribirFin(out);
eliminarTablaHash(table);}
        ;

iniciarTablaHash:
{
    table = create_table();
    if(!table){
        fprintf(stderr, "Error: Inicializacion tabla hash");

    }
    escribir_subseccion_data(out);
    escribir_cabecera_bss(out);
}

declaraciones: declaracion                  {fprintf(out, ";R2:\t<declaraciones> ::= <declaracion>\n");}
             | declaracion declaraciones    {fprintf(out, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
             ;

declaracion: clase identificadores TOK_PUNTOYCOMA {fprintf(out, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");}
           ;

clase: clase_escalar    {current_data_complexity = ESCALAR;fprintf(out, ";R5:\t<clase> ::= <clase_escalar>\n");}
     | clase_vector     {current_data_complexity = ESCALAR;fprintf(out, ";R7:\t<clase> ::= <clase_vector>\n");}
     ;

clase_escalar: tipo {current_size = 1;fprintf(out, ";R9:\t<clase_escalar> ::= <tipo>\n");}
             ;

tipo: TOK_INT       {current_data_type = INT;fprintf(out, ";R10:\t<tipo> ::= int\n");}
    | TOK_BOOLEAN   {current_data_type = BOOLEAN;fprintf(out, ";R11:\t<tipo> ::= boolean\n");}
    ;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {current_size = $4.valor_entero;
    fprintf(out, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");
    if(current_size < 1 || current_size > MAX_VECTOR_LEN){
        printf("****Error semantico en lin %ld: El tamano del vector <nombre_vector> excede los limites permitidos (1,64).",yylin);
        destroy_table(table);
        return 1;
    }   
};

identificadores: identificador                          {fprintf(out, ";R18:\t<identificadores> ::= <identificador>\n");}
               | identificador TOK_COMA identificadores {fprintf(out, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
               ;

funciones: funcion funciones    {fprintf(out, ";R20:\t<funciones> ::= <funcion> <funciones>\n");}
         |                      {fprintf(out, ";R21:\t<funciones> ::=\n");escribir_inicio_main(out);}
         ;

funcion: fn_declaration sentencias TOK_LLAVEDERECHA
         {
           fprintf(yyout,";R22:\t<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }\n");

           if(f_return < 1)
            {
             printf("****Error semantico en lin %ld: Funcion %s no tiene sentencia de retorno.\n", yylin, $1.nombre);
             delete_table(table);
             return 1;
            } 
           shut_down_local_env(table);
           Entry *entry;
           entry = search_entry(table, $1.nombre);
           if(!entry) {
             delete_table(table);
             return 1;
           }
           
           entry->global->cardinal = current_args_info->cardinal;
           entry->cathegory = current_cathegory;
           current_args_info->cardinal = 0;
           current_local_args_info->cardinal = 0;
           current_args_info->position = 0;
         }
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
                 |                     {fprintf(out, ";R90:\t<lista_expresiones> ::=\n");}
                 ;

resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones   {fprintf(out, ";R91:\t<resto_lista_expresiones> ::= , <exp> <resto_lista_expresiones>\n");}
                       |                               {fprintf(out, ";R92:\t<resto_lista_expresiones> ::=\n");}
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
    if(error_id_out_of_range == 1) {
        printf("****Error l %ld, c %ld: identificador excede limite longitud (%s)\n", yylin, yycol, yytext);
    } else if (error_not_allowed_symbol == 1) {
        printf("****Error en l %ld, c %ld: simbolo prohibido (%s)\n", yylin, yycol, yytext);
    } else {
        printf("****Error sintaxis l %ld, c %ld\n", yylin, yycol);
    }
}