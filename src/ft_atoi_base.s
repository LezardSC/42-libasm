bits 64

; #include <stdbool.h>
; #include <stdlib.h>
; #include <string.h>

; static bool     is_space(char c);
; static bool     is_base_valid(char *base, size_t len_base);
; static int      get_sign(char *str);
; static char     *skip_spaces(char *str);
; static char     *skip_signs(char *str);
; static int      convert_base(char *str, char *base, size_t len_base);
; static ssize_t  get_base_value(char c, char *base);

; int ft_atoi_base(char *str, char *base) {
; 	if (str == NULL || base == NULL) {
; 		return (0);
; 	}

; 	size_t len_base = strlen(base);
; 	int sign = get_sign(str);

; 	if (!is_base_valid(base, len_base)) {
; 		return (0);
; 	}
; 	str = skip_spaces(str);
; 	str = skip_signs(str);

; 	int result = convert_base(str, base, len_base);

; 	return (result * sign);
; }

; static bool is_space(const char c) {
; 	return (c == ' ' || c == '\t'
; 		|| c == '\n' || c == '\v'
; 		|| c == '\f' || c == '\r');
; }

; static bool is_base_valid(char *base, size_t len_base) {
; 	if (len_base <= 1) {
; 		return (false);
; 	}
; 	for (size_t i = 0; i < len_base; i++) {
; 		if (is_space(base[i]) || base[i] == '+' || base[i] == '-') {
; 			return (false);
; 		}
; 		for (size_t j = i + 1; j < len_base; j++) {
; 			if (base[i] == base[j]) {
; 				return (false);
; 			}
; 		}
; 	}
; 	return (true);
; }

; static int get_sign(char *str) {
; 	int sign = 1;

; 	while (is_space(str[0])) {
; 		str++;
; 	}
; 	while (str[0] == '+' || str[0] == '-') {
; 		if (str[0] == '-') {
; 			sign *= -1;
; 		}
; 		str++;
; 	}
; 	return (sign);
; }

; static char *skip_spaces(char *str) {
; 	while (is_space(str[0])) {
; 		str++;
; 	}
; 	return (str);
; }

; static char *skip_signs(char *str) {
; 	while (str[0] == '-' || str[0] == '+') {
; 		str++;
; 	}
; 	return (str);
; }

; static int convert_base(char *str, char *base, size_t len_base) {
; 	int result = 0;
; 	ssize_t base_value;

; 	for (size_t i = 0; str[i]; i++) {
; 		base_value = get_base_value(str[i], base);
; 		if (base_value == -1) {
; 			return (result);
; 		}
; 		result = result * len_base + base_value;
; 	}
; 	return (result);
; }

; static ssize_t get_base_value(char c, char *base) {
; 	for (size_t i = 0; base[i]; i++) {
; 		if (base[i] == c) {
; 			return (i);
; 		}
; 	}
; 	return (-1);
; }


section .text
    global ft_atoi_base

    extern ft_strlen

; int ft_atoi_base(char *str, char *base)
; rbx = str
; r12 = base
; r13 = sign
ft_atoi_base:
    push rbx
    push r12
    push r13

    xor rax, rax
    mov rbx, rdi
    mov r12, rsi

    cmp rdi, 0
    je _ft_atoi_base_return
    cmp rsi, 0
    je _ft_atoi_base_return

    mov rdi, r12
    call ft_strlen
    push rax

    mov rdi, r12
    mov rsi, rax
    call is_base_valid
    cmp rax, 0
    je _ft_atoi_base_return_pop_len

    mov rdi, rbx
    call get_sign
    mov r13, rax

    mov rdi, rbx
    call skip_spaces
    mov rbx, rax

    mov rdi, rbx
    call skip_signs
    mov rbx, rax

    mov rdi, rbx
    mov rsi, r12
    pop rdx
    call convert_base

    imul rax, r13
    jmp _ft_atoi_base_return

    _ft_atoi_base_return_pop_len:
        pop rcx ; no effect

    _ft_atoi_base_return:
        pop r13
        pop r12
        pop rbx
        ret



; bool is_base_valid(char *base, size_t len_base)
is_base_valid:
    cmp rsi, 1
    jle _return_false

    push rbx
    push r12

    mov rbx, rdi

    _is_base_valid_main_loop_start:
        cmp byte [rbx], 0
        je _is_base_valid_return_true

        mov dil, byte [rbx]
        call ft_is_space
        cmp rax, 1
        je _is_base_valid_return_false

        mov dil, byte [rbx]
        call ft_is_sign
        cmp rax, 1
        je _is_base_valid_return_false

        mov r12, rbx
        inc r12
        _is_base_valid_nested_loop_start:
            cmp byte [r12], 0
            je _is_base_valid_main_loop_continue
            mov al, byte [rbx]
            cmp al, byte [r12]
            je _is_base_valid_return_false
            inc r12
            jmp _is_base_valid_nested_loop_start

    _is_base_valid_main_loop_continue:
        inc rbx
        jmp _is_base_valid_main_loop_start

    _is_base_valid_return_false:
        pop r12
        pop rbx
        jmp _return_false

    _is_base_valid_return_true:
        pop r12
        pop rbx
        jmp _return_true


; int get_sign(char *str)
get_sign:
    call skip_spaces
    push rbx
    mov rbx, rax
    push r12
    mov r12d, 1

    _get_sign_loop_start:
        mov dil, byte [rbx]
        call ft_is_sign
        cmp rax, 0
        je _get_signs_return
        cmp byte [rbx], '-'
        jne _get_sign_inc_str
        neg r12d

    _get_sign_inc_str:
        inc rbx
        jmp _get_sign_loop_start

    _get_signs_return:
    mov eax, r12d
    pop r12
    pop rbx
    ret


; char *skip_spaces(char *str)
skip_spaces:
    push rbx
    mov rbx, rdi

    _skip_spaces_loop_start:
        mov dil, byte [rbx]
        call ft_is_space
        cmp rax, 0
        je _skip_spaces_return
        inc rbx;
        jmp _skip_spaces_loop_start

    _skip_spaces_return:
        mov rax, rbx
        pop rbx
        ret


; char *skip_signs(char *str)
skip_signs:
    mov rax, rdi
    push rbx
    mov rbx, rdi

    _skip_signs_loop_start:
        mov dil, byte [rbx]
        call ft_is_sign
        cmp rax, 0
        je _skip_signs_return
        inc rbx
        jmp _skip_signs_loop_start

    _skip_signs_return:
        mov rax, rbx
        pop rbx
        ret


; int convert_base(char *str, char *base, size_t len_base)
; rbx = result
; r12 = str
; r13 = base
; r14 = len_base
convert_base:
    push rbx
    push r12
    push r13
    push r14

    xor rbx, rbx
    mov r12, rdi
    mov r13, rsi
    mov r14, rdx

    _convert_base_loop_start:
        cmp byte [r12], 0
        je _convert_base_return_value

        mov dil, byte [r12]
        mov rsi, r13
        call get_base_value

        cmp rax, -1
        je _convert_base_return_value

        imul rbx, r14
        add rbx, rax

        inc r12

        jmp _convert_base_loop_start

    _convert_base_return_value:
        mov rax, rbx
        pop r14
        pop r13
        pop r12
        pop rbx
        ret


; ssize_t get_base_value(char c, char *base)
get_base_value:
    xor rax, rax

    _get_base_value_loop_start:
        cmp byte [rsi], 0
        je _get_base_value_return_invalid
        cmp byte [rsi], dil
        je _get_base_value_return
        inc rax
        inc rsi
        jmp _get_base_value_loop_start

    _get_base_value_return_invalid:
        mov rax, -1

    _get_base_value_return:
        ret


; bool ft_is_space(char c)
ft_is_space:
    cmp dil, ' '
    je _return_true

    ; dil >= 9 && dil <= 13 <=> dil in ['\t', '\n', '\v', '\f', '\r']
    cmp dil, 9
    jl _return_false

    cmp dil, 13
    jg _return_false

    jmp _return_true


; bool ft_is_sign(char c)
ft_is_sign:
    cmp dil, '+'
    je _return_true
    cmp dil, '-'
    je _return_true
    jmp _return_false


_return_false:
    xor rax, rax
    ret


_return_true:
    mov rax, 1
    ret