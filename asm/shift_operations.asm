;in the name of Allah

section .data
bismi_allah_b_var db 0

section .text
global _start
_start:

    mov al, 1
    shl al, 4
end_shl1:
    shl al, 2
end_shl2:
    shr al, 6
end_shr1:

    mov al, -64
start_sar1:
    sar al, 2
end_sar1:

    mov rax, 60
    mov rdi, 0
    syscall

