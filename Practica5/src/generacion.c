/**
 * Autor: Jaime Pons Garrido
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "generacion.h"

/*******************************************************
 * INICIALIZACION Y SEGMENTOS
 ********************************************************/

void escribir_cabecera_bss(FILE *fpasm)
{
  if (fpasm)
  {
    fprintf(fpasm, "\n");
    fprintf(fpasm, "segment .bss\n");
    fprintf(fpasm, "  __esp resd 1\n");
  }
  return;
}

void escribir_subseccion_data(FILE *fpasm)
{
  if (fpasm)
  {
    fprintf(fpasm, "\n");
    fprintf(fpasm, "segment .data\n");
    fprintf(fpasm, "  _msg_error_div_zero db \"****Error de ejecucion: Division por cero.\", 0\n");
    fprintf(fpasm, "  _msg_error_index_out_of_range db \"****Error de ejecucion: Indice fuera de rango.\", 0\n");
  }
  return;
}

void declarar_variable(FILE *fpasm, char *nombre, int tipo, int tamano)
{
  if (fpasm)
  {
    fprintf(fpasm, "  _%s resd %d\n", nombre, tamano);
  }
  return;
}

void escribir_segmento_codigo(FILE *fpasm)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "\n");
  fprintf(fpasm, "segment .text\n");
  fprintf(fpasm, "  global main\n");
  fprintf(fpasm, "  extern print_int, print_boolean, print_string, print_blank, print_endofline\n");
  fprintf(fpasm, "  extern scan_int, scan_boolean\n");
  return;
}

void escribir_inicio_main(FILE *fpasm)
{
  if (fpasm == NULL)
    return;
  fprintf(fpasm, "\n");
  fprintf(fpasm, "main:\n");
  fprintf(fpasm, "; guarda el puntero de pila en su variable\n");
  fprintf(fpasm, "  mov [__esp], esp\n");
  return;
}

void escribir_fin(FILE *fpasm)
{
  if (!fpasm)
    return;

  // Salto al final
  fprintf(fpasm, "  jmp near fin\n");
  fprintf(fpasm, "\n");

  // Casos de error
  // Division entre cero _msg_error_div_zero
  fprintf(fpasm, "error_div_zero:\n");
  fprintf(fpasm, "  push dword _msg_error_div_zero\n");
  fprintf(fpasm, "  call print_string\n");
  fprintf(fpasm, "  add esp, 4\n");
  fprintf(fpasm, "  call print_endofline\n");
  fprintf(fpasm, "  jmp near fin\n");

  // Indice fuera de rango _msg_error_index_out_of_range
  fprintf(fpasm, "\n");
  fprintf(fpasm, "  idx_out_of_range:\n");
  fprintf(fpasm, "  push dword _msg_error_index_out_of_range\n");
  fprintf(fpasm, "  call print_string\n");
  fprintf(fpasm, "  add esp, 4\n");
  fprintf(fpasm, "  call print_endofline\n");
  fprintf(fpasm, "  jmp near fin\n");

  // Puntero pila
  fprintf(fpasm, "\n");
  fprintf(fpasm, "fin:\n");
  fprintf(fpasm, "  mov esp, [__esp]\n");

  // Retorno
  fprintf(fpasm, "  ret\n");
  return;
}

/*******************************************************
 * OPERANDOS EN PILA
 ********************************************************/

void escribir_operando(FILE *fpasm, char *nombre, int es_variable)
{
  if (!fpasm)
    return;

  if (es_variable == 1)
  {
    fprintf(fpasm, "  push dword _%s\n", nombre);
  }
  else
  {
    fprintf(fpasm, "  mov edx, %s\n", nombre);
    fprintf(fpasm, "  push dword edx\n");
  }
  return;
}

void asignar(FILE *fpasm, char *nombre, int es_variable)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");

  if (es_variable == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  mov dword [_%s], edx\n", nombre);

  return;
}

/*******************************************************
 * OPERACIONES ARITMETICAS/LOGICAS
 ********************************************************/

void sumar(FILE *fpasm, int es_variable_1, int es_variable_2)
{

  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable_2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable_1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }
  // Suma
  fprintf(fpasm, "  add eax, edx\n");
  // Añadir a la pila
  fprintf(fpasm, "  push dword eax\n");

  return;
}

void restar(FILE *fpasm, int es_variable_1, int es_variable_2)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable_2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable_1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // Resta
  fprintf(fpasm, "  sub eax, edx\n");
  // Añadir a la pila
  fprintf(fpasm, "  push dword eax\n");

  return;
}

void multiplicar(FILE *fpasm, int es_variable_1, int es_variable_2)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable_2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable_1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // Multiplicacion
  fprintf(fpasm, "  imul edx\n");
  // Añadir a la pila
  fprintf(fpasm, "  push dword eax\n");

  return;
}

void dividir(FILE *fpasm, int es_variable_1, int es_variable_2)
{
  if (!fpasm)
    return;
  // Segundo operando en ecx
  fprintf(fpasm, "  pop dword ecx\n");
  if (es_variable_2 == 1)
  {
    fprintf(fpasm, "  mov dword ecx, [ecx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable_1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // Check error: Division entre cero
  fprintf(fpasm, "  cmp ecx, 0\n");
  fprintf(fpasm, "  je error_div_zero\n");

  fprintf(fpasm, "  mov edx, 0\n");

  // Division
  fprintf(fpasm, "  idiv ecx\n");
  // Resultado en eax
  fprintf(fpasm, "  push dword eax\n");

  return;
}

void o(FILE *fpasm, int es_variable_1, int es_variable_2)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable_2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable_1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // Or
  fprintf(fpasm, "  or eax, edx\n");
  // Añadir a la pila
  fprintf(fpasm, "  push dword eax\n");

  return;
}

void y(FILE *fpasm, int es_variable_1, int es_variable_2)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable_2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable_1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // And
  fprintf(fpasm, "  and eax, edx\n");
  // Resultado en eax
  fprintf(fpasm, "  push dword eax\n");

  return;
}

void cambiar_signo(FILE *fpasm, int es_variable)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // Cambio de signo
  fprintf(fpasm, "  neg eax\n");
  // Resultado en eax
  fprintf(fpasm, "  push dword eax\n");
  return;
}

void no(FILE *fpasm, int es_variable, int cuantos_no)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // Checkeo top de la pila (0 o 1)
  fprintf(fpasm, "  cmp eax, 0\n");
  fprintf(fpasm, "  je no_%d\n", cuantos_no);
  // Si es 1, asignamos 0
  fprintf(fpasm, "  mov eax, 0\n");
  fprintf(fpasm, "  jmp end_no_%d\n", cuantos_no);
  fprintf(fpasm, "\n");
  fprintf(fpasm, "no_%d:\n", cuantos_no);
  // Si es 0, asignamos 1
  fprintf(fpasm, "  mov eax, 1\n");
  fprintf(fpasm, "\n");
  fprintf(fpasm, "end_no_%d:\n", cuantos_no);

  // Añadir resultado a la pila
  fprintf(fpasm, "  push dword eax\n");
  return;
}

/*******************************************************
 * OPERACIONES COMPARATIVAS
 ********************************************************/
// Label: igual (etiqueta de la operacion)
// Label: end_igual (final de la operacion)
void igual(FILE *fpasm, int es_variable1, int es_variable2, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, edx\n");
  fprintf(fpasm, "  je igual_%d\n", etiqueta);

  // No se cumple la condicion
  fprintf(fpasm, "  push dword 0\n");
  fprintf(fpasm, "  jmp end_igual_%d\n", etiqueta);
  // Se cumple la condicion
  fprintf(fpasm, "\n");
  fprintf(fpasm, "igual_%d:\n", etiqueta);
  fprintf(fpasm, "  push dword 1\n");
  // Final
  fprintf(fpasm, "\n");
  fprintf(fpasm, "end_igual_%d:\n", etiqueta);
  return;
}

// Label: distinto (etiqueta de la operacion)
// Label: end_distinto (final de la operacion)
void distinto(FILE *fpasm, int es_variable1, int es_variable2, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, edx\n");
  fprintf(fpasm, "  jne distinto_%d\n", etiqueta);

  // No se cumple la condicion
  fprintf(fpasm, "  push dword 0\n");
  fprintf(fpasm, "  jmp end_distinto_%d\n", etiqueta);
  // Se cumple la condicion
  fprintf(fpasm, "\n");
  fprintf(fpasm, "distinto_%d:\n", etiqueta);
  fprintf(fpasm, "  push dword 1\n");
  // Final
  fprintf(fpasm, "\n");
  fprintf(fpasm, "end_distinto_%d:\n", etiqueta);
  return;
}
// Label: menor_igual (etiqueta de la operacion)
// Label: end_menor_igual (final de la operacion)
void menor_igual(FILE *fpasm, int es_variable1, int es_variable2, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, edx\n");
  fprintf(fpasm, "  jle menor_igual_%d\n", etiqueta);

  // No se cumple la condicion
  fprintf(fpasm, "  push dword 0\n");
  fprintf(fpasm, "  jmp fin_menor_igual_%d\n", etiqueta);

  // Se cumple la condicion
  fprintf(fpasm, "\n");
  fprintf(fpasm, "menor_igual_%d:\n", etiqueta);
  fprintf(fpasm, "  push dword 1\n");
  // Final
  fprintf(fpasm, "\n");
  fprintf(fpasm, "fin_menor_igual_%d:\n", etiqueta);
  return;
}
// Label: mayor_igual (etiqueta de la operacion)
// Label: end_mayor_igual (final de la operacion)
void mayor_igual(FILE *fpasm, int es_variable1, int es_variable2, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, edx\n");
  fprintf(fpasm, "  jge mayor_igual_%d\n", etiqueta);

  // No se cumple la condicion
  fprintf(fpasm, "  push dword 0\n");
  fprintf(fpasm, "  jmp fin_mayor_igual_%d\n", etiqueta);

  // Se cumple la condicion
  fprintf(fpasm, "\n");
  fprintf(fpasm, "mayor_igual_%d:\n", etiqueta);
  fprintf(fpasm, "  push dword 1\n");
  // Final
  fprintf(fpasm, "\n");
  fprintf(fpasm, "fin_mayor_igual_%d:\n", etiqueta);
  return;
}

// Label: menor (etiqueta de la operacion)
// Label: end_menor (final de la operacion)
void menor(FILE *fpasm, int es_variable1, int es_variable2, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, edx\n");
  fprintf(fpasm, "  jl menor_%d\n", etiqueta);
  // Se cumple la condicion
  fprintf(fpasm, "  push dword 0\n");
  fprintf(fpasm, "  jmp end_menor_%d\n", etiqueta);
  // No se cumple la condicion
  fprintf(fpasm, "\n");
  fprintf(fpasm, "menor_%d:\n", etiqueta);
  fprintf(fpasm, "  push dword 1\n");
  // Final
  fprintf(fpasm, "\n");
  fprintf(fpasm, "end_menor_%d:\n", etiqueta);
  return;
}

// Label: mayor (etiqueta de la operacion)
// Label: end_mayor (final de la operacion)
void mayor(FILE *fpasm, int es_variable1, int es_variable2, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword edx\n");
  if (es_variable2 == 1)
  {
    fprintf(fpasm, "  mov dword edx, [edx]\n");
  }

  fprintf(fpasm, "  pop dword eax\n");
  if (es_variable1 == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, edx\n");
  fprintf(fpasm, "  jg mayor_%d\n", etiqueta);
  // Se cumple la condicion
  fprintf(fpasm, "  push dword 0\n");
  fprintf(fpasm, "  jmp end_mayor_%d\n", etiqueta);
  // No se cumple la condicion
  fprintf(fpasm, "\n");
  fprintf(fpasm, "mayor_%d:\n", etiqueta);
  fprintf(fpasm, "  push dword 1\n");
  // Final
  fprintf(fpasm, "\n");
  fprintf(fpasm, "end_mayor_%d:\n", etiqueta);
  return;
}

/*******************************************************
 * OPERACIONES IMPUT/OUTPUT
 ********************************************************/

void leer(FILE *fpasm, char *nombre, int tipo)
{
  if (fpasm == NULL)
    return;

  // introduce la dirección donde se lee en la pila
  fprintf(fpasm, " push dword _%s\n", nombre);

  // llama a la funcion de leer correspondiente
  if (tipo == ENTERO)
  {
    fprintf(fpasm, "  call scan_int\n");
  }
  else if (tipo == BOOLEANO)
  {
    fprintf(fpasm, "  call scan_boolean\n");
  }
  // Arreglar la pila
  fprintf(fpasm, "  add esp, 4\n");
  return;
}

void escribir(FILE *fpasm, int es_variable, int tipo)
{
  if (!fpasm)
    return;

  // Variable into stack
  if (es_variable == 1)
  {
    fprintf(fpasm, "  pop dword edx\n");
    fprintf(fpasm, "  push dword [edx]\n");
  }

  // Select print function
  if (tipo == ENTERO)
  {
    fprintf(fpasm, "  call print_int\n");
  }
  else if (tipo == BOOLEANO)
  {
    fprintf(fpasm, "  call print_boolean\n");
  }
  // Final de linea
  fprintf(fpasm, "  call print_endofline\n");
  // Arreglar la pila
  fprintf(fpasm, "  add esp, 4\n");
  return;
}

/*******************************************************
 * OPERACIONES CONTROL
 ********************************************************/

void ifthenelse_inicio(FILE *fpasm, int exp_es_variable, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword eax\n");

  if (exp_es_variable == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, 0\n");
  fprintf(fpasm, "  je else_%d\n", etiqueta);
  return;
}

void ifthen_inicio(FILE *fpasm, int exp_es_variable, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword eax\n");

  if (exp_es_variable == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  fprintf(fpasm, "  cmp eax, 0\n");

  fprintf(fpasm, "  je end_if_%d\n", etiqueta);

  return;
}

void ifthen_fin(FILE *fpasm, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "end_if_%d:\n", etiqueta);
  return;
}

void ifthenelse_fin_then(FILE *fpasm, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "  je end_if_else_%d\n", etiqueta);

  fprintf(fpasm, "else_%d:\n", etiqueta);

  return;
}

void ifthenelse_fin(FILE *fpasm, int etiqueta)
{
  if (!fpasm)
    return;

  fprintf(fpasm, "end_if_else_%d:\n", etiqueta);

  return;
}

/*******************************************************
 * OPERACIONES DE CONTROL DE BUCLES
 ********************************************************/

void while_inicio(FILE *fpasm, int etiqueta)
{

  if (!fpasm)
    return;

  fprintf(fpasm, "\n");
  fprintf(fpasm, "while_%d:\n", etiqueta);
  return;
}

void while_exp_pila(FILE *fpasm, int exp_es_variable, int etiqueta)
{

  if (!fpasm)
    return;

  fprintf(fpasm, "  pop dword eax\n");

  if (exp_es_variable == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }
  fprintf(fpasm, "  cmp eax, 0\n");
  fprintf(fpasm, "  je end_while_%d\n", etiqueta);
  return;
}

void while_fin(FILE *fpasm, int etiqueta)
{

  if (!fpasm)
    return;

  fprintf(fpasm, "  jmp while_%d\n", etiqueta);
  fprintf(fpasm, "\n");
  fprintf(fpasm, "end_while_%d:\n", etiqueta);
  return;
}

/*******************************************************
 * OPERACIONES DE GENERACION DE DATA STRUCTURES
 ********************************************************/
void escribir_elemento_vector(FILE *fpasm, char *nombre_vector,
                              int tam_max, int exp_es_direccion)
{

  if (!fpasm)
    return;

  // Coger indice de la pila
  fprintf(fpasm, "  pop dword eax\n");

  // Si es direccion, obtener tambien el indice de la posicion en memoria
  if (exp_es_direccion == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }

  // Error control
  // Error: Out of range check
  // Index < 0
  fprintf(fpasm, "  cmp eax, 0\n");
  fprintf(fpasm, "  jl near idx_out_of_range\n");
  // Index > allowed max
  fprintf(fpasm, "  cmp eax, %d-1\n", tam_max);
  fprintf(fpasm, "  jg near idx_out_of_range\n");

  // Calcular direccion efectiva
  fprintf(fpasm, "  mov dword edx, _%s\n", nombre_vector);
  // Join con el indice de memoria
  fprintf(fpasm, "  lea eax, [edx + eax*4]\n");
  // Añadir a la pila
  fprintf(fpasm, "  push dword eax\n");
}

/*******************************************************
 * OPERACIONES DE GENERACION DE FUNCIONES
 ********************************************************/

void declararFuncion(FILE *fd_asm, char *nombre_funcion, int num_var_loc)
{
  if (!fd_asm)
    return;

  // Etiqueta asignacion
  fprintf(fd_asm, "\n");
  fprintf(fd_asm, "_%s:\n", nombre_funcion);

  // guardar ebp y esp ebp en cola, esp en ebp
  fprintf(fd_asm, "  push ebp\n");
  fprintf(fd_asm, "  mov ebp, esp\n");

  // Alojar var. locales
  fprintf(fd_asm, "  sub esp, %d\n", 4 * num_var_loc);
  return;
}

void retornarFuncion(FILE *fd_asm, int es_variable)
{
  if (!fd_asm)
    return;

  // Pop retorno de funcion
  fprintf(fd_asm, "  pop eax\n");
  // Si es_variable es una direccion u otra variable guardamos eax en la pila
  if (es_variable == 1)
  {
    fprintf(fd_asm, "  mov dword eax, [eax]\n");
  }

  // Arreglar pila
  fprintf(fd_asm, "  mov esp,ebp\n");
  // Sacar ebp de la pila
  fprintf(fd_asm, "  pop ebp\n");
  // Retorno
  fprintf(fd_asm, "  ret\n");

  return;
}

void escribirParametro(FILE *fpasm, int pos_parametro, int num_total_parametros)
{
  if (!fpasm)
    return;

  int d_ebp;

  // ***** MIRAR ESTO *****//
  // Sabemos que ebp + 4 es la dir, ebp + 8 es el primer arg
  // Movemos 4 + 4 * numero de parametros menos la posicion del parametro

  d_ebp = 4 + 4 * (num_total_parametros - pos_parametro);

  // Introducir param en pila
  fprintf(fpasm, "  lea eax, [ebp + %d]\n", d_ebp);

  fprintf(fpasm, "  push dword eax\n");

  return;
}

void escribirVariableLocal(FILE *fpasm, int posicion_variable_local)
{

  if (!fpasm)
    return;

  int d_ebp;
  d_ebp = 4 * posicion_variable_local;

  fprintf(fpasm, "  lea eax, [ebp - %d]\n", d_ebp);
  fprintf(fpasm, "  push dword eax\n");

  return;
}

void asignarDestinoEnPila(FILE *fpasm, int es_variable)
{

  if (!fpasm)
    return;

  /* Cojo direccion */
  fprintf(fpasm, "  pop dword ebx\n");
  /* Obtengo valor asignable */
  fprintf(fpasm, "  pop dword eax\n");

  if (es_variable == 1)
  {
    fprintf(fpasm, "  mov dword eax, [eax]\n");
  }
  /* Asignacion*/
  fprintf(fpasm, "  mov dword [ebx], eax\n");
}

void operandoEnPilaAArgumento(FILE *fd_asm, int es_variable)
{

  if (!fd_asm)
    return;

  if (es_variable == 1)
  {
    fprintf(fd_asm, "  pop dword eax\n");
    fprintf(fd_asm, "  mov dword eax, [eax]\n");
    fprintf(fd_asm, "  push dword eax\n");
  }

  return;
}

void llamarFuncion(FILE *fd_asm, char *nombre_funcion, int num_argumentos)
{
  if (!fd_asm)
    return;

  fprintf(fd_asm, "  call _%s\n", nombre_funcion);
  limpiarPila(fd_asm, num_argumentos);
  fprintf(fd_asm, "  push dword eax\n");

  return;
}

void limpiarPila(FILE *fd_asm, int num_argumentos)
{
  if (!fd_asm)
    return;

  fprintf(fd_asm, "  add esp, %d\n", num_argumentos * 4);
  return;
}