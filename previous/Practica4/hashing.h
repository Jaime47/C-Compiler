#ifndef HASHING_H
#define HASHING_H
#include "uthash.h"

typedef enum 
{
  GLOBAL = 1,
  LOCAL
}EnvType;

typedef struct Entry
{
  char *key;
  int integer;
  UT_hash_handle hh;
}Entry;

typedef struct Table
{
  Entry **global;
  Entry **local;
  EnvType env;
}Table;



Table *create_table();
void destroy_table(Table *table);
int open_local_env(Table *table, char *key, int number);
Entry* create_entry(char* key, int number);
int shut_down_local_env(Table * table);
int insert_entry(Table *table, int number, char * key);
Entry *search_entry(Table *table, char *key);
#endif