global ft_write

extern __errno_location

section .text
ft_write:
		mov rax, 1 ;System call number for write
		syscall ; Make the system call

		test rax, rax
		js error
        
        ret
error:
    neg eax
	push rax
	call __errno_location wrt ..plt
	pop rdi
	mov dword [rax], edi
	mov rax, -1
	ret
