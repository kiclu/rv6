OUTPUT_ARCH("riscv")
ENTRY( _start )

SECTIONS {
    . = 0x80000000;

    text.init : {
        *(.text.init)
    }

    text : {
        *(.text)
        *(.text.*)
    }

    rodata : {
        *(.rodata)
        *(.rodata*)
    }

    bss : {
        *(.bss)
        *(.bss*)
        *(COMMON)
    }

    data : {
        *(.data)
        *(.data*)
    }

    . = ALIGN(0x1000);
    _main_stack_region_start = .;
    . += 0x4000;
    _main_stack_region_end = .;
}
