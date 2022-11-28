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
  if (!table->local)
  {
    free(table);
    return NULL;
  }
  *(table->local) = NULL;

  table->global = (Entry **)calloc(1, sizeof(Entry *));
  if (!table->global)
  {
    free(table->local);
    free(table);
    return NULL;
  }
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
    free(entry);
  }

  free(table->global);
  free(table->local);

  free(table);
  return;
}

int open_local_env(Table *table, char *key, int number)
{

  Entry *entry1 = NULL;
  Entry *entry2 = NULL;

  if (table->env == LOCAL)
  {
    return 1;
  }

  entry1 = create_entry(key, number);
  entry2 = create_entry(key, number);

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
    free(entry);
  }

  table->env = GLOBAL;
  return 0;
}

Entry *create_entry(char *key, int number)
{

  Entry *entry = NULL;

  entry = (Entry *)calloc(1, sizeof(Entry));

  if (!entry)
  {
    return NULL;
  }

  entry->key = key;
  entry->integer = number;

  return entry;
}

/**
 * Inserts an entry in a table
 * @param table table object
 * @param key key of entry
 * @param number integer of entry
 * @return Table object
 */
int insert_entry(Table *table, int number, char *key)
{
  // if (!table || !key)
  // return 1;
  Entry *entry = NULL;

  if (table->env == GLOBAL)
  {
    HASH_FIND_STR(*(table->global), key, entry);
  }

  else
  {
    HASH_FIND_STR(*(table->local), key, entry);
  }

  if (entry != NULL)
  {
    return 1;
  }

  entry = create_entry(key, number);

  if (!entry)
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
  if (!table || !key)
    return NULL;

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
  if (!entry)
  {
    return NULL;
  }

  return entry;
}
