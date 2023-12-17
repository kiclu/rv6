OUTPUT_ARCH("riscv")

MEMORY {
    VMA     (rw)    : ORIGIN = 0x80000000, LENGTH = 128k
}

SECTIONS {
    . = 0x80000000;

    text : {
        *(.text.start)
        *(.text.mtrap_handler)
        . = ALIGN(0x100);
        *(.text .text.*)
    } > VMA

    rodata : {
        . = ALIGN(16);
        *(.srodata .srodata.*)
        . = ALIGN(16);
        *(.rodata .rodata.*)
    } > VMA

    data : {
        . = ALIGN(16);
        *(.sdata .sdata.*)
        . = ALIGN(16);
        *(.data .data.*)
    } > VMA

    bss : {
        . = ALIGN(16);
        *(.sbss .sbss.*)
        . = ALIGN(16);
        *(.bss .bss.*)
    } > VMA

    . = ALIGN(0x4000);
    _main_stack_region_start = .;
    . += 0x4000;
    _main_stack_region_end = .;
}
