/**
 * Autor: Jaime Pons Garrido
 *
 * Fichero main para ejecutar test program del fichero de hashing
 * Funcion hash utilizada Fowler–Noll–Vo's
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include "hashing.h"

#define OP_INSERT 1
#define OP_AMBIT 2
#define OP_GET 3
#define OP_END 4

#define TABLE_SIZE 256

void print_output(FILE *out, int result, char *key, int value, int op_type);
int parse_line_to_hash(char *line, char **indent, int *value);

int main(int argc, char **argv)
{

    FILE *in = NULL, *out = NULL;

    size_t length = 0;

    int op_type = 0, value = 0, result = 0;
    char *key = NULL, *line = NULL;

    Info info;
    Info *search_result;

    Table *global_table = NULL, *local_table = NULL, *insert_table = NULL;

    if (argc < 3)
    {
        fprintf(stderr, "Check: ./nombre <entrada.txt> <salida.txt>\n");
        return 1;
    }
    in = fopen(argv[1], "r");
    if (!in)
    {
        return 1;
    }
    out = fopen(argv[2], "w");
    if (!out)
    {
        fclose(in);
        return 1;
    }

    global_table = create_table(TABLE_SIZE);
    if (!global_table)
    {
        printf("Error: No se pudo crear tabla global\n");
        return 1;
    }

    while (getline(&line, &length, in) != -1)
    {
        key = 0;
        value = 0;
        op_type = parse_line_to_hash(line, &key, &value);
        if (op_type < 0)
        {
            free(line);
            line = NULL;
            continue;
        }

        if (op_type == OP_INSERT)
        {
            info = create_standard_info(value);

            insert_table = global_table;
            if (local_table != NULL)
            {
                insert_table = local_table;
            }
            result = hash_table_insert(insert_table, key, info);
            print_output(out, result, key, value, OP_INSERT);
        }

        else if (op_type == OP_AMBIT)
        {
            if (local_table)
            {
                free(line);
                line = NULL;
                continue;
            }

            info = create_standard_info(value);

            result = hash_table_insert(global_table, key, info);
            print_output(out, result, key, value, OP_AMBIT);
            if (result != 0)
            {
                free(line);
                line = NULL;
                continue;
            }

            local_table = hash_table_create(TABLE_SIZE);
            result = hash_table_insert(local_table, key, info);
        }

        else if (op_type == OP_GET)
        {
            if (local_table)
            {
                search_result = hash_table_search(local_table, key);
                if (search_result != NULL)
                {
                    free(line);
                    line = NULL;
                    continue;
                }
            }

            search_result = search_entry(global_table, line);
            if (search_result != NULL)
            {
                fprintf(out, "%s\t%d\n", key, search_result->arg_type);
            }
            else
            {
                fprintf(out, "%s\t-1\n", key);
            }
        }

        else if (op_type == OP_END)
        {
            destroy_table(local_table);
            local_table = NULL;
            fprintf(out, "cierre\n");
        }
        free(line);
        line = NULL;
    }

    destroy_table(local_table);
    destroy_table(global_table);
    fclose(out);
    fclose(in);
    free(line);
    return 0;
}

void print_output(FILE *out, int result, char *key, int value, int op_type)
{
    if (op_type == OP_INSERT || op_type == OP_AMBIT)
    {
        switch (result)
        {
        case 0:
            fprintf(out, "%s\n", key);
        case 1:
            fprintf(out, "-1\t%s\n", key);
        case 2:
            fprintf(out, "No hay espacio en la tabla para key: %s con valor: %d\n", key, value);
        }
    }
}

/* CREATE STANDARD INFO*/
Info create_standard_info(int value) {
    Info result = {value, 0, 0, 0, 0, 0};
    return result;
}

int parse_line_to_hash(char *line, char **indent, int *value)
{
    if (!line || !indent || !value)
        return -1;
    char tok[3] = " \t";
    char *ptr = NULL;
    char *words[2] = {NULL, NULL};

    line[strcspn(line, "\r\n")] = 0;

    ptr = strtok(line, tok);
    if (ptr == NULL)
    {
        return -1;
    }
    words[0] = ptr;
    ptr = strtok(NULL, tok);
    if (!ptr)
    {
        *indent = words[0];
        return OP_GET;
    }
    words[1] = ptr;
    ptr = strtok(NULL, tok);
    if (!ptr)
    {
        if (strcmp(words[0], "cierre") == 0 && strcmp(words[1], "-999") == 0)
        {
            return OP_END;
        }
        *indent = words[0];
        *value = atoi(words[1]);
        if (*value >= 0)
        {
            return OP_INSERT;
        }
        return OP_AMBIT;
    }
    return -1;
}
