;in the name of Allah

section .data

result dw 0
i dd 0
n dd 100

section .text
global _start
_start:

    mov edx, 0 ;result
    mov ecx, 1 ;i
    mov ebx, 20 ;n

    loop_start:

    mov eax, ecx
    imul eax, eax
debug_before_add:
    add edx, eax
debug_after_add:
    inc ecx
    cmp ecx, ebx
    jbe loop_start


    mov dword [n], ebx
    mov dword [i], ecx
    mov dword [result], edx
    end:

    mov rax, 60
    mov rdi, 0
    syscall


