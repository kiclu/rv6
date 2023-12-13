.extern main
.extern _main_stack_region_end

.section .text
_reset_handler:
    add sp, sp, -8
    sd ra, 0(sp)

    # initialize all registers to zero
    call _reg_init

    # load 0xFFFF...FFFF
    li a0, -1

    # load msb
    li a1, 1
    sll a1, a1, 63

    # load MAX_INT
    not a2, a1

    # logic shift left, expected value 0xFFFF...FF00
    sll a3, a2, 8

    # logic right shift, expected value 0x00FFFF...FFFF
    srl a4, a3, 8

    # arithmetic right shift, expected value 0xFFFF...FFFF
    sra a5, a3, 8

    # word logic right shift, expected value 0x7FFFFFFF
    srlw a6, a0, 1

    # word arithmetic right shift, expected value 0xFFFFFFFF
    sraw a7, a0, 1

    # word logic left shift, expected value 0xFFFFFF00
    sllw s2, a0, 8

    # return
    ld ra, 0(sp)
    add sp, sp, 8
    ret

_reg_init:
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
    # initialize stack pointer
    la sp, _main_stack_region_end

    call _reset_handler
_exit:
    j _exit
