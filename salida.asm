
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
;D:	z
  _z resd 1
;R108:	<identificador> ::= TOK_IDENTIFICADOR
;D:	;
;R18:	<identificadores> ::= <identificador>
;R19:	<identificadores> ::= <identificador> , <identificadores>
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
; guarda el puntero de pila en su variable
  mov [__esp], esp
;D:	x
 push dword _x
  call scan_int
  add esp, 4
;R54:	<lectura> ::= scanf <identificador>
;R35:	<sentencia_simple> ::= <lectura>
;D:	;
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	scanf
;D:	y
 push dword _y
  call scan_int
  add esp, 4
;R54:	<lectura> ::= scanf <identificador>
;R35:	<sentencia_simple> ::= <lectura>
;D:	;
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	scanf
;D:	z
 push dword _z
  call scan_int
  add esp, 4
;R54:	<lectura> ::= scanf <identificador>
;R35:	<sentencia_simple> ::= <lectura>
;D:	;
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	if
;D:	(
;D:	(
;D:	x
;D:	==
  push dword _x
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  je igual_0
  push dword 0
  jmp end_igual_0

igual_0:
  push dword 1

end_igual_0:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	y
;D:	==
  push dword _y
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  je igual_1
  push dword 0
  jmp end_igual_1

igual_1:
  push dword 1

end_igual_1:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
  pop dword edx
  pop dword eax
  and eax, edx
  push dword eax
;R77:	<exp> ::= <exp> && <exp> 
;D:	&&
;D:	(
;D:	z
;D:	==
  push dword _z
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  je igual_2
  push dword 0
  jmp end_igual_2

igual_2:
  push dword 1

end_igual_2:
;R93:	<comparacion> ::= <exp> == <exp>
;R83:	<exp> ::= ( <comparacion> )
  pop dword edx
  pop dword eax
  and eax, edx
  push dword eax
;R77:	<exp> ::= <exp> && <exp> 
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_3
;D:	{
;D:	printf
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	else
  je end_if_else_3
else_3:
;D:	{
;D:	if
;D:	(
;D:	(
;D:	x
;D:	>
  push dword _x
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_4
  push dword 0
  jmp end_mayor_4

mayor_4:
  push dword 1

end_mayor_4:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	y
;D:	>
  push dword _y
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_5
  push dword 0
  jmp end_mayor_5

mayor_5:
  push dword 1

end_mayor_5:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
  pop dword edx
  pop dword eax
  and eax, edx
  push dword eax
;R77:	<exp> ::= <exp> && <exp> 
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_6
;D:	{
;D:	if
;D:	(
;D:	(
;D:	z
;D:	>
  push dword _z
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_7
  push dword 0
  jmp end_mayor_7

mayor_7:
  push dword 1

end_mayor_7:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_8
;D:	{
;D:	printf
;D:	1
  mov edx, 1
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	else
  je end_if_else_8
else_8:
;D:	{
;D:	printf
;D:	5
  mov edx, 5
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
end_if_else_8:
;R51:	<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	if
end_if_6:
;R50:	<condicional> ::= if ( <exp> ) { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	x
;D:	<
  push dword _x
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jl menor_9
  push dword 0
  jmp end_menor_9

menor_9:
  push dword 1

end_menor_9:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	y
;D:	>
  push dword _y
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_10
  push dword 0
  jmp end_mayor_10

mayor_10:
  push dword 1

end_mayor_10:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
  pop dword edx
  pop dword eax
  and eax, edx
  push dword eax
;R77:	<exp> ::= <exp> && <exp> 
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_11
;D:	{
;D:	if
;D:	(
;D:	(
;D:	z
;D:	>
  push dword _z
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_12
  push dword 0
  jmp end_mayor_12

mayor_12:
  push dword 1

end_mayor_12:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_13
;D:	{
;D:	printf
;D:	2
  mov edx, 2
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	else
  je end_if_else_13
else_13:
;D:	{
;D:	printf
;D:	6
  mov edx, 6
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
end_if_else_13:
;R51:	<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	if
end_if_11:
;R50:	<condicional> ::= if ( <exp> ) { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	x
;D:	<
  push dword _x
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jl menor_14
  push dword 0
  jmp end_menor_14

menor_14:
  push dword 1

end_menor_14:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	y
;D:	<
  push dword _y
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jl menor_15
  push dword 0
  jmp end_menor_15

menor_15:
  push dword 1

end_menor_15:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
  pop dword edx
  pop dword eax
  and eax, edx
  push dword eax
;R77:	<exp> ::= <exp> && <exp> 
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_16
;D:	{
;D:	if
;D:	(
;D:	(
;D:	z
;D:	>
  push dword _z
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_17
  push dword 0
  jmp end_mayor_17

mayor_17:
  push dword 1

end_mayor_17:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_18
;D:	{
;D:	printf
;D:	3
  mov edx, 3
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	else
  je end_if_else_18
else_18:
;D:	{
;D:	printf
;D:	7
  mov edx, 7
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
end_if_else_18:
;R51:	<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	if
end_if_16:
;R50:	<condicional> ::= if ( <exp> ) { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	(
;D:	(
;D:	x
;D:	>
  push dword _x
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_19
  push dword 0
  jmp end_mayor_19

mayor_19:
  push dword 1

end_mayor_19:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	&&
;D:	(
;D:	y
;D:	<
  push dword _y
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jl menor_20
  push dword 0
  jmp end_menor_20

menor_20:
  push dword 1

end_menor_20:
;R97:	<comparacion> ::= <exp> < <exp>
;R83:	<exp> ::= ( <comparacion> )
  pop dword edx
  pop dword eax
  and eax, edx
  push dword eax
;R77:	<exp> ::= <exp> && <exp> 
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_21
;D:	{
;D:	if
;D:	(
;D:	(
;D:	z
;D:	>
  push dword _z
;R80:	<exp> ::= <identificador>
;D:	0
  mov edx, 0
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	)
  pop dword edx
  pop dword eax
  mov dword eax, [eax]
  cmp eax, edx
  jg mayor_22
  push dword 0
  jmp end_mayor_22

mayor_22:
  push dword 1

end_mayor_22:
;R98:	<comparacion> ::= <exp> > <exp>
;R83:	<exp> ::= ( <comparacion> )
;D:	)
  pop dword eax
  cmp eax, 0
  je end_if_23
;D:	{
;D:	printf
;D:	4
  mov edx, 4
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	else
  je end_if_else_23
else_23:
;D:	{
;D:	printf
;D:	8
  mov edx, 8
  push dword edx
;R104:	<constante_entera> ::= TOK_CONSTANTE_ENTERA
;R100:	<constante> ::= <constante_entera>
;R81:	<exp> ::= <constante>
;D:	;
  call print_int
  call print_endofline
  add esp, 4
;R56:	<escritura> ::= printf <exp>
;R36:	<sentencia_simple> ::= <escritura>
;R32:	<sentencia> ::= <sentencia_simple> ;
;D:	}
;R30:	<sentencias> ::= <sentencia>
end_if_else_23:
;R51:	<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;D:	}
end_if_21:
;R50:	<condicional> ::= if ( <exp> ) { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
end_if_else_3:
;R51:	<condicional> ::= if ( <exp> ) { <sentencias> } else { <sentencias> }
;R40:	<bloque> ::= <condicional>
;R33:	<sentencia> ::= <bloque>
;D:	}
;R30:	<sentencias> ::= <sentencia>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R31:	<sentencias> ::= <sentencia> <sentencias>
;R1:	<programa> ::= main { <declaraciones> <funciones> <sentencias> }  jmp near fin

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
