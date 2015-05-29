---
layout: post
title: "BKPT: Printf Service Calls on the Cortex-M0"
date: 2014-03-26 20:54:58 -0700
comments: true
categories: 
- ARM
- LLVM
- CLANG
- Bare-Metal
- Semi-hosting
- ARM-NONE-EABI
- QEMU
---
[{% img left /images/openjtag2_small.jpg "OpenJTAG" %}](http://www.openjtag.org) I tend to use semi-hosting via QEMU simluation and OpenJTAG/OpenOCD a lot; i.e.: for debugging, simulating sensor input and output, setting the RTC on a board for the first time and while the RMI Monitor interface is built-in to newlib stdio functions like printf, using a library like stdio is not really an option when a core only has 8k of ROM and 2k of RAM. So I need a really small printf routine to use on cores like the [Kinetis KL03](http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=KL03) (MKL03Z32CAF4R)

{% codeblock %}
MEMORY
{
  FLASH (rx)      : ORIGIN = 0x00000000, LENGTH = 0x02000 /* 8K */
  RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 0x00800 /* 2K */
}
{% endcodeblock %}

There are a lot of embedded printf routines posted with a variety of features and mine is just a collection/combo of various standard practices. The main difference of mine is it normally uses SVC/BKPT routines to perform the 'print' output and I *try* to make sure that optimizations via LLVM are taken advantage of.

So the question of how small of a routine is it as otherwise it is useless on something like the 'world's smallest ARM' [KL03](http://cache.freescale.com/files/microcontrollers/doc/fact_sheet/KINETISKL03CSPFS.pdf?fpsp=1&Parent_nodeId=1390844042446720950044&Parent_pageType=product)? Lets start with a newlib stdio version that uses the default syscalls that have RMI enabled. First you have to some heap as newlib printf using malloc. 
{% codeblock %}
#include <stdio.h>
#include "printf_svc.h"

int main (void)
{
	printf("BKPT Hello World\n");
	printf("How small is this?\n");
	
	svcExit(); // QEMU system exit
	
	while (1) { };
}
{% endcodeblock %}
The code size of the complete program above is huge if you are trying to run it on a Cortex-M0+ that only has 8K of ROM and 2k of RAM. Over 32K of ROM and 2+K of RAM just to output two lines of code! 
{% codeblock %}
   text    data     bss     dec     hex filename
  33160    2304    1256   36720    8f70 bin/main.axf
{% endcodeblock %}
So lets use a printf that is self-contained and uses no heap (malloc) and update our test code:
{% codeblock %}
#include "printf.h"
#include "printf_svc.h"

void putc (void* p, char c)
{
	svcPutChar(&c);
}

int main (void)
{
	set_putc(putc);
	printf("BKPT Hello World\n");
	printf("How small is this?\n");
	
	svcExit(); // QEMU system exit
	
	while (1) { };
}
{% endcodeblock %}

Now that is more like it, 2k of ROM and 64 bytes of RAM: Debug code size:
{% codeblock %}
   text    data     bss     dec     hex filename
   2102      64      10    2176     880 bin/main.axf
{% endcodeblock %}

In release configuration it is even better, ~1k of ROM is use, RAM is the same as expected; Release code size, LLVM compiled with -Os, linked with -O4:
{% codeblock %}
   text    data     bss     dec     hex filename
   1106      64      10    1180     49c bin/main.axf
{% endcodeblock %}

Adding 10 more printf statements that each contain a *different* but static 10 char string only adds 210 bytes to the ROM. Removing the 100 bytes for static string allocation, that breaks down to 10 bytes for the printf call. This can be improved upon a little, but 10 bytes is acceptable for now.
{% codeblock %}
   text    data     bss     dec     hex filename
   1316      64       8    1388     56c bin/main.axf
{% endcodeblock %}   

A quick break down of elf size:

**text**: your code, vector table plus constants.

**data**: Initialized variables, and it counts for RAM and FLASH. The linker allocates data in FLASH which then is *copied* from ROM to RAM in the startup code (*in startup.c via the Reset_Handler function in my case*)

**bss**: Uninitialized data in RAM which is initialized with zero in the startup code (*again see the Reset_Handler function*)

