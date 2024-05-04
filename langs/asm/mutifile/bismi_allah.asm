;in the name of Allah

section .data

bismi_allah_str db "in the name of Allah", 10, 0

section .text
extern bismi_allah_print
global _start
_start:

    mov rdi, bismi_allah_str
    call bismi_allah_print

    mov rax, 60
    mov rdi, 0
    syscall

;extern bismi_allah_function

