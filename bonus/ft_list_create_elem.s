bits 64

%include "ft_list.s"

section .text
    global ft_list_create_elem

    extern malloc

; list_t *ft_list_create_elem(void *data)
ft_list_create_elem:
    push rdi

    mov rdi, LIST_T_SIZE
    call malloc wrt ..plt
    pop rdi
    cmp rax, 0
    je _ft_list_create_elem_return
    mov qword [rax + LIST_T_DATA_OFFSET], rdi
    mov qword [rax + LIST_T_NEXT_OFFSET], 0

    _ft_list_create_elem_return:
        ret


; list_t *ft_list_create_elem(void *data) {
;     list_t *new_elem = malloc(sizeof(list_t));
;     if (!new_elem)
;         return NULL;
;     new_elem->data = data;
;     new_elem->next = NULL;
;     return new_elem;
; }