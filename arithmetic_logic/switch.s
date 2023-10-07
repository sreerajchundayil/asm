.section .text
.global _start

.L1:
  movl $1, %edi
  movl $60, %eax
  jmp .L4
.L2:
  movl $2, %edi
  movl $60, %eax
  jmp .L4
.L3: #default case
  movl $3, %edi
  movl $60, %eax
  jmp .L4
.L4:
  syscall
  ret

_start:
  movq $2, %rsi 
  cmpq $100, %rsi
  ja .L3
  jmp *.L0(,%rsi,4)

.section .rodata
  .align 16
.L0:
  .long .L3
  .long .L1
  .long .L2


#The disassembled section is follows
#Will note down how the jump tables are working.

#a.out:     file format elf64-x86-64
#
#
#Disassembly of section .text:
#
#0000000000401000 <_start-0x27>:
#  401000:	bf 01 00 00 00       	mov    $0x1,%edi #.L1
#  401005:	b8 3c 00 00 00       	mov    $0x3c,%eax
#  40100a:	eb 18                	jmp    401024 <_start-0x3> #calling syscall or .L4
#  40100c:	bf 02 00 00 00       	mov    $0x2,%edi #.L2
#  401011:	b8 3c 00 00 00       	mov    $0x3c,%eax
#  401016:	eb 0c                	jmp    401024 <_start-0x3> #calling syscall or .L4
#  401018:	bf 03 00 00 00       	mov    $0x3,%edi #.L3
#  40101d:	b8 3c 00 00 00       	mov    $0x3c,%eax
#  401022:	eb 00                	jmp    401024 <_start-0x3> #calling syscall or .L4
#  401024:	0f 05                	syscall 
#  401026:	c3                   	ret    
#
#0000000000401027 <_start>:
#  401027:	48 c7 c6 02 00 00 00 	mov    $0x2,%rsi
#  40102e:	48 83 fe 64          	cmp    $0x64,%rsi
#  401032:	77 e4                	ja     401018 <_start-0xf>
#  401034:	ff 24 b5 00 20 40 00 	jmp    *0x402000(,%rsi,4)
#
#Disassembly of section .rodata:
#
#Here the jump tables are read as address from a multiple of 4 bytes due to .long
#The addresses are 402000-->402003 = 18 10 40 00 in reverse order = 0x00401018 = .L3
#The addresses are 402004-->402007 = 00 10 40 00 in reverse order = 0x00401000 = .L1
#The addresses are 402008-->40200a = 0c 10 40 in reverse order = 0x0040100c = .L2, last 1 byte is ignored.
#0000000000402000 <__bss_start-0x100c>:
#  402000:	18 10                	sbb    %dl,(%rax)
#  402002:	40 00 00             	rex add %al,(%rax)
#  402005:	10 40 00             	adc    %al,0x0(%rax)
#  402008:	0c 10                	or     $0x10,%al
#  40200a:	40                   	rex
#	...

#buf if you make .quad instead of .long the jump table size has changed to different size
#Just made all the jump addresses to 8byte addresses.

#The previous 4 byte addresses 402000-->402003 changed to 8 byte addresses 402000-->402007 due to .quad 
#The previous 4 byte addresses 402004-->402007 changed to 8 byte addresses 402008-->40200E due to .quad 
#The previous 4 byte addresses 402008-->40200a changed to 8 byte addresses 402010-->402016 due to .quad , last 1 byte is ignored.
#0000000000402000 <__bss_start-0x1000>:
#  402000:	18 10                	sbb    %dl,(%rax)
#  402002:	40 00 00             	rex add %al,(%rax)
#  402005:	00 00                	add    %al,(%rax)
#  402007:	00 00                	add    %al,(%rax)
#  402009:	10 40 00             	adc    %al,0x0(%rax)
#  40200c:	00 00                	add    %al,(%rax)
#  40200e:	00 00                	add    %al,(%rax)
#  402010:	0c 10                	or     $0x10,%al
#  402012:	40 00 00             	rex add %al,(%rax)
#  402015:	00 00                	add    %al,(%rax)
#	...

