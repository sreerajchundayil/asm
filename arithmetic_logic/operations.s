.section .text
  .global _start

arithmetic:
  movl $-1, %ecx
  decl %ecx
  xor %rcx,%rcx
  movabsq $1, %rcx
  inc %rcx
  addb $10,%cl
  addb %cl, %cl
  ret
logic:
  xor %rcx,%rcx
  movabsq $1, %rcx
  or $0x02, %ecx
  ret

shift:
  xor %rcx,%rcx
  movabsq $1, %rcx
  sal %rcx
  ret

leacheck:
  xor %rax, %rax
  xor %rcx, %rcx
  xor %rbx, %rbx
  movq $0x112233445566FF11, %rcx
  movq $0x0000000000000011, %rbx
  leaq 9(%rcx, %rbx, 4) , %rax
  ret

multi:
  movabs $-1, %rax
  movl   $0xF, %ecx  
  mulq   %rcx #after multiplication the lower order bits will be stored in %rax and high order in %rcx
  ret 

_start:
  call arithmetic 
  call logic 
  call shift
  call leacheck
  call multi
  
  movl $60, %eax
  movl $10, %edi
  syscall

