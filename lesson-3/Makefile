main.hex: main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex
main.bin: main.elf
	arm-none-eabi-objcopy -O binary main.elf main.bin
main.elf: main.o main.ld
	arm-none-eabi-ld -v -T main.ld -nostartfiles -o main.elf main.o
main.o: Makefile main.s
	arm-none-eabi-as -mlittle-endian -mcpu=cortex-m3 -march=armv6-m -mthumb -mapcs-32 -gstabs -ahls=main.lst -g -o main.o main.s
openocd:
	openocd -f openocd.cfg
run:
	./st-flash --reset write main.bin 0x08000000
flash: main.elf
	arm-none-eabi-gdb --batch --command flash.gdb
gdb: main.elf
	arm-none-eabi-gdb --command flash.gdb
clean:
	rm -f *.elf *.hex *.bin *.lst *.o
