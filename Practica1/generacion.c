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
    if (fpasn)
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
        fprintf(fpasm, "  _msg_error_div_zero db \"Error: Division entre cero\", 0\n");
        fprintf(fpasm, "  _msg_error_index_out_of_range db \"Error: Indice fuera de rango\", 0\n");
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
    else
    {
        print("[DEBUG] Error: leer: int tipo no es ni 0 ni 1");
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
    else
    {
        print("[DEBUG] Error: escribir: int tipo no es ni 0 ni 1");
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
 * OPERACIONES DE GENERACION DE FUNCIONES
 ********************************************************/


/*******************************************************
 * OPERACIONES DE GENERACION DE DATA STRUCTURES
 ********************************************************/
void escribir_elemento_vector(FILE * fpasm,char * nombre_vector,
  int tam_max, int exp_es_direccion) {

    if (!fpasm)
        return;

  // Coger indice de la pila
  fprintf(fpasm, "  pop dword eax\n");

  // Si es direccion, obtener tambien el indice de la posicion en memoria
  if (exp_es_direccion == 1) {
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
