---
layout: post
title: "New ARM 'machines' in QEMU 2.0"
date: 2014-03-14 23:32:19 -0700
comments: true
categories: 
- ARM
- LLVM
- CLANG
- QEMU
- arm-none-eabi
---
[{% img left /images/QEMU_new_machine_small.png "QEMU 2.0 New ARM Machines" %}](/images/QEMU_new_machine_large.png)I been using QEMU a lot recently to model some Cortex-M0+ software that I am working on.

While technically speaking QEMU does not have a "Cortex-M0(+)" cpu in its feature set, it does have a M3 core and I have used it to create some Cortex-M0+ cpus that model some cores from a couple of ARM vendors, and then added some supporting dev boards ('machines' per QEMU nomenclature). I've been waiting till the QEMU 2.0 release to get my new ARM coding sorted out as major versions usually cause large changes in APIs, C headers, usage patterns, etc... and well, QEMU is tough enough to work through and I did not plan on doing it twice... 

Well, we are getting close, [QEMU 2.0 RC0](http://wiki.qemu.org/ChangeLog/2.0) just released as a tar ball (not in the git repo?), so I did the download, configured and built on OS-X for "arm-softmmu". Everything is great so far, ran some of my work through it and have not found anything amiss. Interesting that the version that shows up as **QEMU emulator version 1.7.90** (BTW: the version on the git master branch is 1.7.5?)

{% codeblock %}
qemu-system-arm -version
QEMU emulator version 1.7.90, Copyright (c) 2003-2008 Fabrice Bellard
{% endcodeblock %}

There are a few new machines available:
	* canon-a1100          Canon PowerShot A1100 IS
	* cubieboard           cubietech cubieboard
	* virt                 ARM Virtual Machine

The [cubie](http://cubieboard.org) board makes sense as you can  use it to test Linux image builds and what-not. I am not sure of the usage pattern for the "Canon PowerShot A1100 DIGIC", is the [DIGIC](http://en.wikipedia.org/wiki/DIGIC) 4 Image Processor available for purchuse? I'll have to look into this one as it leaves me confused.

The interesting one is the fact that there is now a 'virt' machine for ARM. I'm not sure that I will personally have a use for using [virtio](http://wiki.libvirt.org/page/Virtio) devices in any embedded ARM dev work, but you never know. 

Nothing new in the ARM cpu listing, so I guess I will continue with my ARM core and machine work...

The change log for ARM shows the following:
	* Support for "-M virt", a board type that only uses virtio devices
	* Support for "-cpu host" when running under KVM
	* Support for new 32-bit mode ARMv8 instructions in TCG
	* Support for AArch64 disassembling (requires a C++ compiler to be installed on the host)
	* Support for AArch64 user-mode emulation
	* Initial support for KVM on AArch64 systems (some features such as migration are not yet implemented)
	* Support for the Canon PowerShot A1100 DIGIC board using "-M canon-a1100"
	* Support for the allwinner-a10-based board "-M cubieboard"
	* Support for flow control in the Cadence UART




