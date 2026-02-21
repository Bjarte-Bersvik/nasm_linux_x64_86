extern printf
global main

%define double_it(r)	sal r, 1

%macro prntf	2
    section .data
	%%arg1		db	%1, 0
	%%fmtint	db	"%s %ld", 10, 0
    section .text
    	mov	rdi, %%fmtint
	mov	rsi, %%arg1
	mov 	rdx, [%2]
	mov     rax, 0
	call 	printf
%endmacro

%macro readStdin 0   	   
    section .text
	mov rax, 0 ; read
	mov rdi, 1 ; stdin
	syscall
%endmacro

%macro parseNumber 1

	mov rsi, %1

	xor rcx, rcx
	xor rax, rax

	.parse_loop:
		mov dl, [rsi + rcx]
		cmp dl, 10	; if new line '\n' sign
		je .done
		
		sub dl, '0'
		cmp dl, 9	; if is not correct from 0 to 9? then go .done
		ja .done

		imul rax, rax, 10
		movzx rdx, dl
		add rax, rdx

		inc rcx
		jmp .parse_loop

	.done:
		nop
%endmacro


section .data
	number	dq	15
	maxbuff equ	10

section .bss
	inputbuff resb  maxbuff

section .text

main:
push rbp
mov  rbp, rsp

	prntf	"Liczba to", number
	mov 	rax, [number]
	double_it(rax)

	mov	[number], rax
	prntf "Liczba razy 2 to", number

	mov rsi, inputbuff
	mov rdx, maxbuff
	readStdin
	
	lea rsi, [inputbuff]

	parseNumber inputbuff

	mov [number], rax
	prntf "Liczba po odczytaniu stdin", number

leave
ret
