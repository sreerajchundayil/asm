.section .text
	.global _start
#.section .text
#	.global main

movx:
    #This section contains all movx commands
    xorq %rdx, %rdx
    movabsq $-1, %rdx #set all 64 bits to 1 due to 0xFFFFFFFFFFFFFFFFF
    movb $-1, %dl #rewrite lower order 1 byte, no changes to upper bytes
    movw $-1, %dx #rewrite lower order 2 byte, no changes to upper bytes
    movl $-1, %edx #rewrite lower order 4 byte, upper bytes are changed to 0  --> important
    movq $-1, %rdx #rewrite all 8 bytes
    ret

justMov:
    mov $0x10, %dh   #This is fine.
    mov $0x1010, %dh #This will get shorted to 0x10 as %dh is 1byte. A warning is given
    ret

zeroExtension:
    #Zero extension, the source has to be memory or register. It can't be immediate value.
    xor %rdx, %rdx
    movabsq $0x0011223344556677, %rdx
    movb    $0xFF, %al
    movzbw  %al, %dx
    ret

signExtension:
    movl $-1, %eax
    movl $0x12345678, %edx
    movsbw %al, %dx
    ret

_start:
    call movx
    call justMov 
    call zeroExtension 
    call signExtension 

   
    #Just return value 
    movq $0x64, %rdi
	  movq $60, %rax
    syscall
	ret
