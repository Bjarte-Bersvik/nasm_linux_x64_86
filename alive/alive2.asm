section .data

	msg1		db		"Witaj świecie!", 0
	msg2		db		"Żyję i mam się dobrze!", 0
	radius		dd		357
	pi			dq		3.14

	fmtstr		db 		"%s", 10, 0	; format do wypisywania łańcucha
	fmtflt		db		"%lf", 10, 0
	fmtint		db		"%d", 10, 0 

section .bss
section .text

extern printf

	global main

main:
	push	rbp
	mov		rbp, rsp

	mov		rax, 0 ; to nie liczba zmiennoprzecinkowa
	mov		rdi, fmtstr
	mov		rsi, msg1
	call	printf

	mov		rax, 0
	mov		rdi, fmtstr
	mov		rsi, msg2
	call	printf

	mov		rax, 0
	mov		rdi, fmtint
	mov		rsi, [radius]
	call	printf

	mov		rax, 1 ; zmiennoprzecinkowa
	movq	xmm0, [pi] 
	mov 	rdi, fmtflt
	call	printf

	mov	rsp, rbp
	pop		rbp
ret
