global ft_read

extern __errno_location

section .text
ft_read:
		mov rax, 0 ;System call number for read
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
