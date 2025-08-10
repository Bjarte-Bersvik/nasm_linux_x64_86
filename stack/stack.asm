extern printf
section .data

	strng		db		"ABCDEF", 0
	strLen		equ		$ - strng -1
	fmt1		db		"Pierwotny łańcuch:  %s", 10, 0
	fmt2		db		"Odwrócony łańcuch:  %s", 10, 0

section .bss
section .text
	global	 main

main:
	push	rbp
	mov		rbp, rsp

	lea		rdi, [fmt1]
	lea		rsi, [strng]
	mov		rax, 0
	call	printf

	xor		rax, rax
	lea		rbx, [strng] 	; adres strng
	mov		rcx, strLen		; długość
	mov		r12, 0			; indeks - wskaźnik

	pushLoop:
		mov		al, byte [strng+r12]
		push 	rax
		inc		r12
		loop	pushLoop

	; zdejmujemy łańcuch ze stosu znak po znaku
	; Spowoduje odwrócenie pierwotnego łańcucha

	lea		rbx, [strng]
	mov		rcx, strLen
	mov		r12, 0
	popLoop:
		pop 	rax
		mov		byte [rbx+r12], al
		inc		r12
		loop	popLoop

		mov		byte [rbx+r12], 0 ; kończymy znak łańcuchem 0 (null \0)

	lea		rdi, [fmt2]
	lea		rsi, [strng]
	mov		rax, 0
	call 	printf

	mov		rsp, rbp
	pop 	rbp
	ret
	
