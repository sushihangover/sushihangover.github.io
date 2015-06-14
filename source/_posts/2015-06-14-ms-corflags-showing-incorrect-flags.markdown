---
layout: post
title: "MS CorFlags - Showing incorrect flags"
date: 2015-06-14 10:40:23 -0700
comments: true
categories: 
- corflags
- corflags.exe
- xcorflags.exe
---
In the Microsoft supplied CorFlags.exe, when displaying the flags on a COMIMAGE_FLAGS_32BITPREFERRED && COMIMAGE_FLAGS_32BITREQUIRED flagged CIL PE image, it does not show that the COMIMAGE_FLAGS_32BITREQUIRED as being set.

In the case of this output:

    Version   : v4.0.30319
    CLR Header: 2.5
    PE        : PE32
    CorFlags  : 0x20003
    ILONLY    : 1
    32BITREQ  : 0
    32BITPREF : 1
    Signed    : 0

The 0x20003 flags breaks down into:

* 32BITPREFERRED (0x20000)
* 32BITREQUIRED (0x00002)
* ILONLY (0x00001)

So why is **32BITREQ** not shown as selected? 

My [xplat version of CorFlags](https://github.com/sushihangover/corflags) shows the following:

    Version   : v4.0.30319
    CLR Header: 2.5
    PE        : PE32
    CorFlags  : 0x20003
    ILONLY    : 1
    32BITREQ  : 1
    32BITPREF : 1
    Signed    : 0

The 32BITREQ is shown as flagged as the value of 0x20003 includes that flag.... so who is right? 

Microsoft in hiding that the 32BITREQ flag is set on PEs that have 32BITPREF set (while still showing the actual flag value), is that right? a bug? Should I do the same in my xplat version of the tool? Let me know in the comments below, or even better post an issue over at my xplat [CorFlags](https://github.com/sushihangover/corflags/issues/new) project (Thanks).

## Misc:

In setting the compiler /platform flag to 'anycpu32bitpreferred' you are targeting 32-bit even if on a 64-bit system, thus the 32BITREQ and 32BITPREF flags are set.

{% blockquote %}
anycpu32bitpreferred compiles your assembly to run on any platform. Your application runs in 32-bit mode on systems that support both 64-bit and 32-bit applications. You can specify this option only for projects that target the .NET Framework 4.5. (Or Mono 4.5...)
{% endblockquote %}


IMAGE_COR20_HEADER.Flags values from \Include\um\CorHdr.h

    COMIMAGE_FLAGS_ILONLY               =0x00000001,
    COMIMAGE_FLAGS_32BITREQUIRED        =0x00000002,
    COMIMAGE_FLAGS_IL_LIBRARY           =0x00000004,
    COMIMAGE_FLAGS_STRONGNAMESIGNED     =0x00000008,
    COMIMAGE_FLAGS_NATIVE_ENTRYPOINT    =0x00000010,
    COMIMAGE_FLAGS_TRACKDEBUGDATA       =0x00010000,
    COMIMAGE_FLAGS_32BITPREFERRED       =0x00020000,
