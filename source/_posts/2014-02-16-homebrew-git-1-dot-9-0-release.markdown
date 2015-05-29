---
layout: post
title: "Homebrew: Git 1.9.0 release"
date: 2014-02-16 10:32:41 -0800
comments: true
categories: 
- Homebrew
- Git
---
> Update: Someone else has done a pull-request for homebrew git that is awaiting cool down on the new 1.9.0 release before it gets mainlined. As the formula is the basically the same as mine you can grab it via the [pull-request](https://github.com/Homebrew/homebrew/pull/26734) on github and post 1.9.0 issues/comments in that thread.

[Git](https://code.google.com/p/git-core/) just released [1.9.0](https://code.google.com/p/git-core/downloads/detail?name=git-1.9.0.tar.gz) (Feb-14-2014) but [Homebrew](http://brew.sh) does not have this update quite yet so I updated the tar ball references, sha1 tags and commented out the patch that is no longer required (this needs cleaned up as there are older patches commented out also...). As for the complete release notes, click [here](http://anzwix.com/a/Git/Git190).

I do not have time right now to do a pull-request, so here is a [gist](https://gist.github.com) of it so you can update your Git version. Do a "brew edit git" and replace the contents with this and you can update to 1.9.0.

{% gist 9036063 git.rb %}
