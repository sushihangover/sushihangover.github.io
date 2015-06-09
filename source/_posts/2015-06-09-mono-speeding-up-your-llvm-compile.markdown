---
layout: post
title: "Mono - Speeding up your llvm compile"
date: 2015-06-09 07:42:41 -0700
comments: true
categories: 
- mono
- llvm
---
{% img left http://sushihangover.github.io/images/mono-logo.png %} If you are building llvm so you can then configure and build mono to use it, then you can speed up the compile by removing the tests as they take as long, if not longer, then the llvm runtime binaries.

I could not find a llvm configure option to skip the **test** directory, but you you just delete it (or move it out of the llvm directory) before you configure/compile llvm, then you will receive a warning that it was not find, but the compile will proceed normally.

Note: You could also mod the llvm configuration (configure/Makefile) to skip the tests.
