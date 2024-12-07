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
	call malloc wrt ..plt
	cmp rax, 0
	je .malloc_error
	mov rdi, rax
	pop rsi
	call ft_strcpy
	ret

.malloc_error:
	pop rdi
	ret

; global ft_strcpy

; section .text
; ft_strcpy:
;     mov rax, rdi

;     cmp rdi, 0
;     je if_null
;     cmp rsi, 0
;     je if_null

;     jmp loop_start

; ; rdi first, rsi second
; loop_start:
;     mov r8b, byte [rsi]
;     cmp r8b, 0
;     je loop_end


;     mov r9, [rsi]
;     mov [rdi], r9
;     inc rdi
;     inc rsi
;     jmp loop_start

; loop_end:
;     mov [rdi], r8b
;     ret

; if_null:
;     mov rax, 0
;     ret
