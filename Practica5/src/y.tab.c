/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "./res/alfa.y"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hashing.h"
#include "generacion.h"
#include "alfa.h"


int yylex();
void yyerror();
// Incializacion de variables alfa

/**
 *Nota inicial:
 * 
 *Por motivos de estructura las macros #define utilizadas en el fichero provienen en su mayoria
 * de las enumeraciones del fichero hashing.h 
 */

extern long yylin;
extern long yycol;

extern char * yytext;

extern int error_id_out_of_range;
extern int error_not_allowed_symbol;

extern FILE * yyout;

int f_return = 0;                        /*RETORNO DE LA FUNCION*/
int f_type = 0;                          /*TIPO DE LA FUNCION*/
int f_num_args = 0;                      /*NUMERO DE ARGUMENTOS DE LA FUNCION*/

int label = 0;
int llamada_funcion = 0;                /* Indica si efectivamente hay una funcion siendo llamada*/

int cardinal_args_funcion = 0;

// Inicializacion de variables hash

int current_size = 0;                   /*TAMANIO VECTOR MAX 64*/
ElementCathegory current_cathegory;
DataType current_data_type;
DataComplexity current_data_complexity; /*CLASE ACTUAL: ESCALAR O VECTOR*/
ArgsInfo current_params_info;             /*Numero de parametros actual y posicion*/
ArgsInfo current_local_vars_info;       /*Numero local de variables actual y posicion*/
Table * table;


#line 121 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOK_MAIN = 258,
    TOK_INT = 259,
    TOK_BOOLEAN = 260,
    TOK_ARRAY = 261,
    TOK_FUNCTION = 262,
    TOK_IF = 263,
    TOK_ELSE = 264,
    TOK_WHILE = 265,
    TOK_SCANF = 266,
    TOK_PRINTF = 267,
    TOK_RETURN = 268,
    TOK_PUNTOYCOMA = 269,
    TOK_COMA = 270,
    TOK_PARENTESISIZQUIERDO = 271,
    TOK_PARENTESISDERECHO = 272,
    TOK_CORCHETEIZQUIERDO = 273,
    TOK_CORCHETEDERECHO = 274,
    TOK_LLAVEIZQUIERDA = 275,
    TOK_LLAVEDERECHA = 276,
    TOK_ASIGNACION = 277,
    TOK_MAS = 278,
    TOK_MENOS = 279,
    TOK_DIVISION = 280,
    TOK_ASTERISCO = 281,
    TOK_AND = 282,
    TOK_OR = 283,
    TOK_NOT = 284,
    TOK_IGUAL = 285,
    TOK_DISTINTO = 286,
    TOK_MENORIGUAL = 287,
    TOK_MAYORIGUAL = 288,
    TOK_MENOR = 289,
    TOK_MAYOR = 290,
    TOK_IDENTIFICADOR = 291,
    TOK_CONSTANTE_ENTERA = 292,
    TOK_TRUE = 293,
    TOK_FALSE = 294,
    TOK_ERROR = 295
  };
#endif
/* Tokens.  */
#define TOK_MAIN 258
#define TOK_INT 259
#define TOK_BOOLEAN 260
#define TOK_ARRAY 261
#define TOK_FUNCTION 262
#define TOK_IF 263
#define TOK_ELSE 264
#define TOK_WHILE 265
#define TOK_SCANF 266
#define TOK_PRINTF 267
#define TOK_RETURN 268
#define TOK_PUNTOYCOMA 269
#define TOK_COMA 270
#define TOK_PARENTESISIZQUIERDO 271
#define TOK_PARENTESISDERECHO 272
#define TOK_CORCHETEIZQUIERDO 273
#define TOK_CORCHETEDERECHO 274
#define TOK_LLAVEIZQUIERDA 275
#define TOK_LLAVEDERECHA 276
#define TOK_ASIGNACION 277
#define TOK_MAS 278
#define TOK_MENOS 279
#define TOK_DIVISION 280
#define TOK_ASTERISCO 281
#define TOK_AND 282
#define TOK_OR 283
#define TOK_NOT 284
#define TOK_IGUAL 285
#define TOK_DISTINTO 286
#define TOK_MENORIGUAL 287
#define TOK_MAYORIGUAL 288
#define TOK_MENOR 289
#define TOK_MAYOR 290
#define TOK_IDENTIFICADOR 291
#define TOK_CONSTANTE_ENTERA 292
#define TOK_TRUE 293
#define TOK_FALSE 294
#define TOK_ERROR 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 52 "./res/alfa.y"

    info_atr atributos;

#line 257 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   149

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  44
/* YYNRULES -- Number of rules.  */
#define YYNRULES  82
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  151

#define YYUNDEFTOK  2
#define YYMAXUTOK   295


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   128,   128,   134,   145,   149,   150,   153,   156,   157,
     160,   163,   164,   167,   178,   179,   182,   183,   187,   214,
     232,   268,   269,   272,   273,   276,   281,   282,   285,   286,
     289,   290,   293,   294,   295,   296,   299,   300,   303,   331,
     357,   386,   391,   398,   409,   415,   421,   432,   438,   459,
     468,   483,   496,   510,   523,   537,   550,   563,   577,   592,
     625,   631,   637,   643,   649,   671,   693,   701,   704,   712,
     715,   729,   744,   759,   774,   790,   807,   814,   823,   835,
     849,   862,   897
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TOK_MAIN", "TOK_INT", "TOK_BOOLEAN",
  "TOK_ARRAY", "TOK_FUNCTION", "TOK_IF", "TOK_ELSE", "TOK_WHILE",
  "TOK_SCANF", "TOK_PRINTF", "TOK_RETURN", "TOK_PUNTOYCOMA", "TOK_COMA",
  "TOK_PARENTESISIZQUIERDO", "TOK_PARENTESISDERECHO",
  "TOK_CORCHETEIZQUIERDO", "TOK_CORCHETEDERECHO", "TOK_LLAVEIZQUIERDA",
  "TOK_LLAVEDERECHA", "TOK_ASIGNACION", "TOK_MAS", "TOK_MENOS",
  "TOK_DIVISION", "TOK_ASTERISCO", "TOK_AND", "TOK_OR", "TOK_NOT",
  "TOK_IGUAL", "TOK_DISTINTO", "TOK_MENORIGUAL", "TOK_MAYORIGUAL",
  "TOK_MENOR", "TOK_MAYOR", "TOK_IDENTIFICADOR", "TOK_CONSTANTE_ENTERA",
  "TOK_TRUE", "TOK_FALSE", "TOK_ERROR", "$accept", "programa",
  "iniciarTablaHash", "segmento_init", "declaraciones", "declaracion",
  "clase", "clase_escalar", "tipo", "clase_vector", "identificadores",
  "funciones", "funcion", "fn_declaration", "fn_name",
  "parametros_funcion", "resto_parametros_funcion", "parametro_funcion",
  "declaraciones_funcion", "sentencias", "sentencia", "sentencia_simple",
  "bloque", "asignacion", "elemento_vector", "condicional", "if_exp",
  "if_else_exp", "bucle", "while_exp", "while", "lectura", "escritura",
  "retorno_funcion", "exp", "idf_llamada_funcion", "lista_expresiones",
  "resto_lista_expresiones", "comparacion", "constante",
  "constante_logica", "constante_entera", "identificador", "idpf", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295
};
# endif

#define YYPACT_NINF (-36)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-66)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     -36,     9,    29,   -36,    16,    25,   -36,   -36,     0,   -36,
      25,     1,   -36,   -36,   -36,    24,    36,   -36,   -36,    31,
      32,    13,     0,     2,    36,     2,    35,   -36,     1,   -36,
      33,    21,    51,   -36,    34,    17,    17,   -15,    48,     2,
      57,   -36,   -36,    62,   -36,    71,    88,   -36,    99,   105,
     -36,   -36,   -36,   -36,   109,     0,   -36,   -36,   -36,    17,
     -36,    17,    17,    17,     5,   -36,   -36,   -36,    84,   106,
     -36,   -36,   -36,    84,    17,    17,   -36,   -36,   -36,    17,
     111,   112,     2,    17,   -36,    97,   117,   121,    84,    68,
     119,    -8,   -36,    17,    17,    17,    17,    17,    17,    17,
     101,    84,    84,     2,     2,   116,    49,   -36,   -36,   118,
       0,   -36,   -36,    17,    17,    17,    17,    17,    17,   -36,
      -8,    -8,     7,     7,   -36,   -36,    90,   122,   -36,   120,
     123,   -36,   -36,    25,   121,    84,    84,    84,    84,    84,
      84,    17,   -36,   -36,   131,   -36,   -36,   -36,   -36,    90,
     -36
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       3,     0,     0,     1,     0,     0,    11,    12,     0,     4,
       5,     0,     8,    10,     9,     0,    17,     6,    81,     0,
      14,     0,     0,     0,    17,     0,     0,     7,     0,    80,
       0,     0,     0,    47,     0,     0,     0,     0,     0,    28,
       0,    31,    32,     0,    36,     0,     0,    37,     0,     0,
      33,    34,    35,    16,     0,    22,    15,    13,    20,     0,
      48,     0,     0,     0,    59,    78,    79,    63,    49,     0,
      60,    76,    77,    50,     0,     0,     2,    29,    30,     0,
       0,     0,     0,     0,    18,     0,     0,    24,    43,     0,
       0,    55,    58,     0,     0,     0,     0,     0,     0,    67,
       0,    38,    39,     0,     0,     0,     0,    82,    25,     0,
       0,    21,    61,     0,     0,     0,     0,     0,     0,    62,
      51,    52,    53,    54,    56,    57,    69,     0,    40,     0,
       0,    45,    46,    27,    24,    70,    71,    72,    73,    74,
      75,     0,    66,    64,    41,    42,    26,    19,    23,    69,
      68
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -36,   -36,   -36,   -36,   -10,   -36,   -36,   -36,    -6,   -36,
     114,   124,   -36,   -36,   -36,   -36,    11,    37,   -36,   -14,
     -36,   -36,   -36,   -36,   -17,   -36,   -36,   -36,   -36,   -36,
     -36,   -36,   -36,   -36,   -35,   -36,   -36,    -3,   -36,   -36,
     -36,   128,   -36,   -36
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     2,    16,     9,    10,    11,    12,    13,    14,
      19,    23,    24,    25,    26,    86,   111,    87,   147,    38,
      39,    40,    41,    42,    67,    44,    45,    46,    47,    48,
      49,    50,    51,    52,    68,    69,   127,   142,    90,    70,
      71,    72,    20,   108
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      17,    73,    15,    74,     6,     7,    43,    75,    43,     3,
      32,    54,    33,    34,    35,    36,    31,    95,    96,    97,
      98,   -65,    43,    74,    88,    77,    89,    91,    92,     6,
       7,     8,     4,    61,    97,    98,     5,    18,    37,   100,
     101,    62,    21,    22,   102,    27,    63,    28,   106,    85,
      29,    55,    57,    64,    29,    65,    66,    58,   120,   121,
     122,   123,   124,   125,   126,    43,   132,    59,   105,    76,
      60,    78,    93,    94,    95,    96,    97,    98,   135,   136,
     137,   138,   139,   140,    79,   112,    43,    43,    80,   129,
     130,    93,    94,    95,    96,    97,    98,    81,   113,   114,
     115,   116,   117,   118,    85,   141,   149,    93,    94,    95,
      96,    97,    98,    93,    94,    95,    96,    97,    98,    82,
     128,    83,    99,   146,    93,    94,    95,    96,    97,    98,
      84,   103,   104,   107,   109,   110,   119,   131,   133,   143,
     -44,   144,    56,     0,   145,   148,   150,   134,    53,    30
};

static const yytype_int16 yycheck[] =
{
      10,    36,     8,    18,     4,     5,    23,    22,    25,     0,
       8,    25,    10,    11,    12,    13,    22,    25,    26,    27,
      28,    16,    39,    18,    59,    39,    61,    62,    63,     4,
       5,     6,     3,    16,    27,    28,    20,    36,    36,    74,
      75,    24,    18,     7,    79,    14,    29,    15,    83,    55,
      37,    16,    19,    36,    37,    38,    39,    36,    93,    94,
      95,    96,    97,    98,    99,    82,    17,    16,    82,    21,
      36,    14,    23,    24,    25,    26,    27,    28,   113,   114,
     115,   116,   117,   118,    22,    17,   103,   104,    17,   103,
     104,    23,    24,    25,    26,    27,    28,     9,    30,    31,
      32,    33,    34,    35,   110,    15,   141,    23,    24,    25,
      26,    27,    28,    23,    24,    25,    26,    27,    28,    20,
      19,    16,    16,   133,    23,    24,    25,    26,    27,    28,
      21,    20,    20,    36,    17,    14,    17,    21,    20,    17,
       9,    21,    28,    -1,    21,   134,   149,   110,    24,    21
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    42,    43,     0,     3,    20,     4,     5,     6,    45,
      46,    47,    48,    49,    50,    49,    44,    45,    36,    51,
      83,    18,     7,    52,    53,    54,    55,    14,    15,    37,
      82,    49,     8,    10,    11,    12,    13,    36,    60,    61,
      62,    63,    64,    65,    66,    67,    68,    69,    70,    71,
      72,    73,    74,    52,    60,    16,    51,    19,    36,    16,
      36,    16,    24,    29,    36,    38,    39,    65,    75,    76,
      80,    81,    82,    75,    18,    22,    21,    60,    14,    22,
      17,     9,    20,    16,    21,    49,    56,    58,    75,    75,
      79,    75,    75,    23,    24,    25,    26,    27,    28,    16,
      75,    75,    75,    20,    20,    60,    75,    36,    84,    17,
      14,    57,    17,    30,    31,    32,    33,    34,    35,    17,
      75,    75,    75,    75,    75,    75,    75,    77,    19,    60,
      60,    21,    17,    20,    58,    75,    75,    75,    75,    75,
      75,    15,    78,    17,    21,    21,    45,    59,    57,    75,
      78
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    41,    42,    43,    44,    45,    45,    46,    47,    47,
      48,    49,    49,    50,    51,    51,    52,    52,    53,    54,
      55,    56,    56,    57,    57,    58,    59,    59,    60,    60,
      61,    61,    62,    62,    62,    62,    63,    63,    64,    64,
      65,    66,    66,    67,    68,    69,    70,    71,    72,    73,
      74,    75,    75,    75,    75,    75,    75,    75,    75,    75,
      75,    75,    75,    75,    75,    76,    77,    77,    78,    78,
      79,    79,    79,    79,    79,    79,    80,    80,    81,    81,
      82,    83,    84
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     8,     0,     0,     1,     2,     3,     1,     1,
       1,     1,     1,     5,     1,     3,     2,     0,     3,     6,
       3,     2,     0,     3,     0,     2,     1,     0,     1,     2,
       2,     1,     1,     1,     1,     1,     1,     1,     3,     3,
       4,     5,     5,     3,     5,     4,     4,     1,     2,     2,
       2,     3,     3,     3,     3,     2,     3,     3,     2,     1,
       1,     3,     3,     1,     4,     1,     2,     0,     3,     0,
       3,     3,     3,     3,     3,     3,     1,     1,     1,     1,
       1,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 128 "./res/alfa.y"
                                                                                                                         {fprintf(yyout, ";R1:\t<programa> ::= main { <declaraciones> <funciones> <sentencias> }\n");
escribir_fin(yyout);
destroy_table(table);}
#line 1552 "y.tab.c"
    break;

  case 3:
#line 134 "./res/alfa.y"
{
    table = create_table();
    if(!table){
        fprintf(stderr, "Error: Inicializacion tabla hash");
        return 1;
    }
    escribir_subseccion_data(yyout);
    escribir_cabecera_bss(yyout);
}
#line 1566 "y.tab.c"
    break;

  case 4:
#line 145 "./res/alfa.y"
{
    escribir_segmento_codigo(yyout);
}
#line 1574 "y.tab.c"
    break;

  case 5:
#line 149 "./res/alfa.y"
                                            {fprintf(yyout, ";R2:\t<declaraciones> ::= <declaracion>\n");}
#line 1580 "y.tab.c"
    break;

  case 6:
#line 150 "./res/alfa.y"
                                            {fprintf(yyout, ";R3:\t<declaraciones> ::= <declaracion> <declaraciones>\n");}
#line 1586 "y.tab.c"
    break;

  case 7:
#line 153 "./res/alfa.y"
                                                  {fprintf(yyout, ";R4:\t<declaracion> ::= <clase> <identificadores> ;\n");}
#line 1592 "y.tab.c"
    break;

  case 8:
#line 156 "./res/alfa.y"
                        {current_data_complexity = ESCALAR;fprintf(yyout, ";R5:\t<clase> ::= <clase_escalar>\n");}
#line 1598 "y.tab.c"
    break;

  case 9:
#line 157 "./res/alfa.y"
                        {current_data_complexity = VECTOR;fprintf(yyout, ";R7:\t<clase> ::= <clase_vector>\n");}
#line 1604 "y.tab.c"
    break;

  case 10:
#line 160 "./res/alfa.y"
                    {current_size = 1;fprintf(yyout, ";R9:\t<clase_escalar> ::= <tipo>\n");}
#line 1610 "y.tab.c"
    break;

  case 11:
#line 163 "./res/alfa.y"
                    {current_data_type = INT;fprintf(yyout, ";R10:\t<tipo> ::= int\n");}
#line 1616 "y.tab.c"
    break;

  case 12:
#line 164 "./res/alfa.y"
                    {current_data_type = BOOLEAN;fprintf(yyout, ";R11:\t<tipo> ::= boolean\n");}
#line 1622 "y.tab.c"
    break;

  case 13:
#line 167 "./res/alfa.y"
                                                                                        {
    current_size = (yyvsp[-1].atributos).integer_value;
    fprintf(yyout, ";R15:\t<clase_vector> ::= array <tipo> [ <constante_entera> ]\n");
    // Observamos el tamano del vector actual y comprobamos que este dentro de los limites
    if(current_size < 1 || current_size > MAX_VECTOR_LEN){
        printf("****Error semantico en lin %ld: El tamanyo del vector <nombre_vector> excede los limites permitidos (1,64).",yylin);
        destroy_table(table);
        return 1;
    }   
}
#line 1637 "y.tab.c"
    break;

  case 14:
#line 178 "./res/alfa.y"
                                                        {fprintf(yyout, ";R18:\t<identificadores> ::= <identificador>\n");}
#line 1643 "y.tab.c"
    break;

  case 15:
#line 179 "./res/alfa.y"
                                                        {fprintf(yyout, ";R19:\t<identificadores> ::= <identificador> , <identificadores>\n");}
#line 1649 "y.tab.c"
    break;

  case 16:
#line 182 "./res/alfa.y"
                             {fprintf(yyout,";R20:\t<funciones> ::= <funcion> <funciones>\n");}
#line 1655 "y.tab.c"
    break;

  case 17:
#line 183 "./res/alfa.y"
                                   {fprintf(yyout,";R21:\t<funciones> ::= \n");
                                    escribir_inicio_main(yyout);}
#line 1662 "y.tab.c"
    break;

  case 18:
#line 188 "./res/alfa.y"
         {
           Entry *entry;
           fprintf(yyout,";R22:\t<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }\n");
           if(f_return < 1)
            {
                printf("****Error semantico en lin %ld: Funcion %s sin sentencia de retorno.\n", yylin, (yyvsp[-2].atributos).name);
                destroy_table(table);
                return 1;
            } 
           shut_down_local_env(table);

           entry = search_entry(table, (yyvsp[-2].atributos).name);
           if(!entry) {
                destroy_table(table);
                return 1;
           }
           
           entry->global.cardinal = current_params_info.cardinal;
           entry->type = f_type;
           current_params_info.cardinal = 0;
           current_local_vars_info.cardinal = 0;
           current_params_info.position = 0;
         }
#line 1690 "y.tab.c"
    break;

  case 19:
#line 216 "./res/alfa.y"
                {
                  Entry* entry;
                  entry = search_entry(table, (yyvsp[-5].atributos).name);
                if(!entry) {
                    destroy_table(table);
                    return 1;
                }

                entry->global.cardinal = current_params_info.cardinal;
                entry->global.cardinal = current_local_vars_info.cardinal;
                entry->type = f_type;
                strcpy((yyval.atributos).name, (yyvsp[-5].atributos).name);
                declararFuncion(yyout, (yyvsp[-5].atributos).name, current_local_vars_info.cardinal);
                }
#line 1709 "y.tab.c"
    break;

  case 20:
#line 233 "./res/alfa.y"
         {
           if (!search_entry(table, (yyvsp[0].atributos).name)) {
             strcpy((yyval.atributos).name, (yyvsp[0].atributos).name);
             // HAY QUE MIRAR LOS ARGUMENTOS DE ESTA LLAMADA

              ArgsInfo entryLocal;
              ArgsInfo entryGlobal;

              entryLocal.cardinal = f_num_args;
              entryLocal.position = current_local_vars_info.position;
              entryGlobal.cardinal = 0;
              entryGlobal.position = f_num_args; 


             open_local_env(table, (yyvsp[0].atributos).name, current_size, VARIABLE, current_data_type,
              current_data_complexity, entryGlobal, entryLocal);
             
             current_params_info.cardinal = 0;
             current_params_info.position = 0;
             f_return = 0;
             f_type = current_data_type;         
             current_size = 1;
             current_local_vars_info.cardinal = 0;


           }
           else {
             printf("****Error semantico en lin %ld: Declaracion duplicada\n", yylin);
             destroy_table(table);
             return 1;
           }
         }
#line 1746 "y.tab.c"
    break;

  case 21:
#line 268 "./res/alfa.y"
                                                                {fprintf(yyout, ";R23:\t<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
#line 1752 "y.tab.c"
    break;

  case 22:
#line 269 "./res/alfa.y"
                                                                {fprintf(yyout, ";R24:\t<parametros_funcion> ::=\n");}
#line 1758 "y.tab.c"
    break;

  case 23:
#line 272 "./res/alfa.y"
                                                                                    {fprintf(yyout, ";R25:\t<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
#line 1764 "y.tab.c"
    break;

  case 24:
#line 273 "./res/alfa.y"
                                                                                    {fprintf(yyout, ";R26:\t<resto_parametros_funcion> ::=\n");}
#line 1770 "y.tab.c"
    break;

  case 25:
#line 276 "./res/alfa.y"
                               {fprintf(yyout, ";R27:\t<parametro_funcion> ::= <tipo> <identificador>\n");
                     current_params_info.cardinal++;
                     current_params_info.position++;}
#line 1778 "y.tab.c"
    break;

  case 26:
#line 281 "./res/alfa.y"
                                        {fprintf(yyout, ";R28:\t<declaraciones_funcion> ::= <declaraciones>\n");}
#line 1784 "y.tab.c"
    break;

  case 27:
#line 282 "./res/alfa.y"
                                        {fprintf(yyout, ";R29:\t<declaraciones_funcion> ::=\n");}
#line 1790 "y.tab.c"
    break;

  case 28:
#line 285 "./res/alfa.y"
                                {fprintf(yyout, ";R30:\t<sentencias> ::= <sentencia>\n");}
#line 1796 "y.tab.c"
    break;

  case 29:
#line 286 "./res/alfa.y"
                                {fprintf(yyout, ";R31:\t<sentencias> ::= <sentencia> <sentencias>\n");}
#line 1802 "y.tab.c"
    break;

  case 30:
#line 289 "./res/alfa.y"
                                            {fprintf(yyout, ";R32:\t<sentencia> ::= <sentencia_simple> ;\n");}
#line 1808 "y.tab.c"
    break;

  case 31:
#line 290 "./res/alfa.y"
                                            {fprintf(yyout, ";R33:\t<sentencia> ::= <bloque>\n");}
#line 1814 "y.tab.c"
    break;

  case 32:
#line 293 "./res/alfa.y"
                                    {fprintf(yyout, ";R34:\t<sentencia_simple> ::= <asignacion>\n");}
#line 1820 "y.tab.c"
    break;

  case 33:
#line 294 "./res/alfa.y"
                                    {fprintf(yyout, ";R35:\t<sentencia_simple> ::= <lectura>\n");}
#line 1826 "y.tab.c"
    break;

  case 34:
#line 295 "./res/alfa.y"
                                    {fprintf(yyout, ";R36:\t<sentencia_simple> ::= <escritura>\n");}
#line 1832 "y.tab.c"
    break;

  case 35:
#line 296 "./res/alfa.y"
                                    {fprintf(yyout, ";R38:\t<sentencia_simple> ::= <retorno_funcion>\n");}
#line 1838 "y.tab.c"
    break;

  case 36:
#line 299 "./res/alfa.y"
                        {fprintf(yyout, ";R40:\t<bloque> ::= <condicional>\n");}
#line 1844 "y.tab.c"
    break;

  case 37:
#line 300 "./res/alfa.y"
                        {fprintf(yyout, ";R41:\t<bloque> ::= <bucle>\n");}
#line 1850 "y.tab.c"
    break;

  case 38:
#line 304 "./res/alfa.y"
            {
              Entry *entry;
              entry = search_entry(table, (yyvsp[-2].atributos).name);

              if(!entry) {
                printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, (yyvsp[-2].atributos).name);
                destroy_table(table);
                return 1;  
              }

              if(entry->complexity == VECTOR || entry->cathegory == FUNCION || entry->type != (yyvsp[0].atributos).type) {
                printf("****Error semantico en lin %ld: Asignacion incompatible.\n", yylin);
                destroy_table(table);
                return 1;
              }

              if(table->env == GLOBAL) {
                asignar(yyout, (yyvsp[-2].atributos).name, (yyvsp[0].atributos).is_address);
              }

              else {
                escribirVariableLocal(yyout, entry->global.position);
                asignarDestinoEnPila(yyout, (yyvsp[0].atributos).is_address);
              }

              fprintf(yyout,";R43:\t<asignacion> ::= <identificador> = <exp>\n");
            }
#line 1882 "y.tab.c"
    break;

  case 39:
#line 332 "./res/alfa.y"
            { 
              Entry *entry;
              entry = search_entry(table, (yyvsp[-2].atributos).name);

              if(!entry) {
                printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, (yyvsp[-2].atributos).name);
                destroy_table(table);
                return 1;  
              }

              if((yyvsp[-2].atributos).type != (yyvsp[0].atributos).type) {
                printf("****Error semantico en lin %ld: Asignacion incompatible.\n", yylin);
                destroy_table(table);
                return 1;  
              }
              char e[MAX_INT_SIZE];
              sprintf(e, "%d", (yyvsp[-2].atributos).integer_value);
              escribir_operando(yyout, e, 0);
              escribir_elemento_vector(yyout, entry->key, entry->size, (yyvsp[0].atributos).is_address); 
              asignarDestinoEnPila(yyout, (yyvsp[0].atributos).is_address);

              fprintf(yyout,";R44:\t<asignacion> ::= <elemento_vector> = <exp>\n");
            }
#line 1910 "y.tab.c"
    break;

  case 40:
#line 358 "./res/alfa.y"
                 { 
                    Entry *entry;
                    entry = search_entry(table, (yyvsp[-3].atributos).name);

                   if(!entry) {
                        printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, (yyvsp[-3].atributos).name);
                        destroy_table(table);
                        return 1;  
                   }
                   if(entry->complexity != VECTOR) {
                     printf("****Error semantico en lin %ld: Intento de indexacion de una variable que no es de tipo vector.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   if((yyvsp[-1].atributos).type != INT){
                     printf("****Error semantico en lin %ld: El indice en una operacion de indexacion tiene que ser de tipo entero.\n",yylin);
                     destroy_table(table);
                     return 1;
                   }
                   (yyval.atributos).type = entry->type;
                   (yyval.atributos).is_address = 1;
                   (yyval.atributos).integer_value = (yyvsp[-1].atributos).integer_value;

                   escribir_elemento_vector(yyout, entry->key, entry->size, (yyvsp[-1].atributos).is_address);
                   fprintf(yyout,";R48:\t<elemento_vector> ::= <identificador> [ <exp> ]\n");
                 }
#line 1941 "y.tab.c"
    break;

  case 41:
#line 387 "./res/alfa.y"
                {
                    ifthen_fin(yyout, (yyvsp[-4].atributos).label);
                    fprintf(yyout, ";R50:\t<condicional> ::= if ( <exp> ) { <sentencias> }\n");
                }
#line 1950 "y.tab.c"
    break;

  case 42:
#line 392 "./res/alfa.y"
                {
                    ifthenelse_fin(yyout, (yyvsp[-4].atributos).label);
                    fprintf(yyout, ";R51:\t<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }\n");
                }
#line 1959 "y.tab.c"
    break;

  case 43:
#line 399 "./res/alfa.y"
                {
                  if ((yyvsp[0].atributos).type != BOOLEAN) {
                      printf("****Error semantico en lin %ld: Condicional con condicion de tipo int.\n",yylin);
                      destroy_table(table);
                      return 1;
                  }
                  (yyval.atributos).label = label++;
                  ifthen_inicio(yyout, (yyvsp[0].atributos).is_address, (yyval.atributos).label);
                }
#line 1973 "y.tab.c"
    break;

  case 44:
#line 410 "./res/alfa.y"
                {
                    (yyval.atributos).label = (yyvsp[-4].atributos).label;
                    ifthenelse_fin_then(yyout, (yyvsp[-4].atributos).label);
                }
#line 1982 "y.tab.c"
    break;

  case 45:
#line 416 "./res/alfa.y"
                { 
                    while_fin(yyout, (yyvsp[-3].atributos).label);
                    fprintf(yyout,";R52:\t<bucle> ::= while ( <exp> ) { <sentencias> }\n");
                }
#line 1991 "y.tab.c"
    break;

  case 46:
#line 422 "./res/alfa.y"
                {
                    if((yyvsp[-1].atributos).type != BOOLEAN) {
                        printf("****Error semantico en lin %ld: Condicional con condicion de tipo int.\n",yylin);
                        destroy_table(table);
                        return 1;
                    }
                    (yyval.atributos).label = (yyvsp[-3].atributos).label;
                    while_exp_pila(yyout, (yyvsp[-1].atributos).is_address, (yyval.atributos).label);  
                }
#line 2005 "y.tab.c"
    break;

  case 47:
#line 433 "./res/alfa.y"
                {
                  (yyval.atributos).label = label++;
                  while_inicio(yyout, (yyval.atributos).label);
                }
#line 2014 "y.tab.c"
    break;

  case 48:
#line 439 "./res/alfa.y"
                {
                    Entry *entry;
                    entry = search_entry(table, (yyvsp[0].atributos).name);

                    if(!entry) {
                        printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, (yyvsp[0].atributos).name);
                        destroy_table(table);
                        return 1;  
                    }
                  
                    if (entry->complexity == VECTOR || entry->cathegory == FUNCION) {
                        printf("****Error semantico en lin %ld: Variable local de tipo no escalar.\n", yylin);
                        destroy_table(table);
                        return 1;  
                    }
                    leer(yyout, (yyvsp[0].atributos).name, entry->type);
                    fprintf(yyout,";R54:\t<lectura> ::= scanf <identificador>\n");
                  }
#line 2037 "y.tab.c"
    break;

  case 49:
#line 460 "./res/alfa.y"
                  {
                    operandoEnPilaAArgumento(yyout, (yyvsp[0].atributos).is_address);
                    escribir(yyout, 0, (yyvsp[0].atributos).type);

                    fprintf(yyout,";R56:\t<escritura> ::= printf <exp>\n");
                  }
#line 2048 "y.tab.c"
    break;

  case 50:
#line 469 "./res/alfa.y"
                  {
                    if(llamada_funcion == 1) {
                      printf("****Error semantico en lin %ld: Sentencia de retorno fuera del cuerpo de una función.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    retornarFuncion(yyout, (yyvsp[0].atributos).is_address);
                    f_return++;
                    fprintf(yyout,";R61:\t<retorno_funcion> ::= return <exp>\n");

                  }
#line 2064 "y.tab.c"
    break;

  case 51:
#line 484 "./res/alfa.y"
                  { 
                    if((yyvsp[-2].atributos).type == BOOLEAN || (yyvsp[0].atributos).type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    sumar(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address);
                    (yyval.atributos).type = INT;
                    (yyval.atributos).is_address = 0;

                    fprintf(yyout,";R72:\t<exp> ::= <exp> + <exp> \n");
                  }
#line 2081 "y.tab.c"
    break;

  case 52:
#line 497 "./res/alfa.y"
                  { 
                    if((yyvsp[-2].atributos).type == BOOLEAN || (yyvsp[0].atributos).type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    restar(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address);
                    (yyval.atributos).type = INT;
                    (yyval.atributos).is_address = 0;    

                    fprintf(yyout,";R73:\t<exp> ::= <exp> - <exp> \n");

                  }
#line 2099 "y.tab.c"
    break;

  case 53:
#line 511 "./res/alfa.y"
                  { 
                    if((yyvsp[-2].atributos).type == BOOLEAN || (yyvsp[0].atributos).type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    dividir(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address);
                    (yyval.atributos).type = INT;
                    (yyval.atributos).is_address = 0;

                    fprintf(yyout,";R74:\t<exp> ::= <exp> / <exp> \n");
                  }
#line 2116 "y.tab.c"
    break;

  case 54:
#line 524 "./res/alfa.y"
                  { 
                    
                    if((yyvsp[-2].atributos).type == BOOLEAN || (yyvsp[0].atributos).type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    multiplicar(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address);
                    (yyval.atributos).type = INT;
                    (yyval.atributos).is_address = 0;
                    fprintf(yyout,";R75:\t<exp> ::= <exp> * <exp> \n");

                  }
#line 2134 "y.tab.c"
    break;

  case 55:
#line 538 "./res/alfa.y"
                  { 
                    if((yyvsp[0].atributos).type == BOOLEAN) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos boolean.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    cambiar_signo(yyout, (yyvsp[0].atributos).is_address);
                    (yyval.atributos).type = INT;
                    (yyval.atributos).is_address = 0;

                    fprintf(yyout,";R76:\t<exp> ::= - <exp> \n");
                  }
#line 2151 "y.tab.c"
    break;

  case 56:
#line 551 "./res/alfa.y"
                  { 
                    if((yyvsp[-2].atributos).type == INT || (yyvsp[0].atributos).type == INT) {
                      printf("****Error semantico en lin %ld: Operacion aritmetica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    y(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address);
                    (yyval.atributos).type = BOOLEAN;
                    (yyval.atributos).is_address = 0;

                    fprintf(yyout,";R77:\t<exp> ::= <exp> && <exp> \n");
                  }
#line 2168 "y.tab.c"
    break;

  case 57:
#line 564 "./res/alfa.y"
                  { 
                    if((yyvsp[-2].atributos).type == INT || (yyvsp[0].atributos).type == INT) {
                      printf("****Error semantico en lin %ld: Operacion logica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    } 
                    o(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address);

                    (yyval.atributos).type = BOOLEAN;
                    (yyval.atributos).is_address = 0;

                    fprintf(yyout,";R78:\t<exp> ::= <exp> || <exp> \n");
                  }
#line 2186 "y.tab.c"
    break;

  case 58:
#line 578 "./res/alfa.y"
                  { 
                    if((yyvsp[0].atributos).type == INT) {
                      printf("****Error semantico en lin %ld: Operacion logica con operandos int.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    no(yyout, (yyvsp[0].atributos).is_address, label);

                    label++;
                    (yyval.atributos).type = BOOLEAN;
                    (yyval.atributos).is_address = 0;

                    fprintf(yyout,";R79:\t<exp> ::= ! <exp> \n");
                  }
#line 2205 "y.tab.c"
    break;

  case 59:
#line 593 "./res/alfa.y"
                  { 
                    Entry* entry;
                    entry = search_entry(table, (yyvsp[0].atributos).name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a la variable no declarada (%s)\n", yylin, (yyvsp[0].atributos).name);
                      destroy_table(table);
                      return 1;
                    }
                    if(entry->cathegory == FUNCION || entry->complexity == VECTOR) {
                      printf("****Error semantico en lin %ld: Asignacion incompatible.", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    (yyval.atributos).type = entry->type;
                    (yyval.atributos).is_address = 1;
                    if (entry->cathegory == PARAMETRO) {
                      escribirParametro(yyout, entry->global.position, current_params_info.cardinal);
                    }
                    else if (entry->cathegory == VARIABLE) {
                      if (table->env == LOCAL) {
                        escribirVariableLocal(yyout, entry->local.position);
                      }
                      else {
                        escribir_operando(yyout, (yyvsp[0].atributos).name, 1);
                        if(llamada_funcion == 1) {
                          operandoEnPilaAArgumento(yyout,1);
                        }
                      }
                    }

                    fprintf(yyout,";R80:\t<exp> ::= <identificador>\n");
                  }
#line 2242 "y.tab.c"
    break;

  case 60:
#line 626 "./res/alfa.y"
                  { 
                    fprintf(yyout,";R81:\t<exp> ::= <constante>\n");
                    (yyval.atributos).is_address = (yyvsp[0].atributos).is_address;
                    (yyval.atributos).type = (yyvsp[0].atributos).type;
                  }
#line 2252 "y.tab.c"
    break;

  case 61:
#line 632 "./res/alfa.y"
                  { 
                    fprintf(yyout,";R82:\t<exp> ::= ( <exp> )\n");
                    (yyval.atributos).is_address = (yyvsp[-1].atributos).is_address;
                    (yyval.atributos).type = (yyvsp[-1].atributos).type;
                  }
#line 2262 "y.tab.c"
    break;

  case 62:
#line 638 "./res/alfa.y"
                  { 
                    fprintf(yyout,";R83:\t<exp> ::= ( <comparacion> )\n");
                    (yyval.atributos).is_address = (yyvsp[-1].atributos).is_address;
                    (yyval.atributos).type = (yyvsp[-1].atributos).type;
                  }
#line 2272 "y.tab.c"
    break;

  case 63:
#line 644 "./res/alfa.y"
                  { 
                    fprintf(yyout,";R85:\t<exp> ::= <elemento_vector>\n");
                    (yyval.atributos).is_address = (yyvsp[0].atributos).is_address;
                    (yyval.atributos).type = (yyvsp[0].atributos).type;
                  }
#line 2282 "y.tab.c"
    break;

  case 64:
#line 650 "./res/alfa.y"
                  {
                    Entry* entry;
                    entry = search_entry(table, (yyvsp[-3].atributos).name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a la variable no declarada (%s)\n", yylin, (yyvsp[-3].atributos).name);
                      destroy_table(table);
                      return 1;
                    }
                    if (f_num_args != entry->global.cardinal) {
                      printf("****Error semantico en lin %ld: Numero incorrecto de parametros en llamada a funcion.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }
                    (yyval.atributos).type = entry->type;
                    llamarFuncion(yyout, (yyvsp[-3].atributos).name, entry->global.cardinal);
                    llamada_funcion = 0;

                    fprintf(yyout,";R88:\t<exp> ::= <identificador> ( <lista_expresiones> ) \n");
                  }
#line 2306 "y.tab.c"
    break;

  case 65:
#line 672 "./res/alfa.y"
                  {
                    Entry* entry;
                    if (llamada_funcion == 1) {
                      printf("****Error semantico en lin %ld: No esta permitido el uso de llamadas a funciones como parametros de otras funciones.\n", yylin);
                      destroy_table(table);
                      return 1;
                    }

                    entry = search_entry(table, (yyvsp[0].atributos).name);
                    if (!entry) {
                      printf("****Error semantico en lin %ld: Acceso a variable no declarada (%s).\n", yylin, (yyvsp[0].atributos).name);
                      destroy_table(table);
                      return 1;
                    }

                    f_num_args = 0;
                    llamada_funcion = 1;
                    strcpy((yyval.atributos).name, (yyvsp[0].atributos).name);
                  }
#line 2330 "y.tab.c"
    break;

  case 66:
#line 694 "./res/alfa.y"
                   { 
                     fprintf(yyout,";R89:\t<lista_expresiones> ::= <exp>  <resto_lista_expresiones> \n");
                      if(llamada_funcion == 1) {
                        f_num_args++;
                      }
                   }
#line 2341 "y.tab.c"
    break;

  case 67:
#line 701 "./res/alfa.y"
                   { fprintf(yyout,";R90:\t<lista_expresiones> ::= \n"); }
#line 2347 "y.tab.c"
    break;

  case 68:
#line 705 "./res/alfa.y"
                         {
                           fprintf(yyout,";R91:\t<resto_lista_expresiones> ::= , <exp>  <resto_lista_expresiones> \n");
                           if(llamada_funcion == 1) {
                             f_num_args++;
                           }
                         }
#line 2358 "y.tab.c"
    break;

  case 69:
#line 712 "./res/alfa.y"
                         { fprintf(yyout,";R92:\t<resto_lista_expresiones> ::= \n"); }
#line 2364 "y.tab.c"
    break;

  case 70:
#line 716 "./res/alfa.y"
                  {
                      if ((yyvsp[-2].atributos).type != INT || (yyvsp[0].atributos).type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }
                      igual(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address, label);
                      label += 1;
                      (yyval.atributos).type = BOOLEAN;
                      (yyval.atributos).is_address = 0;

                      fprintf(yyout, ";R93:\t<comparacion> ::= <exp> == <exp>\n");
                  }
#line 2382 "y.tab.c"
    break;

  case 71:
#line 730 "./res/alfa.y"
                  {
                      if ((yyvsp[-2].atributos).type != INT || (yyvsp[0].atributos).type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      distinto(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address, label);
                      label += 1;
                      (yyval.atributos).type = BOOLEAN;
                      (yyval.atributos).is_address = 0;

                      fprintf(yyout, ";R94:\t<comparacion> ::= <exp> != <exp>\n");
                  }
#line 2401 "y.tab.c"
    break;

  case 72:
#line 745 "./res/alfa.y"
                  {
                      if ((yyvsp[-2].atributos).type != INT || (yyvsp[0].atributos).type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      menor_igual(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address, label);
                      label += 1;
                      (yyval.atributos).type = BOOLEAN;
                      (yyval.atributos).is_address = 0;

                      fprintf(yyout, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");
                  }
#line 2420 "y.tab.c"
    break;

  case 73:
#line 760 "./res/alfa.y"
                  {
                      if ((yyvsp[-2].atributos).type != INT || (yyvsp[0].atributos).type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      mayor_igual(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address, label);
                      label += 1;
                      (yyval.atributos).type = BOOLEAN;
                      (yyval.atributos).is_address = 0;

                      fprintf(yyout, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");
                  }
#line 2439 "y.tab.c"
    break;

  case 74:
#line 775 "./res/alfa.y"
                  {
                      if ((yyvsp[-2].atributos).type != INT || (yyvsp[0].atributos).type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);
                          return 1;
                      }


                      menor(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address, label);
                      label += 1;
                      (yyval.atributos).type = BOOLEAN;
                      (yyval.atributos).is_address = 0;

                      fprintf(yyout, ";R97:\t<comparacion> ::= <exp> < <exp>\n");
                  }
#line 2459 "y.tab.c"
    break;

  case 75:
#line 791 "./res/alfa.y"
                  {
                      if ((yyvsp[-2].atributos).type != INT || (yyvsp[0].atributos).type != INT) {
                          printf("****Error semantico en lin %ld: Comparacion con operandos boolean.\n",yylin);
                          destroy_table(table);                          
                          return 1;
                      }

                      mayor(yyout, (yyvsp[-2].atributos).is_address, (yyvsp[0].atributos).is_address, label);
                      label += 1;
                      (yyval.atributos).type = BOOLEAN;
                      (yyval.atributos).is_address = 0;

                      fprintf(yyout, ";R98:\t<comparacion> ::= <exp> > <exp>\n");
                  }
#line 2478 "y.tab.c"
    break;

  case 76:
#line 808 "./res/alfa.y"
                  {
                      /* Checkeamos la semantica*/
                      (yyval.atributos).type = (yyvsp[0].atributos).type;
                      (yyval.atributos).is_address = (yyvsp[0].atributos).is_address;
                      fprintf(yyout, ";R99:\t<constante> ::= <constante_logica>\n");
                  }
#line 2489 "y.tab.c"
    break;

  case 77:
#line 815 "./res/alfa.y"
                  {
                      /* Checkeamos la semantica*/
                      (yyval.atributos).type = (yyvsp[0].atributos).type;
                      (yyval.atributos).is_address = (yyvsp[0].atributos).is_address;
                      fprintf(yyout, ";R100:\t<constante> ::= <constante_entera>\n");
                  }
#line 2500 "y.tab.c"
    break;

  case 78:
#line 824 "./res/alfa.y"
                    {
                      /* Checkeamos la semantica*/
                        (yyval.atributos).type = BOOLEAN;
                        (yyval.atributos).is_address = 0;

                        char tok[2];

                        sprintf(tok, "1");
                        escribir_operando(yyout, tok, 0);
                        fprintf(yyout, ";R102:\t<constante_logica> ::= true\n");
                    }
#line 2516 "y.tab.c"
    break;

  case 79:
#line 836 "./res/alfa.y"
                    {
                      /* Checkeamos la semantica*/
                        (yyval.atributos).type = BOOLEAN;
                        (yyval.atributos).is_address = 0;

                        char tok[2];

                        sprintf(tok, "0");
                        escribir_operando(yyout, tok, 0);
                        fprintf(yyout, ";R103:\t<constante_logica> ::= false\n");
                    }
#line 2532 "y.tab.c"
    break;

  case 80:
#line 850 "./res/alfa.y"
                    {
                      (yyval.atributos).is_address = 0;
                      (yyval.atributos).integer_value = (yyvsp[0].atributos).integer_value;
                      (yyval.atributos).type = INT;
                      char tok[MAX_INT_SIZE];
                      sprintf(tok, "%d", (yyval.atributos).integer_value);
                      escribir_operando(yyout, tok, 0);
                      fprintf(yyout,";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");
                    }
#line 2546 "y.tab.c"
    break;

  case 81:
#line 863 "./res/alfa.y"
               {
                  ArgsInfo entryLocal;
                  ArgsInfo entryGlobal;

                  entryLocal.cardinal = 0;
                  entryLocal.position = current_local_vars_info.cardinal;
                  entryGlobal.cardinal = current_params_info.cardinal;
                  entryGlobal.position = current_local_vars_info.position;

                 if (table->env == LOCAL) {
                   current_local_vars_info.position++;
                   current_local_vars_info.cardinal++;

                   if(insert_entry(table, create_entry((yyvsp[0].atributos).name, current_size, VARIABLE, current_data_type,
                                         current_data_complexity, entryGlobal, entryLocal)) == 1) {
                     printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                     destroy_table(table);
                     return 1;
                   }
                 }

                 if (table->env == GLOBAL) {
                   if(insert_entry(table, create_entry((yyvsp[0].atributos).name,current_size, VARIABLE, current_data_type,
                                         current_data_complexity, entryGlobal, entryLocal)) == 1) {
                     printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                     destroy_table(table);
                     return 1;
                   }
                   declarar_variable(yyout, (yyvsp[0].atributos).name, current_data_type, current_size);
                 }
                 fprintf(yyout,";R108:\t<identificador> ::= TOK_IDENTIFICADOR\n");
               }
#line 2583 "y.tab.c"
    break;

  case 82:
#line 898 "./res/alfa.y"
              {
              if(!search_entry(table, (yyvsp[0].atributos).name)) {

                ArgsInfo entryLocal;
                ArgsInfo entryGlobal;

                entryLocal.cardinal = 0;
                entryLocal.position = 0;
                entryGlobal.cardinal = 0;
                entryGlobal.position = current_params_info.position;

                if(insert_entry(table, create_entry((yyvsp[0].atributos).name,1,PARAMETRO, current_data_type,ESCALAR, entryGlobal, entryLocal)) == 1) {
                  destroy_table(table);
                  return 1;
                }
              }
              else {
                printf("****Error semantico en lin %ld: Declaracion duplicada.\n", yylin);
                destroy_table(table);
                return 1;
              }
            }
#line 2610 "y.tab.c"
    break;


#line 2614 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 923 "./res/alfa.y"


void yyerror(const char * s) {
    if(!error_not_allowed_symbol) {
        printf("****Error semantico en lin %ld, col %ld\n", yylin, yycol);
    }
}
