.section .text
  .global _start

_start:
 #single precision registers
  #movss -- mov scalar single precision floating point value, 32 bits.
  #XMM regists after move bits 127:32 of destination is cleared to all 0s.
  #YMM part of 255:128 are remain unchanged.
  movss .LC0(%rip), %xmm0
  #movsd same as above, but 64 bits.
  vunpcklps %xmm0, %xmm0, %xmm1  #interleaves values
  movq $10, %rdi
  movq $60, %rax
  ret

.LC0:
  .long 1065353216 
