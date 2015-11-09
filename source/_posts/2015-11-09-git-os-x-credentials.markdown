---
layout: post
title: "Git OS-X Credentials"
date: 2015-11-09 03:33:38 -0800
comments: true
categories: 
- git
- osx
---
Setting up a fresh install of El Capitan...

I instal git via [homebrew](http://brew.sh):

`brew git`

And then since it has been such a long time since I had to link git to the OS-X key chain, I totally forgot how...

But if you installed git using homebrew, you should already have the osxkeychain helper. You can verify this by trying to run it:

`git credential-osxkeychain`

To tell git to use osxkeychain, simply set the global git config:

`git config --global credential.helper osxkeychain
`