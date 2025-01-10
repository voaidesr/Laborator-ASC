.section .note.GNU-stack,"",@progbits
.data
    probabilitati: .float 0.1, 0.2, 0.3, 0.4, 0.5
    n: .long 5
    sum: .space 4
.text
    # float entropy(float *probabilities, float n)
    entropy:
        pushl %ebp
        movl %esp, %ebp

        movl 8(%ebp), %esi
        xorl %ecx, %ecx

        # variabile locale
        # pi
        # log2(pi)
        # sum

        subl $12, %esp 
        fldz 
        fstps -12(%ebp) # floating point load zero - sum = 0

        et_loop:
            cmp 12(%ebp), %ecx
            jae exit_loop

            flds (%esi, %ecx, 4)
            fstps -4(%ebp)

            flds -4(%ebp)
            fstps sum

            pushl %ecx
            flds -4(%ebp)
            subl $4, %esp
            fstps 0(%esp)
            call log2f
            fstps -8(%ebp)
            addl $4, %esp
            popl %ecx

            flds -12(%ebp)
            flds -8(%ebp)
            flds -4(%ebp) # st[0] = p, st[1] = log2p, st[2] = sum
            fmulp %st, %st(1) # floating multiply pair - st[1] = st[0] * st[1], st[0] e popped
            # st[0] = p * log2p, st[1] = sum
            faddp %st, %st(1) 
            fstps -12(%ebp)

            incl %ecx
            jmp et_loop

        exit_loop:
        flds -12(%ebp)
        fchs # floating point change sign s[0] = -s[0]

        addl $12, %esp
        popl %ebp
        ret

.global main
main:
    pushl n
    pushl $probabilitati
    call entropy
    addl $8, %esp 

    fstps sum

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
