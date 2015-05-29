---
layout: post
title: "OS-X LLVM / CLANG Build"
date: 2014-02-11
comments: true
categories: 
- OS-X
- LLVM
- CLANG
- ARM
- Embedded
- Bare-Metal
- QEMU
---
I wanted to test out some C code that I am writting for a ARM Bare Metal (Embedded) project in QEMU (qemu-system-arm) and normally would just use the [GNU Tools for ARM Embedded Processors](https://launchpad.net/gcc-arm-embedded) but I was wondering what the current state of LLVM is for cross-compiling to bare-metal ARM.

Since this is a new area for me and I am having a **dang hard time** finding what is and isn't supported in CLang/LLVM for embedded ARM development, I figured I would compile the latest version and see the difference in code that gets produced between the gcc and Clang compilers.   

Thus I needed to latest and greatest Clang/LLVM and did not feel like nurse-maiding a huge git download and long compile session, so I spent a minute and hacked up a really simple script so I could catch up on "Game of Thrones" ;-)

{% gist 8946898 %}

FYI: [Cross-compilation using Clang](http://clang.llvm.org/docs/CrossCompilation.html)
