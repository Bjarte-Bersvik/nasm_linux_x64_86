; xor.asm

extern printf
section .data

	wrd		db 	"To be, or not to be, that is the question.", 0
	wrdLn	equ	$ - wrd - 1

	ky		db 	"Key123451", 0
	kyLn	equ $ - ky - 1
		
	fmt_enc	db 	"[Encrypt]: %s", 10, 0
	fmt_dec db	"[Decrypt]: %s", 10, 0
	
section .bss
section .text

; ----------------
countKeyIndex:
	push rbp
	mov	 rbp, rsp
		
		mov	rax, rdi 	; r12 = i = index wrd
		xor rdx, rdx    ; zerowanie rdx
		mov	rcx, rsi
		div rcx 		; reszta w rdx - rdx reszta to index po ky

		mov	rax, rdx		

	leave 
	ret
; ----------------

	global main
main:
	push	rbp
	mov		rbp, rsp
	
	xor		rax, rax 	; div
	xor		rcx, rcx 	; div
	xor		rdx, rdx 	; div - index key - mod
	xor		r8, r8 	 	; znaki 
	xor		r9, r9   	; znaki
	xor		r12, r12 	; index wrd inc
	
	mov		rbx, wrdLn ; liczba znakow
	
	loopEncrypt:
		mov	 rdi, r12
		mov	 rsi, kyLn
		call countKeyIndex
				
		mov	r8b, byte [wrd + r12]
		mov	r9b, byte [ky + rax]

		xor r8b, r9b
		mov	byte [wrd + r12], r8b

		inc r12
		cmp	r12, rbx ; index < wrdLn
		jl	loopEncrypt		

			
	mov	 rdi, fmt_enc
	mov	 rsi, wrd
	mov	 rax, 0
	call printf


; -- DECRYPT --
	xor		rax, rax ; div
	xor		rcx, rcx ; div
	xor		rdx, rdx ; div - index key - mod
	xor		r8, r8 	 ; znaki 
	xor		r9, r9   ; znaki
	xor		r12, r12 ; index wrd inc
	
	mov		rbx, wrdLn ; liczba znakow
	
	loopDecrypt:
		mov	 rdi, r12
		mov	 rsi, kyLn
		call countKeyIndex
		
		mov	r8b, byte [wrd + r12]
		mov	r9b, byte [ky + rax]

		xor r8b, r9b
		mov	byte [wrd + r12], r8b

		inc r12
		cmp	r12, rbx
		jl	loopDecrypt

	mov	 rdi, fmt_dec
	mov	 rsi, wrd
	mov	 rax, 0
	call printf

	leave
	ret
