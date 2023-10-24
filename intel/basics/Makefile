float_main_func:	float_main_func.s
	nasm -felf64 $<; gcc -no-pie  float_main_func.o

float: float.s
	nasm -felf64 $<; gcc -no-pie -nostartfiles float.o
