.text

    .globl sum_positive_ints
    .type sum_positive_ints, @function
sum_positive_ints:
    # TODO: Problem 1

    movq $0, %rax
    cmpq $0, %rsi
    jle done
    loop:
        cmpl $0, (%rdi)
        jg add_it
        continue:
            addq $4, %rdi
            subq $1, %rsi
            cmpq $0, %rsi
            jg loop
    done:
        ret
    add_it:
    movslq (%rdi), %rdx
        addq %rdx, %rax
        jmp continue


    .globl reverse_longs
    .type reverse_longs, @function
reverse_longs:
    # TODO: Problem 2

    cmpq $1, %rsi
    jle done2
    loop2:
        movq %rsi, %rdx
        subq $1, %rdx
        imulq $8, %rdx
        movq (%rdi), %rcx
        addq %rdx, %rdi
        movq (%rdi), %r8
        movq %rcx, (%rdi)
        subq %rdx, %rdi
        movq %r8, (%rdi)
        addq $8, %rdi
        subq $2, %rsi
        cmpq $1, %rsi
        jg loop2
    ret

    done2:
        ret

    .globl sensor_score
    .type sensor_score, @function
sensor_score:
    # TODO: Problem 3
    movslq (%rdi), %rax
    movq 8(%rdi), %rsi
    movslq 16(%rdi), %rdx
    imulq %rdx, %rsi
    addq %rsi, %rax
    ret

    .globl sensor_array_total
    .type sensor_array_total, @function
sensor_array_total:
    # TODO: Problem 4
    movq $0, %rax
    cmpq $0, %rsi
    jle done3
    movq $0, %r9
    movq %rsi, %r8
    loop3:
        call sensor_score
        addq %rax, %r9
        subq $1, %r8
        addq $24, %rdi
        cmpq $0, %r8
        jg loop3
    movq %r9, %rax
    ret
    done3:
        ret

    .globl make_arithmetic_sequence
    .type make_arithmetic_sequence, @function
make_arithmetic_sequence:
    # TODO: Problem 5
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)
    cmpq $0, %rdx
    jle alloc_fail
    movq %rdx, %rdi
    imulq $8, %rdi
    call malloc
    cmpq $0, %rax
    je alloc_fail
    movq %rax, -32(%rbp)
    movq -8(%rbp), %r8
    movq -16(%rbp), %r9
    movq -24(%rbp), %r10
    movq -32(%rbp), %rcx
    loop5:
        movq %r8, (%rcx)
        addq %r9, %r8
        addq $8, %rcx
        subq $1, %r10
        cmpq $0, %r10
        jg loop5
    movq -32(%rbp), %rax
    leave
    ret
    alloc_fail:
        movq $0, %rax
        leave
        ret

    .globl make_sensor
    .type make_sensor, @function
make_sensor:
    # TODO: Problem 6A
    movq $0, %rax
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movl %edi, -4(%rbp)
    movq %rsi, -16(%rbp)
    movl %edx, -24(%rbp)
    movq $24, %rdi
    call malloc
    cmpq $0, %rax
    jle alloc_fail
    movl -4(%rbp), %edx
    movl %edx, (%rax)
    movq -16(%rbp), %rdx
    movq %rdx, 8(%rax)
    movl -24(%rbp), %edx
    movl %edx, 16(%rax)
    leave   
    ret

    .globl sensor_destroy
    .type sensor_destroy, @function
sensor_destroy:
    # TODO: Problem 6B
    cmpq $0, %rdi
    jle done6
    call free
    done6:
        ret


    .section .note.GNU-stack,"",@progbits
