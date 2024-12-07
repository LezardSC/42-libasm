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

; char	*ft_strdup(const char *src)
; {
; 	int		i;
; 	char	*dest;

; 	i = 0;
; 	dest = (char *)malloc(sizeof(char) * (ft_strlen(((char *)src)) + 1));
; 	if (dest == NULL)
; 		return (NULL);
; 	while (src[i])
; 	{
; 		dest[i] = src[i];
; 		i++;
; 	}
; 	dest[i] = '\0';
; 	return (((char *)dest));
; }