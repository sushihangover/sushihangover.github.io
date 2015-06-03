---
layout: post
title: "PlayScript 3.2.3001 Posted"
date: 2015-06-03 06:10:59 -0700
comments: true
categories: 
- PlayScript
- Github
---
![](/images/PlayscriptLogo_small.png) 

I posted up the PlayScript compiler 3.2.3001 to [Github](https://github.com/sushihangover/playscript) which is a merge of the mono-3.2.3 tag into the playscript-mono branch.

To speed up testing the merge, I am disabling a number of options in the build. Please log any issues via [Github](https://github.com/sushihangover/playscript/issues)

    ./configure --with-mcs-docs=no --with-profile2=no --with-profile4=no --with-profile4_5=yes --with-moonlight=no --with-tls=posix --enable-nls=no --prefix=/Users/administrator/playscript-install



