---
layout: post
title: "Git - Resetting a file back to its conflicted state"
date: 2015-08-06 17:29:21 -0700
comments: true
categories: 
- git
---
{% img left http://sushihangover.github.io/images/gitlogo.png %} For some reason everytime I need to do this I forget the option. Maybe it is because the help for *git checkout --help* does not actually provide details for "-m" option.

`git checkout -m <filename>
`

This restores the unresolved state, including all information about parent and merge base, which allows restarting the resolution.

There is of course the *--theirs* and *--ours* options available during a checkout if a merge is underway, but those options are explained in the help and the name of the option is self-explanatory, but **-m** does not stick in my head for some reason.... 

