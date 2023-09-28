.section .text
  .global _start



_start:
  movl $10, %eax
  movl $20, %ecx
  cmpl %eax, %ecx
  cmovg %ecx, %esi
  movq $10, %rdi
  movq $60, %rax
  syscall
