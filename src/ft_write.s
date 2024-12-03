global ft_write

extern __errno_location

section .text
ft_write:
		mov rax, 1 ;System call number for write
		syscall ; Make the system call

		jc error

error:
	mov rcx, rax
	call __errno_location wrt ..plt
	mov [rax], rcx
	mov rax, -1
	ret
