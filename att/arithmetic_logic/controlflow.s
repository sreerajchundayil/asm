.section .text
  .global _start

conditionalFlags:
  #underflow -ve numbers and sum became +ve
  #(t = a + b)
  #OF = (a<0 == b<0) & ( (t<0) != (a < 0))
  #signed calc
  # a = 1000 0000  -ve
  # b = 1111 1111  -ve
  # t = 0111 1111 +ve

  #unsigned calc
  #CF = (unsigned) t < (unsigned) b
  # a = 1000 0000  +ve
  # b = 1111 1111  +ve
  # t = 0111 1111  +ve but a carry = 1, unsigned overflow 

  movb $0x80,  %dl #sign bit = 1, -ve
  movb $0xFF,  %al
  addb %al,%dl  #dl = 0x7f --> sign bit = 0, +ve

  movb $0x80,  %dl
  movb $0x80,  %al
  subb %al,%dl #ZF = 1, as output is zero
  
  movb $0x80,  %dl
  movb $0x00,  %al
  addb %al,%dl  #SF = 1
  ret


Compare:
  #Both are equal
  #CF = 0, ZF = 1
  movb $2,  %dl
  movb $2,  %al
  cmpb %al, %dl
  sete %cl #cl is 1
  movzbl %cl, %ecx
  xor %cl, %cl
 
  #A-B (1-2)
  #CF = 1, ZF = 0
  movb $1,  %dl
  movb $2,  %al
  cmpb %al, %dl
  setl %cl #cl is 1
  movzbl %cl, %ecx
  xor %cl, %cl
 
  #A-B (2-1)
  #CF = 0, ZF = 0
  movb $2,  %dl
  movb $1,  %al
  cmpb %al, %dl
  setg %cl #cl is 1
  movzbl %cl, %ecx
  xor %cl, %cl

  ret
  

_start:

  call conditionalFlags
  call Compare

  xorl %eax, %eax

  movl $60, %eax
  movl $10, %edi
  syscall
  ret
  
