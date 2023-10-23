section .data
  size EQU 14
  ;size EQU 20;Error - redefinition not allowd
  %assign total 21
  %assign total 22 ; redefinition allowed
  %define count 31
  %define count 32 ; redefinition allowed
  %define x(a,b) a+b ;You can have a string macro as well
  msg db 'Hello, World!', 0xA ; string constant
  msglen EQU $-msg 

section .text
  global _start

_start:
  mov rax, 60
  mov rdi, size
  mov rdi, count
  mov rdi, msglen
  mov rdi, x(1,2)
  syscall
  ret
