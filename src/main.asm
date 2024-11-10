global main
extern printf

%include "vec3.asm"

%macro print_number 1
  push rdi
  push rax
  lea rdi, [rel number]
  mov rsi, %1
  call printf wrt ..plt
  pop rax
  pop rdi
%endmacro

section .data

align 16
image_width dd 256
image_height dd 256

header db "P3",10,"%d %d",10,"256",10,0
pixel db "%d %d %d",10,0

number db "%d",10,0

const_0 dq 1
const_255_999 dq 255.999 

align 16
test_double: dd 100

section .text

main:
  push rbp
  mov rbp, rsp
  and rsp, -16

  lea rdi, [rel header]
  mov rsi, [rel image_width]
  mov rdx, [rel image_height]
  call printf wrt ..plt

; rdi = j, rsi = i
start_loop:
  sub rsp, 48
  mov dword [rbp - 4], 0 ; j

.j_loop:
  mov eax, [rbp - 4]
  cmp eax, [rel image_height]
  jge .j_loop_end

  mov dword [rbp - 8], 0 ; i

  .i_loop:
    mov eax, dword [rbp-8]
    cmp eax, [rel image_width]
    jge .i_loop_end

    ; r=[rbp-16],g=[rbp-24],b=[rbp-32]

; set up numbers
    cvtsi2sd xmm0, dword [rbp-8]
    mov eax, [rel image_width]
    sub eax, 1
    cvtsi2sd xmm1, eax
    divsd xmm0, xmm1
    movsd [rbp-16], xmm0

    cvtsi2sd xmm0, dword [rbp-4]
    mov eax, [rel image_height]
    sub eax, 1
    cvtsi2sd xmm1, eax
    divsd xmm0, xmm1
    movsd [rbp-24], xmm0

    movsd xmm0, [rel const_0]
    movsd [rbp-32], xmm0

; convert float to int

    movsd xmm0, [rel const_255_999]
    movsd xmm1, [rbp-16]
    mulsd xmm0, xmm1
    cvtsd2si rsi, xmm0

    movsd xmm0, [rel const_255_999]
    movsd xmm1, [rbp-24]
    mulsd xmm0, xmm1
    cvtsd2si rdx, xmm0

    movsd xmm0, [rel const_255_999]
    movsd xmm1, [rbp-32]
    mulsd xmm0, xmm1
    cvtsd2si rcx, xmm0

    call print_pixel

    mov eax, [rbp-8]
    add eax, 1
    mov [rbp-8], eax
    jmp .i_loop
  .i_loop_end:
 
  mov eax, [rbp-4]
  add eax, 1
  mov [rbp-4], eax
  jmp .j_loop

.j_loop_end:
  add rsp, 32
  leave
  ret


print_pixel: ; void print_pixel(double, double, double)
  push rbp
  mov rbp, rsp
  and rsp, -16
  
  lea rdi, [rel pixel]
  call printf wrt ..plt

  leave
  ret
