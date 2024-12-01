bits 64

section .data
	msg db "Hello World!", 0xA ; Message with newline
	len equ $ - msg

section .text
	global _start ; Program's entry point to the linker
	
	_start:
		; System call: write(stdout, msg, len)
		mov rax, 1 ;System call number for write
		mov rdi, 1 ; File descriptor (stdout)
		mov rsi, msg ; Message to write
		mov rdx, len ; Message length
		syscall ; Make the system call


		; System call: exit (status)
		mov rax, 60 ; System call number for exit
		xor rdi, rdi ; Exit status 0
		syscall ; Make the system call