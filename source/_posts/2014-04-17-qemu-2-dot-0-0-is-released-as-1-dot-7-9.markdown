---
layout: post
title: "Qemu 2.0.0 is released (or maybe 1.7.9)"
date: 2014-04-17 23:20:36 -0700
comments: true
categories: 
- ARM
- Bare-Metal
- Semi-hosting
- ARM-NONE-EABI
- QEMU
---
[{% img left /images/QEMU_logo.png "QEMU" %}](http://wiki.qemu.org/Main_Page) QEMU 2.0.0 is now [released](http://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg02734.html). 

The full list of changes are available at: [http://wiki.qemu.org/ChangeLog/2.0](http://wiki.qemu.org/ChangeLog/2.0)

It appears that doing a checkout of tag 'v2.0.0', build and install will produce a binary that reports version 1.7.9

{% codeblock %}
git status
HEAD detached at v2.0.0
nothing to commit, working directory clean
qemu-system-arm --version
QEMU emulator version 1.7.93, Copyright (c) 2003-2008 Fabrice Bellard
{% endcodeblock %}

I did a quick look and they are pulling the version during the ./configure stage so since I am always on the master (bleed-edge) branch, my installed version shows up as 1.7.9. You will need to checkout, **configure**, build and install to produce a binary that has the correct version (~~QEMUVERSION~~) assigned:

{% codeblock %}
qemu-system-arm --version
QEMU emulator version 2.0.0, Copyright (c) 2003-2008 Fabrice Bellard
{% endcodeblock %}