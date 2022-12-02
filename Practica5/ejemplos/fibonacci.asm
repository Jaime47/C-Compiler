
segment .data
    _msg_error_div_zero db "****Error de ejecucion: Division por cero.", 0
    _msg_error_index_out_of_range db "****Error de ejecucion: Indice fuera de rango.", 0

segment .bss
  __esp resd 1
;D:	main
;D:	{
;D:	int
;R10:	<tipo> ::= int
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	x
  _x resd 1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	,
;D:	resultado
  _resultado resd 1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R19:	<identificadores> ::= <identificador> , <identificadores>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	function
;R2:	<declaraciones> ::= <declaracion>

segment .text
    global main
    extern print_int, print_boolean, print_string, print_blank, print_endofline
    extern scan_int, scan_boolean
;D:	int
;R10:	<tipo> ::= int
;D:	fibonacci
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	num1
;R27:	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::=
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	int
;R10:	<tipo> ::= int
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	res1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	,
;D:	res2
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R19:	<identificadores> ::= <identificador> , <identificadores>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	if
;R2:	<declaraciones> ::= <declaracion>
;R28:	<declaraciones_funcion> ::= <declaraciones>

_fibonacci:
    push ebp
    mov ebp, esp
    sub esp, 8
;D:	(
;D:	(
;D:	num1
;D:	==
    lea eax, [ebp + 8]
    push dword eax
;R80:	<exp> ::= <identificador>
;D:	0
    push dword 0
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
    pop dword edx
    pop dword eax
    mov dword eax, [eax]
    cmp eax, edx
    je near igual_0
    push dword 0
    jmp end_igual_0
igual_0:
    push dword 1
end_igual_0:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
    pop eax
    cmp eax, 0
    je near fin_then_1
;D:	{
;D:	return
;D:	0
    push dword 0
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
    pop dword eax
    mov esp, ebp
    pop dword ebp
    ret
;R61:	<retorno_funcion> ::= return <exp>
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	if
fin_then_1:
;R50:	<condicional> ::= if ( <exp> ) { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	num1
;D:	==
    lea eax, [ebp + 8]
    push dword eax
;R80:	<exp> ::= <identificador>
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
    pop dword edx
    pop dword eax
    mov dword eax, [eax]
    cmp eax, edx
    je near igual_2
    push dword 0
    jmp end_igual_2
igual_2:
    push dword 1
end_igual_2:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
    pop eax
    cmp eax, 0
    je near fin_then_3
;D:	{
;D:	return
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
    pop dword eax
    mov esp, ebp
    pop dword ebp
    ret
;R61:	<retorno_funcion> ::= return <exp>
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	res1
fin_then_3:
;R50:	<condicional> ::= if ( <exp> ) { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	=
;D:	fibonacci
;D:	(
;D:	num1
;D:	-
    lea eax, [ebp + 8]
    push dword eax
;R80:	<exp> ::= <identificador>
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
    pop dword edx
    pop dword eax
  mov dword eax, [eax]
    sub eax, edx
    push dword eax
;R73:	<exp> ::= <exp> - <exp> 
;R92:	<resto_lista_expresiones> ::= 
;R89:	<lista_expresiones> ::= <exp>  <resto_lista_expresiones> 
