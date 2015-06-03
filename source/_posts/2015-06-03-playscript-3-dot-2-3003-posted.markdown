---
layout: post
title: "Playscript 3.2.3003 Posted"
date: 2015-06-03 19:22:01 -0700
comments: true
categories: 
---
![](/images/PlayscriptLogo_small.png) 

I posted up the PlayScript compiler 3.2.3003 to [Github](https://github.com/sushihangover/playscript) which fixes a bunch of build issues, including a clang/ld failure if you are running the latest and greatest version from Apple.

Root repo : playscript-small-build.sh 

    ./autogen.sh --with-mcs-docs=no --with-profile2=no --with-profile4=no --with-profile4_5=yes --with-moonlight=no --with-tls=posix --enable-nls=no --prefix=$HOME/playscript-install
    make
    make install


