
segment .data
    _msg_error_div_zero db "****Error de ejecucion: Division por cero.", 0
    _msg_error_index_out_of_range db "****Error de ejecucion: Indice fuera de rango.", 0

segment .bss
  __esp resd 1
;D:	main
;D:	{
;D:	boolean
;R11:	<tipo> ::= boolean
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	resultado
  _resultado resd 1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	array
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	[
;D:	3
    push dword 3
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;D:	]
;R15:	<clase_vector> ::= array <tipo> [ <constante_entera> ]
;R7:	<clase> ::= <clase_vector>
;D:	vector
  _vector resd 3
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	function
;R2:	<declaraciones> ::= <declaracion>
;R3:	<declaraciones> ::= <declaracion> <declaraciones>

segment .text
    global main
    extern print_int, print_boolean, print_string, print_blank, print_endofline
    extern scan_int, scan_boolean
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	or
;D:	(
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	b1
;R27:	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	b2
;R27:	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	boolean
;R11:	<tipo> ::= boolean
;D:	b3
;R27:	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::=
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	boolean
;R11:	<tipo> ::= boolean
;R9:	<clase_escalar> ::= <tipo>
;R5:	<clase> ::= <clase_escalar>
;D:	a
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	a
;R2:	<declaraciones> ::= <declaracion>
;R28:	<declaraciones_funcion> ::= <declaraciones>

_or:
    push ebp
    mov ebp, esp
    sub esp, 4
;D:	=
;D:	b1
;D:	||
    lea eax, [ebp + 16]
    push dword eax
;R80:	<exp> ::= <identificador>
;D:	b2
;D:	||
    lea eax, [ebp + 12]
    push dword eax
;R80:	<exp> ::= <identificador>
    pop dword edx
    mov dword edx, [edx]
    pop dword eax
    mov dword eax, [eax]
    or eax, edx
    push dword eax
;R78:	<exp> ::= <exp> || <exp> 
;D:	b3
;D:	;
    lea eax, [ebp + 8]
    push dword eax
;R80:	<exp> ::= <identificador>
    pop dword edx
    mov dword edx, [edx]
    pop dword eax
    or eax, edx
    push dword eax
;R78:	<exp> ::= <exp> || <exp> 
    lea eax, [ebp - 0]
    push dword eax
    pop dword ebx
    pop dword eax
    mov dword [ebx], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	return
;D:	a
;D:	;
    lea eax, [ebp - 0]
    push dword eax
;R80:	<exp> ::= <identificador>
    pop dword eax
    mov dword eax, [eax]
    mov esp, ebp
    pop dword ebp
    ret
;R61:	<retorno_funcion> ::= return <exp>
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R22:	<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }
;D:	vector
;R21:	<funciones> ::= 

main:
    mov dword [__esp], esp
;R20:	<funciones> ::= <funcion> <funciones>
;D:	[
;D:	0
    push dword 0
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	]
    pop dword eax
    cmp eax, 0
    jl near idx_out_of_range
    cmp eax, 2
    jg near idx_out_of_range
    mov dword edx, _vector
    lea eax, [edx + eax*4]
    push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;D:	=
;D:	false
    push dword 0
;R103:	<constante_logica> ::= false
;R99:	<constante> ::= <constante_logica>
;R81:	<exp> ::= <constante>
;D:	;
    push dword 0
    pop dword eax
    cmp eax, 0
    jl near idx_out_of_range
    cmp eax, 2
    jg near idx_out_of_range
    mov dword edx, _vector
    lea eax, [edx + eax*4]
    push dword eax
    pop dword ebx
    pop dword eax
    mov dword [ebx], eax
;R44:	<asignacion> ::= <elemento_vector> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	vector
;D:	[
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	]
    pop dword eax
    cmp eax, 0
    jl near idx_out_of_range
    cmp eax, 2
    jg near idx_out_of_range
    mov dword edx, _vector
    lea eax, [edx + eax*4]
    push dword eax
;R48:	<elemento_vector> ::= <identificador> [ <exp> ]
;D:	=
;D:	true
    push dword 1
;R102:	<constante_logica> ::= true
;R99:	<constante> ::= <constante_logica>
;R81:	<exp> ::= <constante>
;D:	;
    push dword 1
    pop dword eax
    cmp eax, 0
    jl near idx_out_of_range
    cmp eax, 2
    jg near idx_out_of_range
    mov dword edx, _vector
    lea eax, [edx + eax*4]
    push dword eax
    pop dword ebx
    pop dword eax
    mov dword [ebx], eax
;R44:	<asignacion> ::= <elemento_vector> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	vector
;D:	[
;D:	a
;D:	]
