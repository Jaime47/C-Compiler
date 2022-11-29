
/**
 * Autor: Jaime Pons Garrido
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hashing.h"

extern FILE *in;
extern FILE *out;

extern int yylex();
extern int yyparse();

int main(int argc, char **argv)
{

  if (argc != 3)
  {
    printf("Error: Numero incorrecto de params de entrada\n");
    return 1;
  }

  in = fopen(argv[1], "r");
  if (!in)
  {
    printf("Error: Fichero entrada\n");
    return 1;
  }
  out = fopen(argv[2], "w");
  if (!out)
  {
    printf("Error: Fichero salida\n");
    return 1;
  }

  yyparse();
  fclose(in);
  fclose(out);

  return 0;
}