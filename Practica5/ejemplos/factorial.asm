
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
;D:	;
;R18:	<identificadores> ::= <identificador>
;R19:	<identificadores> ::= <identificador> , <identificadores>
;R4:	<declaracion> ::= <clase> <identificadores> ;
;D:	scanf
;R2:	<declaraciones> ::= <declaracion>

segment .text
    global main
    extern print_int, print_boolean, print_string, print_blank, print_endofline
    extern scan_int, scan_boolean
;R21:	<funciones> ::= 

main:
    mov dword [__esp], esp
;D:	x
    push dword _x
    call scan_int
    add esp, 4
;R54:	<lectura> ::= scanf <identificador>
;R35:	<sentencia_simple> ::= <lectura>
;D:	;
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	y
;D:	=
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
    pop dword eax
    mov dword [_y], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	while

while_0:
;D:	(
;D:	(
;D:	x
;D:	>
    push dword _x
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
    jg near mayor_1
    push dword 0
    jmp near end_mayor_1
mayor_1:
    push dword 1
end_mayor_1:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
    pop eax
    cmp eax, 0
    je  near end_while_0
;D:	{
;D:	y
;D:	=
;D:	x
;D:	*
    push dword _x
;R80:	<exp> ::= <identificador>
;D:	y
;D:	;
    push dword _y
;R80:	<exp> ::= <identificador>
    pop dword ecx
    mov dword ecx, [ecx]
    pop dword eax
    mov dword eax, [eax]
    imul ecx
    push dword eax
;R75:	<exp> ::= <exp> * <exp> 
    pop dword eax
    mov dword [_y], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	x
;D:	=
;D:	x
;D:	-
    push dword _x
;R80:	<exp> ::= <identificador>
;D:	1
    push dword 1
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
    pop dword edx
    pop dword eax
  mov dword eax, [eax]
    sub eax, edx
    push dword eax
;R73:	<exp> ::= <exp> - <exp> 
    pop dword eax
    mov dword [_x], eax
;R43:	<asignacion> ::= <identificador> = <exp>
;R34:	<sentencia_simple> ::= <asignacion>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
    jmp near while_0
end_while_0:
;R52:	<bucle> ::= while ( <exp> ) { <sentencias> }
;R41:	<bloque> ::= <bucle>
;R33:	<sentencia> ::= <bloque>
;D:	printf
;D:	y
;D:	;
    push dword _y
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
