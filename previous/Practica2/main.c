/**
 * Autor: Jaime Pons Garrido
 */
#include <stdio.h>
#include <string.h>
#include "tokens.h"

int yylex();

int main(int argc, char **argv)
{
  FILE *out = NULL;
  extern FILE *yyin;  


  int retorno;
  extern int yyleng;        
  extern long yylin, yycol; 
  
  extern char *yytext;      

  if (argc < 3)
  {
    fprintf(stderr, "****Error en los parámetros, utilizar ./nombre <entrada.txt> <salida.txt>\n");
    return 1;
  }
  yyin = fopen(argv[1], "r");
  if (yyin == NULL)
  {
    return 1;
  }
  out = fopen(argv[2], "w");
  if (out == NULL)
  {
    fclose(yyin);
    return 1;
  }
  while ((retorno = yylex()) != 0)
  {

    switch (retorno)
    {
    /**
    * Etiquetado del control de tipo
    */
    case TOK_MAIN:
      fprintf(out, "%s\t%d\t%s\n", "TOK_MAIN", retorno, yytext);
      break;
    case TOK_INT:
      fprintf(out, "%s\t%d\t%s\n", "TOK_INT", retorno, yytext);
      break;
    case TOK_BOOLEAN:
      fprintf(out, "%s\t%d\t%s\n", "TOK_BOOLEAN", retorno, yytext);
      break;
    case TOK_ARRAY:
      fprintf(out, "%s\t%d\t%s\n", "TOK_ARRAY", retorno, yytext);
      break;
    case TOK_FUNCTION:
      fprintf(out, "%s\t%d\t%s\n", "TOK_FUNCTION", retorno, yytext);
      break;

    /**
    * Etiquetado del control de flujo 
    */
    case TOK_IF:
      fprintf(out, "%s\t%d\t%s\n", "TOK_IF", retorno, yytext);
      break;
    case TOK_ELSE:
      fprintf(out, "%s\t%d\t%s\n", "TOK_ELSE", retorno, yytext);
      break;
    case TOK_WHILE:
      fprintf(out, "%s\t%d\t%s\n", "TOK_WHILE", retorno, yytext);
      break;
    case TOK_SCANF:
      fprintf(out, "%s\t%d\t%s\n", "TOK_SCANF", retorno, yytext);
      break;
    case TOK_PRINTF:
      fprintf(out, "%s\t%d\t%s\n", "TOK_PRINTF", retorno, yytext);
      break;
    case TOK_RETURN:
      fprintf(out, "%s\t%d\t%s\n", "TOK_RETURN", retorno, yytext);
      break;

    /**
    * Etiquetado de simbolos de prioridad y separacion
    */
    case TOK_PUNTOYCOMA:
      fprintf(out, "%s\t%d\t%s\n", "TOK_PUNTOYCOMA", retorno, yytext);
      break;
    case TOK_COMA:
      fprintf(out, "%s\t%d\t%s\n", "TOK_COMA", retorno, yytext);
      break;
    case TOK_PARENTESISIZQUIERDO:
      fprintf(out, "%s\t%d\t%s\n", "TOK_PARENTESISIZQUIERDO", retorno, yytext);
      break;
    case TOK_PARENTESISDERECHO:
      fprintf(out, "%s\t%d\t%s\n", "TOK_PARENTESISDERECHO", retorno, yytext);
      break;
    case TOK_CORCHETEIZQUIERDO:
      fprintf(out, "%s\t%d\t%s\n", "TOK_CORCHETEIZQUIERDO", retorno, yytext);
      break;
    case TOK_CORCHETEDERECHO:
      fprintf(out, "%s\t%d\t%s\n", "TOK_CORCHETEDERECHO", retorno, yytext);
      break;
    case TOK_LLAVEIZQUIERDA:
      fprintf(out, "%s\t%d\t%s\n", "TOK_LLAVEIZQUIERDA", retorno, yytext);
      break;
    case TOK_LLAVEDERECHA:
      fprintf(out, "%s\t%d\t%s\n", "TOK_LLAVEDERECHA", retorno, yytext);
      break;

    /**
    * Etiquetado de operaciones
    */
    case TOK_ASIGNACION:
      fprintf(out, "%s\t%d\t%s\n", "TOK_ASIGNACION", retorno, yytext);
      break;
    case TOK_MAS:
      fprintf(out, "%s\t%d\t%s\n", "TOK_MAS", retorno, yytext);
      break;
    case TOK_MENOS:
      fprintf(out, "%s\t%d\t%s\n", "TOK_MENOS", retorno, yytext);
      break;
    case TOK_DIVISION:
      fprintf(out, "%s\t%d\t%s\n", "TOK_DIVISION", retorno, yytext);
      break;
    case TOK_ASTERISCO:
      fprintf(out, "%s\t%d\t%s\n", "TOK_ASTERISCO", retorno, yytext);
      break;
    case TOK_AND:
      fprintf(out, "%s\t%d\t%s\n", "TOK_AND", retorno, yytext);
      break;
    case TOK_OR:
      fprintf(out, "%s\t%d\t%s\n", "TOK_OR", retorno, yytext);
      break;
    case TOK_NOT:
      fprintf(out, "%s\t%d\t%s\n", "TOK_NOT", retorno, yytext);
      break;
    case TOK_IGUAL:
      fprintf(out, "%s\t%d\t%s\n", "TOK_IGUAL", retorno, yytext);
      break;
    case TOK_DISTINTO:
      fprintf(out, "%s\t%d\t%s\n", "TOK_DISTINTO", retorno, yytext);
      break;
    case TOK_MENORIGUAL:
      fprintf(out, "%s\t%d\t%s\n", "TOK_MENORIGUAL", retorno, yytext);
      break;
    case TOK_MAYORIGUAL:
      fprintf(out, "%s\t%d\t%s\n", "TOK_MAYORIGUAL", retorno, yytext);
      break;
    case TOK_MENOR:
      fprintf(out, "%s\t%d\t%s\n", "TOK_MENOR", retorno, yytext);
      break;
    case TOK_MAYOR:
      fprintf(out, "%s\t%d\t%s\n", "TOK_MAYOR", retorno, yytext);
      break;

    /**
    * Etiquetado de ident + ctes
    */
    case TOK_IDENTIFICADOR:
      fprintf(out, "%s\t%d\t%s\n", "TOK_IDENTIFICADOR", retorno, yytext);
      break;
    case TOK_CONSTANTE_ENTERA:
      fprintf(out, "%s\t%d\t%s\n", "TOK_CONSTANTE_ENTERA", retorno, yytext);
      break;

    // BOOLEANS
    case TOK_TRUE:
      fprintf(out, "%s\t%d\t%s\n", "TOK_TRUE", retorno, yytext);
      break;
    case TOK_FALSE:
      fprintf(out, "%s\t%d\t%s\n", "TOK_FALSE", retorno, yytext);
      break;

    /**
    * Etiquetado para casos de error
    */
    case TOK_ERROR:
      if (yyleng == 1)
      {
        fprintf(stderr, "****Error l %ld, c %ld: simbolo no permitido (%s)\n", yylin, yycol,
                yytext);
      }
      else
      {
        fprintf(stderr, "****Error l %ld, c %ld: identificador excede limite de longitud (%s)\n", yylin,
                yycol, yytext);
      }
      fclose(yyin);
      fclose(out);
      return 1;
    }
  }
  fclose(yyin);
  fclose(out);
  return 0;
}
