---
layout: post
title: "PlayScript | Away3d World Global Example"
date: 2015-07-23 18:17:12 -0700
comments: true
categories: 
- mono
- playscript
- away3d
- actionscript
- xamarin
---

I finally got all the bits together to get the OS-X OpenGL version of the [PlayScript](http://playscriptredux.github.io) flash stage running the [Away3d](http://away3d.com) 3D engine.

500 ActionScript files with over 20000 lines of actual code from [away3d-core-fp11](https://github.com/PlayScriptRedux/away3d-core-fp11) and [away3d-examples-fp11](https://github.com/PlayScriptRedux/away3d-examples-fp11) compiled to [CIL](https://en.wikipedia.org/wiki/Common_Intermediate_Language) using the PlayScript mcs compiler. :-)

{% youtube XlC93cXRlgI %}

[Away3d example source code that is running in the demo](https://github.com/PlayScriptRedux/away3d-examples-fp11/blob/playscript/src/Intermediate_Globe.as)

```
>cloc away3d-core-fp11
     464 text files.
     464 unique files.
      16 files ignored.

http://cloc.sourceforge.net v 1.62  T=3.45 s (130.1 files/s, 23410.8 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
ActionScript                   443          12601          12443          54059
MSBuild script                   3              0              0           1551
C#                               3             39             11            111
-------------------------------------------------------------------------------
SUM:                           449          12640          12454          55721
-------------------------------------------------------------------------------
>cloc away3d-examples-fp11
     110 text files.
     109 unique files.
      60 files ignored.

http://cloc.sourceforge.net v 1.62  T=5.05 s (10.5 files/s, 3247.7 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
ActionScript                    36           1936           2592           8073
Javascript                       2            121            148           1186
MSBuild script                   3              0              0            808
C#                               7            414             99            740
XML                              2             19             10            105
HTML                             2              7             29            102
CSS                              1              1              1              4
-------------------------------------------------------------------------------
SUM:                            53           2498           2879          11018
-------------------------------------------------------------------------------
```

Note: [ScreenFlow](http://www.telestream.net/screenflow/overview.htm) is running on the background so the world rotation is a little choppy at times, without the screen/video capture running, the example runs at 60 fps @ 4% CPU on this old MacBookPro with a Intel Core 2 Duo 2.53 GHz processor.

FYI: ScreenFlow is a **must** have if you are screen capturing video on OS-X. It really is the *bomb* at what it does.
