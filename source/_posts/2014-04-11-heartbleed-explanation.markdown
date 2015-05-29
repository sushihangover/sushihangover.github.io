---
layout: post
title: "XKCD: Heartbleed Explanation"
date: 2014-04-11 07:51:37 -0700
comments: true
categories:
- XKCD
- OPENSSL
- Heartbleed
---
[{% img left /images/HeartBleed.png 200 200 "Heartbleed" %}](http://heartbleed.com) If you have not checked and/or patched your OpenSSL deployment, better get to it:
[Heartbleed](http://heartbleed.com)

XKCD does it again and provides the best explanation of how Heartbleed, one of the worst (THE worst?), Internet security flaw, works:

![image](http://imgs.xkcd.com/comics/heartbleed_explanation.png)

#### What versions of the OpenSSL are affected?
#### * OpenSSL 1.0.1 through 1.0.1f (inclusive) are vulnerable
#### * OpenSSL 1.0.1g is NOT vulnerable
#### * OpenSSL 1.0.0 branch is NOT vulnerable
#### * OpenSSL 0.9.8 branch is NOT vulnerable
#### * Bug was introduced to OpenSSL in December 2011 and has been out in the wild since OpenSSL release 1.0.1 on 14th of March 2012. OpenSSL 1.0.1g released on 7th of April 2014 fixes the bug.

