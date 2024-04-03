;in the name of Allah

section .data

section .text
global _start
_start:
    push rbp
    mov rbp, rsp

    sub rsp, 404

    mov eax, 10
    mov rcx, 0
    lea rbx, word [rbp-400]
loop_start:
    mov dword [rbx + rcx*4], eax
    inc eax
    inc rcx
    cmp rcx, 100
    jl loop_start
end:


    pop rbp
    mov rax, 60
    mov rdi, 0
    syscall

