target extended-remote :3333
monitor arm semihosting enable
monitor reset halt
file main.elf
load main.elf
monitor reset init
continue
