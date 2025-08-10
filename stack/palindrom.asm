extern printf


section .data
	string1		db		"ANNA", 0
	string2		db		"ALA", 0
	string3		db		"SEDES", 0
	string4		db		"RADAR", 0
	string5		db		"KROWxyWORK", 0
	fmt			db		"String: %s | ma dlugosc: %ld", 10, 0

	fmtIs		db		"String: %s | to palindrom", 10, 0
	fmtIsNot	db		"String: %s | to nie palindrom", 10, 0
	

section .bss
			

section .text
	global	main
	

; =====================================================================
main:
	push	rbp
	mov		rbp, rsp

	lea		r12, [string5]
	push	r12

	mov		rdi, r12
	call	countStrLen

	mov		r13, rax ; przenosze obliczona dlugosc stringa
	
	mov		rdi, fmt
	mov		rsi, r12
	mov		rdx, rax
	mov		rax, 0
	call	printf

	mov		rdi, r12  ; string
	mov		rsi, r13 	; max length
	call	verifyIsPalindrome

	pop 	r12

	cmp		rax, 1
	je 		is_palindrome
	jne		is_not_palindrome

	
	is_not_palindrome:
		mov		rdi, fmtIsNot
		mov		rsi, r12
		mov		rax, 0
		call	printf
		mov		rsp, rbp
		pop		rbp
		ret
	
	is_palindrome:
		mov		rdi, fmtIs
		mov		rsi, r12
		mov		rax, 0
		call	printf
	
		mov		rsp, rbp
		pop		rbp
		ret

; =====================================================================
verifyIsPalindrome:
	push	rbp
	mov		rbp, rsp

	xor		rdx, rdx
	xor		rbx, rbx
	xor		rcx, rcx
	xor		rdx, rdx
	xor		r13, r13 
	xor		r12, r12   	; front index
	
	mov		rcx, rsi 	; max length
	mov		r13, rsi 	; back index

	loopPalindrome:
		mov		dl, byte [rdi + r12]
		mov		bl, byte [rdi + r13 -1]
		
		cmp		dl, bl
		jne		_return_false

		inc		r12 	; index od poczatku
		dec		r13 	; index od konca
		dec		rcx 
		cmp		rcx, 0
		jne 	loopPalindrome

	jmp	_return_true

	_return_false:
		mov		rax, 0
		mov		rsp, rbp
		pop		rbp
		ret
	
	_return_true:
		mov		rax, 1
		mov		rsp, rbp
		pop		rbp
		ret

; =====================================================================
countStrLen:
	push	rbp
	mov		rbp, rsp

	xor		rax, rax
	xor		rbx, rbx
	xor		rcx, rcx
		
	mov		bl, byte [rdi+rcx]

	cmp		bl, 0 ; jesli przed petla jest to znak null 
	jne		loopCount
	je 		_exit
			
	loopCount:
		mov		bl, byte [rdi + rcx]
		inc		rcx
		cmp		bl, 0 ; czy jest rowny znakowi null
		jne		loopCount

	_exit:	
		dec		rcx 	; -1 bez znaku null !!!
		mov		rax, rcx
		mov		rsp, rbp
		pop		rbp
		ret   		
; =====================================================================
