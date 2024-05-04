;in the name of Allah

section .data
bismi_allah_num db 0

arr dd 20, 20, 25, 30, 30
len dd 5
min dd 0
sum dd 0
ave dd 0
med1 dd 0
med2 dd 0
max dd 0

section .text
global bismi_allah_function
global bismi_allah_function_extended
global _start

_start:

    mov rdi, arr
    mov esi, dword [len]
    mov rdx, sum
    mov rcx, ave
    call bismi_allah_function

    push ave
    push sum
    mov r9, max
    mov r8, med2
    mov rcx, med1
    mov rdx, min
    mov esi, dword [len]
    mov rdi, arr
    call bismi_allah_function_extended
    add rsp, 16;clear passed arguments
end:

    mov rax, 60
    mov rdi, 0
    syscall

; HLL bismi_allah_function(arr, len, sum, ave)
bismi_allah_function:
    ;rdi <- &arr
    ;esi <- len
    ;rdx <- &sum
    ;rcx <- &ave

    push r12
    mov r12, 0
    mov rax, 0

bismi_allah_function_loop_start:
    add eax, dword [rdi + r12*4]
    inc r12
    cmp r12, rsi
    jb bismi_allah_function_loop_start

bismi_allah_function_end:
    mov dword [rdx], eax

    cdq
    idiv esi
    mov dword [rcx], eax

    pop r12
    ret

; bismi_allah_function_extended(arr, len, min, med1, med2, max, sum, ave)
    ;rdi  <- &arr
    ;rsi  <- len
    ;rdx  <- &min
    ;rcx  <- &med1
    ;r8   <- &med2
    ;r9   <- &max
    ;[rbp + 16] <- &sum
    ;[rbp + 24] <- ave
bismi_allah_function_extended:
    push rbp
    mov rbp, rsp
    push r12

    ;return min and max
    mov eax, dword [rdi]
    mov dword [rdx], eax

    ;return max
    mov r12, rsi
    dec r12 ;len-1
    mov eax, dword [rdi + r12*4]
    mov dword [r9], eax
    
    ;medians
    mov eax, esi
    mov rdx, 0
    mov r12, 2
    div r12

    cmp rdx, 0
    je even_length

    mov r12d, dword [rdi + rax*4]
    mov dword [rcx], r12d
    mov dword [r8], r12d
    jmp meds_done

even_length:
    mov r12d, dword [rdi + rax*4]
    mov dword [r8], r12d
    dec rax
    mov r12d, dword [rdi + rax*4]
    mov dword [rcx], r12d

meds_done:


    ;sum and ave
    mov rax, 0
    mov r12, 0
bismi_allah_function_extended_loop_start:
    add eax, dword [rdi + r12*4]
    inc r12
    cmp r12, rsi
    jl bismi_allah_function_extended_loop_start

    mov r12, qword [rbp + 16]
    mov dword [r12], eax ;return sum

    cdq
    idiv rsi
    mov r12, qword [rbp + 24]
    mov dword [r12], eax ;return ave

    pop r12
    pop rbp
    ret

