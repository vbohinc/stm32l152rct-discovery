.thumb
.cpu cortex-m3
.syntax unified

.equ STACKINIT,0x20002000

.section .text
	.org 0

isr_vectors:
	.equ  BootRAM, 0xF108F85F

	.word STACKINIT
	.word start    // Reset_Handler
	.word _handler // NMI_Handler
	.word _handler // HardFault_Handler
	.word _handler // MemManage_Handler
	.word _handler // BusFault_Handler
	.word _handler // UsageFault_Handler
	.word _handler // 0
	.word _handler // 0
	.word _handler // 0
	.word _handler // 0
	.word _handler // SVC_Handler
	.word _handler // DebugMon_Handler
	.word _handler // 0
	.word _handler // PendSV_Handler
	.word _handler // SysTick_Handler
	.word _handler // WWDG_IRQHandler
	.word _handler // PVD_IRQHandler
	.word _handler // TAMPER_STAMP_IRQHandler
	.word _handler // RTC_WKUP_IRQHandler
	.word _handler // FLASH_IRQHandler
	.word _handler // RCC_IRQHandler
	.word _handler // EXTI0_IRQHandler
	.word _handler // EXTI1_IRQHandler
	.word _handler // EXTI2_IRQHandler
	.word _handler // EXTI3_IRQHandler
	.word _handler // EXTI4_IRQHandler
	.word _handler // DMA1_Channel1_IRQHandler
	.word _handler // DMA1_Channel2_IRQHandler
	.word _handler // DMA1_Channel3_IRQHandler
	.word _handler // DMA1_Channel4_IRQHandler
	.word _handler // DMA1_Channel5_IRQHandler
	.word _handler // DMA1_Channel6_IRQHandler
	.word _handler // DMA1_Channel7_IRQHandler
	.word _handler // ADC1_IRQHandler
	.word _handler // USB_HP_IRQHandler
	.word _handler // USB_LP_IRQHandler
	.word _handler // DAC_IRQHandler
	.word _handler // COMP_IRQHandler
	.word _handler // EXTI9_5_IRQHandler
	.word _handler // LCD_IRQHandler  
	.word _handler // TIM9_IRQHandler
	.word _handler // TIM10_IRQHandler
	.word _handler // TIM11_IRQHandler
	.word _handler // TIM2_IRQHandler
	.word _handler // TIM3_IRQHandler
	.word _handler // TIM4_IRQHandler
	.word _handler // I2C1_EV_IRQHandler
	.word _handler // I2C1_ER_IRQHandler
	.word _handler // I2C2_EV_IRQHandler
	.word _handler // I2C2_ER_IRQHandler
	.word _handler // SPI1_IRQHandler
	.word _handler // SPI2_IRQHandler
	.word _handler // USART1_IRQHandler
	.word _handler // USART2_IRQHandler
	.word _handler // USART3_IRQHandler
	.word _handler // EXTI15_10_IRQHandler
	.word _handler // RTC_Alarm_IRQHandler
	.word _handler // USB_FS_WKUP_IRQHandler
	.word _handler // TIM6_IRQHandler
	.word _handler // TIM7_IRQHandler
	.word _handler // SDIO_IRQHandler
	.word _handler // TIM5_IRQHandler
	.word _handler // SPI3_IRQHandler
	.word _handler // UART4_IRQHandler
	.word _handler // UART5_IRQHandler
	.word _handler // DMA2_Channel1_IRQHandler
	.word _handler // DMA2_Channel2_IRQHandler
	.word _handler // DMA2_Channel3_IRQHandler
	.word _handler // DMA2_Channel4_IRQHandler
	.word _handler // DMA2_Channel5_IRQHandler
	.word _handler // AES_IRQHandler
	.word _handler // COMP_ACQ_IRQHandler
	.word _handler // 0
	.word _handler // 0
	.word _handler // 0
	.word _handler // 0
	.word _handler // 0
	.word BootRAM

.global start
.type start, %function
start:
        str     fp, [sp, #-4]!
        add     fp, sp, #0
        sub     sp, sp, #132
        mov     r3, #0
        strb    r3, [fp, #-5]
loop:
	// SYS_WRITE0 (msg)
	mov r0,0x04
	ldr %r1,=msgloop
	bkpt 0xab

	b loop

_handler:
	nop
	b _handler

msgloop:
	.ascii "UAUAUA\n\0"	
