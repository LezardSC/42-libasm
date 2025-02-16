global ft_strcpy

section .text
; char ft_strcpy(char *dest, char *src);
ft_strcpy:
    mov rax, rdi

    jmp loop_start

; rdi first, rsi second
loop_start:
    mov dh, byte [rsi]
    test dh, dh
    jz loop_end

    mov [rdi], dh
    inc rdi ; dest pointer
    inc rsi ; src pointer
    jmp loop_start

loop_end:
    mov [rdi], dh
    ret
