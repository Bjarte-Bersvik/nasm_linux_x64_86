section .data
	msg1	db	"Witaj swiecie!", 10, 0
	msgLen 	equ $ - msg1

	msg2	db	"Żyje i mam sie dobrze", 10, 0
	msg2Len equ $ - msg2

	radius	dq	333
	pi		dq	3.14
	
section .bss

section .text
	global main

main:
	push	rbp			; prolog
	mov		rbp, rsp	; prolog

	mov		rax, 1 		; write
	mov		rdi, 1 		; stdout
	mov		rsi, msg1 	; msg1
	mov		rdx, msgLen
	syscall

	mov		rax, 1 		; write
	mov		rdi, 1 		; stdout
	mov		rsi, msg2   ;
	mov     rdx, msg2Len
	syscall 

	mov		rsp, rbp
	pop		rbp

	mov		rax, 60		; exit
	mov		rdi, 0		; success
	syscall 
