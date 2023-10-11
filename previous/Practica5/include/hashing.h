#ifndef HASHING_H
#define HASHING_H
#include "uthash.h"

#define MAX_ID_LEN 100
#define MAX_VECTOR_LEN 64
#define MAX_INT_SIZE 64

typedef enum
{
  GLOBAL = 0,
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

typedef struct ArgsInfo
{
  int cardinal;
  int position;
} ArgsInfo;

typedef struct Entry
{
  char *key;
  int size;
  ElementCathegory cathegory;
  DataType type;
  DataComplexity complexity;
  ArgsInfo global;
  ArgsInfo local;
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

int open_local_env(Table *table, char *key, int size, ElementCathegory cathegory,
                   DataType type, DataComplexity complexity, ArgsInfo global, ArgsInfo local);

int shut_down_local_env(Table *table);

Entry *create_entry(char *key, int size, ElementCathegory cathegory,
                    DataType type, DataComplexity complexity, ArgsInfo global, ArgsInfo local);

int insert_entry(Table *table, Entry *entry);

Entry *search_entry(Table *table, char *key);
#endif