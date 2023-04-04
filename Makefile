asm: asm.s
	as asm.s -o output.o
	ld output.o -o output1
	rm output.o

gcc: gcc.s
	gcc gcc.s -o output2

main: main.c
	gcc -S main.c

