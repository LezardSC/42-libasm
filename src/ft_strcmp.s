global ft_strcmp

section .text
ft_strcmp:
    jmp loop_start

; rdi first, rsi second
loop_start:
    mov r8b, byte [rdi] ; current char of arg1
    mov r9b, byte [rsi] ; current char of arg2
    
    cmp r8b, 0 ; while *arg1 != null
    je loop_end

    cmp r8b, r9b ; compare char
    jne loop_end ; if different exit the loop

    inc rdi
    inc rsi
    jmp loop_start

loop_end:
    movzx rax, r8b
    movzx rdx, r9b
    sub rax, rdx
    ret

; int	ft_strcmp(const char *s1, const char *s2)
; {
; 	size_t	i;

; 	i = 0;
; 	while (((unsigned char *)s1)[i] && s1[i] == ((unsigned char *)s2)[i])
; 		i++;
; 	return (((unsigned char *)s1)[i] - ((unsigned char *)s2)[i]);
; }