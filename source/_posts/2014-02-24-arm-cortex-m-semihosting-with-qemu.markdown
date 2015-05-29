---
layout: post
title: "ARM Cortex-M Semihosting"
date: 2014-02-24 21:02:34 -0800
comments: true
categories: 
- ARM
- Cortex-M
- Bare-metal
- LLVM
- CLANG
- ARM-GCC
- QEMU
---
[{% img left /images/ARM_Semihosting.png "ARM Semihosting" %}](/images/ARM_Semihosting_large.png) **[What is semihosting?](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0471c/Bgbjjgij.html)** *...Examples of these facilities include keyboard input, screen output, and disk I/O. For example, you can use this mechanism to enable functions in the C library, such as printf() and scanf(), to use the screen and keyboard of the host instead of having a screen and keyboard on the target system...*

So you need to output some debug messages via your host debugging session (via JTAG or such) or working with QEMU to prototype some ARM code? Well semihosting is simple use, but it can come at a large price in memory and overhead if you use stdio to do it...

You can skip the "#include <stdio.h>" and linking the semihosting newlib library (assuming you have the syscalls inplementated) and just use some simple inline assembly to get the job done.

Lets take a quick look at two of the twenty-some service calls (SVC) that are available, SYS_WRITEC (0x03) and WRITE0 (0x04).

##### * SYS_WRITEC outputs a single character, an address pointer to that character is loaded in register R1. Register R0 is loaded with 0x03 and then you can execute a *SuperVisor Call* (SVC 0x00123456).
##### * SYS_WRITE0 outputs a null-term string, the string's beginning address is stored in R1, R0 is loaded with 0x04 and you execute a supervisor call again.

If we translate that knowledge into inline assembly:
{% codeblock lang:c++ main.c %}
void main() {
  int SYS_WRITEC = 0x03;
  int SYS_WRITE0 = 0x04;
  register int reg0 asm("r0");
  register int reg1 asm("r1");
  char outchar = '_';

  // A 'NOP' so we can 'see' the start of the folllowing svc call
  asm volatile("mov r0,r0");

  outchar = '!';
  reg0 = SYS_WRITEC;
  reg1 = (int)&outchar;
  asm("svc 0x00123456");
 
  // A 'NOP' so we can 'see' the start of the folllowing svc call
  asm volatile("mov r0,r0");
  reg0 = SYS_WRITEC;
  outchar = '\n';
  reg1 = (int)&outchar;
  asm("svc 0x00123456");

  // A 'NOP' so we can 'see' the start of the folllowing svc call
  asm volatile("mov r0, r0");

  reg0 = SYS_WRITE0;
  reg1 = (int)&"Print this to my jtag debugger\n";
  asm("svc 0x00123456");
}
{% endcodeblock %}
###### Note: This is not pretty inline styling as it is meant to break each step down. Normally you would create a couple of functions (i.e: a 'PutChar' for SYS_WRITEC) and include the R0/R1 clobbers, etc... 

And the output that we get:
```
qemu-system-arm -nographic -monitor null -serial null -semihosting -kernel main.axf 
!
Print this to my jtag debugger
```

{% codeblock lang:c-objdump main.o: file format elf32-littlearm %}
00000000 <main>:
   0:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
   4:	e28db000 	add	fp, sp, #0
   8:	e24dd014 	sub	sp, sp, #20
   c:	e3a03003 	mov	r3, #3
  10:	e50b3008 	str	r3, [fp, #-8]
  14:	e3a03004 	mov	r3, #4
  18:	e50b300c 	str	r3, [fp, #-12]
  1c:	e3a0305f 	mov	r3, #95	; 0x5f
  20:	e54b300d 	strb	r3, [fp, #-13]
  24:	e1a00000 	nop			; (mov r0, r0)
  28:	e3a03021 	mov	r3, #33	; 0x21
  2c:	e54b300d 	strb	r3, [fp, #-13]
  30:	e51b0008 	ldr	r0, [fp, #-8]
  34:	e24b300d 	sub	r3, fp, #13
  38:	e1a01003 	mov	r1, r3
  3c:	ef123456 	svc	0x00123456
  40:	e1a00000 	nop			; (mov r0, r0)
  44:	e51b0008 	ldr	r0, [fp, #-8]
  48:	e3a0300a 	mov	r3, #10
  4c:	e54b300d 	strb	r3, [fp, #-13]
  50:	e24b300d 	sub	r3, fp, #13
  54:	e1a01003 	mov	r1, r3
  58:	ef123456 	svc	0x00123456
  5c:	e1a00000 	nop			; (mov r0, r0)
  60:	e51b000c 	ldr	r0, [fp, #-12]
  64:	e59f3010 	ldr	r3, [pc, #16]	; 7c <main+0x7c>
  68:	e1a01003 	mov	r1, r3
  6c:	ef123456 	svc	0x00123456
  70:	e28bd000 	add	sp, fp, #0
  74:	e8bd0800 	ldmfd	sp!, {fp}
  78:	e12fff1e 	bx	lr
  7c:	00000000 	.word	0x00000000
{% endcodeblock %}

PS: SYS_TMPNAM and SYS_READC are not implemented in Qemu (up to and including 1.7.0), so consult the "qemu/target-arm/arm-semi.c" source if you are have questions about how those SVC calls are implemented.