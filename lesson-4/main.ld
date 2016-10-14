ENTRY(start)

MEMORY
{
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 256K
	RAM  (xrw) : ORIGIN = 0x20000000, LENGTH = 16K
}

SECTIONS
{
    /* for Cortex devices, the beginning of the startup code is stored in the .isr_vector section, which goes to FLASH */
    .isr_vector :
    {
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

        /* internal RAM starts at 0x20000000 */
        . = 0x20000000;
        .ram : { *(.ram) }

        .bss :
        {
          *(.bss)
          *(.ram)
	}
}
