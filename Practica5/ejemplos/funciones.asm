
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
;D:	y
  _y resd 1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	,
;D:	resultado
  _resultado resd 1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R19:	<identificadores> ::= <identificador> , <identificadores>
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
;D:	suma
;D:	(
;D:	int
;R10:	<tipo> ::= int
;D:	num1
;R27:	<parametro_funcion> ::= <tipo> <identificador>
;D:	;
;D:	int
;R10:	<tipo> ::= int
;D:	num2
;R27:	<parametro_funcion> ::= <tipo> <identificador>
;D:	)
;R26:	<resto_parametros_funcion> ::=
;R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>
;R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>
;D:	{
;D:	return
;R29:	<declaraciones_funcion> ::=

_suma:
    push ebp
    mov ebp, esp
    sub esp, 0
;D:	num1
;D:	+
    lea eax, [ebp + 12]
    push dword eax
;R80:	<exp> ::= <identificador>
;D:	num2
;D:	;
    lea eax, [ebp + 8]
    push dword eax
;R80:	<exp> ::= <identificador>
    pop dword edx
    mov dword edx, [edx]
    pop dword eax
    mov dword eax, [eax]
    add eax, edx
    push dword eax
;R72:	<exp> ::= <exp> + <exp> 
    pop dword eax
    mov esp, ebp
    pop dword ebp
    ret
;R61:	<retorno_funcion> ::= return <exp>
;R38:	<sentencia_simple> ::= <retorno_funcion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R22:	<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> }
;D:	x
;R21:	<funciones> ::= 

main:
    mov dword [__esp], esp
;R20:	<funciones> ::= <funcion> <funciones>
;D:	=
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
    pop dword eax
    mov dword [_x], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	y
;D:	=
;D:	3
    push dword 3
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
    pop dword eax
    mov dword [_y], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	resultado
;D:	=
;D:	suma
;D:	(
;D:	x
;D:	,
    push dword _x
    pop eax
    mov eax, [eax]
    push eax
;R80:	<exp> ::= <identificador>
;D:	y
;D:	)
    push dword _y
    pop eax
    mov eax, [eax]
    push eax
;R80:	<exp> ::= <identificador>
;R92:	<resto_lista_expresiones> ::= 
;R91:	<resto_lista_expresiones> ::= , <exp>  <resto_lista_expresiones> 
;R89:	<lista_expresiones> ::= <exp>  <resto_lista_expresiones> 
   call _suma
   add esp, 8
   push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> ) 
;D:	;
    pop dword eax
    mov dword [_resultado], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	resultado
;D:	;
    push dword _resultado
;R80:	<exp> ::= <identificador>
    pop eax
    mov eax, [eax]
    push eax
    pop dword eax
    push dword eax
    call print_int
    call print_endofline
    add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	resultado
;D:	=
;D:	suma
;D:	(
;D:	x
;D:	,
    push dword _x
    pop eax
    mov eax, [eax]
    push eax
;R80:	<exp> ::= <identificador>
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::= 
;R91:	<resto_lista_expresiones> ::= , <exp>  <resto_lista_expresiones> 
;R89:	<lista_expresiones> ::= <exp>  <resto_lista_expresiones> 
   call _suma
   add esp, 8
   push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> ) 
;D:	;
    pop dword eax
    mov dword [_resultado], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	resultado
;D:	;
    push dword _resultado
;R80:	<exp> ::= <identificador>
    pop eax
    mov eax, [eax]
    push eax
    pop dword eax
    push dword eax
    call print_int
    call print_endofline
    add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	resultado
;D:	=
;D:	suma
;D:	(
;D:	10
    push dword 10
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	y
;D:	)
    push dword _y
    pop eax
    mov eax, [eax]
    push eax
;R80:	<exp> ::= <identificador>
;R92:	<resto_lista_expresiones> ::= 
;R91:	<resto_lista_expresiones> ::= , <exp>  <resto_lista_expresiones> 
;R89:	<lista_expresiones> ::= <exp>  <resto_lista_expresiones> 
   call _suma
   add esp, 8
   push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> ) 
;D:	;
    pop dword eax
    mov dword [_resultado], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	resultado
;D:	;
    push dword _resultado
;R80:	<exp> ::= <identificador>
    pop eax
    mov eax, [eax]
    push eax
    pop dword eax
    push dword eax
    call print_int
    call print_endofline
    add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	resultado
;D:	=
;D:	suma
;D:	(
;D:	3
    push dword 3
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	,
;D:	5
    push dword 5
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
;R92:	<resto_lista_expresiones> ::= 
;R91:	<resto_lista_expresiones> ::= , <exp>  <resto_lista_expresiones> 
;R89:	<lista_expresiones> ::= <exp>  <resto_lista_expresiones> 
   call _suma
   add esp, 8
   push dword eax
;R88:	<exp> ::= <identificador> ( <lista_expresiones> ) 
;D:	;
    pop dword eax
    mov dword [_resultado], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	printf
;D:	resultado
;D:	;
    push dword _resultado
;R80:	<exp> ::= <identificador>
    pop eax
    mov eax, [eax]
    push eax
    pop dword eax
    push dword eax
    call print_int
    call print_endofline
    add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R1:	<programa> ::= main { <declaraciones> <funciones> <sentencias> }
    jmp near fin
error_div_zero:
    push dword _msg_error_div_zero
    call print_string
    add esp, 4
    call print_endofline
    jmp near fin

idx_out_of_range:
    push dword _msg_error_index_out_of_range
    call print_string
    add esp, 4
    call print_endofline
    jmp near fin

fin:
    mov esp, [__esp]
    ret
