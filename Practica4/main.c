#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "hashing.h"

#define MAX_BUFFER 512

int main(int argc, char *argv[])
{
  FILE *in;
  FILE *out;

  char buffer[MAX_BUFFER];
  char *identificador;
  char *entero_str;
  int integer;
  Entry *entry;
  Table *tabla = NULL;

  if (argc != 3)
  {
    fprintf(stdout, "Error: Incorrect Args\n");
    return 1;
  }

  in = fopen(argv[1], "r");
  if (in == NULL)
  {
    fprintf(stderr, "Error: Could not open in file\n");
    return 1;
  }

  out = fopen(argv[2], "w");
  if (out == NULL)
  {
    fprintf(stderr, "Error: Could not open out file\n");
  }

  tabla = create_table();

  if (!tabla)
  {
    return -1;
  }

  while (fgets(buffer, MAX_BUFFER, in))
  {
    identificador = strtok(buffer, " ");

    entero_str = strtok(NULL, "\n");

    printf("%s \n",identificador);

    if (entero_str == NULL)
    {
      identificador[strcspn(identificador, "\n")] = '\0';
      entry = search_entry(tabla, identificador);
      if (!entry)
      {
        printf("1.1%s %d\n", identificador, -1);
        fprintf(out, "%s %d\n", identificador, -1);
      }
      else
      {
        printf("1.2%s %d\n", identificador, entry->integer);
        fprintf(out, "%s %d\n", identificador, entry->integer);
      }
    }

    else
    {
      integer = atoi(entero_str);
      if (integer < 0)
      {
        if (strcmp(identificador, "cierre") == 0 && integer == -999)
        {
          if (shut_down_local_env(tabla) == 0)
          {
            printf("1.3cierre\n");
            fprintf(out, "cierre\n");
          }
        }

        else
        {
          if (open_local_env(tabla, identificador, integer) == 0)
          {
            printf("1.4%s\n", identificador);
            fprintf(out, "%s\n", identificador);
          }
        }
      }

      else
      {
        if (insert_entry(tabla, integer, identificador) == 1)
        {
          printf("1.5-1 %s\n", identificador);
          fprintf(out, "-1 %s\n", identificador);
        }

        else
        {
          printf("1.6%s\n", identificador);
          fprintf(out, "%s\n", identificador);
        }
      }
    }
  }
  destroy_table(tabla);

  fclose(in);
  fclose(out);

  return 0;
}