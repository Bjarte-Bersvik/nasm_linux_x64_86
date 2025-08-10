extern printf
section .data
    number1     dq      1233
    number2     dq      123

    fmtg        db      "%d > %d", 10, 0
    fmtl        db      "%d < %d", 10, 0
    fmte        db      "%d == %d", 10, 0
     
section .bss

section .text

global main
main:
    
    push    rbp
    mov     rbp, rsp

    mov     rax, [number1]
    mov     rbx, [number2]
    
    cmp     rax, rbx
    jg      greater
    
    je      equal
    
    xor     rax, rax
    mov     rdi, fmtl
    mov     rsi, [number1]
    mov     rdx, [number2]
    call    printf    
    jmp     exit
    
greater:
    xor     rax, rax
    mov     rdi, fmtg
    mov     rsi, [number1]
    mov     rdx, [number2]
    call    printf
    jmp     exit

equal:
    xor     rax, rax
    mov     rdi, fmte
    mov     rsi, [number1]
    mov     rdx, [number2]
    call    printf
    jmp     exit

exit:
    mov     rsp, rbp
    pop     rbp
    
    ret
    