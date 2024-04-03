;in the name of Allah

section .data

bismi_allah_num dd 1001001

bismi_allah_arr db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

;section .bss
;str resb 10

section .text
global _start
_start:
    ;mov eax, dword [bismi_allah_num]
    ;mov ebx, 3
    ;idiv ebx

    ;mov rax, 0
    ;push rax
    ;knows it is the end when it gets a number lower than 10

    ;mov ecx, dword [bismi_allah_num]

; 1. keep dividing until it is equal to 0: [X]
; 2. push values onto the stack
; 3. pop them in reverse order and put them in the 'bismi_allah_arr'
; 4. print it out to the consol

;    mov eax, 3642
;    mov ebx, 10
;    idiv ebx
;    mov edx, 0
;    idiv ebx
;    mov edx, 0
;    idiv ebx
;    mov edx, 0
;    idiv ebx

;    mov eax, 3642
;loop_start:
;    mov edx, 0
;    mov ebx, 10
;    idiv ebx
;    inc ecx
;    cmp eax, 10
;    ja loop_start


    mov rax, 0
    push rax
    mov eax, dword [bismi_allah_num]
loop_push_start:
    mov edx, 0
    mov ebx, 10
    idiv ebx
    add rdx, "0"
    push rdx
    inc ecx
    cmp eax, 10
    ja loop_push_start
    add rax, "0"
    push rax
loop_push_end:

;    mov rcx, 0
;loop_pop_start:
;    inc rcx
;    pop rax
;    mov dword [bismi_allah_arr + rax*8], eax
;    cmp rax, 0
;    jne loop_pop_start
    
;    mov rcx, 0
;    ;lea rbx, byte [bismi_allah_arr]
;    mov rbx, bismi_allah_arr
;loop_pop_start:
;    pop rax
;    mov byte [rbx], al
;    add rbx, 8
;    cmp rax, 0
;    jne loop_pop_start
;loop_pop_end:

    mov rbx, bismi_allah_arr
    mov rdi, 0
loop_pop_start:
    pop rax
    mov byte [rbx + rdi], al
    inc rdi
    cmp rax, 0
    jne loop_pop_start
loop_pop_end:

write:
    mov rax, 1
    mov rdi, 1
    mov rsi, bismi_allah_arr
    mov rdx, 9
    syscall

end:

    mov rax, 60
    mov rdi, 0
    syscall

