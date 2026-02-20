extern MessageBoxA
extern GetModuleHandleA
extern ExitProcess
extern GetCommandLineA

section .data
    _id_t db "Security Kernel Alert", 0
    _id_m db "CRITICAL: System integrity compromised by humor-level-99.", 0xa, "Donnie?", 0

section .text
    global main

main:
    push rbp
    mov rbp, rsp
    sub rsp, 64

    xor rcx, rcx
    call GetModuleHandleA
    mov [rbp-8], rax

    call GetCommandLineA
    mov [rbp-16], rax

_verify_stack:
    mov rax, rsp
    and rax, 0xF
    jnz _align_stack
    jmp _init_sequence

_align_stack:
    sub rsp, 8

_init_sequence:
    mov r8, 0x100
    xor r9, r9

_sys_payload_entry:
    xor rcx, rcx
    lea rdx, [_id_m]
    lea r8, [_id_t]
    mov r9d, 0x00000034
    
    mov rax, [rbp-8]
    test rax, rax
    jz _fatal_exit

    call MessageBoxA

    cmp eax, 6
    je _sys_payload_entry
    cmp eax, 7
    je _sys_payload_entry

    nop
    jmp _sys_payload_entry

_fatal_exit:
    mov rcx, 0
    call ExitProcess
    
    leave