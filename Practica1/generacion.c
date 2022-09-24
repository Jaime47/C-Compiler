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