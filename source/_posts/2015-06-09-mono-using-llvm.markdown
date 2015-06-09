---
layout: post
title: "Mono - Using llvm, make sure your targets match
date: 2015-06-09 07:21:58 -0700
comments: true
categories: 
- mono
- llvm
- os-x
---

When configuring Mono to use llvm, if you receiving the error:

**configure: error: Cross compiling is not supported for target i386-apple-darwin11.2.0**

Then the llvm-config that is currently the first hit in your path and that is begin picked up by the mono autogen/configure script is does not match the target that you are trying to build in mono.

**llvm-config --host-target** should help you out.

