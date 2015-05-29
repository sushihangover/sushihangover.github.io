---
layout: post
title: "ARM starts move to LLVM"
date: 2014-04-10 22:03:36 -0700
comments: true
categories: 
- ARM
- CLANG
- LLVM
- CORTEX
---
Very cool news from ARM Holding the other day. They are formally adopting clang/LLVM as their future compiler. If you have been following LLVM commits, you might have noticed that AArch64 support has been making progress for quite some time, and now ARM is publicly releasing v6 of their compiler:

> ARM announces the availability of version 6 of the ARM Compiler, the reference code generation toolchain for the ARM® architecture. ARM Compiler 6 adopts the Clang and LLVM open source compiler framework, channeling contributions from the whole ARM Partnership to improve code quality, performance and power efficiency of software on ARM processors. 
> 
> The flexible and modern Clang and LLVM infrastructure provides a solid foundation for ARM's code generation tools. Clang is a C/C++ compiler front end based on a modular architecture with well-defined interfaces for applying complimentary tools such as code analyzers and code generators. Clang also offers improved diagnostic capabilities, leading to higher quality code and shorter development cycles. 

[ARM's Press Release](http://www.arm.com/about/newsroom/arm-compiler-builds-on-open-source-llvm-technology.php
)

I am really looking forward to when they start contributing on the existing Cortex-M backend in LLVM. :-)