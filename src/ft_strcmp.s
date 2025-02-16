global ft_strcmp

section .text
ft_strcmp:
    jmp loop_start

; rdi first, rsi second
loop_start:
    mov dl, byte [rdi] ; current char of arg1
    mov cl, byte [rsi] ; current char of arg2
    
    test dl, dl ; while *arg1 != null
    jz loop_end

    cmp dl, cl ; compare char
    jne loop_end ; if different exit the loop

    inc rdi
    inc rsi
    jmp loop_start

loop_end:
    movzx rax, dl ; movzx move smaller registers into bigger ones
    movzx rdx, cl
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