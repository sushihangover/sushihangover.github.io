---
layout: post
title: "Ellcc.org build fix for OS-X"
date: 2014-02-12
comments: true
categories:
- OS-X
- LLVM
- CLANG
- ARM
- Embedded
- Bare-Metal
- QEMU
- ELLCC
---
In my ARM Bare Metal searches for using Clang/LLVM I stumbled across [The ELLCC Embedded Compiler Collection](http://ellcc.org) that provides a one-stop build enviroment for all the LLVM tools for cross-platform compiling. 

I'm not sure if they are trying to be a [YAGARTO](http://yagarto.org) for LLVM vs. GCC. I waiting for a reply to post on their forum to understand the actual code changes to Clang/LLVM that they include (if any). ~~I will update when I hear back.~~ **(Update: Read Rich's [full reply](http://ellcc.org/blog/?topic=ellcc-vs-clangllvm-trunk/#post-1571), it cleared everything up for me)**

{% blockquote Rich http://ellcc.org/blog/?topic=ellcc-vs-clangllvm-trunk/#post-1571 What is ELLCC all about %}
ELLCC is really just a weekly repackaging of clang/LLVM with two minor additions.
1. The triples of the form -ellcc- (where OS is linux for now, but will include others eventually) control how include files and libraries are found. You might notice for example that the #include path for ELLCC...
{% endblockquote %}

But in the mean time I figured I give it a build and include it in my GCC/ARM vs. Clang/LLVM-ARM testing but hit a build error on OS-X. On the linking of QEMU, libintl (GNU's gettext) is not found:

```
LINK  i386-softmmu/qemu-system-i386
ld: library not found for -lintl
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[1]: *** [qemu-system-i386] Error 1
make: *** [subdir-i386-softmmu] Error 2
```
I do have gettext on my system, but it is in my "Cellar"" as I use [HomeBrew](http://brew.sh) as my package manager and try not to install anything to "/usr/bin" or other systems places that can muck everything up and thus can run parrallels versions of different applications (i.e. If I have to 'sudo' to an open-source software install, it is not going on my system unless they have a serious reason for it and I trust the code from a security viewpoint). 

FYI: Brew does not 'hard' link gettext as compiling software outside of the HomeBrew can cause problems:

{% blockquote %}
brew link gettext
Warning: gettext is keg-only and must be linked with --force
Note that doing so can interfere with building software.
{% endblockquote %}

So I mod'd the "ellcc/gnu/build" to force brew to link gettext before compiling/linking qemu and unlink it after.

{% codeblock lang:bash %}
svn diff build
Index: build
===================================================================
--- build	(revision 3780)
+++ build	(working copy)
@@ -69,6 +69,10 @@
     ppc-linux-user ppc64-linux-user ppc64abi32-linux-user sparc-linux-user"
 fi
 echo Configuring package qemu for $targets
+if [!  -e `which brew` ]; then
+	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
+fi
+brew link gettext --force
 qemu_target_list=`echo $qemu_target_list | sed -e "s/ /,/g"`
 make DIR=src/qemu CC=$cc HCC=$hcc AR=$ar TARGET=$host OS=$os \
     targetlist=$qemu_target_list haslibs=$haslibs \
@@ -76,6 +80,7 @@
     qemu.configure || exit 1
 
 make -C src/qemu || exit 1
+brew unlink gettext
 
 # Finally, install into the target specific bin dir.
 mkdir -p $bindir
{% endcodeblock %}

Everything builds fine after that...

The entire file is here:
{% gist 8949755 %}
