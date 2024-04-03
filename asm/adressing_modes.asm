; in the name of Allah

section .data
    bismi_allah_var dd 11
    bismi_allah_arr dd 12, 13, 14, 15, 16, 10, 10
    array_sum dd 0

section .text
global _start
_start:
    
    mov eax, bismi_allah_var
    mov eax, dword [bismi_allah_var]

    mov rbx, 2

    mov eax, dword [bismi_allah_arr]
    mov eax, dword [bismi_allah_arr + 4]
    mov eax, dword [bismi_allah_arr + rbx * 4]

    ;sum of array
;    mov rbx, bismi_allah_arr  ;base
    mov rcx, 0                ;counter ('i' in c)
    mov rdx, 6                ;limit

    mov eax, 0

loop_start:
    add eax, dword [bismi_allah_arr + rcx * 4]
    inc rcx
    cmp rcx, rdx
    jbe loop_start

    mov dword [array_sum], eax

end:
    mov rax, 60
    mov rdi, 0
    syscall

