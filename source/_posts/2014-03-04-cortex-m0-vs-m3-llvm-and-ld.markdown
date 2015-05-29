---
layout: post
title: "Cortex-M0 vs. M3 : LLVM and LD"
date: 2014-03-05 06:30:13 -0800
comments: true
categories: 
- ARM
- Cortex-M
- Bare-metal
- LLVM
- CLANG
- QEMU
- arm-none-eabi
---
[{% img left /images/ARM_Cortex-M_instruction_set_small.png  "ARM Cortex-M instruction set" %}](/images/ARM_Cortex-M_instruction_set_large.png) One of the issues that you run into using Clang/LLVM as your compiler for bare-metal ARM Cortex cores is you have to directly use arm-none-eabi-ld to do your linking. 

Directly using **ld** can be a bit nerve wrecking at times to get the options correct (and the **order** of options does matter) as normally you are just let gcc use collect2 and have it internally execute ld to perform your linking. 

One of the areas using it directly that can bite you is not linking to the proper libgcc.a for the Cortex-M that you are targeting. Looking into your *arm-none-eabi/lib/gcc/arm-none-eabi/X.X.X* tool-chain directory and you will find multiple directories. One for each ARM architecture; armv6-m, armv7-ar, armv7-m, thumb, thumb2, etc... 

Add a library include for *architecture* directory that matches the core that you compiled against and everything will be fine:

Cortex M3 example:
```
arm-none-eabi-ld -Map bin/main.axf.map -T src/cortex_M3.ld --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/lib/thumb/thumb2 --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/lib/thumb  --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/lib  --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/lib/gcc/arm-none-eabi/4.8.3/armv7-m -g   obj/printf_with_malloc.o obj/startup.o --start-group -lgcc -lc --end-group -o bin/main.axf
```

Cortex M0+ example:
```
arm-none-eabi-ld -Map bin/main.axf.map -T src/cortex_M0.ld --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/newlib-syscalls/arm-none-eabi/lib/thumb/thumb2 --library-path /Users/administrator/Code/llvm_superproject/install/arm-none-eabi/lib/gcc/arm-none-eabi/4.8.3/armv6-m  --gc-sections --print-gc-sections  obj/printf_with_malloc.o obj/startup.o --start-group -lgcc -lc --end-group -o bin/main.axf
```

[ARM Cortex-M instruction sets](http://en.wikipedia.org/wiki/ARM_Cortex-M#Instruction_sets)
<table class="wikitable">
<tbody><tr>
<th>ARM<br>
Cortex-M</th>
<th>Thumb</th>
<th>Thumb-2</th>
<th>Hardware<br>
multiply</th>
<th>Hardware<br>
divide</th>
<th>Saturated<br>
math</th>
<th>DSP<br>
extensions</th>
<th>Floating-point</th>
<th>ARM<br>
architecture</th>
<th>Core<br>
architecture</th>
</tr>
<tr>
<td>
<center>Cortex-M0<sup id="cite_ref-M0-TRM_1-2" class="reference"><a href="#cite_note-M0-TRM-1"><span>[</span>1<span>]</span></a></sup></center>
</td>
<td style="background: cyan">
<center>Most</center>
</td>
<td style="background: cyan">
<center>Subset</center>
</td>
<td style="background: yellow">
<center>1 or 32 cycle</center>
</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td>
<center>ARMv6-M<sup id="cite_ref-ARMv6-M-Manual_6-8" class="reference"><a href="#cite_note-ARMv6-M-Manual-6"><span>[</span>6<span>]</span></a></sup></center>
</td>
<td><a href="/wiki/Von_Neumann_architecture" title="Von Neumann architecture">Von Neumann</a></td>
</tr>
<tr>
<td>
<center>Cortex-M0+<sup id="cite_ref-M0.2B-TRM_2-2" class="reference"><a href="#cite_note-M0.2B-TRM-2"><span>[</span>2<span>]</span></a></sup></center>
</td>
<td style="background: cyan">
<center>Most</center>
</td>
<td style="background: cyan">
<center>Subset</center>
</td>
<td style="background: yellow">
<center>1 or 32 cycle</center>
</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td>
<center>ARMv6-M<sup id="cite_ref-ARMv6-M-Manual_6-9" class="reference"><a href="#cite_note-ARMv6-M-Manual-6"><span>[</span>6<span>]</span></a></sup></center>
</td>
<td><a href="/wiki/Von_Neumann_architecture" title="Von Neumann architecture">Von Neumann</a></td>
</tr>
<tr>
<td>
<center>Cortex-M1<sup id="cite_ref-M1-TRM_3-2" class="reference"><a href="#cite_note-M1-TRM-3"><span>[</span>3<span>]</span></a></sup></center>
</td>
<td style="background: cyan">
<center>Most</center>
</td>
<td style="background: cyan">
<center>Subset</center>
</td>
<td style="background: yellow">
<center>3 or 33 cycle</center>
</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td>
<center>ARMv6-M<sup id="cite_ref-ARMv6-M-Manual_6-10" class="reference"><a href="#cite_note-ARMv6-M-Manual-6"><span>[</span>6<span>]</span></a></sup></center>
</td>
<td><a href="/wiki/Von_Neumann_architecture" title="Von Neumann architecture">Von Neumann</a></td>
</tr>
<tr>
<td>
<center>Cortex-M3<sup id="cite_ref-M3-TRM_4-2" class="reference"><a href="#cite_note-M3-TRM-4"><span>[</span>4<span>]</span></a></sup></center>
</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Entire</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Entire</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">1 cycle</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Yes</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Yes</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td style="background:#ff9090; color:black; vertical-align: middle; text-align: center;" class="table-no">No</td>
<td>
<center>ARMv7-M<sup id="cite_ref-ARMv7-M-Manual_7-9" class="reference"><a href="#cite_note-ARMv7-M-Manual-7"><span>[</span>7<span>]</span></a></sup></center>
</td>
<td><a href="/wiki/Harvard_architecture" title="Harvard architecture">Harvard</a></td>
</tr>
<tr>
<td>
<center>Cortex-M4<sup id="cite_ref-M4-TRM_5-2" class="reference"><a href="#cite_note-M4-TRM-5"><span>[</span>5<span>]</span></a></sup></center>
</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Entire</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Entire</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">1 cycle</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Yes</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Yes</td>
<td style="background: #90ff90; color: black; vertical-align: middle; text-align: center;" class="table-yes">Yes</td>
<td style="background: yellow">
<center>Optional</center>
</td>
<td>
<center>ARMv7E-M<sup id="cite_ref-ARMv7-M-Manual_7-10" class="reference"><a href="#cite_note-ARMv7-M-Manual-7"><span>[</span>7<span>]</span></a></sup></center>
</td>
<td><a href="/wiki/Harvard_architecture" title="Harvard architecture">Harvard</a></td>
</tr>
</tbody></table>