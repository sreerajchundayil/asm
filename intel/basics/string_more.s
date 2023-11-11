section .text


global _start


_start:
  cld
  mov rsi, source
  mov rdi, destination
  mov rcx, len
  rep movsb
  sub rdi, len
  mov al, BYTE[rdi]

  repe cmpsd 
  

  std
  mov rsi, source
  mov rdi, destination
  add rdi, len
  mov rcx, len
  rep movsb
  add rdi, len
  mov al, BYTE[rdi]

  cld
  mov ecx, len1
  mov rsi, source
  mov rdi, source1
  repz cmpsb
  ja L1
  jna L2


L1:
  mov rdi, 10
  jmp L3
L2:
  mov rdi, 11

L3:
  mov eax, 60
  syscall
  ret


section .data
  source db  "ABCDEFG",0
  len EQU $-source
  source1 db "ABCEEFG",0
  len1 EQU $-source
  
section .bss
  destination resb 20
