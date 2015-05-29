---
layout: post
title: "ARM Cortex-M3 Bare-metal with NEWLIB"
date: 2014-03-04 18:18:56 -0800
comments: true
categories: 
- ARM
- QEMU
- NEWLIB
- Bare-metal
- Clang
- LLVM
- arm-none-eabi
---
I am working on a custom NEWLIB but first I wanted to make sure that [NEWLIB](https://sourceware.org/newlib/) compiled for ARM-NONE-EABI works out of the box with my ARM bare-metal [Clang/LLVM](http://llvm.org) build and Qemu.

Lets start with a simple main() that includes printf, puts and malloc. The first test is related to malloc, as if your linker script is not setting up your heap properly and providing the heap "end" address as defined in NEWLIB then not much else is going to work (i.e. printf uses malloc). If malloc works, then lets so some printfs including one with a random string. After that lets keep increasing the size of our mallocs till we run out of heap space.

{% codeblock lang:c %}
#include <stdio.h>      /* printf, scanf, NULL */
#include <stdlib.h>     /* malloc, free, rand */

int main ()
{
  extern char _heap_start; /* Defined by the linker from src/cortex_M3.ld */
  extern char _heap_end; /* Defined by the linker from src/cortex_M3.Ld. */
  int i,n;
  char * buffer;

  i = 43;
  buffer = (char*) malloc (i);
  if (buffer==NULL)
  {
     puts ("Malloc failed\n");
     exit (1);
  }

  printf ("Printf string\n");
  for (n=0; n<i; n++)
  {
    buffer[n]=rand()%26+'a';
  }
  buffer[i]='\0';
  printf ("Random string: %s\n",buffer);

  i = 32;
  do
  {
     buffer = realloc(buffer, i);
     if (buffer == NULL)
     {
        puts("Out of memory!\n");
        exit (1);
     } else {
        printf("%d bytes @ address 0x%X (Low=0x%X:Hi=0x%X)\n",
           i,
           (unsigned int)buffer,
           (unsigned int)&_heap_start,
           (unsigned int)&_heap_end
       );
       i = i + 32;
     }
  } while (buffer != NULL);
 
  exit(0); /* cause qemu to exit */
  return 0;
}
{% endcodeblock %}

Easy enough, so lets create a linker script that is geared for a Cortex-M3, the main section to pay attention to in this example is **.heap**:
{% codeblock lang:bash %}
OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")

ENTRY(Reset_Handler)

/* Specify the memory areas */
MEMORY
{
  FLASH (rx)      : ORIGIN = 0x00000000, LENGTH = 0x10000 /* 64K */
  RAM (xrw)       : ORIGIN = 0x00020000, LENGTH = 0x04000 /* 16K */
}

heap_size = 0x800; /* 2K */

SECTIONS {
    . = ORIGIN(FLASH);

    .vectors :
    {
        . = ALIGN(4);
        KEEP(*(.vectors)) /* Startup code */
        . = ALIGN(4);
    } >FLASH

    .text :
    {
        . = ALIGN(4);
        _start_text = .;
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
        _end_text = .;
    } >FLASH

        .ARM.extab : 
        {
                *(.ARM.extab* .gnu.linkonce.armextab.*)
        } > FLASH

        __exidx_start = .;
        .ARM.exidx :
        {
                *(.ARM.exidx* .gnu.linkonce.armexidx.*)
        } > FLASH
        __exidx_end = .;

    _end_text = .;

    .data : AT (_end_text)
    {
        _start_data = .;
        *(.data)
        *(.data*) 
        . = ALIGN(4);
        _end_data = .;
    } >RAM 

    .bss :
    {
         . = ALIGN(4);
        _start_bss = .;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _end_bss = .;
    } >RAM

    . = ALIGN(4);
    .heap :
    {
        __end__ = .;
        /* _heap_start = .; */
        /* "end" is used by newlib's syscalls!!! */
        PROVIDE(end = .);
        PROVIDE(_heap_start = end );
        . = . + heap_size;
        PROVIDE(_heap_end = .);
    } >RAM

    .ARM.attributes 0 : { *(.ARM.attributes) }

    .stack_dummy (COPY):
    {
        _end_stack = .;
        *(.stack*)
    } > RAM
    
    /* Set stack top to end of RAM, and stack limit move down by
     * size of stack_dummy section */
    _start_stack = ORIGIN(RAM) + LENGTH(RAM);
    _size_stack = _start_stack - SIZEOF(.stack_dummy);
    PROVIDE(__stack = _start_stack);
        
    /* Check if data + heap + stack exceeds RAM limit */
    ASSERT(_size_stack >= _heap_end, "region RAM overflowed with stack")
}
_end = .;
{% endcodeblock %}

Ok, now that we have a linker script that defines our stack and heap properly, lets reuse our startup.c routine for the Cortex-M cores and compile it all with CLang/LLVM and link it with arm-none-eabi-ld:

{% codeblock lang:bash %}
clang -g -nostdlib -ffreestanding  -O0  -target arm-none-eabi -mcpu=cortex-m3  -mfloat-abi=soft -mthumb -I/Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/include -I/Users/administrator/Code/llvm_superproject/install/arm-none-eabi/arm-none-eabi/include  -o obj/printf_with_malloc.o -c src/printf_with_malloc.c
clang -g -nostdlib -ffreestanding  -O0  -target arm-none-eabi -mcpu=cortex-m3  -mfloat-abi=soft -mthumb -I/Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/include -I/Users/administrator/Code/llvm_superproject/install/arm-none-eabi/arm-none-eabi/include  -o obj/startup.o -c src/startup.c
arm-none-eabi-ld -Map bin/main.axf.map -T src/cortex_M3.ld --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/lib/thumb/thumb2 --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/lib/thumb  --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/lib  --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/lib/gcc/arm-none-eabi/4.8.3/thumb -g   obj/printf_with_malloc.o obj/startup.o --start-group -lgcc -lc --end-group -o bin/main.axf
{% endcodeblock %}

And now we can run a simulation of it with QEMU:

{% codeblock lang:bash %}
qemu-system-arm -cpu cortex-m3  -semihosting -nographic -kernel  bin/main.axf
Puts string
Printf string
Random string: lvqdyoqykfdbxnqdquhydjaeebzqmtblcabwgmscrno
32 bytes @ address 0x209C0 (Low=0x209B4:Hi=0x211B4)
64 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
96 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
128 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
160 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
192 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
224 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
256 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
288 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
320 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
352 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
384 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
416 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
448 bytes @ address 0x20DF8 (Low=0x209B4:Hi=0x211B4)
Out of memory!
{% endcodeblock %}