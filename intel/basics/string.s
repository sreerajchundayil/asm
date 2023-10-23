section .data
  source db "Hello World\n",0
  src_len EQU $-source
  

section .bss
  destination resb 20
section .text

global _start

_start:

  mov rcx, src_len
  mov rsi, source
  mov rdi, destination
  cld ;reset diretion flag to 0
  rep movsb ; for 64bit mode move byte from rsi to rdi, with rep, rcx is used.
  mov r8, destination
  mov r9, src_len
  jmp _printToScreen
return:
  xor rdi, rdi
  mov rax, 0x3c
  syscall
  ret

_printToScreen:
  mov rsi, r8; string to print
  mov rdx, r9; length to print
  dec rdx    ; exclude null char be decrementing 1
  mov rax, 1 ; write
  mov rdi, 1 ; stdout
  syscall
  jmp return
  
