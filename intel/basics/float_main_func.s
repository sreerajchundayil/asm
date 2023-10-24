extern printf
section .text
  global main
main:
        movsd xmm0, qword [f] 
        mov rax,1
        mov rdi, string
        sub rsp, 8
        call printf
        add rsp, 8
        mov eax,60
        xor rdi, rdi
        syscall

section .data
  string db `%f\n`,0
  f dq 1.0


