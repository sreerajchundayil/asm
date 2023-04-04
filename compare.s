.section .text
	.global main

main:
	movl $20, %edx
	movl $20, %esi
    xorq %rdi, %rdi
    movl $1001, %eax
	cmpl %edx, %esi
    je .L2

.L1:
    movl $2001, %eax
.L2:
	;Only lower order 1 byte will printed as return value as 
    ;0xFF is the max value returned by exit call as per man page.
	ret
