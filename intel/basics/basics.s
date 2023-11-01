section .text
  global _start


_start:
  movzx rdi, byte[var1] ;zero extension
  movzx rsi, word[var3] ;zero extension

  movsx rdx, byte[var1] ;sign extension
  movsx rsi, word[var3] ;zero extension

  ;Couldn't find the above statement with dword

  ;alternate approach, since these are registers no need to put the xword key
  mov al, 0xFF
  movzx ax, al
  mov al, 0xFF
  movsx ax, al
  
  mov eax, 0x0
  lahf; load EFLAGS lower byte to ah
  mov [var2], ah; store ah to uninitialzed area

  mov eax, 0x0
  mov ah, 0xFF ; This doesn't work as expected in 64 bit mode as the flags are not sequential
  sahf         ; saves the SF, ZF, AF, PF, and CF flags of the EFLAGS register with values from the corresponding bits in the AH register (bits 7, 6, 4, 2, and 0, respectively).


  mov ah, 0x00 ;
  lahf         ; Loads the SF, ZF, AF, PF, and CF flags of the EFLAGS register with values from the corresponding bits in the AH register (bits 7, 6, 4, 2, and 0, respectively). 


  mov eax, 0x12345678
  mov rax, [var3]; copies 8 bytes, so 0x82 in lower bytes and rest of the data comes
  mov rcx, [var3+1]; copies 8 bytes from next byte



  mov ecx, 0xFFFFFFFE
  inc ecx
  inc ecx
  
  mov ecx, 0x80000000
  dec ecx

  mov rax, 60
  syscall


section .data
  var0 dq 0x1111111111111111
  var1 db 0x81
  var3 db 0x82
  var4 db 0x83
  var5 dq 0x1122334455667700

section .bss
  var2 db ?
  
