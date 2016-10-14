.thumb
.cpu cortex-m3
.syntax unified

.equ STACKINIT,0x20002000

.macro FUNC name
	.func \name,\name
	.type \name,%function
	.thumb_func
	.align
	\name\():
.endm

.macro ENDFUNC name
	.size
	.pool
	.endfunc
.endm

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
	.word SysTick_Handler // SysTick_Handler
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

.equ SYSTICK_CSR, 0xE000E010
.equ SYSTICK_RVR, 0xE000E014
.equ SYSTICK_CVR, 0xE000E018

.equ RCC_AHBENR,  0x4002381C
.equ GPIOB_MODER, 0x40020400
.equ GPIOB_ODR,   0x40020414

.global start
.type start, %function
start:
	ldr r6, = RCC_AHBENR
	mov r0, 0x2
	str r0, [r6]

	ldr r6, = GPIOB_MODER
	ldr r0, = 0x00005000
	str r0, [r6]

	ldr r6, = SYSTICK_CSR
	ldr r0, = 0x00000000
	str r0, [r6]

	ldr r6, = SYSTICK_RVR
	ldr r0, = 0x01FFFFFF
	str r0, [r6]

	ldr r6, = SYSTICK_CVR
	ldr r0, = 0
	str r0, [r6]

	ldr r6, = SYSTICK_CSR
	ldr r0, = 0x00000007
	str r0, [r6]
wait:
/*
	ldr r6, = GPIOB_ODR
	mov r2, 0x00000040
	str r2, [r6]

	wfi

	ldr r6, = GPIOB_ODR
	ldr r2, = 0x00000000
	str r2, [r6]

	wfi
*/
	wfi

	// SYS_WRITE0 (msg)
	mov r0,0x04
	ldr %r1,=msgloop
	bkpt 0xab

	b wait

_handler:
	nop
	b _handler

.type SysTick_Handler, %function
SysTick_Handler:
	stmdb sp!,{r0,r1,sl,lr}

	// SYS_WRITE0 (msg)
	mov r0,0x04
	ldr %r1,=msg
	bkpt 0xab

	ldmia sp!,{r0,r1,sl,lr}
	bx lr

msgloop:
	.ascii "Loop!\n\0"
msg:
	.ascii "SysTick_Handler!\n\0"
	len = . -msg
args:
	.word 2
	.word msg
	.word len
