---
layout: post
title: "MonoCov - Building on OS-X"
date: 2015-06-15 10:52:29 -0700
comments: true
categories: 
- mono
- os-x
- -monocov
---

My [answer](http://stackoverflow.com/questions/20757444/how-to-compile-c-sharp-code-to-64-bit-in-xamarin-studio-on-os-x/30714801#30714801) from Stackoverflow on compiling MonoCov on OS-X and Mono 4.0.x

    # Clone the MonoCov repo
    git clone https://github.com/mono/monocov.git MonoCov
    cd MonoCov
    # A really old version of cecil and it not available as a nuget
    curl http://go-mono.com/archive/cecil/cecil-0.6-bin.zip -o cecil-0.6-bin.zip
    unzip cecil-0.6-bin.zip
    # Make sure configure can find the Mono.Option source file
    export PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Versions/4.0.1/lib:/Library/Frameworks/Mono.framework/Versions/4.0.1/lib/pkgconfig:$PKG_CONFIG_PATH
    export 
    # Config to install to users home dir
    /configure --cecil=$PWD/monocov/cecil-0.6/Mono.Cecil.dll --prefix $HOME/monocov
    # Fix Makefile, gmcs no longer exists under Mono 4.x and Makefile is hard coded
    sed -i.bak s/gmcs/mcs/g Makefile
    # Pass -m32 to make since OS-X Mono framework is still 32-bit
    CC="cc -m32" make
    # Install does not properly create bin dir, do it before the first install
    mkdir $HOME/monocov/bin
    # Install..
    make install

## Compile a test app and test MonoCov:

    // Save this to a file named Program.cs
    using System;
    namespace Foobar
    {
    	class MainClass
    	{
    		public static void Main (string[] args)
    		{
    			Console.WriteLine ("Hello MonoCov");
    		}
    	}
    }


## Profile a Mono (.Net) application

    # Compile a sample app
    mcs Program.cs
    # Update path to include MonoCov so mono can load it as a profiler
    export PATH=$HOME/monocov:$PATH
    mono --debug --profile=monocov Program.exe

## Launch the MonoCov GUI

    # GUI Framework DllNotFoundException fix (if needed)
    export DYLD_FALLBACK_LIBRARY_PATH="/Library/Frameworks/Mono.framework/Versions/Current/lib:/usr/local/lib:/usr/lib"
    # Update path to include MonoCov
    export PATH=$HOME/monocov/bin:$PATH
    monocov

[Mono Code Coverage Profiler : MonoCov](http://www.mono-project.com/docs/debug+profile/profile/code-coverage/)

[Mono.Cecil 0.6 05 Oct 2007](http://evain.net/blog/articles/2007/10/05/mono-cecil-0-6)
