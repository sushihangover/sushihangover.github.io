---
layout: post
title: "Embedded 'Bare-Metal' ARM Development - Part 1"
date: 2014-02-14 06:01:48 -0800
comments: true
categories: 
- ARM
- Embedded
- Bare-metal
- Programming
- ARM-Beginners
---
This is a start of a series of posts related to getting into ARM-based Cortex core programming. So I started on a quest to checkout ARM Embedded 'Bare-Metal' compilers and tools and in the end(?) cleared up my confusion about what I can and can not do on a restricted budget and time. 

The reasoning behind this is I wanted to do some bare metal ARM C coding for a project that might become some type of OSHW or even a commerical offering so I wanted to keep my options open, try to future proof my decisions. 

Instead of falling back to my comfort zone with AVR 8-bit MCU C-codings and forcing a project that really is beyond what AVRs offer (mainly execution speed and size related plus I tired of all the bit-banging to 'add' protocals) and the fact that ARM-based core offerings that are now available have not just tons of digital GPIOs, footprints that are as small, but also have great signal processing options (input and output) that can match or exceed what is available in Amtel's AVR 8-bit line up and** match them at price.** 

Just compare the Atmel AVR line up to their D20 ARM-core offerings and for non-legacy new embedded projects the decision matrix might be almost equal, but if you are adding 'future-proofing' to the mix and what MCUs will be offering in the next decade, ARM-based MCUs become a clear choice (would love to hear someone's counter-point!).

So first I figured I look at ARM compilers/linkers as if you can not compile/link your code, than you are just screwed ;-) So in terms of ARM compilers available there **is** more than one:

* [GNU C Compiler](https://launchpad.net/gcc-arm-embedded)(1)
* [CodeWarrior](http://www.freescale.com/codewarrior) ARM C Compiler(2)
* [IAR](http://www.iar.com) ARM C Compiler
* [ImageCraft](https://www.imagecraft.com) C Compiler Tools 
* [Kiel](http://www.keil.com) ARM C/C++ Compiler(3)
* [ARM DS-5](http://ds.arm.com) RealView C/C++ Compiler(3)
* ARM [Clang](http://clang.llvm.org)/[LLVM](http://llvm.org) Compiler
* Microsoft Visual Studio C/C++ Native ARM Compiler(4)

###### 	* 1: Technically the launchpad link is the 'output' of an ARM version of GCC and binutils but is the best starting point for info on the ARM version as it is the offical distro end-point ;-)
{% blockquote %}
ARM employees are maintaining this project. Contributing to this project should be via GCC trunk http://gcc.gnu.org and binutils trunk http://www.gnu.org/software/binutils/. This launchpad project is for communication and downloading. No code change is done in lp project.
{% endblockquote %}
###### 	* 2: The 'Freescale Kinetis Compiler' is in maintance mode. The GNU compiler is the 'active' mainline of ARM compiler within CodeWarror now and thus I am not looking at this one at all as it fails my future proofing rules. For existing 'legacy' embedded projects based on it, [MetroWorks](http://en.wikipedia.org/wiki/CodeWarrior) was acquired by Motorola which was then included in the Freescale spinoff, so go to Freescale if you need a version...
###### 	* 3: ARM acquired Kiel and thus the compiler IP from the two is now within one toolchain simply called "ARM Compiler toolchain" and thus RealView no longer exists, but some old-timers ;-) still call the new version by the RealView name. Note: There are still different development IDEs from each company; Kiel has uVision and ARM has Eclipse intergation (via a standalone version or plugins for your existing install), but again, they use just the 'new' version of the compiler, but more on the IDEs in a future post of this series.
###### 	* 4: Yes, you can produce ARM code as you would have to in order to cross-compile Windows RT apps, but can you do bare metal programming with it? I am not sure if you can get a CMSIS setup using it and handle the .S/SystemInit/Reset_Handler/__main() of bare metal programming... 
###### 	* If I missed one, please let me know!.

So an ARM compiler choice is not as easy as just saying GNU/GCC as you have other options and while in the end they all produce an ELF/BIN that you flash on your bare-metal ARM, how that binary gets created and the size and speed of the ARM code and/or THUMB instructions that was produced can vary greatly...

Next time, we look into some compilers...


