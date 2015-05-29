---
layout: post
title: "LLVM ARM triple CPU targets"
date: 2014-02-19 06:36:42 -0800
comments: true
categories: 
- ARM
- LLVM
- Triple
- arm-none-eabi
---
I am building a bare-metal ARM Clang/LLVM cross-compiler for my Arm Cortex-M LLVM vs. arm-gcc experiments and was looking for the complete ARM core list available. 

LLVM makes it soooo easy to get that information from the LLVM static compiler binary ([llc](http://llvm.org/docs/CommandGuide/llc.html)), just pass it a generic ARM triple, here is the lsit from my build:
```
llc -mtriple=arm-none-eabi -mcpu=help
```
```
Available CPUs for this target:

  arm1020e      - Select the arm1020e processor.
  arm1020t      - Select the arm1020t processor.
  arm1022e      - Select the arm1022e processor.
  arm10e        - Select the arm10e processor.
  arm10tdmi     - Select the arm10tdmi processor.
  arm1136j-s    - Select the arm1136j-s processor.
  arm1136jf-s   - Select the arm1136jf-s processor.
  arm1156t2-s   - Select the arm1156t2-s processor.
  arm1156t2f-s  - Select the arm1156t2f-s processor.
  arm1176jz-s   - Select the arm1176jz-s processor.
  arm1176jzf-s  - Select the arm1176jzf-s processor.
  arm710t       - Select the arm710t processor.
  arm720t       - Select the arm720t processor.
  arm7tdmi      - Select the arm7tdmi processor.
  arm7tdmi-s    - Select the arm7tdmi-s processor.
  arm8          - Select the arm8 processor.
  arm810        - Select the arm810 processor.
  arm9          - Select the arm9 processor.
  arm920        - Select the arm920 processor.
  arm920t       - Select the arm920t processor.
  arm922t       - Select the arm922t processor.
  arm926ej-s    - Select the arm926ej-s processor.
  arm940t       - Select the arm940t processor.
  arm946e-s     - Select the arm946e-s processor.
  arm966e-s     - Select the arm966e-s processor.
  arm968e-s     - Select the arm968e-s processor.
  arm9e         - Select the arm9e processor.
  arm9tdmi      - Select the arm9tdmi processor.
  cortex-a12    - Select the cortex-a12 processor.
  cortex-a15    - Select the cortex-a15 processor.
  cortex-a5     - Select the cortex-a5 processor.
  cortex-a53    - Select the cortex-a53 processor.
  cortex-a57    - Select the cortex-a57 processor.
  cortex-a7     - Select the cortex-a7 processor.
  cortex-a8     - Select the cortex-a8 processor.
  cortex-a9     - Select the cortex-a9 processor.
  cortex-a9-mp  - Select the cortex-a9-mp processor.
  cortex-m0     - Select the cortex-m0 processor.
  cortex-m3     - Select the cortex-m3 processor.
  cortex-m4     - Select the cortex-m4 processor.
  cortex-r5     - Select the cortex-r5 processor.
  ep9312        - Select the ep9312 processor.
  generic       - Select the generic processor.
  iwmmxt        - Select the iwmmxt processor.
  krait         - Select the krait processor.
  mpcore        - Select the mpcore processor.
  mpcorenovfp   - Select the mpcorenovfp processor.
  strongarm     - Select the strongarm processor.
  strongarm110  - Select the strongarm110 processor.
  strongarm1100 - Select the strongarm1100 processor.
  strongarm1110 - Select the strongarm1110 processor.
  swift         - Select the swift processor.
  xscale        - Select the xscale processor.
```
