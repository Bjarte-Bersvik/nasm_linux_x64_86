section .data
	fmtstr		db	"%s", 10, 0
	line		db	"===============================================", 0
	col1		db	" Month", 0
	col2		db 	" m1 ", 0
	col3		db	" m2 ", 0
	col4		db 	" m3 ", 0
	col5		db	" m4 ", 0
	
	headers		db 	" %-10s | %5s  | %5s  | %5s  | %5s  |", 10, 0
	tbody		db 	" %-10s | %lf  | %lf  | %lf  | %lf  |", 10, 0
	month		db  "Juny", 0
	m1			dq	21.33
	m2			dq	22.31
	m3			dq	32.32
	m4			dq	30.05
	
section .bss

section .text
	extern printf
	global main

main:
	push	rbp
	mov		rbp, rsp

	call	print_line
	
	mov		rax, 0
	mov		rdi, headers
	mov		rsi, col1
	mov		rdx, col2
	mov		rcx, col3
	mov		r8,	col4
	mov		r9, col5
	call	printf

	call	print_line
	
	mov		rax, 4
	mov		rdi, tbody
	mov 	rsi, month

	movsd	xmm0, [m1]
	movq	rdx, xmm0

	movsd	xmm1, [m2]
	movq	rcx, xmm1

	movsd   xmm2, [m3]
	movq	r8, xmm2

	movsd	xmm3, [m4]
	movq	r9, xmm3
	
	call	printf 
	
	mov		rbp, rsp
	pop		rbp
	
	ret


print_line:
	push	rbp
	mov		rbp, rsp
	
	mov		rax, 0
	mov		rdi, fmtstr
	mov		rsi, line
	call	printf

	mov 	rsp, rbp
	pop		rbp
	ret
	
