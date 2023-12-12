.extern main
.extern _main_stack_region_end

.section .text
_reset_handler:
    # initialize all registers to zero
    call _reg_init

    # initialize stack pointer
    la sp, _main_stack_region_end

    li a0, 0xdeadbeef

    # return
    ret

_reg_init:
    li sp,  0
    li gp,  0
    li tp,  0
    li t0,  0
    li t1,  0
    li t2,  0
    li fp,  0
    li s1,  0
    li a0,  0
    li a1,  0
    li a2,  0
    li a3,  0
    li a4,  0
    li a5,  0
    li a6,  0
    li a7,  0
    li s2,  0
    li s3,  0
    li s4,  0
    li s5,  0
    li s6,  0
    li s7,  0
    li s8,  0
    li s9,  0
    li s10, 0
    li s11, 0
    li t3,  0
    li t4,  0
    li t5,  0
    li t6,  0
    ret

.section .text.start
_start:
    call _reset_handler
_exit:
    j _exit
