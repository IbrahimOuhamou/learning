;in the name of Allah

section .data

bismi_allah db "in the name of Allah", 10, 0, "la ilaha illa Allah", 10, 0
;bismi_allah_str db 

section .bss
chr resb 1
bismi_allah_str resb 52

section .text
global _start
_start:
    ;SYS WRITE
    mov rax, 1
    mov rdi, 1
    mov rsi, bismi_allah
    mov rdx, 22
    syscall

    mov rdi, bismi_allah
    call bismi_allah_print

    mov rdi, bismi_allah
    add rdi, 22
    call bismi_allah_print

    mov rax, 0
    mov rdi, 0
    mov rsi, bismi_allah_str
    mov rdx, 52
    syscall

    mov rdi, bismi_allah_str
    call bismi_allah_print

end:

    mov rax, 60
    mov rdi, 0
    syscall

;rdi <- &str
bismi_allah_print:
    mov rdx, 0
    ;count characters
print_loop_start:
    mov al, byte [rdi + rdx]
    cmp al, 0
    je print_loop_end
    inc rdx
    jmp print_loop_start
print_loop_end:

    mov rsi, rdi
    mov rdi, 1
    ;mov rdx, rdx
    mov rax, 1
    syscall
    ret

;rdi <- &str
bismi_allah_read:
    
    ret


