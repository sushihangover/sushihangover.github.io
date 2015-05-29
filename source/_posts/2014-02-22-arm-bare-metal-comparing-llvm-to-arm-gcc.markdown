---
layout: post
title: "ARM Bare Metal Hello World: Comparing LLVM & ARM-GCC"
date: 2014-02-22 20:43:28 -0800
comments: true
categories:
- ARM
- Bare-metal
- LLVM
- CLANG
- ARM-GCC
- QEMU
---
With the ever maturing and stable ARM backend of LLVM it is hard to find information using it vs. the well known ARM-GCC release. 

So lets start with the most simple HelloWorld example and compare LLVM and [ARM-GCC](https://launchpad.net/gcc-arm-embedded).

[Balau's post](http://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/) is a popular one showing an ARM bare metal Hello World and test using QEMU, so lets start with that one. First, lets reproduce the compile/link steps to make sure it works:

```
arm-none-eabi-as -mcpu=arm926ej-s src/startup.s -o obj/startup.o
arm-none-eabi-gcc -c -mcpu=arm926ej-s -O0 src/HelloWorldSimple.c -o obj/HelloWorldSimple.o
arm-none-eabi-ld -T src/HelloWorldSimple.ld obj/HelloWorldSimple.o obj/startup.o -o bin/HelloWorldSimple.axf_gcc
arm-none-eabi-size bin/HelloWorldSimple.axf_gcc
qemu-system-arm -M versatilepb -m 128M -nographic -kernel bin/HelloWorldSimple.axf_gcc
Hello world!
QEMU: Terminated
```
Works just fine, so lets reproduce that using 	my [LLVM bare metal build](https://github.com/sushihangover/llvm_baremetal). All the compiler options are being shown even though some are defaulted in my build of LLVM so you can see everything it is required to get the LLVM bitcode conversion to produce a valid object file for our ARM target (I'm using the Clang driver, but you can use LLVM and pipe bitcode through the various tools so you can deeply control the optimization phase):
```
clang -c -target arm-none-eabi -mcpu=arm926ej-s -O0 -mfloat-abi=soft -g startup.s -o startup.o
clang -c -target arm-none-eabi -mcpu=arm926ej-s -O0 -mfloat-abi=soft -g HelloWorldSimple.c -o main.o
arm-none-eabi-ld -T HelloWorldSimple.ld main.o startup.o -o main.axf_llvm
qemu-system-arm -M versatilepb -m 128M -nographic -kernel main.axf_llvm
Hello world!
QEMU: Terminated
```
* target : Option providing the triple that you are 'targeting'
* mpcu : Option provding the ARM core that will be flashed
* mfloat-abi : Soft or Hard depending upon if your ARM core has an FPU implementation on it. Cores that can support an FPU does not mean your vendor's core has one, comes down to features/price of the core.

###### Note: In both, I am turning off the optimizers via the compile drivers.

Lets look at the size of the AXF (ARM Executable Format) produced by:

```
   text	   data	    bss	    dec	    hex	filename
    140	      0	      0	    140	     8c	bin/HelloWorldSimple.axf_gcc
    
   text	   data	    bss	    dec	    hex	filename
    150	      0	      0	    150	     96	bin/HelloWorldSimple.axf
```
There is a 10 byte difference, interesting... lets look at that a little more:

| llvm ||| arm-gcc | | |
| - | - | - | - | - | - |
| section  | size | addr|section |size| addr
|.startup  |16|   65536|.startup | 16 |65536
|.text |             108 |  65552|.text              |104   |65552
|.ARM.exidx|           8 |  65660|
|.rodata   |           4 |  65668|.rodata  |           20  | 65656
|.rodata.str1.1|      14 |  65672|
|.ARM.attributes|     40 |      0|.ARM.attributes |    46 |      0
|.comment       |     19 |      0|.comment  |         112  |     0
|Total          |    209||Total              |298|

###### Note: I ran strip on the arm-gcc version to remove the empty debug sections that gcc inserts automatically

The **.startup** are the same size since this code is assembly and no codegen or optimization will happen there.

It is interesting that LLVM inserts a **.ARM.exidx** section even though this is *only* .c code. I'll have to look at LLVM to see if *-funwind-tables* and/or *-fexceptions* are defaulted to on, but I disassemble it below so we can look at that as that is 8 bytes and accounts for the size difference in this really basic example.

> .ARM.exidx is the section containing information for unwinding the stack

###### Note: Understanding the [ARM ELF format](http://infocenter.arm.com/help/topic/com.arm.doc.ihi0044e/IHI0044E_aaelf.pdf) is not really required to do bare metal programming, but, understanding how your code is allocated and loaded can maek a world of differences when you are writting linker definitions files for different cores, so send a few minutes and read the 46 pages :-)

First the gcc disassembly so we can compare the LLVM version to it:
```
bin/HelloWorldSimple.axf_gcc:     file format elf32-littlearm
Disassembly of section .startup:
00010000 <_Reset>:
   10000:	e59fd004 	ldr	sp, [pc, #4]	; 1000c <_Reset+0xc>
   10004:	eb000015 	bl	10060 <c_entry>
   10008:	eafffffe 	b	10008 <_Reset+0x8>
   1000c:	00011090 	.word	0x00011090
Disassembly of section .text:
00010010 <print_uart0>:
   10010:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
   10014:	e28db000 	add	fp, sp, #0
   10018:	e24dd00c 	sub	sp, sp, #12
   1001c:	e50b0008 	str	r0, [fp, #-8]
   10020:	ea000006 	b	10040 <print_uart0+0x30>
   10024:	e59f3030 	ldr	r3, [pc, #48]	; 1005c <print_uart0+0x4c>
   10028:	e51b2008 	ldr	r2, [fp, #-8]
   1002c:	e5d22000 	ldrb	r2, [r2]
   10030:	e5832000 	str	r2, [r3]
   10034:	e51b3008 	ldr	r3, [fp, #-8]
   10038:	e2833001 	add	r3, r3, #1
   1003c:	e50b3008 	str	r3, [fp, #-8]
   10040:	e51b3008 	ldr	r3, [fp, #-8]
   10044:	e5d33000 	ldrb	r3, [r3]
   10048:	e3530000 	cmp	r3, #0
   1004c:	1afffff4 	bne	10024 <print_uart0+0x14>
   10050:	e24bd000 	sub	sp, fp, #0
   10054:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
   10058:	e12fff1e 	bx	lr
   1005c:	101f1000 	.word	0x101f1000
00010060 <c_entry>:
   10060:	e92d4800 	push	{fp, lr}
   10064:	e28db004 	add	fp, sp, #4
   10068:	e59f0004 	ldr	r0, [pc, #4]	; 10074 <c_entry+0x14>
   1006c:	ebffffe7 	bl	10010 <print_uart0>
   10070:	e8bd8800 	pop	{fp, pc}
   10074:	0001007c 	.word	0x0001007c
```
Now the LLVM version:
```
bin/HelloWorldSimple.axf:     file format elf32-littlearm
Disassembly of section .startup:
00010000 <_Reset>:
   10000:	e59fd004 	ldr	sp, [pc, #4]	; 1000c <_Reset+0xc>
   10004:	eb000016 	bl	10064 <c_entry>
   10008:	eafffffe 	b	10008 <_Reset+0x8>
   1000c:	00011098 	.word	0x00011098
Disassembly of section .text:
00010010 <print_uart0>:
   10010:	e24dd008 	sub	sp, sp, #8
   10014:	e1a01000 	mov	r1, r0
   10018:	e58d0004 	str	r0, [sp, #4]
   1001c:	e58d1000 	str	r1, [sp]
   10020:	e59d0004 	ldr	r0, [sp, #4]
   10024:	e5d00000 	ldrb	r0, [r0]
   10028:	e3500000 	cmp	r0, #0
   1002c:	0a000009 	beq	10058 <print_uart0+0x48>
   10030:	eaffffff 	b	10034 <print_uart0+0x24>
   10034:	e59d0004 	ldr	r0, [sp, #4]
   10038:	e5d00000 	ldrb	r0, [r0]
   1003c:	e59f101c 	ldr	r1, [pc, #28]	; 10060 <print_uart0+0x50>
   10040:	e5911000 	ldr	r1, [r1]
   10044:	e5810000 	str	r0, [r1]
   10048:	e59d0004 	ldr	r0, [sp, #4]
   1004c:	e2800001 	add	r0, r0, #1
   10050:	e58d0004 	str	r0, [sp, #4]
   10054:	eafffff1 	b	10020 <print_uart0+0x10>
   10058:	e28dd008 	add	sp, sp, #8
   1005c:	e12fff1e 	bx	lr
   10060:	00010084 	.word	0x00010084
00010064 <c_entry>:
   10064:	e92d4800 	push	{fp, lr}
   10068:	e1a0b00d 	mov	fp, sp
   1006c:	e59f0004 	ldr	r0, [pc, #4]	; 10078 <c_entry+0x14>
   10070:	ebffffe6 	bl	10010 <print_uart0>
   10074:	e8bd8800 	pop	{fp, pc}
   10078:	00010088 	.word	0x00010088
```
[{% img left /images/llvm-gcc-diff_small.png "LLVM vs. GCC Hello World ARM Bare Metal" %}](/images/llvm-gcc-diff_large.png) We can ignore the _Reset section as that is hand coded assembly and the same for both.

The c_entry is interesting as LLVM uses a move to copy the stack register to fp (r11 = frame pointer) which I what I would do, but arm-gcc does an ""add"" to get fp into the sp and does that by adding fp to register #4(?) This is flagged as general variable for gcc... I am slightly confused by gcc's choice to do that, now that question is when would #4 not contain zero? The rest of this function is the same between the two compilers.

The print_uart0 function is a hack function as it does not implement FIFO/flow-control to an actual UART, but in this case it points to a memory address where the discontinued ARM Versatile PB dev-board does have a UART and QEMU board simulation echos those writes. I am not going to do a line by line comparision of the generated code as for un-optimized code they are both getting the job done, but in slightly different ways in almost the same number of instructions.

So we are able to produce a working bare metal ARM AXF from LLVM and next time, I will spend a little time on compiler optimizations to see how the two code generators/optimizisers compare...
