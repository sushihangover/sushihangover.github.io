---
layout: post
title: "GCC 4.9 is out with ARM enhancements"
date: 2014-04-22 18:35:15 -0700
comments: true
categories: 
- ARM
- GCC 
- BARE-METAL
- ARM-NONE_EABI
---
GCC 4.9 is out with in the wild now with a long list of ARM enhancements. I'm hoping to look at into a few of the items on their [change/log list](http://gcc.gnu.org/gcc-4.9/changes.html).

One of them is the "**-mslow-flash-data**", I'm really interested in what they are doing when this option is used. Using QEMU and LLVM I create variable and function usage maps during the last stage of speed optimizations and tag the high use items to be moved to RX to any remaining XRW (RAM) during startup in the reset_handler (would really be nice to burn that routine in the feedback loop of the LLVM profiler, need to create perf records that could be fed to the [LLVM AutoFDO Converter](http://lists.cs.uiuc.edu/pipermail/llvmdev/2014-April/072138.html) that Google did and have it spew out 'linker scriptets'.... too many ideas, not enough time at get them all done ;-)

So what is listed in the man for "-mslow-flash-data" is:
**Assume loading data from flash is slower than fetching instruction. Therefore literal load is minimized for better performance. This option is only supported when compiling for ARMv7 M-profile and off by default.** 

{% pullquote %}
{"Is ARMv6 M-profile really excluded in whatever they are doing with mslow-flash-data? Only M3 and M4x support? Need to find the commit(s) for this feature."}

Also everyone always loves items like: **A number of code generation improvements for Thumb2 to reduce code size when compiling for the M-profile processors**. Free code size reduction is always a great thing when during with those dirt-cheap [Nuvoton NuMicro M0 chips](http://www.nuvoton.com/NuvotonMOSS/Community/ProductInfo.aspx?tp_GUID=5dbf7d7a-b6df-4fe1-91c9-063449500ce7), well, assuming it comes with using "-Os" and not with a speed impact when throughput matters more... small is good, but it is not always what everyone needs.

And the "[Local Register Allocator](http://en.wikipedia.org/wiki/Register_allocation)" is turned on for ARM by default:
`The Local Register Allocator, introduced in GCC 4.8.0 for ia32 and x86-64 targets only, is now used also on the Aarch64, ARM, S/390 and ARC targets by default..`
{% endpullquote %}

Getting it compiled on OS-X proved to be a pain as I do not have a native build of GCC, just clang acting as gcc, and could not get a  ARM-NONE-EABI 4.9.0 version built using clang. One of the issues that I could not work around was:
{% codeblock %}
clang: error: unsupported option '-static-libgcc'
{% endcodeblock %}
Well, duh..., clang does not support that option, but not clear on why that is showing up under the 4.9.0 build using the same configure options as 4.8.x. Manually hacking on the make files to get passed this and I ended up getting into other issues, so I give up and built an OS-X 'native' gcc that I then used to build the ARM-NONE-EABI cross-compiler to get around the orginal "-static-libgcc" issue. Never had any problems doing a "make all-gcc" or "make all" to build gcc 4.8.x with clang->gcc before.

So I build a native version on the master branch (4.10.x now):
{% codeblock %}
./gcc --version
gcc (GCC) 4.10.0 20140422 (experimental)
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
{% endcodeblock %}

And then used that to build my arm-none-eabi cross-compiler,  yep, living on the bleeding edge with gcc and LLVM ;-)
{% codeblock %}
./arm-none-eabi-gcc --version
arm-none-eabi-gcc (GCC) 4.10.0 20140422 (experimental)
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
...
  Known ARM architectures (for use with the -march= option):
    armv2 armv2a armv3 armv3m armv4 armv4t armv5 armv5e armv5t armv5te armv6
    armv6-m armv6j armv6k armv6s-m armv6t2 armv6z armv6zk armv7 armv7-a armv7-m
    armv7-r armv7e-m armv7ve armv8-a armv8-a+crc iwmmxt iwmmxt2 native
...
{% endcodeblock %}

FYI: I'm on OS-X 10.9.2:
{% codeblock %}
Software  OS X 10.9.2 (13C64)
clang --version
Apple LLVM version 5.1 (clang-503.0.40) (based on LLVM 3.4svn)
gcc --version
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Apple LLVM version 5.1 (clang-503.0.40) (based on LLVM 3.4svn)
Target: x86_64-apple-darwin13.1.0
Thread model: posix
{% endcodeblock %}

ARM enhancements from the change list include:

* **ARM:**
+ Use of Advanced SIMD (Neon) for 64-bit scalar computations has been disabled by default. This was found to generate better code in only a small number of cases. It can be turned back on with the -mneon-for-64bits option.
+ Further support for the ARMv8-A architecture, notably implementing the restriction around IT blocks in the Thumb32 instruction set has been added. The -mrestrict-it option can be used with -march=armv7-a or the -march=armv7ve options to make code generation fully compatible with the deprecated instructions in ARMv8-A.
+ Support has now been added for the ARMv7ve variant of the architecture. This can be used by the -march=armv7ve option.
+ The ARMv8-A crypto and CRC instructions are now supported through intrinsics and are available through the -march=armv8-a+crc and mfpu=crypto-neon-fp-armv8 options.
+ LRA is now on by default for the ARM target. This can be turned off using the -mno-lra option. This option is purely transitionary command line option and will be removed in a future release. We are interested in any bug reports regarding functional and performance regressions with LRA.
+ **A new option -mslow-flash-data to improve performance of programs fetching data on slow flash memory has now been introduced for the ARMv7-M profile cores.**
+ A new option -mpic-data-is-text-relative for targets that allows data segments to be relative to text segments has been added. This is on by default for all targets except VxWorks RTP.
+ A number of infrastructural changes have been made to both the ARM and AArch64 backends to facilitate improved code-generation.
+ GCC now supports Cortex-A12 and the Cortex-R7 through the -mcpu=cortex-a12 and -mcpu=cortex-r7 options.
+ GCC now has tuning for the Cortex-A57 and Cortex-A53 through the -mcpu=cortex-a57 and -mcpu=cortex-a53 options.
Initial big.LITTLE tuning support for the combination of Cortex-A57 and Cortex-A53 was added through the -mcpu=cortex-a57.cortex-a53 option. Similar support was added for the combination of Cortex-A15 and Cortex-A7 through the -mcpu=cortex-a15.cortex-a7 option.
+ Further performance optimizations for the Cortex-A15 and the Cortex-M4 have been added.
+ ** A number of code generation improvements for Thumb2 to reduce code size when compiling for the M-profile processors.**

* **AArch64:**
+ The ARMv8-A crypto and CRC instructions are now supported through intrinsics. These are enabled when the architecture supports these and are available through the -march=armv8-a+crc and -march=armv8-a+crypto options.
+ Initial support for ILP32 has now been added to the compiler. This is now available through the command line option -mabi=ilp32. + Support for ILP32 is considered experimental as the ABI specification is still beta.
+ Coverage of more of the ISA including the SIMD extensions has been added. The Advanced SIMD intrinsics have also been improved.
+ The new local register allocator (LRA) is now on by default for the AArch64 backend.
+ The REE (Redundant extension elimination) pass has now been enabled by default for the AArch64 backend.
+ Tuning for the Cortex-A53 and Cortex-A57 has been improved.
+ Initial big.LITTLE tuning support for the combination of Cortex-A57 and Cortex-A53 was added through the -mcpu=cortex-a57.cortex-a53 option.
+ A number of structural changes have been made to both the ARM and AArch64 backends to facilitate improved code-generation.

