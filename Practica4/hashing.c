/**
 * Autor: Jaime Pons Garrido
 *
 * Implementacion del fichero de hashing,
 * contiene la logica referente a las operaciones
 * de insercion, extraccion y busqueda
 * de una tabla hash
 *
 * The hash function used to create this logic is Fowler–Noll–Vo's
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include "hashing.h"

#define HASH_OFFSET 14695981039346656037UL
#define HASH_PRIME 1099511628211UL

static uint64_t hash(const char *key)
{
  uint64_t hash_object = HASH_OFFSET;
  for (const char *i = key; *i; i++)
  {
    hash_object ^= (uint64_t)(unsigned char)(i);
    hash_object *= HASH_PRIME;
  }
  return hash_object;
}
/**
 * Creates a table object
 * @param int lenght of table
 * @return Table object
 */
Table *create_table(int length)
{
  if (length == 0)
    return NULL;

  Table *table = NULL;
  Entry **entries = NULL;

  table = (Table *)calloc(1, sizeof(Table));
  if (!table)
  {
    return NULL;
  }

  entries = (Entry **)calloc(length, sizeof(Entry *));
  if (!entries)
  {
    free(table);
    return NULL;
  }
  // is this truly necessary?, I miss Java
  for (int i = 0; i < length; i++)
  {
    entries[i] = NULL;
  }

  table->entries = entries;
  table->length = length;
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

  for (int i = 0; i < table->length; i++)
  {
    if (table->entries[i])
    {
      free(table->entries[i]);
    }
  }

  free(table->entries);
  free(table);
  return;
}

/**
 * Inserts an entry in a table
 * @param table table object
 * @param info Table entry information
 * @return Table object
 */
int insert_entry(Table *table, Info info, char *key)
{
  if (!table || !key)
    return 1;

  int position = hash(key) % table->length;
  int initialPosition = position;
  while (table->entries[position] != NULL)
  {
    if (strcmp(table->entries[position]->entry_id, key) == 0)
    {
      return 1;
    }

    position++;
    initialPosition = position % table->length;

    if (position == initialPosition)
      return 1;
  }
  Entry *entry = NULL;
  entry = (Entry *)calloc(1, sizeof(Entry));
  if (!entry)
    return 1;

  entry->info = info;
  memset(entry->entry_id, 0, KEY_LEN);
  strncpy(entry->entry_id, key, KEY_LEN - 1);
  table->entries[position] = entry;
  return 0;
}
/**
 * Deletes an entry in a table
 * @param table table object
 * @param key Entry key to be searched
 * @return true if succeeded false if not
 */
int delete_entry(Table *table, char *key)
{

  if (!table || !key)
    return 1;

  int position = hash(key) % table->length;
  int initialPosition = position;
  while (table->entries[position] != NULL)
  {
    if (strcmp(table->entries[position]->entry_id, key) == 0)
    {
      free(table->entries[position]);
      table->entries[position] = NULL;
      return 1;
    }

    position++;
    initialPosition = position % table->length;

    if (position == initialPosition)
      break;
  }
  return 0;
}
/**
 * Searches an entry's information in a table
 * @param table table object
 * @param key Entry key to be searched
 * @return Info object linked to entry
 */
Info *search_entry(Table *table, char *key)
{
  if (!table || !key)
    return NULL;

  int position = hash(key) % table->length;
  int initialPosition = position;
  while (table->entries[position] != NULL)
  {
    if (strcmp(table->entries[position]->entry_id, key) == 0)
    {
      return &table->entries[position]->info;
    }

    position++;
    initialPosition = position % table->length;

    if (position == initialPosition)
      break;
  }
  return NULL;
}
