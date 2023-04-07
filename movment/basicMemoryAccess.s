.section .text
	.global _start
_start:
	movq %rsp, %rbp
	subq $200, %rsp
	movl $0x01020304, -10(%rbp)
	movl $0x11121314, -14(%rbp)
	movq $40, %rcx
    xorq %rdi, %rdi
	movb -14(%rbp), %dil
    movq $60, %rax
	syscall
	ret
