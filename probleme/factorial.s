.section .note.GNU-stack,"",@progbits
.data
    x: .space 4
    formatString: .asciz "%ld"
.text
factorial:
    pushl %ebp
    movl %esp, %ebp

    # vom calcula factorialul lui %eax

    # conditie de iesire din recursiv
    cmp $1, %eax
    jle et_base_case

    # recursion
    pushl %eax
    dec %eax
    call factorial 
    popl %ebx
    imul %ebx
    jmp exit_stack_frame

et_base_case:
    movl $1, %eax

exit_stack_frame: 
    popl %ebp
    ret

.global main
main:
    # citim variabila x
    pushl $x
    pushl $formatString
    call scanf
    popl %ebx
    popl %ebx

    # memoram factorial in eax
    mov x, %eax
    call factorial

    # afisam factorial

    pushl %eax
    pushl $formatString
    call printf
    popl %ebx
    popl %ebx

et_exit:
    pushl $0
    call fflush
    popl %ebx

    movl $1, %eax
    movl $0, %ebx
    int $0x80