extern printf

section .data
	numbers 		db 	"1234567890", 0
	numLen			equ	$ - numbers -1

	before			db  "Before", 0
	after			db 	"After", 0
	
	fmt				db 	"%s : %s", 10, 0
	
section .bss

section .text
	global main

main:
	push	rbp
	mov		rbp, rsp

	; before push
	lea		rdi, [fmt]
	lea		rsi, [before]
	lea		rdx, [numbers]
	mov		rax, 0
	call	printf


	xor		rax, rax
	xor		rbx, rbx
	xor		rcx, rcx
	xor		r12, r12

	lea		rbx, [numbers]
	mov		rcx, numLen


	pushLoop:
		mov		al, byte [rbx+r12]
		push 	rax
		inc		r12
		loop	pushLoop

	xor		rbx, rbx
	xor		r12, r12
	xor		rax, rax
	mov		rcx, numLen
	lea		rbx, [numbers]

	popLoop:
		pop 	rax
		mov		byte [rbx + r12], al
		inc		r12
		loop	popLoop

	mov		byte [rbx + r12], 0 ; konczymy znakiem null \0

	; after pop
	lea		rdi, [fmt]
	lea		rsi, [after]
	lea		rdx, [numbers]
	mov		rax, 0
	call	printf

	mov		rsp, rbp
	pop		rbp
	ret
