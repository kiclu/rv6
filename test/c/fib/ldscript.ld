OUTPUT_ARCH("riscv")

MEMORY {
    VMA     (rw)    : ORIGIN = 0x80000000, LENGTH = 32k
}

SECTIONS {
    start : {
        *(.text.start)
    } > VMA

    text : {
        *(.text)
        *(.text*)
    } > VMA

    data : {
        *(.data)
        *(.data*)
    } > VMA

    rodata : {
        *(.rodata)
        *(.rodata*)
    } > VMA

    bss : {
        *(.bss)
        *(.bss*)
        *(COMMON)
    } > VMA

    stack : {
        _main_stack_region_start = .;
        . += 0x4000;
        _main_stack_region_end = .;
    } > VMA
}
