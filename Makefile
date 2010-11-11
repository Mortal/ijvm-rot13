stdinout.bc: stdinout.j
	ijvm-asm stdinout.j|sed -re 's/(bb (15 01 )?b6 )00/\180/g' > stdinout.bc
