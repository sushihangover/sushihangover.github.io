---
layout: post
title: "PlayScript 3.2.2002 posted"
date: 2015-05-31 22:16:23 -0700
comments: true
categories: 
- Github
- PlayScript
- Mono
---
![](/images/PlayscriptLogo.png)

I posted up the PlayScript compiler (3.2.2002). This is the last posted release of the Apache licensed open-source version before Zynga pulled it from public domain.

I will be migrating it to the Mono 4.x compiler in the days and weeks ahead before working on finishing and getting the ActionScript language side stable (feature complete?). Not really looking forwarded to the Mono 4.x migration as the number of internal API changes to the mcs compiler since the 3.2.0 release is quite extensive.

If you want to compile and use the current 3.2.2002 release, just autogen.sh like normal.

Note: Due to dependency updates on OS-X since Mono 3.2 was release, I had to supply " <u>--with-tls</u>" option as it was auto-selecting **__thread** instead of **_posix**.

    ./autogen.sh --with-tls=posix --enable-nls=no --prefix=/Users/administrator/mono-install

Note: Since this is mono 3.x, to build you will need gmcs during the bootstrap process. If you only have Mono 4.x installed, you will need a 3.x mono install to proceed. I just did a separate mono checkout of 3.2 and built it with a different install prefix location. When doing an initial/full compile and install, you can add this 3.2 install location to the front of your PATH and the default mono bootstrap will work cleanly.
 