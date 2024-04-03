;in the name of Allah

section .data
    bismi_allah_var db 88


section .text
global _start
_start:


    movzx rax, byte [bismi_allah_var]

    cmp rax, 50
    jle stop1
    jmp stop2

stop1:
    mov byte [bismi_allah_var], 1
    jmp end1

stop2:
    mov byte [bismi_allah_var], 2
    jmp end1
end1:


    mov byte [bismi_allah_var], 1
bismi_allah_label:

    jmp while_loop_test
while_loop_start:
    mov al, byte [bismi_allah_var]
    inc al
    mov byte [bismi_allah_var], al
while_loop_test:
    mov al, byte [bismi_allah_var]
    cmp al, 10
    jbe while_loop_start

end2:

    mov rax, 60
    mov rdi, 0
    syscall

