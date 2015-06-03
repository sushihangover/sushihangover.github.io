---
layout: post
title: "Git - Overlay a directory with a different branch version"
date: 2015-05-11 16:10:28 -0700
comments: true
categories:
- git 
---
I was trying to overlay just one directory within one git branch with the files from another branch (actually a tag in my case)) and could find a way to do it with just one git command.

So using git ls-files and xargs this is my solution:

    git ls-files |xargs -J %  git checkout -f mono-3.2.4 -- %

If anyone has a way to do this without using xargs I'm all ears... ;-

