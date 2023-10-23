extern printf
section .text
  global _start
_start:
        movsd xmm0, qword [f] 
        mov rax,1
        mov rdi, string
        call printf
        mov eax,60
        xor rdi, rdi
        syscall

section .data
  string db `%f\n`,0
  f dq 1.0


