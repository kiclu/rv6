.extern main
.extern _main_stack_region_end

.section .text
_reset_handler:
    # initialize all registers to zero
    call _reg_init

    # initialize stack pointer
    la sp, _main_stack_region_end

    add sp, sp, -0x40

    li t0, 0xdeadbeefdeadbeef
    sd t0, 0x00(sp)
    sd t0, 0x08(sp)
    sd t0, 0x10(sp)
    sd t0, 0x18(sp)
    sd t0, 0x20(sp)
    sd t0, 0x28(sp)
    sd t0, 0x30(sp)
    sd t0, 0x38(sp)

    amoadd.d  a0, s0, (sp)
    add sp, sp, 8
    amoxor.d  a1, s1, (sp)
    add sp, sp, 8
    amoand.d  a2, s2, (sp)
    add sp, sp, 8
    amoor.d   a3, s3, (sp)
    add sp, sp, 8
    amomin.d  a4, s4, (sp)
    add sp, sp, 8
    amomax.d  a5, s5, (sp)
    add sp, sp, 8
    amominu.d a6, s6, (sp)
    add sp, sp, 8
    amomaxu.d a7, s7, (sp)
    add sp, sp, 8

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
