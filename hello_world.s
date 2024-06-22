bits 64

section .data
	message db 'Hello World!', 10

section .text
	global _start
	_start:
		; write
		mov rax, 0x2000004 ; calling write. Linux = mov rax, 1
		mov rdi, 1 ; stdout
		lea rsi, [rel message]	;linux =  mov rsi, message ; message
		mov rdx, 12+1 ; message length
		syscall

		; exit
		mov rax, 0x2000001	; linux = mov rax, 60 ; exit
		xor rdi, rdi	; linux = mov rdi, 0 ; no args
		syscall

; compilation:
; nasm -f macho64 hello_world.s -o hello_world.o
; -f to chose the format. macho64 to be sure it's 64 bits. 