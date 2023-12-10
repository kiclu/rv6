.extern main
.extern _main_stack_region_end

.section .text.start
_start:
    # set stack pointer
    la sp, _main_stack_region_end

    # call C main
    call main

    # save return value to t6
    mv t5, a0
exit:
    # infinite loop
    j exit
