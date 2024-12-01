global ft_strcmp

ft_strcmp:
    mov rax, rdi

    cmp rdi, 0
    je if_null
    cmp rsi, 0
    je if_null

    jmp loop_start

; rdi first, rsi second
loop_start:
    mov r8b, byte [rsi]
    cmp r8b, 0
    je loop_end


    mov r9, [rsi]
    mov [rdi], r9
    inc rdi
    inc rsi
    jmp loop_start

loop_end:
    mov [rdi], r8b
    ret



; int	ft_strcmp(const char *s1, const char *s2)
; {
; 	size_t	i;

; 	i = 0;
; 	while (((unsigned char *)s1)[i] && s1[i] == ((unsigned char *)s2)[i])
; 		i++;
; 	return (((unsigned char *)s1)[i] - ((unsigned char *)s2)[i]);
; }