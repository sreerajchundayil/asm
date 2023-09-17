.section .text
	.global _start
_start:
    xorq %rdx, %rdx
    movabsq $-1, %rdx #set all 64 bits to 1
    movb $-1, %dl #rewrite lower order 1 byte, no changes to upper bytes
    movw $-1, %dx #rewrite lower order 2 byte, no changes to upper bytes
    movl $-1, %edx #rewrite lower order 4 byte, upper bytes are changed to 0  --> important
    movq $-1, %rdx #rewrite all 8 bytes


    xorq %rdx, %rdx
    movabsq $-1, %rdx #set all 64 bits to 1
    movq $1, %rdx
   
    #Just return value 
    movq $0x64, %rdi
	  movq $60, %rax
    syscall
	ret
