.section .text
	.global _start

_start:
	movq $60, %rax
	movq $100, %rdi
	syscall
	ret
