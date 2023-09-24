.section .text
  .global _start

.L_Sign:
  ret

.L_NotSign:
  ret

.L_Zero:
  ret

.L_NotZero:
  ret

Test1_zero:
  #10 --> 0000 1010
  #20 --> 0001 0100
  movb $10, %al
  movb $20, %ah
  test %al, %ah
  js  .L_Sign #Won't got to this.
  
  #10 --> 0000 1010
  #20 --> 0001 0100
  movb $10, %al
  movb $20, %ah
  test %al, %ah
  jz .L_Zero #Hit here

  #Don't execut this as return from .L_zero gets back to next call in _start
  #10 --> 0000 1010
  #20 --> 0001 0100
  movb $10, %al
  movb $20, %ah
  test %al, %ah
  jnz .L_NotZero
  ret

Test1_nonzero:
  #10 --> 0000 1010
  #28 --> 0001 1100
  movb $10, %al
  movb $28, %ah
  test %al, %ah
  jz  .L_Zero #Not executing
  
  movb $10, %al
  movb $28, %ah
  test %al, %ah
  jnz  .L_NotZero #executing
  
  ret


Test1_Sign:
  #138 --> 1000 1010
  #156 --> 1001 1100
  movb $0x8A, %al
  movb $0x9C, %ah
  test %al, %ah
  jns  .L_NotSign #Not executing
  
  movb $0x8A, %al
  movb $0x9C, %ah
  test %al, %ah
  js  .L_Sign #Execute
  ret

_start:

  call Test1_zero
  call Test1_nonzero
  call Test1_Sign
  
  movl $60, %eax
  movl $10, %edi
  syscall
  ret
