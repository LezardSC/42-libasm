global ft_strlen

section .text
ft_strlen:
    mov rax, 0

    jmp loop_start

loop_start:
    mov sil, byte [rdi + rax]
    cmp sil, 0
    je loop_end

    inc rax
    jmp loop_start

loop_end:
    ret