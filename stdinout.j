.method fgetc
.args 1
	bipush -69
	invokevirtual fgetc
	ireturn

.method fputc
.args 2
	nop
	bipush -69
	iload 1
	invokevirtual fputc
	ireturn

.method main
.args 1
	bipush 0
while:
	bipush 42 // fputc objref

	bipush 42 // fgetc objref
	invokevirtual fgetc

	dup
	bipush -1
	if_icmpeq endwhile // eof

	dup
	bipush 4
	if_icmpeq endwhile // ^D

	dup
	// check c < 'A'
	bipush 65 // 'A'
	isub
	iflt post_uppercase

	dup
	// check 'Z' < c
	bipush 26+65 // letters in alphabet
	swap
	isub
	iflt post_uppercase

	dup
	bipush 13+65
	isub
	dup
	iflt uppercase_lowerregion

uppercase_upperregion:
	bipush 65
	iadd
	goto post_uppercase

uppercase_lowerregion:
	bipush 65+26
	iadd
post_uppercase:

	invokevirtual fputc
	pop // disregard return value from fputc
	bipush 1
	iadd
	goto while
endwhile:
	pop // remove read character
	pop // remove fputc objref
	ireturn

// vim:syn=bytecode:
