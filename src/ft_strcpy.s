global ft_strcpy

section .text
; char ft_strcpy(char *dest, char *src);
ft_strcpy:
    test rdi, rdi
    je ret_null
    test rsi, rsi
    je ret_null

    mov rax, rdi

    jmp loop_start

; rdi first, rsi second
loop_start:
    mov dh, byte [rsi]
    test dh, dh
    je loop_end

    mov [rdi], dh
    inc rdi ; dest pointer
    inc rsi ; src pointer
    jmp loop_start

loop_end:
    mov [rdi], dh
    ret

ret_null:
    xor rax, rax
    ret
