bits 64

%include "ft_list.s"

section .text
    global ft_list_size

; size_t ft_list_size(list_t *begin_list)
ft_list_size:
    xor rax, rax

    _ft_list_size_loop_start:
        cmp rdi, 0
        je _ft_list_size_return
        inc rax
        mov rdi, [rdi + LIST_T_NEXT_OFFSET]
        jmp _ft_list_size_loop_start

    _ft_list_size_return:
        ret