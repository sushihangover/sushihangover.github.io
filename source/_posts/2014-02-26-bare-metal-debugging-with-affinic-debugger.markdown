---
layout: post
title: "Bare metal debugging with Affinic Debugger"
date: 2014-02-26 23:19:58 -0800
comments: true
categories: 
- ARM
- Cortex-M
- Bare-metal
- LLVM
- CLANG
- QEMU
- arm-none-eabi
- gdb
- Affinic
---
[{% img left /images/Affinic_gui_small.png "Affinic gdb on OS-X" %}](/images/Affinic_gui_large.png) I am not currently using a full IDE for my bare metal C coding on OS-X. Thus is mainly due to my usage of an [ARM targeting Clang/LLVM build](https://github.com/sushihangover/llvm_baremetal)) since I am compiling to LLVM **bitcode**, piping to **opts** and than handing the resulting object files directly to **arm-none-eabi-ld**. Makefile creation is the only way to get this build pipeline working as no IDE on any OS is natively supporting using LLVM as a cross-compiler for bare metal ARM (yet!).

Thus that leaves me in a term window a lot, not that I mind, but gdb (arm-none-eabi-gdb) based debugging can be a pain when you are used to working with a fully intergated IDE (*I dream of Visual Studio style bare metal debugging* ;-) . The 'layout asm' and 'layout src' text-based *gui*  of gdb does help a lot but till you learn all the commands and setup custom command-sets, productivity tends to suffer...

There are several GUI-based interfaces that can ease the pain of using gdb. **Eclipse** has the CDT debug perspective that provides a complete wrapper to [gdb MI commands](http://www.ibm.com/developerworks/library/os-eclipse-cdt-debug2/index.html) and **ddd** ([Data Display Debugger](http://www.gnu.org/software/ddd/)) provides a frontend to many session based cmd-line debuggers, including gdb. But I figured I would give [Affinic Debugger](http://www.affinic.com) a quick try to see how it work.

Using Affinic Debugger for GDB does not completely shield you from gdb and you also have access to the gdb terminal so as you  learn gdb commands you can type them vs. clicking your way throught the GUI. 

> You can use it as a gdb learning tool, as all the gui actions that involve gdb cmds are echo'd in the intergated terminal.

[{% img right /images/Affinic_preferences_small.png "Affinic gdb location" %}](/images/Affinic_preferences_large.png)After you download and install it, you will need to set which gdb you are using to debug your target. I am using a version of arm-none-eabi-gdb that I built, so start the app and open the Preferences and change the "Set Debugger Path" entry to the gdb that you are using. Affinic Debugger will need to restart after that change.

Lets debug something! 

Using the HelloWorld example from last time, let re-compile it with Clang/LLVM using "-g -O0" so we get the debug symbols (-g) and remove any code optimizations (-O0) so the generated assembly is easy to follow and allow breakpoints to be set with the source code (depending upon optimization level, your breakpoints might be limited in the source view):

{% codeblock lang:bash %}
clang -g -O0 -target arm-none-eabi -mcpu=arm926ej-s -mfloat-abi=soft -o obj/startup.o -c src/startup.s
clang -g -O0 -target arm-none-eabi -mcpu=arm926ej-s -mfloat-abi=soft -o obj/HelloWorldSimple.o -c src/HelloWorldSimple.c
arm-none-eabi-ld -Lobj --gc-sections --print-gc-sections  -T src/HelloWorldSimple.ld obj/startup.o obj/HelloWorldSimple.o -o bin/HelloWorldSimple.axf
arm-none-eabi-size bin/HelloWorldSimple.axf
{% endcodeblock %}

Lets startup QEMU as we will use it as our remote gdb debugging  target. 
{% codeblock lang:bash %}
qemu-system-arm -M versatilepb -m 128M -nographic -kernel  bin/HelloWorldSimple.axf -s -S
{% endcodeblock %}

Note: We are using the two following additional options in order to remotely debug our HelloWorldSimple.axf program:
###### * -s              shorthand for -gdb tcp::1234
###### * -S              freeze CPU at startup

Now start Affinic and connect to the QEMU gdb remote debugging server that is running. Enter the following into the "Command:" text field:
```
target remote localhost:1234
file bin/HelloWorldSimple.axf
```
Note: This is the same are if you were using gdb on the cmd-line. You can also use the Affinic menus to do this (Remote and File menus)

[{% img left /images/Affinic_assembly_view_small.png "Affinic gdb on OS-X" %}](/images/Affinic_assembly_view_large.png) You will see the assembly and source tabs filed. At this point you can set breakpoints, step through your source/assembly code, view register values, etc... 
[{% img right /images/Affinic_source_view_small.png "Affinic gdb on OS-X" %}](/images/Affinic_source_view_large.png)

So far I like the Affinic Debugger interface, but I guess time will tell if I buy the full version after the 30 day trail, use the limited light/free version or setup ddd and/or Eclipse on my MacBookPro...









