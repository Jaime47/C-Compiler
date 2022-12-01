/**
 * Autor: Jaime Pons Garrido
 *
 * Implementacion del fichero de hashing,
 * contiene la logica referente a las operaciones
 * de insercion, extraccion y busqueda
 * de una tabla hash
 */

#include <stdio.h>
#include <stdlib.h>

#include "hashing.h"

/**
 * Creates a table object
 * @return Table object
 */
Table *create_table()
{
  Table *table = NULL;

  table = (Table *)calloc(1, sizeof(Table));
  if (!table)
  {
    return NULL;
  }

  table->local = (Entry **)calloc(1, sizeof(Entry *));

  *(table->local) = NULL;

  table->global = (Entry **)calloc(1, sizeof(Entry *));

  *(table->global) = NULL;

  table->env = GLOBAL;

  return table;
}
/**
 * Destroy a table object
 * @param Table object
 */
void destroy_table(Table *table)
{
  if (!table)
    return;

  Entry *entry, *temp;

  HASH_ITER(hh, *(table->global), entry, temp)
  {
    HASH_DEL(*(table->global), entry);
    free(entry->key);
    free(entry);
  }

  free(table->global);
  free(table->local);

  free(table);
  return;
}

int open_local_env(Table *table, char *key, int size, ElementCathegory cathegory,
                   DataType type, DataComplexity complexity, ArgsInfo global, ArgsInfo local)
{

  Entry *entry1 = NULL;
  Entry *entry2 = NULL;

  if (table->env == LOCAL)
  {
    return 1;
  }
  // PREGUNTA POR QUE ESTOY CREANDO DOS ELEMENTOS, Y NO METO EL MISMO EN LAS DOS TABLAS
  entry1 = create_entry(key, size, cathegory, type, complexity, global, local);
  entry2 = create_entry(key, size, cathegory, type, complexity, global, local);

  if (!entry1 || !entry2)
  {
    return 1;
  }

  HASH_ADD_STR(*(table->global), key, entry1);

  HASH_ADD_STR(*(table->local), key, entry2);

  table->env = LOCAL;

  return 0;
}

int shut_down_local_env(Table *table)
{

  Entry *entry, *temp;

  if (table->env == GLOBAL)
  {
    return 1;
  }

  HASH_ITER(hh, *(table->local), entry, temp)
  {
    HASH_DEL(*(table->local), entry);
    // Borramos mas cosas?
    free(entry);
  }

  table->env = GLOBAL;
  return 0;
}

Entry *create_entry(char *key, int size, ElementCathegory cathegory,
                    DataType type, DataComplexity complexity, ArgsInfo global, ArgsInfo local)
{

  Entry *entry = NULL;

  entry = (Entry *)calloc(1, sizeof(Entry));

  if (!entry)
  {
    return NULL;
  }

  entry->key = (char*) calloc(1, sizeof(char) * (strlen(key) + 1));

  strcpy(entry->key, key);
  entry->size = size;
  entry->cathegory = cathegory;
  entry->type = type;
  entry->complexity = complexity;
  // Cuidado con esto, cuanto tiempo permanece en memoria?
  entry->global = global;
  entry->local = local;

  return entry;
}

/**
 * Inserts an entry in a table
 * @param table table object
 * @param entry entry object
 * @return Table object
 */
int insert_entry(Table *table, Entry *entry)
{

  // if (search_entry(table, entry->key) != NULL)
  //{
  //   return 1;
  // }
  Entry* test = NULL;
  if (table->env == GLOBAL)
  {
    HASH_FIND_STR(*(table->global), entry->key, test);
  }

  else
  {
    HASH_FIND_STR(*(table->local), entry->key, test);
  }

  if (test != NULL)
  {
    return 1;
  }

  if (table->env == GLOBAL)
  {
    HASH_ADD_STR(*(table->global), key, entry);
  }
  else
  {
    HASH_ADD_STR(*(table->local), key, entry);
  }

  return 0;
}
/**
 * Searches an entry's information in a table
 * @param table table object
 * @param key Entry key to be searched
 * @return Entry object linked to entry
 */
Entry *search_entry(Table *table, char *key)
{
  Entry *entry = NULL;

  if (table->env == GLOBAL)
  {

    HASH_FIND_STR(*(table->global), key, entry);
  }
  else
  {

    HASH_FIND_STR(*(table->local), key, entry);
    if (!entry)
    {

      HASH_FIND_STR(*(table->global), key, entry);
    }
  }

  return entry;
}
