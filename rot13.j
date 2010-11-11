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

.method rot13int
.args 2
	iload 1
	bipush 13
	isub
	iflt lower

	iload 1
	bipush 13
	isub
	ireturn

lower:
	iload 1
	bipush 13
	iadd
	ireturn

.method rot13
.args 2
	// check c < 'A'
	iload 1
	dup
	bipush 65 // 'A'
	isub
	iflt post_uppercase

	// check 'Z' < c
	dup
	bipush 26+65 // letters in alphabet
	swap
	isub
	iflt post_uppercase

	bipush 42 // objref
	swap
	bipush 65
	isub
	invokevirtual rot13int
	bipush 65
	iadd
	ireturn

post_uppercase:
	// check c < 'a'
	iload 1
	dup
	bipush 97 // 'a'
	isub
	iflt post_lowercase

	// check 'z' < c
	dup
	bipush 26+97 // letters in alphabet
	swap
	isub
	iflt post_lowercase

	bipush 42 // objref
	swap
	bipush 97
	isub
	invokevirtual rot13int
	bipush 97
	iadd
	ireturn

post_lowercase:
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

	bipush 42 // objref
	iload char
	invokevirtual rot13
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
