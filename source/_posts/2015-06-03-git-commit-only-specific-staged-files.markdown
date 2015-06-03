---
layout: post
title: "git  - Commit only specific staged files"
date: 2015-05-14 17:34:13 -0700
comments: true
categories: 
- git
---
I needed to commit a limited number of changes that were already staged. 

In the early days of git, I remember having to stash all the changes and pop only the changes that I need to commit and push. I'm not sure when the '--only' option was added to commit, but it sure saves a bunch of extra steps:

    git commit --only configure.in


