%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hashing.h"
#include "generacion.h"
#include "alfa.h"


int yylex();
void yyerror();
// Incializacion de variables alfa

/**
 *Nota inicial:
 * 
 *Por motivos de estructura las macros #define utilizadas en el fichero provienen en su mayoria
 * de las enumeraciones del fichero hashing.h 
 */

extern long yylin;
extern long yycol;

extern char * yytext;

extern int error_id_out_of_range;
extern int error_not_allowed_symbol;

extern FILE * yyout;

int f_return = 0;                        /*Retorno de la funcion*/
int f_type = 0;                          /*Tipo de la funcion*/
int f_num_args = 0;                      /*Numero de args de la funcion*/

int label = 0;
int llamada_funcion = 0;                  /* Indica si efectivamente hay una funcion siendo llamada*/

int cardinal_args_funcion = 0;

// Inicializacion de variables hash

int current_size = 0;                     /*Tamnio actual del vector*/
ElementCathegory current_cathegory;
DataType current_data_type;
DataComplexity current_data_complexity;   /*Clase actual: ESCALAR O VECTOR*/
ArgsInfo current_params_info;             /*Numero de parametros actual y posicion*/
ArgsInfo current_local_vars_info;         /*Numero local de variables actual y posicion*/
Table * table;

%}

%union {
    info_atr atributos;
}

%token TOK_MAIN
%token TOK_INT
%token TOK_BOOLEAN
%token <atributos> TOK_ARRAY
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

programa: iniciarTablaHash TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones segmento_init funciones sentencias TOK_LLAVEDERECHA {fprintf(yyout, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");
escribir_fin(yyout);
destroy_table(table);}
        ;

iniciarTablaHash:
{
    table = create_table();
    if(!table){
        fprintf(stderr, "Error: Inicializacion tabla hash");
        return 1;
    }
    escribir_subseccion_data(yyout);
    escribir_cabecera_bss(yyout);
}

segmento_init:
{
    escribir_segmento_codigo(yyout);
}

declaraciones: declaracion                  {fprintf(yyout, ";R2:\t<declaraciones> ::= <declaracion>\n");}
             | declaracion declaraciones    {fprintf(yyout, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
             ;

declaracion: clase identificadores TOK_PUNTOYCOMA {fprintf(yyout, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");}
           ;

clase: clase_escalar    {current_data_complexity = ESCALAR;fprintf(yyout, ";R5:\t<clase> ::= <clase_escalar>\n");}
     | clase_vector     {current_data_complexity = VECTOR;fprintf(yyout, ";R7:\t<clase> ::= <clase_vector>\n");}
     ;

clase_escalar: tipo {current_size = 1;fprintf(yyout, ";R9:\t<clase_escalar> ::= <tipo>\n");}
             ;

tipo: TOK_INT       {current_data_type = INT;fprintf(yyout, ";R10:\t<tipo> ::= int\n");}
    | TOK_BOOLEAN   {current_data_type = BOOLEAN;fprintf(yyout, ";R11:\t<tipo> ::= boolean\n");}
    ;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO TOK_CONSTANTE_ENTERA TOK_CORCHETEDERECHO {
    fprintf(yyout,";clase_vector\n");
    current_size = $4.integer_value;
    fprintf(yyout, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");
    // Observamos el tamano del vector actual y comprobamos que este dentro de los limites
    if(current_size < 1 || current_size > MAX_VECTOR_LEN){
        printf("****Error semantico en lin %ld: El tamanyo del vector <nombre_vector> excede los limites permitidos (1,64).",yylin);
        destroy_table(table);
        return 1;
    }   
};

identificadores: identificador                          {fprintf(yyout, ";R18:\t<identificadores> ::= <identificador>\n");}
               | identificador TOK_COMA identificadores {fprintf(yyout, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
               ;

funciones: funcion funciones {fprintf(yyout,";R20:\t<funciones> ::= <funcion> <funciones>\n");}
               |                   {fprintf(yyout,";R21:\t<funciones> ::= \n");
                                    escribir_inicio_main(yyout);}
              ;

funcion: fn_declaration sentencias TOK_LLAVEDERECHA
         {
           fprintf(yyout,";funcion\n");
           Entry *entry;
           if(f_return < 1)
            {
                printf("****Error semantico en lin %ld: Funcion %s sin sentencia de retorno.\n", yylin, $1.name);
                destroy_table(table);
                return 1;
            } 
           shut_down_local_env(table);

           entry = search_entry(table, $1.name);
           if(!entry) {
                destroy_table(table);
                return 1;
           }
           
           entry->global.cardinal = current_params_info.cardinal;
           entry->local.cardinal = current_local_vars_info.cardinal; ///
           entry->type = f_type;
           //current_params_info.cardinal = 0;
           //current_local_vars_info.cardinal = 0;
           //current_params_info.position = 0;
           f_return = 0;

            fprintf(yyout,";R22:\t<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }\n");

         }
       ;


fn_declaration: fn_name TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO
                TOK_LLAVEIZQUIERDA declaraciones_funcion
                {
                  fprintf(yyout,";fn_declaracion\n");
                  Entry* entry;
                  entry = search_entry(table, $1.name);
                  if(!entry) {
                      destroy_table(table);
                      return 1;
                  }

                  entry->global.cardinal = current_params_info.cardinal;
                  entry->local.cardinal = current_local_vars_info.cardinal;
                  entry->type = f_type;
                  strcpy($$.name, $1.name);
                  declararFuncion(yyout, $1.name, current_local_vars_info.cardinal);
                }
              ;

fn_name: TOK_FUNCTION tipo TOK_IDENTIFICADOR
         {
           fprintf(yyout,";fn_name\n");
           if (!search_entry(table, $3.name)) {
             strcpy($$.name, $3.name);
             // HAY QUE MIRAR LOS ARGUMENTOS DE ESTA LLAMADA

              ArgsInfo entryLocal;
              ArgsInfo entryGlobal;

              entryLocal.cardinal = f_num_args;
              entryLocal.position = current_local_vars_info.position;
              entryGlobal.cardinal = 0;
              entryGlobal.position = f_num_args; 


             open_local_env(table, $3.name, current_size, FUNCION, current_data_type,
              ESCALAR, entryGlobal, entryLocal);
             
             current_params_info.cardinal = 0;
             current_params_info.position = 0;
             f_return = 0;
             f_type = current_data_type;         
             current_size = 1;
             current_local_vars_info.cardinal = 0;
              strcpy($$.name, $3.name);

           }
           else {
             printf("****Error semantico en lin %ld: Declaracion duplicada\n", yylin);
             destroy_table(table);
             return 1;
           }
         }
       ;


parametros_funcion: parametro_funcion resto_parametros_funcion  {fprintf(yyout, ";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
                  |                                             {fprintf(yyout, ";R24:\t<parametros_funcion> ::=\n");}
                  ;

resto_parametros_funcion: TOK_PUNTOYCOMA parametro_funcion resto_parametros_funcion {fprintf(yyout, ";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
                        |                                                           {fprintf(yyout, ";R26:\t<resto_parametros_funcion> ::=\n");}
                        ;
// CAMBIAR identificador
parametro_funcion: tipo idpf   {fprintf(yyout, ";R27:\t<parametro_funcion> ::= <tipo> <identificador>\n");}
;

declaraciones_funcion: declaraciones    {fprintf(yyout, ";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
                     |                  {fprintf(yyout, ";R29:\t<declaraciones_funcion> ::=\n");}
                     ;

sentencias: sentencia           {fprintf(yyout, ";R30:\t<sentencias> ::= <sentencia>\n");}
         | sentencia sentencias {fprintf(yyout, ";R31:\t<sentencias> ::= <sentencia> <sentencias>\n");}
         ;

sentencia: sentencia_simple TOK_PUNTOYCOMA  {fprintf(yyout, ";R32:\t<sentencia> ::= <sentencia_simple> ;\n");}
         | bloque                           {fprintf(yyout, ";R33:\t<sentencia> ::= <bloque>\n");}
         ;

sentencia_simple: asignacion        {fprintf(yyout, ";R34:\t<sentencia_simple> ::= <asignacion>\n");}
                | lectura           {fprintf(yyout, ";R35:\t<sentencia_simple> ::= <lectura>\n");}
                | escritura         {fprintf(yyout, ";R36:\t<sentencia_simple> ::= <escritura>\n");}
                | retorno_funcion   {fprintf(yyout, ";R38:\t<sentencia_simple> ::= <retorno_funcion>\n");}
                ;

bloque: condicional     {fprintf(yyout, ";R40:\t<bloque> ::= <condicional>\n");}
      | bucle           {fprintf(yyout, ";R41:\t<bloque> ::= <bucle>\n");}
      ;

asignacion: TOK_IDENTIFICADOR TOK_ASIGNACION exp
            {
              fprintf(yyout,";asignacion\n");
              Entry *entry;
              entry = search_entry(table, $1.name);

              if(!entry) {
                printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.name);
                destroy_table(table);
                return 1;  
              }

              if(entry->complexity == VECTOR || entry->cathegory == FUNCION || entry->type != $3.type) {
                printf("****Error semantico en lin %ld: Asignacion incompatible.\n", yylin);
                destroy_table(table);
                return 1;
              }

              if(table->env == GLOBAL) {
                asignar(yyout, $1.name, $3.is_address);
              }

              else {
                  if (entry->cathegory == PARAMETRO) {
                      escribirParametro(yyout, entry->global.position, current_params_info.cardinal);
                  } else {
                      escribirVariableLocal(yyout, entry->local.position);   
                  }
                  asignarDestinoEnPila(yyout, $3.is_address);
              }

              fprintf(yyout,";R43:\t<asignacion> ::= <identificador> = <exp>\n");
            }
          | elemento_vector TOK_ASIGNACION exp
            { 
              fprintf(yyout,";asignacion: elemento_vector\n");
              Entry *entry;
              entry = search_entry(table, $1.name);

              if(!entry) {
                printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.name);
                destroy_table(table);
                return 1;  
              }

              if($1.type != $3.type) {
                printf("****Error semantico en lin %ld: Asignacion incompatible.\n", yylin);
                destroy_table(table);
                return 1;  
              }
              reordenacionEnPila(yyout, $3.is_address);

              fprintf(yyout,";R44:\t<asignacion> ::= <elemento_vector> = <exp>\n");
            }
          ;

elemento_vector: TOK_IDENTIFICADOR TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO
                 { 
                    fprintf(yyout,";elemento_vector\n");
                    Entry *entry;
                    entry = search_entry(table, $1.name);

                   if(!entry) {
                        printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.name);
                        destroy_table(table);
                        return 1;  
                   }
                   if(entry->complexity != VECTOR) {
                     printf("****Error semantico en lin %ld: Intento de indexacion de una variable que no es de tipo vector.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   if($3.type != INT){
                     printf("****Error semantico en lin %ld: El indice en una operacion de indexacion tiene que ser de tipo entero.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   $$.type = entry->type;
                   $$.is_address = 1;
                   //$$.integer_value = $3.integer_value;

                   escribir_elemento_vector(yyout, entry->key, entry->size, $3.is_address);
                   fprintf(yyout,";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");
                 }
               ;

condicional:    if_exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA                                                            
                {
                  fprintf(yyout,";condicional: if_exp\n");
                    ifthen_fin(yyout, $1.label);
                    fprintf(yyout, ";R50:\t<condicional> ::= if ( <exp> ) { <sentencias> }\n");
                }
           |    if_else_exp TOK_ELSE TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA    
                {
                    ifthenelse_fin(yyout, $1.label);
                    fprintf(yyout, ";R51:\t<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }\n");
                }
           ;

if_exp: TOK_IF TOK_PARENTESISIZQUIERDO exp
                {
                  fprintf(yyout,";if_exp\n");
                  if ($3.type != BOOLEAN) {
                      printf("****Error semantico en lin %ld: Condicional con condicion de tipo int.\n",yylin);
                      destroy_table(table);
                      return 1;
                  }
                  $$.label = label++;
                  ifthen_inicio(yyout, $3.is_address, $$.label);
                };

if_else_exp: if_exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA 
                {
                  fprintf(yyout,";if_else_exp\n");
                    $$.label = $1.label;
                    ifthenelse_fin_then(yyout, $1.label);
                };

bucle: while_exp TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA
                {   
                    fprintf(yyout,";bucle\n");
                    while_fin(yyout, $1.label);
                    fprintf(yyout,";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");
                };

while_exp: while TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO
                {
                    fprintf(yyout,";while_exp\n");
                    if($3.type != BOOLEAN) {
                        printf("****Error semantico en lin %ld: Condicional con condicion de tipo int.\n",yylin);
                        destroy_table(table);
                        return 1;
                    }
                    $$.label = $1.label;
                    while_exp_pila(yyout, $3.is_address, $$.label);  
                };

while: TOK_WHILE
                {
                  fprintf(yyout,";while\n");
                  $$.label = label++;
                  while_inicio(yyout, $$.label);
                };

lectura: TOK_SCANF TOK_IDENTIFICADOR
                {
                    fprintf(yyout,";lectura\n");
                    Entry *entry;
                    entry = search_entry(table, $2.name);

                    if(!entry) {
                        printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $2.name);
                        destroy_table(table);
                        return 1;  
                    }
                  
                    if (entry->complexity == VECTOR || entry->cathegory == FUNCION) {
                        printf("****Error semantico en lin %ld: Variable local de tipo no escalar.\n", yylin);
                        destroy_table(table);
                        return 1;  
                    }
                    leer(yyout, $2.name, entry->type);
                    fprintf(yyout,";R54:\t<lectura> ::= scanf <identificador>\n");
                  }
                ; 

escritura: TOK_PRINTF exp
                  {
                    fprintf(yyout,";escritura\n");
                    //operandoEnPilaAArgumento(yyout, $2.is_address);
                    escribir(yyout, $2.is_address, $2.type);                    
                    fprintf(yyout,";R56:\t<escritura> ::= printf <exp>\n");              
                  }
                ;

retorno_funcion: TOK_RETURN exp     
                  {
                    fprintf(yyout,";retorno_funcion\n");
                    if(llamada_funcion == 1) {
                      printf("****Error semantico en lin %ld: Sentencia de retorno fuera del cuerpo de una función.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    retornarFuncion(yyout, $2.is_address);
                    f_return++;
                    fprintf(yyout,";R61:\t<retorno_funcion> ::= return <exp>\n");

                  }
                ;


exp:            exp TOK_MAS exp
                  { 
                    fprintf(yyout,";exp: TOK_MAS\n");
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    $$.type = INT;
                    $$.is_address = 0;

                    sumar(yyout, $1.is_address, $3.is_address);
                    fprintf(yyout,";R72:\t<exp> ::= <exp> + <exp> \n");
                  }
                | exp TOK_MENOS exp
                  { 
                    fprintf(yyout,";exp: TOK_MENOS Resta\n");
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    $$.type = INT;
                    $$.is_address = 0;  

                    restar(yyout, $1.is_address, $3.is_address);  
                    fprintf(yyout,";R73:\t<exp> ::= <exp> - <exp> \n");

                  }
                | exp TOK_DIVISION exp
                  { 
                    fprintf(yyout,";exp: TOK_DIVISION\n");
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    $$.type = INT;
                    $$.is_address = 0;

                    dividir(yyout, $1.is_address, $3.is_address);
                    fprintf(yyout,";R74:\t<exp> ::= <exp> / <exp> \n");
                  }
                | exp TOK_ASTERISCO exp
                  { 
                    fprintf(yyout,";exp: TOK_ASTERISCO\n");
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    $$.type = INT;
                    $$.is_address = 0;

                    multiplicar(yyout, $1.is_address, $3.is_address);
                    fprintf(yyout,";R75:\t<exp> ::= <exp> * <exp> \n");

                  }
                | TOK_MENOS exp
                  { 
                    fprintf(yyout,";exp: TOK_MENOS\n");
                    if($2.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    $$.type = INT;
                    $$.is_address = 0;       

                    cambiar_signo(yyout, $2.is_address);
                    fprintf(yyout,";R76:\t<exp> ::= - <exp> \n");
                  }
                | exp TOK_AND exp
                  { 
                    fprintf(yyout,";exp: TOK_AND\n");
                    if($1.type == INT || $3.type == INT) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    $$.type = BOOLEAN;
                    $$.is_address = 0;

                    y(yyout, $1.is_address, $3.is_address);

                    fprintf(yyout,";R77:\t<exp> ::= <exp> && <exp> \n");
                  }
                | exp TOK_OR exp
                  { 
                    fprintf(yyout,";exp: TOK_OR\n");
                    if($1.type == INT || $3.type == INT) {
                      printf("****Error semantico en lin %ld: Operacion logica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 

                    $$.type = BOOLEAN;
                    $$.is_address = 0;

                    o(yyout, $1.is_address, $3.is_address);
                    fprintf(yyout,";R78:\t<exp> ::= <exp> || <exp> \n");
                  }
                | TOK_NOT exp
                  { 
                    fprintf(yyout,";exp: TOK_NOT\n");
                    if($2.type == INT) {
                      printf("****Error semantico en lin %ld: Operacion logica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }

                    $$.type = BOOLEAN;
                    $$.is_address = 0;

                    no(yyout, $2.is_address, label);
                    label++;

                    fprintf(yyout,";R79:\t<exp> ::= ! <exp> \n");
                  }
                | TOK_IDENTIFICADOR
                  { 
                    fprintf(yyout,";exp: TOK_IDENTIFICADOR\n");
                    Entry* entry;
                    entry = search_entry(table, $1.name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a la variable no declarada (%s)\n", yylin, $1.name);
                      destroy_table(table);
                      return 1;
                    }
                    if(entry->cathegory == FUNCION || entry->complexity == VECTOR) {
                      printf("****Error semantico en lin %ld: Asignacion incompatible.", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    $$.type = entry->type;
                    $$.is_address = 1;
                    if (entry->cathegory == PARAMETRO) {
                      escribirParametro(yyout, entry->global.position, current_params_info.cardinal);
                    }
                    else if (entry->cathegory == VARIABLE) {
                      if (table->env == LOCAL) {
                        escribirVariableLocal(yyout, entry->local.position);
                      }
                      else {
                        escribir_operando(yyout, $1.name, 1);
                        if(llamada_funcion == 1) {
                          operandoEnPilaAArgumento(yyout,1);
                        }
                      }
                    }

                    fprintf(yyout,";R80:\t<exp> ::= <identificador>\n");
                  }
                | constante
                  { 
                    fprintf(yyout,";exp: constante\n");
                    $$.is_address = $1.is_address;
                    $$.type = $1.type;
                    char tok[MAX_INT_SIZE];

                    if ($1.type == BOOLEAN) {
                        if ($1.integer_value == 1) {
                            escribir_operando(yyout, "1", $1.is_address);
                        }
                        else {
                            escribir_operando(yyout, "0", $1.is_address);
                        }
                    }
                    else {
                        sprintf(tok, "%d", $1.integer_value);
                        escribir_operando(yyout, tok, $1.is_address);
                    }

                    fprintf(yyout,";R81:\t<exp> ::= <constante>\n");
                  }
                | TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO
                  { 
                    fprintf(yyout,";exp: TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO\n");
                    $$.is_address = $2.is_address;
                    $$.type = $2.type;                    
                    fprintf(yyout,";R82:\t<exp> ::= ( <exp> )\n");
                  }
                | TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO
                  { 
                    fprintf(yyout,";exp: TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO\n");
                    $$.is_address = $2.is_address;
                    $$.type = $2.type;                    
                  
                    fprintf(yyout,";R83:\t<exp> ::= ( <comparacion> )\n");
                  }
                | elemento_vector
                  { 
                    fprintf(yyout,";exp: elemento_vector\n");                    
                    $$.is_address = $1.is_address;
                    $$.type = $1.type;
                    fprintf(yyout,";R85:\t<exp> ::= <elemento_vector>\n");
                  }
                | idf_llamada_funcion TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO
                  {
                    fprintf(yyout,";exp: idf_llamada_funcion TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO\n");
                    Entry* entry;
                    entry = search_entry(table, $1.name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s)\n", yylin, $1.name);
                      destroy_table(table);
                      return 1;
                    }
                    if (f_num_args != entry->global.cardinal) {
                      printf("****Error semantico %d %d.\n", f_num_args, entry->global.cardinal);
                      printf("****Error semantico en lin %ld: Numero incorrecto de parametros en llamada a funcion.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    $$.type = entry->type;
                    llamarFuncion(yyout, $1.name, entry->global.cardinal);
                    llamada_funcion = 0;

                    fprintf(yyout,";R88:\t<exp> ::= <identificador> ( <lista_expresiones> ) \n");
                  }
                ;

idf_llamada_funcion: TOK_IDENTIFICADOR
                  {
                    fprintf(yyout,";idf_llamada_funcion: TOK_IDENTIFICADOR\n");
                    Entry* entry;
                    if (llamada_funcion == 1) {
                      printf("****Error semantico en lin %ld: No esta permitido el uso de llamadas a funciones como parametros de otras funciones.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }

                    entry = search_entry(table, $1.name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.name);
                      destroy_table(table);
                      return 1;
                    }

                    f_num_args = 0;
                    llamada_funcion = 1;
                    strcpy($$.name, $1.name);
                  }
                ;

lista_expresiones: exp resto_lista_expresiones
                   {
                    fprintf(yyout,";lista_expresiones\n");
                    fprintf(yyout,";R89:\t<lista_expresiones> ::= <exp>  <resto_lista_expresiones> \n");
                      if(llamada_funcion == 1) {
                        f_num_args++;
                      }
                   }
                 |
                   { fprintf(yyout,";R90:\t<lista_expresiones> ::= \n"); }
                 ;

resto_lista_expresiones: TOK_COMA exp resto_lista_expresiones 
                         {
                           fprintf(yyout,";resto_lista_expresiones\n");
                           fprintf(yyout,";R91:\t<resto_lista_expresiones> ::= , <exp>  <resto_lista_expresiones> \n");
                           if(llamada_funcion == 1) {
                             f_num_args++;
                           }
                         }
                       |
                         { fprintf(yyout,";R92:\t<resto_lista_expresiones> ::= \n"); } 
                       ;

comparacion: exp TOK_IGUAL exp      
                  {
                      fprintf(yyout,";comparacion TOK_IGUAL\n");
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }
                      igual(yyout, $1.is_address, $3.is_address, label);
                      label += 1;
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      fprintf(yyout, ";R93:\t<comparacion> ::= <exp> == <exp>\n");
                  }
            | exp TOK_DISTINTO exp   
                  {
                      fprintf(yyout,";comparacion TOK_DISTINTO\n");
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      distinto(yyout, $1.is_address, $3.is_address, label);
                      label += 1;
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      fprintf(yyout, ";R94:\t<comparacion> ::= <exp> != <exp>\n");
                  }
            | exp TOK_MENORIGUAL exp 
                  {
                      fprintf(yyout,";comparacion TOK_MENORIGUAL\n");
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      menor_igual(yyout, $1.is_address, $3.is_address, label);
                      label += 1;
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      fprintf(yyout, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");
                  }
            | exp TOK_MAYORIGUAL exp 
                  {
                      fprintf(yyout,";comparacion TOK_MAYORIGUAL\n");
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      mayor_igual(yyout, $1.is_address, $3.is_address, label);
                      label += 1;
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      fprintf(yyout, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");
                  }
            | exp TOK_MENOR exp      
                  {
                      fprintf(yyout,";comparacion TOK_MENOR\n");
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);
                          return 1;
                      }


                      menor(yyout, $1.is_address, $3.is_address, label);
                      label += 1;
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      fprintf(yyout, ";R97:\t<comparacion> ::= <exp> < <exp>\n");
                  }
            | exp TOK_MAYOR exp      
                  {
                      fprintf(yyout,";comparacion TOK_MAYOR\n");
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      mayor(yyout, $1.is_address, $3.is_address, label);
                      label += 1;
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      fprintf(yyout, ";R98:\t<comparacion> ::= <exp> > <exp>\n");
                  }
                  ;

constante: constante_logica 
                  {
                      fprintf(yyout,";constante_logica\n");
                      /* Checkeamos la semantica*/
                      $$.type = $1.type;
                      $$.is_address = $1.is_address;
                      $$.integer_value = $1.integer_value;                      
                      fprintf(yyout, ";R99:\t<constante> ::= <constante_logica>\n");
                  }
          | constante_entera 
                  {
                      fprintf(yyout,";constante_entera\n");
                      /* Checkeamos la semantica*/
                      $$.type = $1.type;
                      $$.is_address = $1.is_address;
                      $$.integer_value = $1.integer_value;
                      fprintf(yyout, ";R100:\t<constante> ::= <constante_entera>\n");
                  }
                  ;

constante_logica: TOK_TRUE  
                    {
                        fprintf(yyout,";constante_logica: TOK_TRUE\n");
                        /* Checkeamos la semantica*/
                        $$.type = BOOLEAN;
                        $$.is_address = 0;
                        $$.integer_value = 1;
                        //escribir_operando(yyout, "1", 0);
                        fprintf(yyout, ";R102:\t<constante_logica> ::= true\n");                      

                    }
                | TOK_FALSE 
                    {
                        fprintf(yyout,";constante_logica: TOK_FALSE\n");
                        /* Checkeamos la semantica*/
                        $$.type = BOOLEAN;
                        $$.is_address = 0;
                        $$.integer_value = 0;
                        //escribir_operando(yyout, "0", 0);
                        fprintf(yyout, ";R103:\t<constante_logica> ::= false\n");
                    }
                    ;

constante_entera: TOK_CONSTANTE_ENTERA
                    {
                      fprintf(yyout,";constante entera\n");
                      fprintf(yyout,";R104:\t<constante_entera> ::= <numero>\n");
                      $$.is_address = 0;
                      $$.integer_value = $1.integer_value;
                      $$.type = INT;
                      //char tok[MAX_INT_SIZE];
                      //sprintf(tok, "%d", $$.integer_value);
                      //escribir_operando(yyout, tok, 0);
                    }
                    ;
                

identificador: TOK_IDENTIFICADOR
               {
                  fprintf(yyout,";identificador\n");
                  ArgsInfo entryLocal;
                  ArgsInfo entryGlobal;

                  int size = 0;

                  if(current_data_complexity == ESCALAR){
                      size = 0;
                  }
                  else{
                      size = current_size;
                  }

                 if (table->env == LOCAL) {
                    current_local_vars_info.position++;
                    current_local_vars_info.cardinal++;

                    entryLocal.cardinal = 0;
                    entryLocal.position = current_local_vars_info.cardinal;
                    entryGlobal.cardinal = current_params_info.cardinal;
                    entryGlobal.position = current_local_vars_info.position;

                   if(insert_entry(table, create_entry($1.name, size,
                     VARIABLE, current_data_type,
                     current_data_complexity,
                     entryGlobal, entryLocal)) == 1) {
                     printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                     destroy_table(table);
                     return 1;

                      current_local_vars_info.cardinal += 1;
                      current_local_vars_info.position += 1;
                   }
                 }

                 if (table->env == GLOBAL) {
                  
                    entryLocal.cardinal = 0;
                    entryLocal.position = current_local_vars_info.cardinal;
                    entryGlobal.cardinal = current_params_info.cardinal;
                    entryGlobal.position = current_local_vars_info.position;

                   if(insert_entry(table, create_entry($1.name,current_size, VARIABLE, current_data_type,
                                         current_data_complexity, entryGlobal, entryLocal)) == 1) {
                     printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                     destroy_table(table);
                     return 1;
                   }
                   declarar_variable(yyout, $1.name, current_data_type, current_size);
                 }
                 fprintf(yyout,";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
               }
              ;

idpf: TOK_IDENTIFICADOR
              {
              fprintf(yyout,";idpf\n");
              if(!search_entry(table, $1.name)) {

                ArgsInfo entryLocal;
                ArgsInfo entryGlobal;

                entryLocal.cardinal = 0;
                entryLocal.position = 0;
                entryGlobal.cardinal = 0;
                entryGlobal.position = current_params_info.position;

                if(insert_entry(table, create_entry($1.name,0,PARAMETRO,
                 current_data_type,ESCALAR,
                  entryGlobal, entryLocal)) == 1) {
                  destroy_table(table);
                  return 1;
                }
                current_params_info.position++;
                current_params_info.cardinal++;                
                fprintf(yyout, ";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
              }
              else {
                printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                destroy_table(table);
                return 1;
              }
            }
            ;


%%

void yyerror(const char * s) {
    if(!error_not_allowed_symbol) {
        printf("****Error semantico en lin %ld, col %ld\n", yylin, yycol);
    }
}