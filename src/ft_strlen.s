global ft_strlen

ft_strlen:
    mov rcx, rdi
    mov rax, 0

    jmp loop_start

loop_start:
    mov sil, byte [rcx + rax]
    cmp sil, 0
    je loop_end

    inc rax
    jmp loop_start

loop_end:
    ret