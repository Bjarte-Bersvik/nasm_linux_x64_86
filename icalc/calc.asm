extern  choose_option
extern 	printf


section .data
	number1		dq	12345678901234567
	number2		dq	10000
	neg_num		dq	-12

	fmt			db	"Liczby to %ld i %ld", 10, 0
	fmtint		db	"%s %ld", 10, 0

	sumi		db	"Suma to", 0
	difi		db	"Różnica to", 0
	inci		db 	"Liczba 1 zwiększona o 1:", 0
	deci		db	"Liczba 1 zmniejszona o 1:", 0
	sali		db 	"Liczba 1 przesunięta w lewo o 2 (x4):", 0
	sari		db 	"Liczba 1 przesunięta w prawo o 2 (/4):", 0
	sariex		db 	"Liczba 1 przesunięta w prawo o 2 (/4): ", 0
				db  "z rozszerzeniem znakowym:", 0
	multi		db	"Iloczyn to", 0
	divi		db  "Iloraz całkowity to", 0
	remi		db 	"Reszta to", 0

section .bss
	resulti	resq	1
	modulo	resq	1
	
section .text
        global main
main:
        push    rbp
        mov     rbp, rsp
		sub		rsp, 8
		
		; wyswietlam liczby
		lea		rdi, [fmt]
		mov		rsi, [number1]
		mov		rdx, [number2]
		mov		rax, 0
		call	printf

		; dodawanie
		mov		rax, [number1]
		add		rax, [number2] ; dodajemy
		mov		[resulti], rax ; przenoszę 8 bajtów - sumę pod adres result i

		; wyswietlam wynik dodawania
		lea		rdi, [fmtint]
		lea		rsi, [sumi]
		mov		rdx, [resulti]
		mov		rax, 0
		call	printf

		; odejmowanie
		mov		rax, [number1]
		sub		rax, [number2]
		mov		[resulti], rax
		
		; wynik odejmowania
		lea		rdi, [fmtint]
		lea		rsi, [difi]
		mov		rdx, [resulti]
		mov		rax, 0
		call	printf


		; inkrementacja
		mov		rax, [number1]
		inc 	rax
		mov		[resulti], rax

		; wyswietlamy wynik
		mov		rax, 0
		lea		rdi, [fmtint]
		lea 	rsi, [inci]
		mov		rdx, [resulti]
		call	printf			

		; dekrementacja
		mov		rax, [number1]
		dec 	rax
		mov		[resulti], rax

		; wyswietlamy wynik
		mov		rax, 0
		lea		rdi, [fmtint]
		lea 	rsi, [deci]
		mov		rdx, [resulti]
		call	printf

		; arytmetyczne przesunięcie w lewo
		mov		rax, [number1]
		sal 	rax, 2
		mov		[resulti], rax

		; wynik 
		lea		rdi, [fmt]
		lea		rsi, [sali]
		mov		rdx, [resulti]
		mov		rax, 0
		call	printf

		; arytemtyczne przesunięcie w prawo
		mov		rax, [number1]
		sar 	rax, 2
		mov		[resulti], rax

		; wynik		
		lea		rdi, [fmt]
		lea		rsi, [sari]
		mov		rdx, [resulti]
		xor		rax, rax
		call	printf

		; arytmetyczne przesinięcie w prawo z rozszerzeniem znakowym
		mov		rax, [neg_num]
		sar 	rax, 2
		mov		[resulti], rax

		; wynik
		lea		rdi, [fmt]
		lea		rsi, [sariex]
		mov		rdx, [resulti]
		xor		rax, rax
		call	printf

		; mnożenie
		mov		rax, [number1]
		imul	qword [number2]
		mov		[resulti], rax

		
		; wyswietlamy wynik
		lea		rdi, [fmtint]
		lea		rsi, [multi]
		mov		rdx, [resulti]
		xor		rax, rax
		call	printf


		xor		rax, rax
		; dzielenie -------------------
		mov		rax, qword [number1]
		mov		rdx, 0 ; rdx musi mieć wartość 0, zanim wykonamy idiv
		mov		rcx, qword [number2]
		idiv	rcx ; dzielimy rax przez number2, reszta w rdx
		mov		[resulti], rax
		mov		[modulo], rdx

		; wynik dzielenia ----------------
		
		lea		rdi, [fmtint]
		lea		rsi, [divi]
		mov		rdx, [resulti]
		xor		rax, rax
		call	printf

		xor		rax, rax
		lea		rdi, [fmtint]
		lea		rsi, [remi]
		mov		rdx, [modulo]
		xor		rax, rax
		call	printf
		
        ; call    choose_option
		add				rsp, 8
        pop             rbp
        ret

