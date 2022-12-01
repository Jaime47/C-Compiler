
/**
 * Autor: Jaime Pons Garrido
 */

#include <stdio.h>
#include "hashing.h"
#include "alfa.h"
#include "generacion.h"

int yylex();
int yyparse();

int main(int argc, char **argv)
{
  extern FILE *yyin;
  extern FILE *yyout;

  if (argc != 3)
  {
    printf("Error: Numero incorrecto de params de entrada\n");
    return 1;
  }

  yyin = fopen(argv[1], "r");
  yyout = fopen(argv[2], "w");
  if (!yyin)
  {
    printf("Error: Fichero entrada\n");
    return 1;
  }

  if (!yyout)
  {
    printf("Error: Fichero salida\n");
    return 1;
  }
  yyparse();

  fclose(yyin);
  fclose(yyout);

  return 0;
}