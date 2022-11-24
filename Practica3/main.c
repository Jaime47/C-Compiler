#include <stdio.h>
#include <string.h>

FILE *out = NULL;

int yylex();
int yyparse();

int main(int argc, char **argv)
{

  extern FILE *yyin;

  if (argc < 3)
  {
    printf("Error: Entrada de parámetros incorrecta\n");
    return 1;
  }

  yyin = fopen(argv[1], "r");
  if (!yyin)
  {
    printf("Error fichero entrada\n");
    return 1;
  }
  out = fopen(argv[2], "w");
  if (!out)
  {

    fclose(yyin);
    printf("Error fichero salida\n");
    return 1;
  }

  yyparse();

  fclose(yyin);
  fclose(out);
  return 0;
}
