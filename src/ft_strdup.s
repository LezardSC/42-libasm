global ft_strdup

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
	test rax, rax
	jz .malloc_error

	pop rsi
	mov rdi, rax
	call ft_strcpy
	ret


.malloc_error:
	pop rdi
	ret
