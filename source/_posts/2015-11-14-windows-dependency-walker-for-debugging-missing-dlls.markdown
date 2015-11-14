---
layout: post
title: "Windows Dependency Walker for debugging missing  DLLs"
date: 2015-11-14 03:40:21 -0800
comments: true
categories: 
- windows
---
I was trying to track down am issue on a fresh Window 10 install with a older application that was starting but faulting on a dependancy but was getting the std DLL missing message...

Running the `.exe` under Visual Studio was getting me no where fast and then I remembered a really *old* program called "Dependency Walker". 

What do you know, it is still avaiable and being kept up to date. Solved my problem in less then a minute...

	Error: At least one required implicit or forwarded dependency was not found.	Error: At least one module has an unresolved import due to a missing export function in an implicitly dependent module.		Warning: At least one delay-load dependency module was not found.	Warning: At least one module has an unresolved import due to a missing export function in a delay-load dependent module.

[Dependency Walker](http://www.dependencywalker.com)

> Dependency Walker is a free utility that scans any 32-bit or 64-bit Windows module (exe, dll, ocx, sys, etc.) and builds a hierarchical tree diagram of all dependent modules. For each module found, it lists all the functions that are exported by that module, and which of those functions are actually being called by other modules. Another view displays the minimum set of required files, along with detailed information about each file including a full path to the file, base address, version numbers, machine type, debug information, and more.


FYI: I remember using that program on Window's ARCH types long forgotten... and the site still has versions available (unsupported of course) for Alpha, AXP64, MIPS, and PowerPC architectures.... wow, remember when Windows ran on those ;-)

![](http://www.dependencywalker.com/snapshot.png)
