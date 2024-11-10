global main
extern printf

%include "vec3.asm"

section .data

text: db "%f",10,0

main.a:
  dq 12.0, 16.0, 20.0

main.b:
  dq 4.0, 4.0, 4.0

section .text

main:
  push rbp
  mov rbp, rsp

  lea rdi, [rel main.a]
;  lea rsi, [rel main.b]
  call vec3_len


  lea rdi, [rel text]
  call printf wrt ..plt

  pop rbp
  ret
