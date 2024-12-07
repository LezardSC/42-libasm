global ft_strdup

extern __errno_location
extern ft_strlen
extern ft_strcpy
extern malloc

section .text
ft_strdup:
	push rdi
	call ft_strlen
	inc rax
	mov rdi, rax
	call malloc wrt ..plt
	cmp rax, 0
	je .malloc_error
	pop rsi
	mov rdi, rax
	call ft_strcpy
	ret


.malloc_error:
	ret
