;in the name of Allah

section .data
    bismi_allah_var_1 db 100

section .text
global _start
_start:
    movzx rax, byte [bismi_allah_var_1]

    mov rax, 60
    mov rdi, 0
    syscall


