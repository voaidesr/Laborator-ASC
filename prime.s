.section .note.GNU-stack,"",@progbits
.data
    x: .long 11
    formatString1: .asciz "Numarul %d e prim\n"
    formatString2: .asciz "Numarul %d nu este prim\n"

.text
prime:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ebx
    # verficam daca e 1
    cmp $1, %ebx
    je et_nu_prim
    # verificam daca e 2
    cmp $2, %ebx
    je et_prim
    mov $2, %ecx

    # structura repetitiva numar divizori
et_loop:
    cmp %ebx, %ecx
    je et_prim
    xorl %edx, %edx
    mov %ebx, %eax
    div %ecx
    cmp $0, %edx
    je et_nu_prim
    incl %ecx 
    jmp et_loop

et_prim:
    mov $1, %eax
    jmp et_finish

et_nu_prim:
    mov $0, %eax

et_finish:
    popl %ebp
    ret

.global main
main:
    pushl x
    call prime
    popl %ebx
    cmp $0, %eax
    je et_afisare_nu_prim

et_afisare_prim:
    pushl x
    pushl $formatString1
    call printf
    popl %ebx
    popl %ebx
    jmp et_exit

et_afisare_nu_prim:
    pushl x
    pushl $formatString2
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
