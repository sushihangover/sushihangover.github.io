---
layout: post
title: "Qemu Machine and CPU list"
date: 2014-04-05 12:27:42 -0700
comments: true
categories: 
- ARM
- Bare-Metal
- Semi-hosting
- ARM-NONE-EABI
- QEMU
---
[{% img left /images/QEMU_logo.png "QEMU" %}](http://wiki.qemu.org/Main_Page)I merged the latest changes from QEMU 2.0 RC master into the changes that I am making and noticed that since there is no default ARM 'machine' any more, you can not get a cpu listing without giving it a machine:
{% codeblock %}
qemu-system-arm -cpu help
No machine specified, and there is no default.
Use -machine help to list supported machines!
{% endcodeblock %}
So now, you will need to include any machine (--machine help) in order to see the cpu listing, using the ARM Cortex-M0+ dev board that I am putting together (*sushi-m0plus-board*), you can get the cpu listing. 
> The cores; cortex-m0, cortex-m0+ and machine; sushi-m0plus-board, are my additions and not apart of the QEMU main-line code.
{% codeblock %}
qemu-system-arm --machine sushi-m0plus-board -cpu help
Available CPUs:
  arm1026
  arm1136
  arm1136-r2
  arm1176
  arm11mpcore
  arm926
  arm946
  cortex-a15
  cortex-a8
  cortex-a9
  cortex-m0
  cortex-m0plus
  cortex-m3
  pxa250
  pxa255
  pxa260
  pxa261
  pxa262
  pxa270-a0
  pxa270-a1
  pxa270
  pxa270-b0
  pxa270-b1
  pxa270-c0
  pxa270-c5
  sa1100
  sa1110
  ti925t
{% endcodeblock %}