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
	bipush 1
	iadd
	ifeq endwhile // eof

	dup
	bipush 4
	isub
	ifeq endwhile // ^D

	invokevirtual fputc
	pop // disregard return value from fputc
	bipush 1
	iadd
	goto while
endwhile:
	pop // remove read character
	pop // remove fputc objref
	ireturn
