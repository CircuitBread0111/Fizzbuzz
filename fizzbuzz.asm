section .text
	default rel
	extern printf
	extern putchar
	global main

main:
	; Create stack frame
	push rbp
	mov rbp, rsp

	; rbx must be preserved between calls
	push rbx

	; stack must be on a 16-byte boundary, so put some extra space there
	sub rsp, 8

	; initialize loop
	mov ebx, 1
loop:
	; test for Fizz
	xor edx, edx
	mov eax, ebx
	mov ecx, 3
	div ecx
	test edx, edx
	jz fizz

	; test for Buzz
	xor edx, edx
	mov eax, ebx
	mov ecx, 5
	div ecx
	test edx, edx
	jz buzz

num:
	; neither Fizz nor Buzz
	mov rdi, num_fmt
	mov esi, ebx
	xor rax, rax
	call printf wrt ..plt
	jmp loop_inc

fizz:
	mov rdi, fizz_str
	xor rax, rax
	call printf wrt ..plt

	; check if we still need Buzz
	xor edx, edx
	mov eax, ebx
	mov ecx, 5
	div ecx
	test edx, edx
	jnz loop_inc

buzz:
	mov rdi, buzz_str
	xor rax, rax
	call printf wrt ..plt

loop_inc:
	inc ebx
	mov rdi, 10
	call putchar wrt ..plt
	cmp ebx, 100
	jng loop

loop_end:
	; restore rbx and return
	xor eax, eax
	mov rbx, [rbp-8]
	mov rsp, rbp
	pop rbp
	ret

section .rodata
fizz_str: db "Fizz",0
buzz_str: db "Buzz",0
num_fmt: db "%d",0
