global choose_option
extern printf
extern fflush

section .data
    MAX_BUFFER        equ     2

    err_bad_option    db      "Bad option choosen. Try again", 10, 0
    len_err_bad_opt   equ     $ - err_bad_option

    start_prompt      db      "Wybierz opcję: ", 10, 0
    fmt_1             db      "[%c]. Dodawanie", 10, 0
    fmt_2             db      "[%c]. Odejmowanie", 10, 0
    fmt_3             db      "[%c]. Mnożenie", 10, 0
    fmt_4             db      "[%c]. Dzielenie", 10, 0
    end_prompt        db      ">>> ", 0

section .bss
    opt_buffer:       resb    MAX_BUFFER
    byte_buffer:      resb    1

section .text
choose_option:
    push    rbp
    mov     rbp, rsp

loop_menu:
    mov     rax, 0
    lea     rdi, [start_prompt]     ; Adresowanie absolutne
    call    printf

    mov     rax, 0
    lea     rdi, [fmt_1]
    mov     rsi, '1'
    call    printf

    mov     rax, 0
    lea     rdi, [fmt_2]
    mov     rsi, '2'
    call    printf

    mov     rax, 0
    lea     rdi, [fmt_3]
    mov     rsi, '3'
    call    printf

    mov     rax, 0
    lea     rdi, [fmt_4]
    mov     rsi, '4'
    call    printf

    mov     rax, 0
    lea     rdi, [end_prompt]
    call    printf

    mov     rax, 0
    mov     rdi, 0
    call    fflush

    mov     rax, 0
    mov     rdi, 0
    lea     rsi, [opt_buffer]
    mov     rdx, MAX_BUFFER
    syscall

    cmp     rax, MAX_BUFFER
    jne     .bad_option

    movzx   rsi, byte [opt_buffer+1]
    cmp     sil, 0xA
    jne     .clear_extra

    movzx   rsi, byte [opt_buffer]
    
    cmp     sil, '1'
    jl      .bad_option

    cmp     sil, '4'
    jg      .bad_option

    jmp     .return

.clear_extra:
.flush_loop:
    mov     rax, 0
    mov     rdi, 0
    lea     rsi, [byte_buffer]
    mov     rdx, 1
    syscall

    movzx   rax, byte [byte_buffer]
    cmp     al, 0xA
    jne     .flush_loop
    jmp     .bad_option

.bad_option:
    mov     rax, 1
    mov     rdi, 1
    lea     rsi, [err_bad_option]
    mov     rdx, len_err_bad_opt
    syscall
    jmp     loop_menu

.return:
    movzx   rax, sil
    mov     rsp, rbp
    pop     rbp
    ret
