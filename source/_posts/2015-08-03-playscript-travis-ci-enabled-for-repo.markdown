---
layout: post
title: "PlayScript | Travis CI enabled for repo"
date: 2015-08-03 12:54:06 -0700
comments: true
categories: 
- playscript
- mono
- travis
- actionscript
---

{% img left http://sushihangover.github.io/images/PlayscriptLogo_small.png %} I have enabled Travis CI on the [PlayScript](https://github.com/PlayScriptRedux/playscript) repo. 

FYI: While the OS-X build is running fine, the linux build is failing as it has never really been tested (in the original Zngya release or The Redux version). This has been flagged as acceptable in Travis for now.

 The CI builds are generously hosted and run on [Travis][travis]

{% img right http://blog.travis-ci.com/images/travis-mascot-200px.png %}

|  Git Branch  |   Mac OS-X / Linux  |
| :----------: | :-----------------: | 
| **[playscript](https://github.com/PlayScriptRedux/playscript)** | [![master nix][master-nix-badge]][master-nix] |




 [travis]: https://travis-ci.org/

 [master-nix-badge]: https://travis-ci.org/PlayScriptRedux/playscript.svg?branch=playscript
 [master-nix]: https://travis-ci.org/PlayScriptRedux/playscript/branches
