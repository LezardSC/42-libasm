global ft_strlen

section .text
ft_strlen:
    xor rax, rax

    jmp loop_start

loop_start:
    mov sil, byte [rdi + rax]
    test sil, sil
    jz loop_end

    inc rax
    jmp loop_start

loop_end:
    ret