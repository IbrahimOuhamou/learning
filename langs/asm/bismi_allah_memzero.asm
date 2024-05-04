;بسم الله الرحمن الرحيم
;la ilaha illa Allah mohammed rassoul Allah

section .bss
bismi_allah_arr resd 10

section .text
global _start
_start:

    mov rdi, bismi_allah_arr
    mov rsi, 10
    call bismi_allah_memzero

    mov rdi, 0
    mov rax, 60
    syscall

bismi_allah_memzero:

    mov rcx, 0
    jmp bismi_allah_memzero_loop_test
    bismi_allah_memzero_middle:

    ret
    
    bismi_allah_memzero_loop_start:
    mov dword [rdi+rcx*4], 0x0
    inc ecx
    bismi_allah_memzero_loop_test:
    cmp rcx, rsi
    jb bismi_allah_memzero_loop_start
    jmp bismi_allah_memzero_middle

