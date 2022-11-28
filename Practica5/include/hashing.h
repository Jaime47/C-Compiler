#ifndef HASHING_H
#define HASHING_H
#include "uthash.h"

#define MAX_ID_LEN 100
#define MAX_VECTOR_LEN 64
#define MAX_INT_SIZE 64

typedef enum
{
  GLOBAL = 1,
  LOCAL
} EnvType;

typedef enum
{
  ESCALAR = 1,
  VECTOR
} DataComplexity;

typedef enum
{
  INT = 0,
  BOOLEAN
} DataType;

typedef enum
{
  VARIABLE = 1,
  PARAMETRO,
  FUNCION
} ElementCathegory;

typedef struct Entry
{
  char *key;
  int size;
  ElementCathegory cathegory;
  DataType data;
  DataComplexity complexity;
  int local_args_cardinal;
  int global_args_cardinal;
  int local_args_position;
  int global_args_position;
  UT_hash_handle hh;
} Entry;

typedef struct Table
{
  Entry **global;
  Entry **local;
  EnvType env;
} Table;

Table *create_table();

void destroy_table(Table *table);

int open_local_env(Table *table, char *key, ElementCathegory cathegory,
                   DataType data, DataComplexity complexity, int size, int local_args_cardinal,
                   int global_args_cardinal, int local_args_position, int global_args_position);

int shut_down_local_env(Table *table);

Entry *create_entry(char *key, int number);

int insert_entry(Table *table, char *key, ElementCathegory cathegory,
                 DataType data, DataComplexity complexity, int size, int local_args_cardinal,
                 int global_args_cardinal, int local_args_position, int global_args_position);

Entry *search_entry(Table *table, char *key);
#endif