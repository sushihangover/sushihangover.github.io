---
layout: post
title: "Cortex-M0 & M3 SysTick: Polling vs. Interrupt driven"
date: 2014-03-09 19:24:34 -0700
comments: true
categories: 
- ARM
- Cortex-M0
- Cortex-M3
- Bare-metal
- LLVM
- CLANG
- QEMU
- SysTick
- arm-none-eabi
- CMSIS
---
[{% img left /images/ARM_CortexM_CMSIS_small.png "CMSIS Version 3 Block Diagram (Source: Arm.com)" %}](/images/ARM_CortexM_CMSIS_large.png)
This time around, lets use the CMSIS abstraction layer to access the SysTick core peripheral.

This peripheral can be used to provide the core timer to an embedded RTOS kernel, such as FreeRTOS, or to provide application timing events to know when to read some attached sensors or such. In the most basic form, it provides a pollable countdown value. This value is decreased from a user settable value ([Reload Value](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dai0179b/ar01s02s08.html)) on every clock tick. If it configured as an interrupt, the function assigned activates every n+1 clock ticks.

I used Clang/LLVM to compile a simple app that shows you how to set the reload value, read (poll) the internal SysTick value or enable it as an interrupt.

The semihosting output of this app (via QEMU):
{% codeblock lang:bash %}
qemu-system-arm -M lm3s811evb -cpu cortex-m3 -semihosting -kernel  bin/main.axf
SysTick should not be active yet...
...Current value: 0
...Current value: 0
...Current value: 0
...Current value: 0
...Current value: 0
...Current value: 0
...Current value: 0
...Current value: 0
...Current value: 0
...Current value: 0
Enable SysTick and lets poll it...
...Current value: 6913
...Current value: 2825
...Current value: 2450
...Current value: 2138
...Current value: 1825
...Current value: 1525
...Current value: 1225
...Current value: 913
...Current value: 613
...Current value: 313
Enable SysTick Interrupts and watch local var get incremented...
...myTicks = 1; SysTick->VAL = 0
...myTicks = 2; SysTick->VAL = 3425
...myTicks = 3; SysTick->VAL = 8725
...myTicks = 4; SysTick->VAL = 2938
...myTicks = 5; SysTick->VAL = 8113
...myTicks = 6; SysTick->VAL = 2550
...myTicks = 7; SysTick->VAL = 7725
...myTicks = 8; SysTick->VAL = 2938
...myTicks = 9; SysTick->VAL = 8125
...myTicks = 10; SysTick->VAL = 2563
...myTicks = 11; SysTick->VAL = 8100
...myTicks = 12; SysTick->VAL = 3038
{% endcodeblock %}

{% codeblock lang:c %}
#include <stdlib.h>

#include "CortexM3_xx.h"
#include <core_cm3.h>
#include <stdint.h> 
#include "svc.h"

volatile uint32_t myTicks;

void SysTick_Handler(void) {
  myTicks++;
  printf("...myTicks = %lu; SysTick->VAL = %lu\n", myTicks, SysTick->VAL);
}

int main(void) {
	printf("SysTick should not be active yet...\n");
	for (int x=0; x<10; x++) {
		printf("...Current value: %lu\n", SysTick->VAL);
	}
	printf("Enable SysTick and lets poll it...\n");
	
	volatile uint32_t clock = 10000;
	SysTick->LOAD = clock - 1;
	/*
		* SysTick_CTRL_CLKSOURCE_Msk : Use core's clock
		* SysTick_CTRL_ENABLE_Msk    : Enable SysTick
		* SysTick_CTRL_TICKINT_Msk   : Active the SysTick interrupt on the NVIC
	*/ 
	SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
	for (int x=0; x<10; x++) {
		printf("...Current value: %lu\n", SysTick->VAL);
	}

	printf("Enable SysTick Interrupts and watch local var get incremented...\n");
	myTicks = 0;
	SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk |  SysTick_CTRL_ENABLE_Msk | SysTick_CTRL_TICKINT_Msk;
	
	while(myTicks <= 10) {
		asm("nop"); // Do nothing till SysTick_Handler been been called at least 10 times
	}
	exit(0);
}
{% endcodeblock %}

