;in the name of Allah

section .data

b_var db 0

section .text
global _start
_start:
    mov al, 2
    and al, 10
    mov byte [b_var], al
    ;mov byte [b_var1], 2
    ;and byte [b_var], al
end_and:

    mov al, 2
    or al, 10
    mov byte [b_var], al
end_or:

    mov al, 2
    xor al, 10
    mov byte [b_var], al
end_xor:

    mov al, 0
    not al
    mov byte [b_var], al
end_not:

    mov rax, 60
    mov rdi, 0
    syscall

