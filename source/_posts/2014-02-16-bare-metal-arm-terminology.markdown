---
layout: post
title: "Bare Metal ARM Terminology"
date: 2014-02-16 21:35:45 -0800
comments: true
categories: 
- ARM
- Bare-metal
- Cortex
- M0
- arm-none-eabi
---
[CMSIS](http://www.arm.com/products/processors/cortex-m/cortex-microcontroller-software-interface-standard.php) : ARM® **C**ortex™ **M**icrocontroller **S**oftware **I**nterface **S**tandard

Thread mode : 
> Used to execute application software. The processor enters Thread mode when it comes out of reset.

Privileged or unprivileged software execution : 
> Cortex-M0 do not support different privilege levels. Software execution is always privileged; i.e. Software can access all the features of the processor. Other ARM series do support pri and unpri execution.

Handler mode :
> Used to handle exceptions. The processor returns to Thread mode when it has finished all exception processing

SysTick : A 24-bit count-down timer. 
> This timer is the basis for a *ticktimer* for an embedded Real Time Operating System (RTOS) like FreeRTOS. And, yes, it can be used as a simple counter.

System Control Block : 
> Provides system implementation information and system control, including configuration, control,and reporting of system exceptions.

NVIC : Nested Vectored Interrupt Controller
> In the Cortex-M0, Cortex-M0+ and Cortex-M1 processors, the NVIC support up to 32 interrupts (IRQ), a Non-Maskable Interrupt (NMI) and various system exceptions, other M series, like M3/M4, can support up to 240 IRQs.
Tail chaining > If another exception is pending when an ISR exits, the processor does not restore all saved registers from the stack and instead moves on to the next ISR. This reduces the latency when switching from one exception handler to another.