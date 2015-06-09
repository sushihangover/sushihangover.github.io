---
layout: post
title: "Mono - Using llvm? Make sure your targets match"
date: 2015-06-09 07:21:58 -0700
comments: true
categories: 
- mono
- llvm
- os-x
---
{% img left http://sushihangover.github.io/images/mono-logo.png %} When configuring Mono to use llvm, if you receive the error:

**configure: error: Cross compiling is not supported for target i386-apple-darwin11.2.0**

Then the llvm-config that is currently the first hit in your path and that is begin picked up by the mono autogen/configure script is does not match the target that you are trying to build in mono.

**llvm-config --host-target** should help you out and change your path so the correct llvm bin directory is first in the list so when mono's configure runs llvm-config it gets the correct info.

