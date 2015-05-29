---
layout: post
title: "ARM: LLVM and why no GPL"
date: 2014-04-11 07:28:16 -0700
comments: true
categories: 
- ARM
- CLANG
- LLVM
- GPL
- GCC
---
As a follow up to my last post about ARM's annoucement concerning their move to clang/LLVM.

Seems that more of the GPL-only mindset are upset that ARM is another company that is picking up and carrying the LLVM torch for their future development activities. 

My take on it is it is a good thing, something they could not do with GCC without violating the GPL license that they would have to follow.  Clang/LLVM is licensed with a BSD-style license and not wanting to get in to a religious war over open source licensing, their LLVM selection and thus license choice allows them to keep things proprietary while working on new designs and code and releasing that to development partners like they currently do with their in-house ARM/Keli development environment. Then there is the problem of linking and including non-open code in end-user projects if they would have chosen GCC, this is a non-trivial problem for private and public companies dealing with IP that has extreme competition. 

As ARM's new designs become public, they can then push LLVM changes to the public branch and, we as end-users, then get to enjoy the benefits of what they can release. Will there be code components that they alway keep private and/or charge for in their commerical 'ulitmate' compiler version, maybe, but the code that does make it to the git repo will be vetted by the company that actually produces the MCU designs. Good enough for me, GPL be damned in this case...
