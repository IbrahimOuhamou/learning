;in the name of Allah

%define mulby4(x) shl x, 2

%macro sys_write 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .data
bismi_allah_str db "bismi Allah", 0

section .text
global _start
_start:
    ;mov eax, 1
    ;mulby4 (edx)
    ;mulby4 (eax)

    sys_write bismi_allah_str, 12
end:

    mov rax, 60
    mov edi, 0
    syscall


