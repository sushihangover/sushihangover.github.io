---
layout: post
title: "OS-X Brew : Clean it up"
date: 2015-06-07 23:10:40 -0700
comments: true
categories: 
- os-x
- brew
- homebrew
---
![](/images/Homebrew_logo.png)

I'm a big fan of [Homebrew](http://brew.sh) on OS-X and it normally it works so well that you just do not think about it. That is a very good thing, it just works, does not get in your way and anything is good. 

While I was updating/upgrading packages today, I ended up running 'brew info':

    brew info 
    146 kegs, 171208 files, 8.0G

I just surprised that I had 8 GBs of hard drive space consumed by brew packages. If you did not know, brew does not auto-purge older packages.

{% blockquote %}
By default, Homebrew [does not uninstall old versions of a formula](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/FAQ.md
), so over time you will accumulate old versions.
{% endblockquote %}


Clean up everything at once:

    brew cleanup

Clean up just one formula:

    brew cleanup {FORMULA}

Do a dry run to see what would be cleaned up:

    brew cleanup -n

I had well over a hundred older versions of various packages that I was not using (not pinned; *brew pin {FORMULA*), so I ran the cleanup and freed up 7.3 GB of drive space.

    brew info 
    146 kegs, 63167 files, 2.7G




