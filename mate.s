.section .note.GNU-stack,"",@progbits
.data 
    x: .long 30
    y: .long 7
    sum: .space 4
    dif: .space 4
    prod: .space 4
    cat: .space 4
    restu: .space 4
.text
.global main

main:
    mov x, %eax
    mov y, %ebx
    add %eax, %ebx
    mov %ebx, sum

    mov x, %eax
    mov y, %ebx
    sub %ebx, %eax
    mov %ebx, dif

    mov x, %eax
    mull y
    mov %eax, prod

    xor %edx, %edx
    mov x, %eax
    divl y
    mov %eax, cat
    mov %edx, restu
exit:
    mov $1, %eax
    mov $0, %ebx
    int $0x80
