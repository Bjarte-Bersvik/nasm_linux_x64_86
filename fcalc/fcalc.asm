; fcalc.asm
extern printf

section .data
	number_int	dq		121
	number1		dq		9
	number2		dq		73
	
	fmt			db		"Liczby to %d i %d", 10, 0
	fmtfloat	db		"%s %d", 10, 0
	fmtint		db		"Calkowita %d do zmiennoprzecinkowej %d pierwiastek to %d", 10, 0
	f_sum		db		"Zmiennoprzecinkowa suma %d i %d to %d", 10, 0
	f_dif		db		"Zmiennoprzecinkowa roznica %d i %d to %d", 10, 0
	f_mul		db		"Zmiennoprzecinkowy iloczyn %d i %d to %d", 10, 0
	f_div		db		"Zmiennoprzecinkowy iloraz %d i %d to %d", 10, 0
	f_sqrt		db		"Pierwiastek kwadratowy z %d to %d", 10, 0

section .bss
section .text
	global	main

main:
;	push		rbp
	mov			rbp, rsp

	; wypisujemy liczby
	mov 		rdi, fmt
	mov			rsi, [number1]
	mov			rdx, [number2]
	mov 		rax, 0 ; dwie wartosci zmiennoprzecinkowe
	call		printf

	mov 		rsp, rbp
;	pop			rbp
	ret
	; suma	
	;movsd		xmm2, [number1] ; 
	;addsd 		xmm2, [number2] ; dodajemy do xmm

		; wypisujemy wynik
		;movsd 	xmm0, [number1]
		;movsd   xmm1, [number2]
		;mov     rdi, f_sum
		;mov     rax, 3 ; trzy wartosci zmiennoprzecinkowe
		;call    printf

	;movsd		xmm2, [number1]
	;subsd		xmm2, [number2] ; odejmujemy xmm
		; wynik
		;movsd	xmm0, [number1]
		;movsd	xmm1, [number2]
		;mov 	rdi, f_dif
		;mov 	rax, 3
		;call	printf

	; mnozenie
;	movsd		xmm2, [number1]
;	mulsd		xmm2, [number2]
;		;	wynik
;		movsd	xmm0, [number1]
;		movsd	xmm1, [number2]
;		mov 	rdi, f_mul
;		mov 	rax, 3
;		call	printf
	
	; dzielenie	
;	movsd		xmm2, [number1]
;	divsd 		xmm2, [number2]
		; wynik
;		mov 	rdi, f_div
;		movsd	xmm0, [number1]
;		movsd   xmm1, [number2]
;		mov 	rax, 3
;		call	printf

	; pierwiastek kwadratowy
;	sqrtsd	xmm1, [number1] ; z liczby podwojnej precyzji

;	mov 	rdi, f_sqrt
;	movsd 	xmm0, [number1]
;	mov 	rax, 2
;	call 	printf


	; pierwiastek kwadratowy z liczby calkowitej
;	mov 	rax, [number_int]

	; konwersja
;	cvtsi2sd	xmm1, rax
;	sqrtsd 		xmm0, xmm1
;
	; konwersja z double -> int
;	cvttsd2si 	rax, xmm0

;	mov 		rdi, fmtint
;	mov 		rsi, [number_int] 
;	movsd 		xmm0, xmm1
;	mov 		rdx, rax
;	mov 		rax, 1
;	call		printf
;	
;	mov 		rsp, rbp
	;pop			rbp
;	ret
