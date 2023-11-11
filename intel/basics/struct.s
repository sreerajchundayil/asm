section .data

struc MyStruct 
  mybyte1 resb 1
  myword1 resw 1
endstruc

myStruct istruc MyStruct 
  at mybyte1, db 34
  at myword1, dw 0x0004
iend



section .text
  global _start

_start:

  xor rdi, rdi
  mov dil, BYTE[myStruct + mybyte1]
  mov di, [myStruct + myword1]
  mov WORD[myStruct + myword1], 10
  mov di, [myStruct + myword1]
  mov eax, 60
  syscall
