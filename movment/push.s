.section .text
  .global _start


pushTest1:
  movl $0x12345678, %eax
  movl $0x11223344, %edx
  subq $4, %rsp
  movl %eax, (%rsp) #always use %rsp, using %esp is partial address. Which is incorrect.
  subq $4, %rsp   #make sure the memory is released for ret to work
  movl %edx, (%rsp)
  movl 4(%rsp), %esi
  movl %edx, (%rsp)
  addq $8, %rsp
  ret


pushTest2:
  movl $0x12345678, %eax
  movl $0x11223344, %edx
  pushq %rax   #64 bit pushq works. There is no pushl in 64 bit. 
  pushq %rdx
  movq 8(%rsp), %rsi
  popq %rcx
  popq %rcx
  ret


_start:
  call pushTest1
  call pushTest2
  movq $0x64, %rdi
	movq $60, %rax
  syscall
  ret
