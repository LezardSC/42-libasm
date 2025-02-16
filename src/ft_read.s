global ft_read

extern __errno_location

section .text
ft_read:
		xor rax, rax ;System call number for read
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
