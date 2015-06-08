---
layout: post
title: "OS-X 64-bit Mono : Midnight Commander"
date: 2015-06-08 18:43:29 -0700
comments: true
categories: 
- mono
- os-x
- midnightcommander
- ncurses
- curses
---
![](/images/midnightcommander.png)

In testing out 64-bit ncurses on OS-X, I grabbed the C# version of [Midnight Commander](https://github.com/migueldeicaza/mc) to do some manual testing.

After tweaking the Makefile for PE32+ images, I ended up with a 64-bit exe, dll, and dylib: 

    file *.exe *.dll *.dylib
    mc.exe:               PE32+ executable for MS Windows (console) Mono/.Net assembly
    mono-curses.dll:      PE32+ executable for MS Windows (DLL) (console) Mono/.Net/assembly
    libmono-curses.dylib: Mach-O 64-bit dynamically linked shared library x86_64

There are some minor painting issues which I do not know if they are related to the arch type, OS-X or bugs in the actual C# code (mc or the ncurses wrapper, but overall it works very well.


