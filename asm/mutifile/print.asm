;in the name of Allah


section .text
global bismi_allah_print
bismi_allah_print:
    mov rdx, 0
print_loop_start:
    mov al, byte [rdi + rdx]
    cmp al, 0
    je print_loop_end
    inc rdx
    jmp print_loop_start
print_loop_end:
    mov rsi, rdi
    mov rdi, 1
    mov rax, 1
    syscall
    ret

