---
layout: post
title: "Stripping the build prefix from cross-compiled binaries"
date: 2015-06-09 06:14:24 -0700
comments: true
categories: 
- clang
- llvm
- mono
---

## Remove a filename prefix from a directory of files

When cross-compiling and using the standard autogen/configure "-build=" option, you end up with binaries that have the arch prefix on your binaries. While this makes sense in order to distinguish that the binaries are different, there are times you do not want to deal with the issue of using these prefixes all the time.

Here is a simple script to strip those prefixes:

    #!/bin/bash
    if [ -z "$1" ]
    then
      prefix="i386-apple-darwin10.10.0-"
    else
      prefix=$1
    fi
    for filename in `ls $prefix*`
    do
       newfilename=${filename:${#prefix}}
       echo $filename $newfilename
       mv $filename $newfilename
    done

I seem to be stripping "i386-apple-darwin10.10.0-" lately so that is the default if no prefix is passed as an argument... 

