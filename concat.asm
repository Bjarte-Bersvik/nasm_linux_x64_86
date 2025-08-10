; konkatenacja stringow
section .data
	napis1 db "Hello, ", 0
	napis2 db " Wordl!", 0

section .bss
mov	buffer: resb 256
	buffer_name: resb 256

section .text
global _start
_start:

	mov	rax, 0
	mov	rdi, 0
	mov	rsi, buffer_name
	mov	rdx, 256
	syscall

	mov	al, [rsi]
	cmp	al, 0x0 	; empty
	je	exit

	cmp	al, 0xA		; only enter
	je	exit

	cmp	al, 0x9		; only tab
	je	exit

	cmp	al, 0x20	; space [DEC] = 32
	je	exit

	mov	rsi, napis1 ; adres na napis1
	mov	rdi, buffer ; adr bufora
	mov	r15, 0 ; licz ilosc znakow w buforze

.copy1:
	mov	al, [rsi] ; pobierz bajt z napis1 do al
	mov	[rdi], al ; zapisz bajt do bufora
	inc	rsi ; kolejne bajty +1
	inc	rdi ; kolejny bajt pozycji w buforze
	inc	r15
	test	al, al	; sprawdź czy bajt to 0 (koniec stringa)
	jnz 	.copy1	; jeśli nie zero, kopiuj dalej

	dec	rdi ; cofnięcie w buforze o 1 bajt
	dec	r15 ; cofnięcie długości bufora o 1 bajt

	mov	rsi, buffer_name ; pobierz pierwszy adres na który wskazuje buffer_name

.copy_name:
	mov	al, [rsi]
	mov	[rdi], al
	inc	rsi
	inc	rdi
	inc	r15
	test	al, al
	jnz	.copy_name

	sub	rdi, 2 ; minus eneter
	dec	r15

	mov	rsi, napis2
.copy2:
	mov	al, [rsi] ; pobierz bajt
	mov	[rdi], al
	inc	rsi
	inc	rdi
	inc	r15
	test	al, al
	jnz	.copy2


	mov	rax, 1
	mov	rdi, 1
	mov	rsi, buffer
	mov	rdx, r15
	syscall

exit:
	mov	rax, 60
	mov	rdi, 0
	syscall


