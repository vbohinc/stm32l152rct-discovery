ENTRY(start)

MEMORY
{
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
	RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

SECTIONS
{
	.isr_vector : {
		. = ALIGN(4);
		KEEP(*(.isr_vector))            /* Startup code */
		. = ALIGN(4);
	} >FLASH

        .text :  {  *(.text)   }

        .data :
        { 
          *(.data)
          *(.rom)
        }

        . = 0x20000000;
        .ram : { *(.ram) }

        .bss :
        {
          *(.bss)
          *(.ram)
        }
}
