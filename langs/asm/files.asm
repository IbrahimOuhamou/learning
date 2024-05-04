;in the name of Allah

section .data

SYS_open equ 2
SYS_create equ 85
SYS_read equ 0
SYS_write equ 1
SYS_lseek equ 8
SYS_close equ 3

stdin equ 0
stdout equ 1
stderr equ 2

O_RDONLY equ 000000q ;readonlu
O_WRONLY equ 000001q ;write only
O_RDWR   equ 000002q ;read and write

O_CREAT equ 0x40
O_TRUNC equ 0x200
O_APPEND equ 0x400

S_IRUSR equ 00400q
S_IWUSR equ 00200q
S_IXUSR equ 00100q

bismi_allah_str db "in the name of Allah", 0
bismi_allah_file_name db "bismi_allah.txt", 0
bismi_allah_fd db 0

section .bss
bismi_allah_buffer resb 128

section .text
global _start
_start:
    mov rax, SYS_create
    mov rdi, bismi_allah_file_name
    mov rsi, O_RDWR | S_IRUSR | S_IWUSR
    syscall

    mov byte [bismi_allah_fd], al
    
    mov rax, SYS_write
    movzx rdi, byte [bismi_allah_fd]
    mov rsi, bismi_allah_str
    mov rdx, 21
    syscall

    mov rax, SYS_close
    movzx rdi, byte [bismi_allah_fd]
    syscall

    mov rax, SYS_open
    mov rdi, bismi_allah_file_name
    mov rsi, O_RDONLY
    syscall

    mov rax, SYS_read
    movzx rdi, byte [bismi_allah_fd]
    mov rsi, bismi_allah_buffer
    mov rdx, 128
    syscall

    mov rax, SYS_write
    mov rdi, stdout
    mov rsi, bismi_allah_buffer
    mov rdx, 21
    syscall

    ;mov rax, SYS_write
    ;mov rdi, stdout
    ;mov rsi, bismi_allah_str
    ;mov rdx, 21
    ;syscall

    mov rax, 60
    mov rdi, 0
    syscall

