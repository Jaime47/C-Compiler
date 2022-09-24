#ifndef HASHING_H
#define HASHING_H

#define KEY_LEN 100

enum ArgType
{
  VARIABLE = 1,
  PARAMETRO,
  FUNCION
};
enum DataType
{
  BOOLEAN = 1,
  INT
};
enum CardinalityType
{
  ESCALAR = 1,
  VECTOR
};

typedef struct _Info
{
  ArgType arg_type;
  DataType data_type;
  CardinalityType cardinality_type;
  int position;
  int args_number;
  /*Vector only*/
  int size;
} Info;

typedef struct _Entry
{
  Info info;
  char entry_id[ID_LEN];
} Entry;

typedef struct _Table
{
  Entry **entries;
  int length;
} Table;

Table *create_table(int length);
void destroy_table(Table &table);
bool insert_entry(Table &table, Info info, char * key);
bool delete_entry(Table &table, char *key);
Info *search_entry(Table &table, char *key);
#endif