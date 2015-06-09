---
layout: post
title: "Mono - libtool: Version mismatch error.  This is libtool 2.4.6"
date: 2015-06-09 17:20:35 -0700
comments: true
categories: 
- mono
- os-x
---
{% img left http://sushihangover.github.io/images/mono-logo.png  %} If you are receiving the following error when compiling mono 4.x "Version mismatch error.  This is libtool 2.4.6, but the definition of this LT_INIT comes from libtool 2.4.2.", then the aclocal.m4 file needs to be rebuilt. It appears something in the mono autogen/configure and/or make clean is not deleting and rebuilding it (or is picking an older libtool vs. actually using glibtool).

I have find that the "libgc/aclocal.m4" has been my main problem:

     ....   
        make[4]: Nothing to be done for `all-am'.
        Making all in doc
        make[3]: Nothing to be done for `all'.
          CC       pthread_support.lo
        libtool: Version mismatch error.  This is libtool 2.4.6, but the
        libtool: definition of this LT_INIT comes from libtool 2.4.2.
        libtool: You should recreate aclocal.m4 with macros from libtool 2.4.6
        libtool: and run autoconf again.
        make[3]: *** [pthread_support.lo] Error 63
        make[2]: *** [all-recursive] Error 1
        make[1]: *** [all-recursive] Error 1
        make: *** [all] Error 2

Remove that file:

    rm libgc/aclocal.m4 

And re-run the make and it will be recreated correctly.

