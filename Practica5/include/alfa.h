#ifndef ALFA_H
#define ALFA_H

#define NAME_LEN 100

#define ERR_DEC_DUPLICADA             1
#define ERR_ACCESO_VAR_NO_DEC         2
#define ERR_OP_ARIT_CON_BOOL          3
#define ERR_OP_LOG_CON_INT            4
#define ERR_COMP_CON_BOOL             5

#define ERR_COND_CON_INT              6
#define ERR_BUCLE_CON_INT             7
#define ERR_NUM_PARAM                 8
#define ERR_ASIGNACION                9
#define ERR_TAM_VECTOR                10

#define ERR_INDEXACION                11
#define ERR_INDICE_INDEXACION         12
#define ERR_FUNCION_SIN_RETORNO       13
#define ERR_RETORNO_FUERA_FUNCION     14
#define ERR_FUNCION_EN_PARAM          15

#define ERR_VAR_LOCAL                 16
#define ERR_AMBITO_ERRONEO            17
#define ERR_AMBITO_NO_ENCONTRADO      18
#define ERR_FUNCION_NO_GLOBAL         19
#define ERR_AMBITO_NO_CERRADO         20

#define ERR_RESERVA_MEMORIA           100
#define ERR_ES_FUNCION                101
#define ERR_NO_ES_FUNCION             102
#define ERR_NO_ESCALAR                103
#define ERR_TIPO_RETORNO              104
#define ERR_INESPERADO                404


typedef struct info_args {
	char name[NAME_LEN];
    int type;
    int label;
    int is_address;
	int value;
}InfoArgs;

#endif