---
layout: post
title: "OS-X Mono - Unable to find the dylib native library"
date: 2015-06-08 10:41:32 -0700
comments: true
categories: 
- mono
- os-x
---
{% img left http://sushihangover.github.io/images/mono_logo.png  %}
When using .Net libraries that have native binding and you are receiving errors like 
"**Unable to find the xxxx native library**" or "**DllImport error loading library**". 

You can easily find where mono is looking for that native library by setting the MONO_LOG_LEVEL to debug and filtering (MONO_LOG_MASK) the debug to just DLL related messages.

    export MONO_LOG_LEVEL=debug
    export MONO_LOG_MASK=dll
    mono yourprogram.exe

I was recently using the mono-curses, or at least trying to ;-) and I knew my DYLD_LIBRARY_PATH was set properly to pick up the "libmono-curses.dylib" that I just built. But I set the MONO_LOG_LEVEL and MONO_LOG_MASK env vars and re-run the program and yes it was finding the dylib OK but it was complaining about it being the wrong architecture... 

    Mono: DllImport attempting to load: 'libmono-curses.dylib'.
    Mono: DllImport error loading library '/Users/administrator/Documents/Code/github/mono-curses/libmono-curses.dylib': 'dlopen(/Users/administrator/Documents/Code/github/mono-curses/libmono-curses.dylib, 9): no suitable image found.
    Did find:  /Users/administrator/Documents/Code/github/mono-curses/libmono-curses.dylib: mach-o, but wrong architecture        

Checking with file and yes, it was a 32-bit version of the library

    file libmono-curses.dylib
    libmono-curses.dylib: Mach-O dynamically linked shared library i386

I am compiling using a 64-bit version of Mono on OS-X, so a quick fix in the mono-curses Makefile and re-compile and I have a 64-bit version.

    file libmono-curses.dylib 
    libmono-curses.dylib: Mach-O 64-bit dynamically linked shared library x86_64

After that, testing the C# ncurses wrapper test went fine... ;-)


## [Mac OS X Framework and .dylib Search Path](http://www.mono-project.com/docs/advanced/pinvoke/#mac-os-x-framework-and-dylib-search-path)
### The Framework and library search path is:

* A colon-separated list of directories in the user’s DYLD_FRAMEWORK_PATH environment variable.
* A colon-separated list of directories in the user’s DYLD_LIBRARY_PATH environment variable.
* A colon-separated list of directories in the user’s DYLD_FALLBACK_FRAMEWORK_PATH environment variable, which defaults to the directories:

		~/Library/Frameworks
		/Library/Frameworks
		/Network/Library/Frameworks
		/System/Library/Frameworks

* A colon-separated list of directories in the user’s DYLD_FALLBACK_LIBRARY_PATH environment variable, which defaults to the directories:

		~/lib
		/usr/local/lib
		/lib
		/usr/lib


Note: Mono will automatically append the appropriate suffix depending on the platform (.dylib on Mac, .so on Linux and .dll on Windows).