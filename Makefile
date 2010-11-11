all: rot13.bc

rot13.bc: rot13.j
	ijvm-asm rot13.j|sed -re 's/(bb (15 01 )?b6 )00/\180/g' > rot13.bc

clean:
	rm rot13.bc
