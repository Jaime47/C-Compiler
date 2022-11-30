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
int f_type = 0;
int f_num_args

int etiqueta = 0;
int llamada_funcion = 0;

int cardinal_args_funcion = 0;

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
           fprintf(out,";R22:\t<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }\n");

           if(f_return < 1)
            {
                printf("****Error semantico en lin %ld: Funcion %s no tiene sentencia de retorno.\n", yylin, $1.nombre);
                destroy_table(table);
                return 1;
            } 
           shut_down_local_env(table);
           Entry *entry;
           entry = search_entry(table, $1.nombre);
           if(!entry) {
                destroy_table(table);
                return 1;
           }
           
           entry->global->cardinal = current_args_info->cardinal;
           entry->cathegory = current_cathegory;
           current_args_info->cardinal = 0;
           current_local_args_info->cardinal = 0;
           current_args_info->position = 0;
         }
       ;


fn_declaration: fn_name TOK_PARENTESISIZQUIERDO parametros_funcion TOK_PARENTESISDERECHO
                TOK_LLAVEIZQUIERDA declaraciones_funcion
                {
                  Entry* entry;
                  entry = search_entry(table, $1.nombre);
                if(!entry) {
                    destroy_table(table);
                    return 1;
                }
                strcpy($$.nombre, $1.nombre);
                entry->global->cardinal = current_args_info->cardinal;
                entry->local->cardinal = current_local_args_info->cardinal;
                entry->cathegory = current_cathegory;
                declararFuncion(out, $1.nombre, current_local_args_info->cardinal);
                }
              ;

fn_name: TOK_FUNCTION tipo TOK_IDENTIFICADOR
         {
           if (!search_entry(table, $3.nombre)) {
             strcpy($$.nombre, $3.nombre);
             // HAY QUE MIRAR LOS ARGUMENTOS DE ESTA LLAMADA

             ArgsInfo entryLocal;
             ArgsInfo entryGlobal;

              entryLocal.cardinal = f_num_args;
              entryLocal.position = current_local_args_info->position;
              entryGlobal.cardinal = 0;
              entryGlobal.position = f_num_args; 


             open_local_env(table, $3.nombre, current_size, VARIABLE, current_data_type,
              current_data_complexity, entryGlobal, entryLocal);
             
             current_args_info->cardinal = 0;
             f_return = 0;
             f_type = current_data_type;         
             current_size = 1;
             current_local_args_info->cardinal = 0;
             current_args_info->position = 0;

           }
           else {
             printf("****Error semantico en lin %ld: Declaracion duplicada\n", yylin);
             destroy_table(table);
             return 1;
           }
         }
       ;


parametros_funcion: parametro_funcion resto_parametros_funcion  {fprintf(out, ";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
                  |                                             {fprintf(out, ";R24:\t<parametros_funcion> ::=\n");}
                  ;

resto_parametros_funcion: TOK_PUNTOYCOMA parametro_funcion resto_parametros_funcion {fprintf(out, ";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
                        |                                                           {fprintf(out, ";R26:\t<resto_parametros_funcion> ::=\n");}
                        ;
// CAMBIAR identificador
parametro_funcion: tipo idpf   {fprintf(out, ";R27:\t<parametro_funcion> ::= <tipo> <identificador>\n");
                     current_args_info->position++;
                     current_args_info->cardinal++;}
                 ;

declaraciones_funcion: declaraciones    {fprintf(out, ";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
                     |                  {fprintf(out, ";R29:\t<declaraciones_funcion> ::=\n");}
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

asignacion: TOK_IDENTIFICADOR TOK_ASIGNACION exp
            {
              Entry *entry;
              entry = search_entry(table, $1.nombre);

              if(!entry) {
                printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.nombre);
                destroy_table(table);
                return 1;  
              }

              if(entry->complexity == VECTOR || entry->cathegory == FUNCION || entry->data != $3.tipo) {
                printf("****Error semantico en lin %ld: Asignacion incompatible.\n", yylin);
                destroy_table(table);
                return 1;
              }

              if(table->env == GLOBAL) {
                asignar(out, $1.nombre, $3.es_direccion);
              }

              else {
                escribirVariableLocal(out, entry->global->position);
                asignarDestinoEnPila(out, $3.es_direccion);
              }

              fprintf(out,";R43:\t<asignacion> ::= <identificador> = <exp>\n");
            }
          | elemento_vector TOK_ASIGNACION exp
            { 
              Entry *entry;
              entry = search_entry(table, $1.nombre);

              if(!entry) {
                printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.nombre);
                destroy_table(table);
                return 1;  
              }

              if($1.tipo != $3.tipo) {
                printf("****Error semantico en lin %ld: Asignacion incompatible.\n", yylin);
                destroy_table(table);
                return 1;  
              }
              char e[MAX_INT_SIZE];
              sprintf(e, "%d", $1.valor_entero);
              escribir_operando(out, e, 0);
              escribir_elemento_vector(out, entry->key, entry->size, $3.es_direccion); 
              asignarDestinoEnPila(out, $3.es_direccion);

              fprintf(out,";R44:\t<asignacion> ::= <elemento_vector> = <exp>\n");
            }
          ;

elemento_vector: TOK_IDENTIFICADOR TOK_CORCHETEIZQUIERDO exp TOK_CORCHETEDERECHO
                 { 
                    Entry *entry;
                    entry = search_entry(table, $1.nombre);

                    if(!entry) {
                        printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.nombre);
                        destroy_table(table);
                        return 1;  
                    }

                   if(entry->complexity != VECTOR) {
                     printf("****Error semantico en lin %ld: Indexando variable no vectorial.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   if($3.tipo != INT){
                     printf("****Error semantico en lin %ld: El indice debe ser de tipo entero.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   $$.tipo = entry->data;
                   $$.es_direccion = 1;
                   $$.valor_entero = $3.valor_entero;

                   escribir_elemento_vector(out, entry->key, entry->size, $3.es_direccion);
                   fprintf(out,";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");
                 }
               ;

condicional:    if_exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA                                                            
                {
                    ifthen_fin(out, $1.etiqueta);
                    fprintf(out, ";R50:\t<condicional> ::= if ( <exp> ) { <sentencias> }\n");
                }
           |    if_else_exp TOK_ELSE TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA    
                {
                    ifthenelse_fin(out, $1.etiqueta);
                    fprintf(out, ";R51:\t<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }\n");
                }
           ;

if_exp: TOK_IF TOK_PARENTESISIZQUIERDO exp
                {
                    if ($3.tipo != BOOLEAN) {
                        printf("****Error semantico en lin %ld: Condicion de tipo int.\n",yylin);
                        return 1;
                    }
                    $$.etiqueta = etiqueta++;
                    ifthen_inicio(out, $3.es_direccion, $$.etiqueta);
                };

if_else_exp: if_exp TOK_PARENTESISDERECHO TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA 
                {
                    $$.etiqueta = $1.etiqueta;
                    ifthenelse_fin_then(out, $1.etiqueta);
                };

bucle: while_exp TOK_LLAVEIZQUIERDA sentencias TOK_LLAVEDERECHA
                { 
                    while_fin(out, $1.etiqueta);
                    fprintf(out,";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");
                };

while_exp: while TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO
                {
                    if($3.tipo != BOOLEAN) {
                        printf("****Error semantico en lin %ld: Condicion de tipo int.\n",yylin);
                        destroy_table(table);
                        return 1;
                    }
                    $$.etiqueta = $1.etiqueta;
                    while_exp_pila(out, $3.es_direccion, $$.etiqueta);  
                };

while: TOK_WHILE
                {
                $$.etiqueta = etiqueta++;
                while_inicio(out, $$.etiqueta);
                };

lectura: TOK_SCANF TOK_IDENTIFICADOR
                {
                    Entry *entry;
                    entry = search_entry(table, $2.nombre);

                    if(!entry) {
                        printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $2.nombre);
                        destroy_table(table);
                        return 1;  
                    }
                  
                    if (entry->complexity == VECTOR || entry->cathegory == FUNCION) {
                      printf("****Error semantico en lin %ld: Variable local de tipo no escalar.\n", yylin);
                          destroy_table(table);
                          return 1;  
                    }
                    leer(out, $2.nombre, entry->data);
                    fprintf(out,";R54:\t<lectura> ::= scanf <identificador>\n");
                  }
                ; 

escritura: TOK_PRINTF exp
                  {
                    operandoEnPilaAArgumento(out, $2.es_direccion);
                    escribir(out, 0, $2.tipo);

                    fprintf(out,";R56:\t<escritura> ::= printf <exp>\n");
                  }
                ;

retorno_funcion: TOK_RETURN exp     
                  {
                    if(llamada_funcion == 1) {
                      printf("****Error semantico en lin %ld: Sentencia de retorno fuera del cuerpo de una función.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    retornarFuncion(out, $2.es_direccion);
                    f_return++;
                    fprintf(out,";R61:\t<retorno_funcion> ::= return <exp>\n");

                  }
                ;


exp: exp TOK_MAS exp
                  { 
                    if($1.tipo == BOOLEAN || $3.tipo == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    sumar(out, $1.es_direccion, $3.es_direccion);
                    $$.tipo = INT;
                    $$.es_direccion = 0;

                    fprintf(out,";R72:\t<exp> ::= <exp> + <exp> \n");
                  }
                | exp TOK_MENOS exp
                  { 
                    if($1.tipo == BOOLEAN || $3.tipo == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    restar(out, $1.es_direccion, $3.es_direccion);
                    $$.tipo = INT;
                    $$.es_direccion = 0;    

                    fprintf(out,";R73:\t<exp> ::= <exp> - <exp> \n");

                  }
                | exp TOK_DIVISION exp
                  { 
                    if($1.tipo == BOOLEAN || $3.tipo == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    dividir(out, $1.es_direccion, $3.es_direccion);
                    $$.tipo = INT;
                    $$.es_direccion = 0;

                    fprintf(out,";R74:\t<exp> ::= <exp> / <exp> \n");
                  }
                | exp TOK_ASTERISCO exp
                  { 
                    
                    if($1.tipo == BOOLEAN || $3.tipo == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    multiplicar(out, $1.es_direccion, $3.es_direccion);
                    $$.tipo = INT;
                    $$.es_direccion = 0;
                    fprintf(out,";R75:\t<exp> ::= <exp> * <exp> \n");

                  }
                | TOK_MENOS exp
                  { 
                    if($2.tipo == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    cambiar_signo(out, $2.es_direccion);
                    $$.tipo = INT;
                    $$.es_direccion = 0;

                    fprintf(out,";R76:\t<exp> ::= - <exp> \n");
                  }
                | exp TOK_AND exp
                  { 
                    if($1.tipo == INT || $3.tipo == INT) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    y(out, $1.es_direccion, $3.es_direccion);
                    $$.tipo = BOOLEAN;
                    $$.es_direccion = 0;

                    fprintf(out,";R77:\t<exp> ::= <exp> && <exp> \n");
                  }
                | exp TOK_OR exp
                  { 
                    if($1.tipo == INT || $3.tipo == INT) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    o(out, $1.es_direccion, $3.es_direccion);

                    $$.tipo = BOOLEAN;
                    $$.es_direccion = 0;

                    fprintf(out,";R78:\t<exp> ::= <exp> || <exp> \n");
                  }
                | TOK_NOT exp
                  { 
                    if($2.tipo == INT) {
                      printf("****Error semantico en lin %ld: Operacion logica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    no(out, $2.es_direccion, etiqueta);

                    etiqueta++;
                    $$.tipo = BOOLEAN;
                    $$.es_direccion = 0;

                    fprintf(out,";R79:\t<exp> ::= ! <exp> \n");
                  }
                | TOK_IDENTIFICADOR
                  { 
                    Entry* entry;
                    entry = search_entry(table, $1.nombre);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a la variable no declarada (%s)\n", yylin, $1.nombre);
                      destroy_table(table);
                      return 1;
                    }
                    if(entry->cathegory == FUNCION || entry->complexity == VECTOR) {
                      printf("****Error semantico en lin %ld: Asignacion incompatible.", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    $$.tipo = entry->data;
                    $$.es_direccion = 1;
                    if (entry->cathegory == PARAMETRO) {
                      escribirParametro(out, entry->global->position, current_args_info->cardinal);
                    }
                    else if (entry->cathegory == VARIABLE) {
                      if (entry->env == AMBITO_LOCAL) {
                        escribirVariableLocal(out, entry->local->position);
                      }
                      else {
                        escribir_operando(out, $1.nombre, 1);
                        if(llamada_funcion == 1) {
                          operandoEnPilaAArgumento(out,1);
                        }
                      }
                    }

                    fprintf(out,";R80:\t<exp> ::= <identificador>\n");
                  }
                | constante
                  { 
                    fprintf(out,";R81:\t<exp> ::= <constante>\n");
                    $$.es_direccion = $1.es_direccion;
                    $$.tipo = $1.tipo;
                  }
                | TOK_PARENTESISIZQUIERDO exp TOK_PARENTESISDERECHO
                  { 
                    fprintf(out,";R82:\t<exp> ::= ( <exp> )\n");
                    $$.es_direccion = $2.es_direccion;
                    $$.tipo = $2.tipo;
                  }
                | TOK_PARENTESISIZQUIERDO comparacion TOK_PARENTESISDERECHO
                  { 
                    fprintf(out,";R83:\t<exp> ::= ( <comparacion> )\n");
                    $$.es_direccion = $2.es_direccion;
                    $$.tipo = $2.tipo;
                  }
                | elemento_vector
                  { 
                    fprintf(out,";R85:\t<exp> ::= <elemento_vector>\n");
                    $$.es_direccion = $1.es_direccion;
                    $$.tipo = $1.tipo;
                  }
                | idf_llamada_funcion TOK_PARENTESISIZQUIERDO lista_expresiones TOK_PARENTESISDERECHO
                  {
                    Entry* entry;
                    entry = search_entry(table, $1.nombre);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a la variable no declarada (%s)\n", yylin, $1.nombre);
                      destroy_table(table);
                      return 1;
                    }
                    if (function->cardinal != entry->global->cardinal) {
                      printf("****Error semantico en lin %ld: Numero incorrecto de parametros en llamada.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    $$.tipo = elemento->tipo;
                    llamarFuncion(out, $1.nombre, elemento->num_par);
                    llamada_funcion = 0;

                    fprintf(out,";R88:\t<exp> ::= <identificador> ( <lista_expresiones> ) \n");
                  }
                ;

idf_llamada_funcion: TOK_IDENTIFICADOR
                  {
                    Entry* entry;

                    entry = search_entry(table, $1.nombre);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, $1.nombre);
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
                    strcpy($$.nombre, $1.nombre);
                  }
                ;

lista_expresiones: argPila resto_lista_expresiones  
                  {
                      f_num_args += 1;
                      fprintf(out, ";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");
                  }
                | {fprintf(out, ";R90:\t<lista_expresiones> ::=\n");}
                ;

resto_lista_expresiones: TOK_COMA argPila resto_lista_expresiones   
                  {
                      f_num_args += 1;
                      fprintf(out, ";R91:\t<resto_lista_expresiones> ::= , <exp> <resto_lista_expresiones>\n");
                  }
              |   {fprintf(out, ";R92:\t<resto_lista_expresiones> ::=\n");}
              ;

argPila: exp
                  {
                      operandoEnPilaAArgumento(out, $1.es_direccion);
                  }
              ;

comparacion: exp TOK_IGUAL exp      
                  {
                      if ($1.tipo != INT || $3.tipo != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.tipo = BOOLEAN;
                      $$.es_direccion = 0;

                      igual(out, $1.es_direccion, $3.es_direccion, etiqueta);
                      etiqueta += 1;

                      fprintf(out, ";R93:\t<comparacion> ::= <exp> == <exp>\n");
                  }
            | exp TOK_DISTINTO exp   
                  {
                      if ($1.tipo != INT || $3.tipo != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.tipo = BOOLEAN;
                      $$.es_direccion = 0;

                      distinto(out, $1.es_direccion, $3.es_direccion, etiqueta);
                      etiqueta += 1;

                      fprintf(out, ";R94:\t<comparacion> ::= <exp> != <exp>\n");
                  }
            | exp TOK_MENORIGUAL exp 
                  {
                      if ($1.tipo != INT || $3.tipo != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.tipo = BOOLEAN;
                      $$.es_direccion = 0;

                      menor_igual(out, $1.es_direccion, $3.es_direccion, etiqueta);
                      etiqueta += 1;

                      fprintf(out, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");
                  }
            | exp TOK_MAYORIGUAL exp 
                  {
                      if ($1.tipo != INT || $3.tipo != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.tipo = BOOLEAN;
                      $$.es_direccion = 0;

                      mayor_igual(out, $1.es_direccion, $3.es_direccion, etiqueta);
                      etiqueta += 1;

                      fprintf(out, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");
                  }
            | exp TOK_MENOR exp      
                  {
                      if ($1.tipo != INT || $3.tipo != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.tipo = BOOLEAN;
                      $$.es_direccion = 0;

                      menor(out, $1.es_direccion, $3.es_direccion, etiqueta);
                      etiqueta += 1;

                      fprintf(out, ";R97:\t<comparacion> ::= <exp> < <exp>\n");
                  }
            | exp TOK_MAYOR exp      
                  {
                      if ($1.tipo != INT || $3.tipo != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          return 1;
                      }
                      $$.tipo = BOOLEAN;
                      $$.es_direccion = 0;

                      mayor(out, $1.es_direccion, $3.es_direccion, etiqueta);
                      etiqueta += 1;

                      fprintf(out, ";R98:\t<comparacion> ::= <exp> > <exp>\n");
                  }
                  ;

constante: constante_logica 
                  {
                      /* Checkeamos la semantica*/
                      $$.tipo = $1.tipo;
                      $$.es_direccion = $1.es_direccion;
                      $$.valor_entero = $1.valor_entero;
                      fprintf(out, ";R99:\t<constante> ::= <constante_logica>\n");
                  }
          | constante_entera 
                  {
                      /* Checkeamos la semantica*/
                      $$.tipo = $1.tipo;
                      $$.es_direccion = $1.es_direccion;
                      $$.valor_entero = $1.valor_entero;
                      fprintf(out, ";R100:\t<constante> ::= <constante_entera>\n");
                  }
                  ;

constante_logica: TOK_TRUE  
                    {
                      /* Checkeamos la semantica*/
                        $$.tipo = BOOLEAN;
                        $$.es_direccion = 0;
                        $$.valor_entero = 1;

                        char type[2];

                        sprintf(type, "1");
                        escribir_operando(out, type, 0);
                        fprintf(out, ";R102:\t<constante_logica> ::= true\n");
                    }
                | TOK_FALSE 
                    {
                      /* Checkeamos la semantica*/
                        $$.tipo = BOOLEAN;
                        $$.es_direccion = 0;
                        $$.valor_entero = 1;

                        char type[2];

                        sprintf(type, "0");
                        escribir_operando(out, type, 0);
                        fprintf(out, ";R103:\t<constante_logica> ::= false\n");
                    }
                    ;

constante_entera: TOK_CONSTANTE_ENTERA
                    {
                      $$.es_direccion = 0;
                      $$.valor_entero = $1.valor_entero;
                      $$.tipo = INT;
                      char c[MAX_INT_SIZE];
                      sprintf(c, "%d", $$.valor_entero);
                      escribir_operando(out, c, 0);
                      fprintf(yyout,";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");
                    }
                    ;
                

identificador: TOK_IDENTIFICADOR
               {
                  ArgsInfo entryLocal;
                  ArgsInfo entryGlobal;

                  entryLocal.cardinal = 0;
                  entryLocal.position = current_local_args_info->cardinal;
                  entryGlobal.cardinal = f_num_args;
                  entryGlobal.position = current_local_args_info->position;

                 if (tabla->env == LOCAL) {
                   current_local_args_info->position++;
                   current_local_args_info->cardinal++;
                  


                   if(insert_entry(table, create_entry($1.nombre,current_size, VARIABLE, current_data_type,
                                         current_data_complexity, entryGlobal, entryLocal)) == 1) {
                     printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                     destroy_table(table);
                     return 1;
                   }
                 }

                 if (tabla->ambito == GLOBAL) {
                   if(insert_entry(table, create_entry($1.nombre,current_size, VARIABLE, current_data_type,
                                         current_data_complexity, entryGlobal, entryLocal)) == 1) {
                     printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                     destroy_table(table);
                     return 1;
                   }
                   declarar_variable(out, $1.nombre, current_data_type, current_size);
                 }
                 fprintf(out,";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
               }
              ;

idpf: TOK_IDENTIFICADOR
              {
              if(!search_entry(table, $1.nombre)) {

                ArgsInfo entryLocal;
                ArgsInfo entryGlobal;

                entryLocal.cardinal = 0;
                entryLocal.position = 0;
                entryGlobal.cardinal = 0;
                entryGlobal.position = current_args_info->position;

                if(insert_entry(table, create_entry($1.nombre,1,PARAMETRO, current_data_type,ESCALAR, entryGlobal, entryLocal)) == 1) {
                  destroy_table(table);
                  return 1;
                }
              }
              else {
                printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                destroy_table(tabla);
                return 1;
              }
            }
            ;


%%
