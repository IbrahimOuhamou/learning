;in the name of Allah

section .data

section .bss
bismi_allah_buffer resb 512

section .text
global _start
_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, bismi_allah_buffer
    mov rdx, 511
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, bismi_allah_buffer
    mov rdx, 511
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

