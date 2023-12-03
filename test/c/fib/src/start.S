.extern main
.extern _main_stack_region_end

.section .text.start
_start:
    #set stack pointer
    li sp, 0x100

    # call C main
    call main

    # save result to MEM[0x00] & t6 register
    li t0, 0x00
    sd a0, 0x00(t0)
    addi t6, a0, 0
exit:
    # infinite loop
    j exit
