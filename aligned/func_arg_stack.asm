; func_arg_stack.asm
extern printf

section .data
	n1	dq	123
	n2	dq	223
	n3	dq	12312
	n4	dq	32431
	n5  dq	321
	n6  dq  999
	n7  dq  99889
	n8	dq  2131

	fmt_before	db  "Przed prt", 10, 0
	fmt_after	db  "After prt", 10, 0
	
section .bss
section .text

;----------
prt:
	section .data
		.fmt	db	"Argumenty przekazane: n1: %d, n2: %d, n3: %d, n4: %d, n5: %d, n6: %d, n7: %d, n8: %d ", 10, 0
	section .text
		push	rbp
		mov		rbp, rsp

		mov		rbx, rdi
		mov		r10, rsi
		mov		r11, rdx
		mov		r12, rcx
		mov		r13, r8
		mov		r14, [r9]

		mov		r15, qword [rbp + 16]
		mov		rax, qword [rbp + 24]

		mov		r15, [r15]
		mov		rax, [rax]
		
		mov		rdi, .fmt
		mov		rsi, [rbx]
		mov		rdx, [r10]
		mov		rcx, [r11]
		mov		r8, [r12]
		mov		r9,	[r13]

		sub		rsp, 32

		mov		qword [rsp + 0], r14
		mov		qword [rsp + 8], r15
		mov		qword [rsp + 16], rax
		xor		rax, rax
		call	printf

		add		rsp, 32
		
		leave
		ret
	
	global main
main:
	push	rbp
	mov		rbp, rsp

	mov		rdi, fmt_before
	mov		rax, 0
	call	printf

	mov		rdi, n1
	mov		rsi, n2
	mov		rdx, n3
	mov		rcx, n4
	mov		r8,  n5
	mov		r9,  n6

	sub		rsp, 32

	mov		qword [rsp + 0], n7
	mov		qword [rsp + 8], n8
	call	prt

	add		rsp, 32

	mov		rdi, fmt_after
	mov		rax, 0
	call	printf

	leave
	ret
