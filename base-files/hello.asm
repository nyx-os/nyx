global	_start
section	.text

_start:

	; ssize_t write(int fd, const void *buf, size_t count)
	mov	rdi,1			; fd
	mov	rsi,hello_world		; buffer
	mov	rdx,hello_world_size 	; count
	mov	rax,1	 		; write(2)
	syscall
hi:
    jmp hi

hello_world:	db "Hello World!",10
hello_world_size EQU $ - hello_world

