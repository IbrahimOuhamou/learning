;in the name of Allah

section .data

arr_qw dq 123, 124, 125, 126, 127

section .text
global _start
_start:

    mov rbx, 0
loop1:
    push qword [arr_qw + (rbx * 8)]
    inc rbx
    cmp rbx, 5
    jb loop1

    mov rbx, 0
loop2:
    pop rax
    mov qword [arr_qw + rbx * 8], rax
    inc rbx
    cmp rbx, 5
    jb loop2

end:
    mov rax, 60
    mov rdi, 0
    syscall


