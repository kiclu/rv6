MEMORY {
    LMA     (rx)    : ORIGIN = 0x00000000, LENGTH = 32k
    VMA     (rw)    : ORIGIN = 0x80000000, LENGTH = 32k
}

SECTIONS {
    start : {
        *(.text.start)
    } > VMA AT> LMA

    text : {
        *(.text)
        *(.text*)
    } > VMA AT> LMA

    data : {
        *(.data)
        *(.data*)
    } > VMA AT> LMA

    rodata : {
        *(.rodata)
        *(.rodata*)
    } > VMA AT> LMA

    bss : {
        *(.bss)
        *(.bss*)
        *(COMMON)
    } > VMA
    stack : {
        _main_stack_region_start = .;
        . = 0x4000;
        _main_stack_region_end = .;
    } > VMA
}
