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
    neg rax
	mov ecx, eax
	call __errno_location wrt ..plt
	mov dword [rax], ecx
	mov rax, -1
	ret
