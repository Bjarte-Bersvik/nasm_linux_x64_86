extern printf
section .data
    max     dq      5
    fmt     db      "Suma od %ld do %ld = %ld", 10, 0
    
section .bss

section .text
global main
main:
    push    rbp
    mov     rbp, rsp
            
    mov     r15, [max]
    mov     rbx, 0
    mov     r12, 0
    
jloop:
    mov     rdi, fmt
    mov     rsi, 0
    mov     rdx, r12
    mov     rcx, rbx
    mov     rax, 0    
    call    printf
    
    inc     r12 ; r11 + 1
    
    add     rbx, r12
    
    cmp     r12, r15
    jle     jloop
    
    mov     rsp, rbp
    pop     rbp

    ret
    