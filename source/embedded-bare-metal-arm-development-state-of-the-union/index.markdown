---
published: false
layout: page
title: "embedded 'bare metal' arm development - state of the union ;-)"
date: 2014-02-14 06:46
comments: true
sharing: true
footer: true
---



there are just a handfull, but damn, the info about them gets confusing real fast.

First there is a LOT of info out there, second there is a LOT of confusion for 'beginners' and not just one solution.... 

If you are playing with 8-bit AVRs, you can look at Arduino.cc at the central focal point of hobby style 8-bit embedded hardware and programming. Yes, I know, there are now 'offical' Intel and ARM based 'Arduinos' now, but library and shield support is really messed up at this point, even 3.3v and 5v line-vel AVR 8-bit Arduinos are still causing choas in their community. Personally I like Arduino (and the 100s of clones on the market), but as a 'coder' I get hung up on the whole 'sketch' process and the Processing IDE while libraries are 'bare-metal' based. Personally, I want Bare Metal C/C++ code, not semi-C code that is run through some Processing/Java code that 'transforms' it into C code that GCC-AVR can consume.. But that is me, you if want your 'Skectch' code to run on an Atmel ARM Cortex-M3 core, stop here and go grab a 'Due' board and have fun. 

Personally I want to actually learn about ARM Cortex core programming and thus would be able to write libraries for people (including myself) writing Sketches for ARM-based 'duinos if that is something I wanted to do (just one of my future-proofing areas).

Note: Low level bare-medal coding is not the 'eductional' goal/direction that the Arduino project take. That 'opinion' said, if I had kids and wanted to offer them a fun and exciting way to learn coding, I would buy an AVR 8-bit based Ardiuno and buy a new shield for them, say once a month, and they will be be entertained for days, weeks, months... and get a fantasic start on learning the basics of software and hardware...

If you are a software/hardware professional and making your living from ARM embedded coding, IMHO the options are fairly clear, because cost of compilers and toolsets take a back seat to the actual project cost as your profeessional salary, let alone the rest of the project infrustuture are huge compared to the toolchain cost. 

If you have chosend a Freescale Atmel, or (insert your ARM vendor here) ARM core-based MCU for your project, the odds are you have THEIR supported toolset(s) for development. They are producing Application Notes, community forums, enginnering support, tutorials, development boards, etc.. for their various MCU family variations and those will focus on their toolsets. I have tried some their various demo/eval products and when coupled with their MCU evaluation boards you can be up and running and blinking LEDs faster then it takes to unbox the dev board and install their toolset.

Need an RTOS for your bare metal app? They have you covered; from things like FreeRTOS/OpenRTOS support and/or their own RTOS offerings, you can have pre-emptive threading, queuing, mutex support, semaphores, and what-not running in a matter of minutes not hours or days or weeks... 

Need to configure 40 GPIO pins, setup I2C and RS232 with interupt driven routines, and provide support for the four main compiler/toolchains all in a point-click GUI or code producing Wizards? they have you covered... 

For the hobbyist, of course, this level of productively comes at a price ($) and if you would like those high ends IDE options with great hardware level debuggers, that price can be $3000USD for a compiler and $1000USD for a debugger, so if you are a OSS kind of guy, do not go off on a rant that these tools and services are not 'free'. There are 'free' and low cost options and you will have to do more of the work  

Most of these companies either license toolsets from ARM (and others) or develop specialized environments and this costs them money... While most vendors do offer a Lite, EDU or none-time bombed license for their tools, these versions do have limitations, usually limited by code size, but the actual limitations compare to their 'pro' versions vary greatly from vendor to vendor.





This is meant as resource and not as a recommendation or sponsorship of any given company's products. 
