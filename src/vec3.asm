global vec3_init
global vec3_sub
global vec3_mul
global vec3_div
global vec3_len
global vec3_len_sq

section .data

struc vec3
.r resq 1
.g resq 1
.b resq 1
endstruc

section .text

vec3_init: ; void vec3_init(vec3* $rdi)
  push rbp
  mov rbp, rsp

  mov rax, rdi
  xorps xmm0, xmm0
  movsd [rax+vec3.r], xmm0
  movsd [rax+vec3.g], xmm0
  movsd [rax+vec3.b], xmm0

  pop rbp
  ret

vec3_sub: ; void vec3_sub(vec3*, const vec3*)
  push rbp
  mov rbp, rsp

  movupd xmm0, [rdi]
  movupd xmm1, [rsi]
  subpd xmm0, xmm1
  movupd [rdi], xmm0

  movsd xmm0, [rdi+vec3.b]
  subsd xmm0, [rsi+vec3.b]
  movsd [rdi+vec3.b], xmm0

  pop rbp
  ret

vec3_mul: ; void vec3_mul(vec3*, const vec3*)
  push rbp
  mov rbp, rsp

  movupd xmm0, [rdi]
  movupd xmm1, [rsi]
  mulpd xmm0, xmm1
  movupd [rdi], xmm0

  movsd xmm0, [rdi+vec3.b]
  mulsd xmm0, [rsi+vec3.b]
  movsd [rdi+vec3.b], xmm0

  pop rbp
  ret

vec3_div: ; void vec3_div(vec3*, const vec3*)
  push rbp
  mov rbp, rsp

  movupd xmm0, [rdi]
  movupd xmm1, [rsi]
  divpd xmm0, xmm1
  movupd [rdi], xmm0

  movsd xmm0, [rdi+vec3.b]
  divsd xmm0, [rsi+vec3.b]
  movsd [rdi+vec3.b], xmm0

  pop rbp
  ret

vec3_len: ; double vec3_len(const vec3*)
  push rbp
  mov rbp, rsp

  call vec3_len_sq

  sqrtsd xmm1, xmm0
  movsd xmm0, xmm1

  pop rbp
  ret

vec3_len_sq: ; double vec3_len_sq(const vec3*)
  push rbp
  mov rbp, rsp

  movupd xmm0, [rdi+vec3.r]
  movupd xmm1, [rdi+vec3.g]
  movupd xmm2, [rdi+vec3.b]
  mulsd xmm0,xmm0
  mulsd xmm1,xmm1
  mulsd xmm2,xmm2

  addsd xmm0, xmm1
  addsd xmm0, xmm2

  pop rbp
  ret
