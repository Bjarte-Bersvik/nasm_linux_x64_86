; hello.asm
section .data
	msg			db	"Hello", 0
	len 		equ $ - msg

	msg_error 	db	"Wystapil blad podczas otwarcia pliku", 0xa, 0	
	len_error	equ $ - msg_error

	filename db "f.txt", 0

	NL			db	0xa ; kod ascii nowego wiersza

	O_RDONLY equ 0x0
	O_WRONLY equ 0x1
	O_RDWR   equ 0x2
	O_CREAT  equ 0x40

	MODE	equ 0777
	
section .bss
	file_descriptor resq 1 ; 8 bajtów na file descriptor
	read_buffer resb 1024 ; 1024 bajty max bufor na odczyt
	
section .text
global main

main:
	mov rax, 1 ; 1 = wypisz
	mov rdi, 1 ; na stdout
	mov rsi, msg ; lancuch do wyswietlania w rsi
	mov rdx, len ;
	syscall

	mov	rax, 1
	mov rdi, 1
	mov rsi, NL
	mov rdx, 1
	syscall

	mov rax, 2 ; open
	mov rdi, filename
	mov rsi, O_RDONLY
	mov rdx, MODE
	syscall

	cmp rax, 0
	jl 	exit_error_open_file

	mov [file_descriptor], rax

	mov rax, 0 ; read file content
	mov rdi, [file_descriptor]
	mov rsi, read_buffer
	mov rdx, 1024
	syscall

	mov r8, rax ; liczba bajtów wczytanych do bufora (jest w rax)

	mov rax, 1
	mov rdi, 1
	mov rsi, read_buffer
	mov rdx, r8
	syscall

	mov rax, 3
	mov rdi, [file_descriptor]
	syscall
	
	mov	rax, 60 ; wyjscie
	mov	rdi, 0 ; sygnal sukces
	syscall

exit_error_open_file:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg_error
	mov rdx, len_error
	syscall

	mov rax, 3
	mov rdi, [file_descriptor]
	syscall
		
	mov	rax, 60 ; wyjscie
	mov	rdi, 1 ; error
	syscall
