#ifndef ALFA_H
#define ALFA_H

#define NAME_LEN 100


struct _info_atr{
	char name[NAME_LEN];
    int type;
    int label;
    int is_address;
	int integer_value;
};

typedef struct _info_atr info_atr;

#endif