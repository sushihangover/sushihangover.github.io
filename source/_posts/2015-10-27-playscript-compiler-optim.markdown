---
layout: post
title: "PlayScript | Optimizing psc/mcs"
date: 2015-10-27 22:20:18 -0700
comments: true
categories: 
- playscript
- mono
- mcs
- C#
- Eric Lippert
---

{% img left http://sushihangover.github.io/images/PlayscriptLogo_small.png %}

[Eric Lippert](http://ericlippert.com) has a couple of recent posts that I have been reviewing in conjuction with the PlayScript version of Mono's mcs (psc) as some of the things devs do in ActionScript 3.0 are targeted to making Flash's AVM run efficiently does not always make the cut for a C#/CLR oriented compiler. Many of these items revolve around arrays and vector and misuse of the generic (dynamic) Object types, but strings, associative operations, and nulls need some love also and his posts are very insightful as how C# is optimized in certain areas.

{% pullquote %} 
**Great** reading for any C#/CLR devs, {" including PowerShell DevOps "} that are bundling their custom C# written assemblies to speed up their PS modules.
{% endpullquote %}

[Optimizing associative operations](http://ericlippert.com/2015/10/27/optimizing-associative-operations/)

[String concatenation behind the scenes, part one](http://ericlippert.com/2013/06/17/string-concatenation-behind-the-scenes-part-one/)

[String concatenation behind the scenes, part two](http://ericlippert.com/2013/06/24/string-concatenation-behind-the-scenes-part-two/)

He also has a great series on Nullable micro-optimizations that start here:

[Nullable micro-optimizations, part one](http://ericlippert.com/2012/12/20/nullable-micro-optimizations-part-one/
)

PlayScript Github repo is [here](https://github.com/PlayScriptRedux/playscript) check it out now!
