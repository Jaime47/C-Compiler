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

extern long yylin;
extern long yycol;

extern char * yytext;

extern int error_id_out_of_range;
extern int error_not_allowed_symbol;

extern FILE * yyout;

int f_return = 0;
int f_type = 0;
int f_num_args = 0;

int label = 0;
int llamada_funcion = 0;

int cardinal_args_funcion = 0;

// Inicializacion de variables hash

int current_size = 0;
ElementCathegory current_cathegory;
DataType current_data_type;
DataComplexity current_data_complexity;
ArgsInfo current_args_info;
ArgsInfo current_local_args_info;
Table * table;

%}

%union {
    info_atr atributos;
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

programa: iniciarTablaHash TOK_MAIN TOK_LLAVEIZQUIERDA declaraciones funciones sentencias TOK_LLAVEDERECHA {fprintf(yyout, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }");
escribir_fin(yyout);
destroy_table(table);}
        ;

iniciarTablaHash:
{
    table = create_table();
    if(!table){
        fprintf(stderr, "Error: Inicializacion tabla hash");

    }
    escribir_subseccion_data(yyout);
    escribir_cabecera_bss(yyout);
}

declaraciones: declaracion                  {fprintf(yyout, ";R2:\t<declaraciones> ::= <declaracion>\n");}
             | declaracion declaraciones    {fprintf(yyout, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
             ;

declaracion: clase identificadores TOK_PUNTOYCOMA {fprintf(yyout, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");}
           ;

clase: clase_escalar    {current_data_complexity = ESCALAR;fprintf(yyout, ";R5:\t<clase> ::= <clase_escalar>\n");}
     | clase_vector     {current_data_complexity = ESCALAR;fprintf(yyout, ";R7:\t<clase> ::= <clase_vector>\n");}
     ;

clase_escalar: tipo {current_size = 1;fprintf(yyout, ";R9:\t<clase_escalar> ::= <tipo>\n");}
             ;

tipo: TOK_INT       {current_data_type = INT;fprintf(yyout, ";R10:\t<tipo> ::= int\n");}
    | TOK_BOOLEAN   {current_data_type = BOOLEAN;fprintf(yyout, ";R11:\t<tipo> ::= boolean\n");}
    ;

clase_vector: TOK_ARRAY tipo TOK_CORCHETEIZQUIERDO constante_entera TOK_CORCHETEDERECHO {current_size = $4.integer_value;
    fprintf(yyout, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");
    if(current_size < 1 || current_size > MAX_VECTOR_LEN){
        printf("****Error semantico en lin %ld: El tamano del vector <nombre_vector> excede los limites permitidos (1,64).",yylin);
        destroy_table(table);
        return 1;
    }   
};

identificadores: identificador                          {fprintf(yyout, ";R18:\t<identificadores> ::= <identificador>\n");}
               | identificador TOK_COMA identificadores {fprintf(yyout, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
               ;

funciones: funcion funciones    {fprintf(yyout, ";R20:\t<funciones> ::= <funcion> <funciones>\n");}
         |                      {fprintf(yyout, ";R21:\t<funciones> ::=\n");escribir_inicio_main(yyout);}
         ;

funcion: fn_declaration sentencias TOK_LLAVEDERECHA
         {
           fprintf(yyout,";R22:\t<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }\n");

           if(f_return < 1)
            {
                printf("****Error semantico en lin %ld: Funcion %s no tiene sentencia de retorno.\n", yylin, $1.name);
                destroy_table(table);
                return 1;
            } 
           shut_down_local_env(table);
           Entry *entry;
           entry = search_entry(table, $1.name);
           if(!entry) {
                destroy_table(table);
                return 1;
           }
           
           entry->global.cardinal = current_args_info.cardinal;
           entry->cathegory = current_cathegory;
           current_args_info.cardinal = 0;
           current_local_args_info.cardinal = 0;
           current_args_info.position = 0;
         }
       ;


fn_declaration: fn_name TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO
                TOK_LLAVEIZQUIERDA declaraciones_funcion
                {
                  Entry* entry;
                  entry = search_entry(table, $1.name);
                if(!entry) {
                    destroy_table(table);
                    return 1;
                }
                strcpy($$.name, $1.name);
                entry->global.cardinal = current_args_info.cardinal;
                entry->global.cardinal = current_local_args_info.cardinal;
                entry->cathegory = current_cathegory;
                declararFuncion(yyout, $1.name, current_local_args_info.cardinal);
                }
              ;

fn_name: TOK_FUNCTION tipo TOK_IDENTIFICADOR
         {
           if (!search_entry(table, $3.name)) {
             strcpy($$.name, $3.name);
             // HAY QUE MIRAR LOS ARGUMENTOS DE ESTA LLAMADA

             ArgsInfo entryLocal;
             ArgsInfo entryGlobal;

              entryLocal.cardinal = f_num_args;
              entryLocal.position = current_local_args_info.position;
              entryGlobal.cardinal = 0;
              entryGlobal.position = f_num_args; 


             open_local_env(table, $3.name, current_size, VARIABLE, current_data_type,
              current_data_complexity, entryGlobal, entryLocal);
             
             current_args_info.cardinal = 0;
             f_return = 0;
             f_type = current_data_type;         
             current_size = 1;
             current_local_args_info.cardinal = 0;
             current_args_info.position = 0;

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
parametro_funcion: tipo idpf   {fprintf(yyout, ";R27:\t<parametro_funcion> ::= <tipo> <identificador>\n");
                     current_args_info.position++;
                     current_args_info.cardinal++;}
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
              Entry *entry;
              entry = search_entry(table, $1.name);

              if(!entry) {
                printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.name);
                destroy_table(table);
                return 1;  
              }

              if(entry->complexity == VECTOR || entry->cathegory == FUNCION || entry->data != $3.type) {
                printf("****Error semantico en lin %ld: Asignacion incompatible.\n", yylin);
                destroy_table(table);
                return 1;
              }

              if(table->env == GLOBAL) {
                asignar(yyout, $1.name, $3.is_address);
              }

              else {
                escribirVariableLocal(yyout, entry->global.position);
                asignarDestinoEnPila(yyout, $3.is_address);
              }

              fprintf(yyout,";R43:\t<asignacion> ::= <identificador> = <exp>\n");
            }
          | elemento_vector TOK_ASIGNACION exp
            { 
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
              char e[MAX_INT_SIZE];
              sprintf(e, "%d", $1.integer_value);
              escribir_operando(yyout, e, 0);
              escribir_elemento_vector(yyout, entry->key, entry->size, $3.is_address); 
              asignarDestinoEnPila(yyout, $3.is_address);

              fprintf(yyout,";R44:\t<asignacion> ::= <elemento_vector> = <exp>\n");
            }
          ;

elemento_vector: TOK_IDENTIFICADOR TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO
                 { 
                    Entry *entry;
                    entry = search_entry(table, $1.name);

                    if(!entry) {
                        printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.name);
                        destroy_table(table);
                        return 1;  
                    }

                   if(entry->complexity != VECTOR) {
                     printf("****Error semantico en lin %ld: Indexando variable no vectorial.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   if($3.type != INT){
                     printf("****Error semantico en lin %ld: El indice debe ser de tipo entero.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   $$.type = entry->data;
                   $$.is_address = 1;
                   $$.integer_value = $3.integer_value;

                   escribir_elemento_vector(yyout, entry->key, entry->size, $3.is_address);
                   fprintf(yyout,";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");
                 }
               ;

condicional:    if_exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA                                                            
                {
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
                    if ($3.type != BOOLEAN) {
                        printf("****Error semantico en lin %ld: Condicion de tipo int.\n",yylin);
                        return 1;
                    }
                    $$.label = label++;
                    ifthen_inicio(yyout, $3.is_address, $$.label);
                };

if_else_exp: if_exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA 
                {
                    $$.label = $1.label;
                    ifthenelse_fin_then(yyout, $1.label);
                };

bucle: while_exp TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA
                { 
                    while_fin(yyout, $1.label);
                    fprintf(yyout,";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");
                };

while_exp: while TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO
                {
                    if($3.type != BOOLEAN) {
                        printf("****Error semantico en lin %ld: Condicion de tipo int.\n",yylin);
                        destroy_table(table);
                        return 1;
                    }
                    $$.label = $1.label;
                    while_exp_pila(yyout, $3.is_address, $$.label);  
                };

while: TOK_WHILE
                {
                $$.label = label++;
                while_inicio(yyout, $$.label);
                };

lectura: TOK_SCANF TOK_IDENTIFICADOR
                {
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
                    leer(yyout, $2.name, entry->data);
                    fprintf(yyout,";R54:\t<lectura> ::= scanf <identificador>\n");
                  }
                ; 

escritura: TOK_PRINTF exp
                  {
                    operandoEnPilaAArgumento(yyout, $2.is_address);
                    escribir(yyout, 0, $2.type);

                    fprintf(yyout,";R56:\t<escritura> ::= printf <exp>\n");
                  }
                ;

retorno_funcion: TOK_RETURN exp     
                  {
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


exp: exp TOK_MAS exp
                  { 
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    sumar(yyout, $1.is_address, $3.is_address);
                    $$.type = INT;
                    $$.is_address = 0;

                    fprintf(yyout,";R72:\t<exp> ::= <exp> + <exp> \n");
                  }
                | exp TOK_MENOS exp
                  { 
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    restar(yyout, $1.is_address, $3.is_address);
                    $$.type = INT;
                    $$.is_address = 0;    

                    fprintf(yyout,";R73:\t<exp> ::= <exp> - <exp> \n");

                  }
                | exp TOK_DIVISION exp
                  { 
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    dividir(yyout, $1.is_address, $3.is_address);
                    $$.type = INT;
                    $$.is_address = 0;

                    fprintf(yyout,";R74:\t<exp> ::= <exp> / <exp> \n");
                  }
                | exp TOK_ASTERISCO exp
                  { 
                    
                    if($1.type == BOOLEAN || $3.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    multiplicar(yyout, $1.is_address, $3.is_address);
                    $$.type = INT;
                    $$.is_address = 0;
                    fprintf(yyout,";R75:\t<exp> ::= <exp> * <exp> \n");

                  }
                | TOK_MENOS exp
                  { 
                    if($2.type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    cambiar_signo(yyout, $2.is_address);
                    $$.type = INT;
                    $$.is_address = 0;

                    fprintf(yyout,";R76:\t<exp> ::= - <exp> \n");
                  }
                | exp TOK_AND exp
                  { 
                    if($1.type == INT || $3.type == INT) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    y(yyout, $1.is_address, $3.is_address);
                    $$.type = BOOLEAN;
                    $$.is_address = 0;

                    fprintf(yyout,";R77:\t<exp> ::= <exp> && <exp> \n");
                  }
                | exp TOK_OR exp
                  { 
                    if($1.type == INT || $3.type == INT) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    o(yyout, $1.is_address, $3.is_address);

                    $$.type = BOOLEAN;
                    $$.is_address = 0;

                    fprintf(yyout,";R78:\t<exp> ::= <exp> || <exp> \n");
                  }
                | TOK_NOT exp
                  { 
                    if($2.type == INT) {
                      printf("****Error semantico en lin %ld: Operacion logica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    no(yyout, $2.is_address, label);

                    label++;
                    $$.type = BOOLEAN;
                    $$.is_address = 0;

                    fprintf(yyout,";R79:\t<exp> ::= ! <exp> \n");
                  }
                | TOK_IDENTIFICADOR
                  { 
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
                    $$.type = entry->data;
                    $$.is_address = 1;
                    if (entry->cathegory == PARAMETRO) {
                      escribirParametro(yyout, entry->global.position, current_args_info.cardinal);
                    }
                    else if (entry->cathegory == VARIABLE) {
                      if (table->env == LOCAL) {
                        escribirVariableLocal(yyout, entry->global.position);
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
                    fprintf(yyout,";R81:\t<exp> ::= <constante>\n");
                    $$.is_address = $1.is_address;
                    $$.type = $1.type;
                  }
                | TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO
                  { 
                    fprintf(yyout,";R82:\t<exp> ::= ( <exp> )\n");
                    $$.is_address = $2.is_address;
                    $$.type = $2.type;
                  }
                | TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO
                  { 
                    fprintf(yyout,";R83:\t<exp> ::= ( <comparacion> )\n");
                    $$.is_address = $2.is_address;
                    $$.type = $2.type;
                  }
                | elemento_vector
                  { 
                    fprintf(yyout,";R85:\t<exp> ::= <elemento_vector>\n");
                    $$.is_address = $1.is_address;
                    $$.type = $1.type;
                  }
                | idf_llamada_funcion TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO
                  {
                    Entry* entry;
                    entry = search_entry(table, $1.name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a la variable no declarada (%s)\n", yylin, $1.name);
                      destroy_table(table);
                      return 1;
                    }
                    if (f_num_args != entry->global.cardinal) {
                      printf("****Error semantico en lin %ld: Numero incorrecto de parametros en llamada.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    $$.type = entry->data;
                    llamarFuncion(yyout, $1.name, entry->global.cardinal);
                    llamada_funcion = 0;

                    fprintf(yyout,";R88:\t<exp> ::= <identificador> ( <lista_expresiones> ) \n");
                  }
                ;

idf_llamada_funcion: TOK_IDENTIFICADOR
                  {
                    Entry* entry;

                    entry = search_entry(table, $1.name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.name);
                      destroy_table(table);
                      return 1;
                    }

                    if (llamada_funcion == 1) {
                      printf("****Error semantico en lin %ld: No esta permitido el uso de llamadas a funciones como parametros de otras funciones.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }

                    f_num_args = 0;
                    llamada_funcion = 1;
                    strcpy($$.name, $1.name);
                  }
                ;

lista_expresiones: argPila resto_lista_expresiones  
                  {
                      f_num_args += 1;
                      fprintf(yyout, ";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");
                  }
                | {fprintf(yyout, ";R90:\t<lista_expresiones> ::=\n");}
                ;

resto_lista_expresiones: TOK_COMA argPila resto_lista_expresiones   
                  {
                      f_num_args += 1;
                      fprintf(yyout, ";R91:\t<resto_lista_expresiones> ::= , <exp> <resto_lista_expresiones>\n");
                  }
              |   {fprintf(yyout, ";R92:\t<resto_lista_expresiones> ::=\n");}
              ;

argPila: exp
                  {
                      operandoEnPilaAArgumento(yyout, $1.is_address);
                  }
              ;

comparacion: exp TOK_IGUAL exp      
                  {
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      igual(yyout, $1.is_address, $3.is_address, label);
                      label += 1;

                      fprintf(yyout, ";R93:\t<comparacion> ::= <exp> == <exp>\n");
                  }
            | exp TOK_DISTINTO exp   
                  {
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      distinto(yyout, $1.is_address, $3.is_address, label);
                      label += 1;

                      fprintf(yyout, ";R94:\t<comparacion> ::= <exp> != <exp>\n");
                  }
            | exp TOK_MENORIGUAL exp 
                  {
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      menor_igual(yyout, $1.is_address, $3.is_address, label);
                      label += 1;

                      fprintf(yyout, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");
                  }
            | exp TOK_MAYORIGUAL exp 
                  {
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      mayor_igual(yyout, $1.is_address, $3.is_address, label);
                      label += 1;

                      fprintf(yyout, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");
                  }
            | exp TOK_MENOR exp      
                  {
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      menor(yyout, $1.is_address, $3.is_address, label);
                      label += 1;

                      fprintf(yyout, ";R97:\t<comparacion> ::= <exp> < <exp>\n");
                  }
            | exp TOK_MAYOR exp      
                  {
                      if ($1.type != INT || $3.type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.type = BOOLEAN;
                      $$.is_address = 0;

                      mayor(yyout, $1.is_address, $3.is_address, label);
                      label += 1;

                      fprintf(yyout, ";R98:\t<comparacion> ::= <exp> > <exp>\n");
                  }
                  ;

constante: constante_logica 
                  {
                      /* Checkeamos la semantica*/
                      $$.type = $1.type;
                      $$.is_address = $1.is_address;
                      $$.integer_value = $1.integer_value;
                      fprintf(yyout, ";R99:\t<constante> ::= <constante_logica>\n");
                  }
          | constante_entera 
                  {
                      /* Checkeamos la semantica*/
                      $$.type = $1.type;
                      $$.is_address = $1.is_address;
                      $$.integer_value = $1.integer_value;
                      fprintf(yyout, ";R100:\t<constante> ::= <constante_entera>\n");
                  }
                  ;

constante_logica: TOK_TRUE  
                    {
                      /* Checkeamos la semantica*/
                        $$.type = BOOLEAN;
                        $$.is_address = 0;
                        $$.integer_value = 1;

                        char type[2];

                        sprintf(type, "1");
                        escribir_operando(yyout, type, 0);
                        fprintf(yyout, ";R102:\t<constante_logica> ::= true\n");
                    }
                | TOK_FALSE 
                    {
                      /* Checkeamos la semantica*/
                        $$.type = BOOLEAN;
                        $$.is_address = 0;
                        $$.integer_value = 1;

                        char type[2];

                        sprintf(type, "0");
                        escribir_operando(yyout, type, 0);
                        fprintf(yyout, ";R103:\t<constante_logica> ::= false\n");
                    }
                    ;

constante_entera: TOK_CONSTANTE_ENTERA
                    {
                      $$.is_address = 0;
                      $$.integer_value = $1.integer_value;
                      $$.type = INT;
                      char c[MAX_INT_SIZE];
                      sprintf(c, "%d", $$.integer_value);
                      escribir_operando(yyout, c, 0);
                      fprintf(yyout,";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");
                    }
                    ;
                

identificador: TOK_IDENTIFICADOR
               {
                  ArgsInfo entryLocal;
                  ArgsInfo entryGlobal;

                  entryLocal.cardinal = 0;
                  entryLocal.position = current_local_args_info.cardinal;
                  entryGlobal.cardinal = f_num_args;
                  entryGlobal.position = current_local_args_info.position;

                 if (table->env == LOCAL) {
                   current_local_args_info.position++;
                   current_local_args_info.cardinal++;
                  


                   if(insert_entry(table, create_entry($1.name,current_size, VARIABLE, current_data_type,
                                         current_data_complexity, entryGlobal, entryLocal)) == 1) {
                     printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                     destroy_table(table);
                     return 1;
                   }
                 }

                 if (table->env == GLOBAL) {
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
              if(!search_entry(table, $1.name)) {

                ArgsInfo entryLocal;
                ArgsInfo entryGlobal;

                entryLocal.cardinal = 0;
                entryLocal.position = 0;
                entryGlobal.cardinal = 0;
                entryGlobal.position = current_args_info.position;

                if(insert_entry(table, create_entry($1.name,1,PARAMETRO, current_data_type,ESCALAR, entryGlobal, entryLocal)) == 1) {
                  destroy_table(table);
                  return 1;
                }
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
        printf("****Error sintactico en [lin %ld, col %ld]\n", yylin, yycol);
    }
}