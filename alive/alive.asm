extern printf

section .data
	msg		db "Witaj, świecie", 0
	fmtstr	db "To jest nasz łańcuch: %s, ", 10, 0 ; printf
	
section .bss
section .text

global main

main:
	push	rbp
	mov		rbp, rsp

	mov		rdi, fmtstr ; pierwszy argument printf czyli string printf("string")
	mov		rsi, msg	; drugi arg printf("string", dane);
	mov		rax, 0		; nie używam rejestrów xmm
	call	printf

	mov		rsp, rbp
	pop		rbp
	
	mov rax, 60
	mov rdi, 0
	syscall
