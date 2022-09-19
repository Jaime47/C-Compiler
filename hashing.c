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
        hash_object ^= (uint64_t)(unsigned char)(*p);
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

    table = (Table *)calloc(sizeof(Table));
    if (!table)
    {
        return NULL;
    }

    entries = (Entry **)calloc(sizeof(Entry *) * length);
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
    table->current_index = 0;
    return table;
}
/**
 * Destroy a table object
 * @param Table object
 */
void destroy_table(Table &table)
{
    if (!table)
        return;

    for (int i = 0; i < table->length; i++)
    {
        if (table->items[i])
        {
            free(table->items[i]);
        }
    }

    free(table->items);
    free(table);
    return;
}

/**
 * Inserts an entry in a table
 * @param table table object
 * @param info Table entry information
 * @return Table object
 */
bool insert_entry(Table &table, Info info, char *key)
{
    if (!table || !key)
        return false;

    int position = hash(hey) % table->length;
    int initialPosition = position;
    while (table->entries[position] != NULL)
    {
        if (strcmp(table->entries[position]->key, key) == 0)
        {
            return false;
        }

        position++;
        initialPosition = position % table->length;

        if (position == initialPosition)
            return false;
    }
    Entry *entry = NULL;
    entry = (Entry *)calloc(sizeof(Entry));
    if (!entry)
        return false;

    entry->info = info;
    memset(entry->key, 0, KEY_LEN);
    strncpy(entry->key, key, KEY_LEN - 1);
    table->entries[hashIndex] = new_item;
    return true;
}
/**
 * Deletes an entry in a table
 * @param table table object
 * @param key Entry key to be searched
 * @return true if succeeded false if not
 */
bool delete_entry(Table &table, char *key)
{

    if (!table || !key)
        return false;

    int position = hash(hey) % table->length;
    int initialPosition = position;
    while (table->entries[position] != NULL)
    {
        if (strcmp(table->entries[position]->key, key) == 0)
        {
            free(table->entries[position]);
            table->entries[position] = NULL;
            return true;
        }

        position++;
        initialPosition = position % table->length;

        if (position == initialPosition)
            break;
    }
    return false;
}
/**
 * Searches an entry's information in a table
 * @param table table object
 * @param key Entry key to be searched
 * @return Info object linked to entry
 */
Info *search_entry(Table &table, char *key)
{
    if (!table || !key)
        return NULL;

    int position = hash(hey) % table->length;
    int initialPosition = position;
    while (table->entries[position] != NULL)
    {
        if (strcmp(table->entries[position]->key, key) == 0)
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
