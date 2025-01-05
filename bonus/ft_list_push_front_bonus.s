bits 64

%include "ft_list.s"

section .text
    global ft_list_push_front

    extern ft_list_create_elem


; void	ft_list_push_front(list_t **begin_list, void *data)
; {
; 	list_t	*new_elem;
;
; 	new_elem = ft_create_elem(data);
;   if (elem == NULL) {
;       return;
;   }
; 	new_elem->next = begin_list[0];
; 	begin_list[0] = new_elem;
; }

; list_t *ft_list_push_front(list_t **begin_list, void *data)
ft_list_push_front:
    push rdi
    mov rdi, rsi

    call ft_list_create_elem
    cmp rax, 0
    je _ft_list_push_front_return

    pop rcx ; begin_list
    mov rdx, [rcx] ; begin_list[0]
    mov [rax + LIST_T_NEXT_OFFSET], rdx ; new_elem->next = begin_list[0]
    mov [rcx], rax
    ret

    _ft_list_push_front_return:
        pop rdi
        ret
