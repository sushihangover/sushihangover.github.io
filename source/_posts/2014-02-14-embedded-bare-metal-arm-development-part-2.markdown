---
published: false
layout: post
title: "Embedded 'Bare Metal' ARM Development - Part 2"
date: 2014-02-14 10:12:07 -0800
comments: true
categories: 
- ARM
- Embedded
- Bare-metal
- Programming
- Compiler
- ARM-Beginners
---
Part 2 of my dive into 'Bare Metal' ARM Development, Part 1 is [here](/embedded-bare-metal-arm-development-part-1/)

So the compiler shortlist at this point:

* [GNU C Compiler](https://launchpad.net/gcc-arm-embedded)
* [IAR](http://www.iar.com) ARM C Compiler
* [ImageCraft](https://www.imagecraft.com) C Compiler Tools 
* [[ARM](http://ds.arm.com/)/Kiel](http://www.keil.com) ARM C/C++ Compiler
* [Clang](http://clang.llvm.org)/[LLVM](http://llvm.org) ARM Compiler

Note: That list is in no particular order at all...

And just to be clear, I am talking about bare-metal C/C++ cross compilers, and all of these world be considered [cross compilers](http://en.wikipedia.org/wiki/Cross_compiler) since there is NO operating system on your bare-metal ARM core to actually host a native compiler. 

There are complete OSs that run on ARM [SoC](http://en.wikipedia.org/wiki/System_on_a_chip). You can look at hobbyist/entry level boards like [BeagleBoard](http://en.wikipedia.org/wiki/BeagleBoard) or [Raspberry Pi](http://en.wikipedia.org/wiki/Raspberry_Pi) as just a couple of the many boards that can run a Linux kernel on ARM. [Window CE](http://en.wikipedia.org/wiki/Windows_CE), now called Windows Embedded Compact 2013, is available for ARM (among other cpus) as a real-time operating system with a  licensed shared source code based kernel from Microsoft and there are other no n-Linux/Microsoft OSs (free or not) that are 'hostable' on ARM, but we are looking at bare-metal only, so cross-compiling is we have to do here.

Out of the five on the list, there are two 'free' compilers with no type of restrictions on the binaries that are produced are GCC and LLVM. In terms of OSS support/acceptance, GCC for ARM is the most well known and community supported. 

ARM Embedded GCC via [launchpad](https://launchpad.net/gcc-arm-embedded) has binary and source downloads. Binaries are available for Windows, OS-X and Linux along with build instructions. My experience so far is most in the embedded hobbyist community will point you to GCC and never tell you about another option. I think this is true mainly do to the fact those people are 'hobbyist' and not professional embedded hardware|software people. The pro will tell you about the market options, plus some will point out that compilers such as from IAR and Kiel will produce faster and/or smaller ARM code then GCC. Efficent code generation and optimization is an art in and off itself but for free, GCC-ARM works 'well enough'. 

Note: A while back I was involved in upgrading a existing GCC-AVR based software/hardware project involving an AVR 8-bit and got stuck towards the end of the projects as we had exceeded the chip's 32k of flash. Upscaling the chip at the time with not possible, first BOM cost and new board development and second there was existing field-deployed hardware to deal with). We're looking at removing features some feature to get it 'out the door' but one of the 'hardware engineers' that we were working with (we were all contractors) had a license of IAR-AVR and its code optimizer squeezed our bin by almost 5% with zero source code changes. Thus our customer bought that compiler to produce the firmware for final field deployment... 

But that does not mean you should not try the others on the list, but more on that later.

Clang/LLVM is the newest kid on the block for ARM bare-metal work.








