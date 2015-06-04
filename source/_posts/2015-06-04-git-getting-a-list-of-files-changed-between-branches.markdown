---
layout: post
title: "Git - Getting a list of files changed between branches"
date: 2015-06-04 07:01:32 -0700
comments: true
categories: 
- git
---
Getting a list of changed files between to different branches or tags could not be any easier when using the '--name-only' diff option:

    git diff --name-only mono-3.2.5 mono-3.2.6
    
    configure.in
    mcs/class/Facades/Makefile
    mcs/class/Facades/System.Dynamic.Runtime/TypeForwarders.cs
    mcs/class/Facades/System.Runtime.InteropServices.WindowsRuntime/AssemblyInfo.cs
    mcs/class/Facades/System.Runtime.InteropServices.WindowsRuntime/Makefile
    ...

A quickie to get the number of files changed:

    git diff --name-only mono-3.2.5 mono-3.2.6|wc -l
          28

And using the '--name-status' option can get you a nice two column output with the change type attribute with each file name, makes it easy to pipe to those maintenace scripts. 

    git diff --name-status mono-3.2.5 mono-3.2.6
    M       configure.in
    M       mcs/class/Facades/Makefile
    M       mcs/class/Facades/System.Dynamic.Runtime/TypeForwarders.cs
    A       mcs/class/Facades/System.Runtime.InteropServices.WindowsRuntime/AssemblyInfo.cs

**Note**: You can feed the '--no-color' option to make sure that none of those ansi escape codes get send down-stream in your pipe. 

**Note**: '--'porcelain' works within the diff mode sub-option but not as a primary option.
 
