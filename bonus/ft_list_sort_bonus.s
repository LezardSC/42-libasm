bits 64

%include "ft_list.s"

section .text
global ft_list_sort

; void ft_list_sort(list_t **begin_list, int (*cmp)(void *, void *))
ft_list_sort:
    push rbx ; head_list
    push r12 ; current
    push r13 ; updated
    push r14 ; int (*cmp)(void *, void *)

    test rsi, rsi
    jz _ft_list_sort_return
    mov rbx, [rdi]
    test rbx, rbx
    jz _ft_list_sort_return
    mov r13, 1
    mov r14, rsi

    _ft_list_sort_main_loop_start:
        test r13, r13
        jz _ft_list_sort_return

        xor r13, r13
        mov r12, rbx

        _ft_list_sort_nested_loop_start:
            cmp qword [r12 + LIST_T_NEXT_OFFSET], 0
            je _ft_list_sort_main_loop_start

            mov rdi, [r12 + LIST_T_DATA_OFFSET] ; rdi = current->data
            mov rcx, [r12 + LIST_T_NEXT_OFFSET] ; rcx = current->next
            mov rsi, [rcx + LIST_T_DATA_OFFSET] ; rsi = current->next->data
            call r14
            cmp eax, 0
            jle _ft_list_sort_nested_continue
            mov rdi, r12 + LIST_T_DATA_OFFSET ; rdi = &current->data
            mov rcx, [r12 + LIST_T_NEXT_OFFSET] ; rcx = current->next
            mov rsi, rcx + LIST_T_DATA_OFFSET ; rsi = &current->next->data
            call swap_value
            mov r13, 1

        _ft_list_sort_nested_continue:
            mov r12, [r12 + LIST_T_NEXT_OFFSET]
            jmp _ft_list_sort_nested_loop_start

    _ft_list_sort_return:
        pop r14
        pop r13
        pop r12
        pop rbx
        ret


; void swap_value(void **a, void **b)
swap_value:
    mov rax, [rdi]
    mov rcx, [rsi]

    mov [rdi], rcx
    mov [rsi], rax
    ret



; static	void	swap_value(void **a, void **b)
; {
; 	void *tmp;
;
; 	tmp = *a;
; 	*a = *b;
; 	*b = tmp;
; }
;
; void	ft_list_sort(list_t **begin_list, int (*cmp)(void *, void *))
; {
; 	int		updated = 1;
; 	list_t  *head_list = *begin_list;
; 	list_t  *current;
;
;     if (head_list == NULL) {
;         return ;
;     }
; 	while (updated)
; 	{
; 		updated = 0;
; 		current = head_list;
; 		while (current->next != NULL) {
;             if ((*cmp)(current->data, current->next->data) > 0) {
;                 swap_value(&current->data, &current->next->data);
;                 updated = 1;
;             }
;             current = current->next;
; 		}
; 	}
; }