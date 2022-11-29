#ifndef ALFA_H
#define ALFA_H

#define NAME_LEN 100


typedef struct info_atr {
	char name[NAME_LEN];
    int type;
    int label;
    int is_address;
	int value;
}InfoAtr;

#endif