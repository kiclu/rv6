.extern main
.extern _main_stack_region_end

.section .text.start
.type _start, %function
_start:
loop:
    j loop
