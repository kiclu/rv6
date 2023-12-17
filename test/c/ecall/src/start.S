.extern main
.extern _main_stack_region_end

.section .text
_reset_handler:
    add sp, sp, -8
    sd ra, 0(sp)

    # initialize all registers to zero
    call _reg_init

    li a0, 0
    li a0, 1
    li a0, 2
    li a0, 3
    li a0, 4
    li a0, 5
    li a0, 6
    li a0, 7
    li a0, 8
    li a0, 9
    li a0, 10
    ecall
    li a0, 11
    li a0, 12
    li a0, 13
    li a0, 14
    li a0, 15
    li a0, 16
    li a0, 17
    li a0, 18
    li a0, 19
    li a0, 20

    # return
    ld ra, 0(sp)
    add sp, sp, 8
    ret

_csr_init:
    la t0, _mtrap_handler
    srl t0, t0, 2
    sll t0, t0, 2
    or  t0, t0, 0b01
    csrw mtvec, t0

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

.section .text.mtrap_handler
_mtrap_handler:
    j 0f
    j 1f
    j 2f
    j 3f
    j 4f
    j 5f
    j 6f
    j 7f
    j 8f
    j 9f
    j _mtrap_ret
    j 11f
    j 12f
    j 13f
    j _mtrap_ret
    j 15f

0:
    # Instruction address misaligned
    j _mtrap_ret
1:
    # Instruction access fault
    j _mtrap_ret
2:
    # Illegal instruction
    j _mtrap_ret
3:
    # Breakpoint
    j _mtrap_ret
4:
    # Load address misaligned
    j _mtrap_ret
5:
    # Load access fault
    j _mtrap_ret
6:
    # Store/AMO address misaligned
    csrr t0, mepc
    add t0, t0, 4
    csrw mepc, t0

    add t5, t5, 1

    j _mtrap_ret
7:
    # Store/AMO access fault
    j _mtrap_ret

8:
    # Environment call from U-mode
    j _mtrap_ret

9:
    # Environment call from S-mode
    j _mtrap_ret

11:
    # Environment call from M-mode
    csrr t0, mepc
    nop
    nop
    nop
    nop
    add t0, t0, 4
    csrw mepc, t0

    add t6, t6, 1
    j _mtrap_ret

12:
    # Instruction page fault
    j _mtrap_ret

13:
    # Load page fault
    j _mtrap_ret

15:
    # Store/AMO page fault
    j _mtrap_ret

_mtrap_ret:
    mret

.section .text.start
_start:
    # initialize stack pointer
    la sp, _main_stack_region_end

    # initialize CSRs
    call _csr_init

    call _reset_handler
_exit:
    j _exit
