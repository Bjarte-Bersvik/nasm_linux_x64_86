section .data
	bNum		db		123
	wNum		dw		12345
	warray		times	5 dw 0
	dNum		dd		12345
	qNum1		dq		12345
	text1		db		"abcdefghijklmnopqrst", 0
	qNum2		dq		3.141592654
	text2		db		"ABCDEFG", 0

section .bss
	bvar		resb	1
	dvar		resd	1
	wvar		resw	10
	qvar		resq	30000

section .text
	global main

main:
	push	rbp
	mov		rbp, rsp

	xor		rax, rax
	xor		rbx, rbx
	xor		rcx, rcx
	xor		rdx, rdx
	xor		rdi, rdi
	xor		rsi, rsi
	xor		r8, r8
	xor		r9, r9
	xor		r10, r10
	
	lea		rax, [bNum] ; adres
	mov		rax, bNum   ; adres
	xor		rax, rax
	mov		al, [bNum] ; zawartosc
	mov		[bvar], al ; do bvar wczytaj zawartosc spod rax

	lea		rax, [wNum]  ; adres
	mov		rax, [wNum]  ; zawartosc
	lea		rax, [text1] ; adres
	mov		rax, text1   ; adres
	mov		rax, text1+1 ; wczytaj adres drugiego znaku do rax
	lea		rax, [text1+1] ; wczytaj; adres drugiego znaku do rax

	



	mov		rsp, rbp
	pop		rbp
	ret
