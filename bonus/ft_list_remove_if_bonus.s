bits 64

%include "ft_list.s"

section .text
    global ft_list_remove_if

    extern free


; void ft_list_remove_if(list_t **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *)) {
ft_list_remove_if:
    push rbx ; previous
    push r12 ; data_ref
    push r13 ; int (*cmp)(void *, void *)
    push r14 ; current
    push r15 ; free_fct

    test rdi, rdi
    jz _ft_list_remove_if_return
    cmp qword [rdi], 0
    jz _ft_list_remove_if_return

    push rdi ; begin_list
    mov rbx, [rdi]
    mov r12, rsi
    mov r13, rdx
    mov r15, rcx

    _ft_list_remove_if_loop_start:
        mov r14, [rbx + LIST_T_NEXT_OFFSET]
        test r14, r14
        jz _ft_list_remove_if_head

        mov rdi, r14
        add rdi, LIST_T_DATA_OFFSET
        mov rdi, [rdi]
        mov rsi, r12
        call r13
        cmp eax, 0
        jne _ft_list_remove_if_loop_next

        mov rcx, [r14 + LIST_T_NEXT_OFFSET]
        mov [rbx + LIST_T_NEXT_OFFSET], rcx

        mov rdi, r14
        mov rsi, r15
        call ft_list_free_elem
        jmp _ft_list_remove_if_loop_start

        _ft_list_remove_if_loop_next:
            mov rbx, r14
            jmp _ft_list_remove_if_loop_start

    _ft_list_remove_if_head:
        pop r14 ; begin_list
        mov rcx, [r14]
        mov rdi, [rcx + LIST_T_DATA_OFFSET]
        mov rsi, r12
        call r13
        cmp rax, 0
        jne _ft_list_remove_if_return

        mov rdi, [r14]
        mov rcx, [r14]
        mov rcx, [rcx + LIST_T_NEXT_OFFSET]
        mov [r14], rcx

        mov rsi, r15
        call ft_list_free_elem


    _ft_list_remove_if_return:
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        ret


; void ft_list_free_elem(list_t *elem, void (*free_fct)(void *))
ft_list_free_elem:
    push rdi
    mov rdi, [rdi + LIST_T_DATA_OFFSET]
    call rsi

    pop rdi
    call free wrt ..plt
    ret



; void ft_list_remove_if(list_t **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *)) {
;     list_t *head_list;
;     list_t *previous;
;     list_t *elem_to_delete;
;
;     if (begin_list == NULL || *begin_list == NULL) {
;       return ;
;     }
;     head_list = *begin_list;
;     previous = head_list;
;     while (previous->next != NULL) {
;         if (cmp(previous->next->data, data_ref) == 0) {
;             elem_to_delete = previous->next;
;             previous->next = elem_to_delete->next;
;             (*free_fct)(elem_to_delete->data);
;             free(elem_to_delete);
;         } else {
;             previous = previous->next;
;         }
;     }
;     if (cmp(head_list->data, data_ref) == 0) {
;         elem_to_delete = head_list;
;         *begin_list = elem_to_delete->next;
;         (*free_fct)(elem_to_delete->data);
;         free(elem_to_delete);
;     }
; }