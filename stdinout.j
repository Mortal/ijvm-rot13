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

.method iseof // return 0 if character is EOF
.args 2
	iload 1
	bipush -1
	if_icmpeq yes // eof

	iload 1
	bipush 4
	if_icmpeq yes // ^D
	
	bipush 1
	ireturn

yes:
	bipush 0
	ireturn

.method main
.args 1
.locals 3
.define char = 1
.define offset = 2
.define charcount = 3

	bipush 0
	istore charcount

while:
	bipush 42 // fgetc objref
	invokevirtual fgetc
	istore char

	bipush 42 // objref
	iload char
	invokevirtual iseof
	ifeq endwhile

	// check c < 'A'
	iload char
	bipush 65 // 'A'
	isub
	iflt post_uppercase

	// check 'Z' < c
	bipush 26+65 // letters in alphabet
	iload char
	isub
	iflt post_uppercase

	iload char
	bipush 13+65
	isub
	iflt uppercase_lowerregion

uppercase_upperregion:
	iload char
	bipush 13
	isub
	istore char
	goto post_uppercase

uppercase_lowerregion:
	iload char
	bipush 13
	iadd
	istore char
post_uppercase:

	bipush 42 // objref
	iload char
	invokevirtual fputc
	pop // disregard return value from fputc

	iload charcount
	bipush 1
	iadd
	istore charcount

	goto while
endwhile:

	bipush 42 // objref
	bipush 10
	invokevirtual fputc

	iload charcount
	ireturn

// vim:syn=bytecode:
