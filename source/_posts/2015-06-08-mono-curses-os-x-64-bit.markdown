---
layout: post
title: "Mono-Curses OS-X 64-bit"
date: 2015-06-08 17:07:00 -0700
comments: true
categories: 
- github
- mono
- mono-curses
- ncurses
- curses
---
{% img left http://sushihangover.github.io/images/mono-logo.png  %} I am looking in writing a git merge assistant that handles a specific work-flow (more on that in a later post) and as such am looking a ncurses interface. There are a couple of C# wrappers but they are old projects and have not been touched in years, so to even get them to compiled in order to even test them, I had to do some minor tweaking.

The first one is from Mono and it called [Mono-curses](http://www.mono-project.com/MonoCurses) and I forked it on Github and tweaked it to produce a 64-bit dylib and a PE32+ assembly. 

It appears to work ok, but there is a issue with timeouts; tryout the mltest.cs sample code and you will see the inconsistent timeout events.... 

It also is missing mouse support... not a deal breaker for me, but it would be a nice to-have.

There are some apps such as the out-dated [MonoTorrent](http://www.mono-project.com/archived/monotorrent/) and a C# version of [Midnight Commander](https://github.com/migueldeicaza/mc). 


http://www.mono-project.com/docs/tools+libraries/libraries/monocurses/



# Mono-Curses OS-X 64-bit 

Note: *This is a fork of the [mono/mono-curses](http://www.mono-project.com/MonoCurses
) project*

Clone the repo and checkout the **osx-64bit** branch

    git clone https://github.com/sushihangover/mono-curses.git
    git check osx-64bit 

Set our path to your 64-bit version of Mono and set your Mono package config env var to that install, configure and make the project.

**Example:**

    export PATH=$HOME/mono-install/bin
    export PKG_CONFIG_PATH=/$HOME/mono-install/lib/pkgconfig
    #WARNING: by default it installs into /usr/local
    ./configure --prefix=/$HOME/mono-install
    make 
    make install

That should do it, lets do a quick arch check:

    file libmono-curses.dylib 
    libmono-curses.dylib: Mach-O 64-bit dynamically linked shared library x86_64
    
    file mono-curses.dll
    mono-curses.dll: PE32+ executable for MS Windows (DLL) (console) Mono/.Net assembly

FYI: The difference in a [PE 32-bit and 64-bit](http://en.wikipedia.org/wiki/Portable_Executable) is show below:

    file mono-curses.dll
    mono-curses.dll: **PE32+** executable for MS Windows (DLL) (console) Mono/.Net assembly
    
    file mono-curses-32.dll 
    mono-curses-32.dll: **PE32 **executable for MS Windows (DLL) (console) **Intel 80386 32-bit **Mono/.Net assembly

## There are a couple of tests that are built during the *make* you can run:

    (make test) mono test.exe (Unicode sample, any key to exit)
    (make gtest) mono gtest.exe (Ctrl-C to exit app)
    (make mltest) mono mltest.exe (Timer events do not work as expected(?), Ctrl-C to exit app)

