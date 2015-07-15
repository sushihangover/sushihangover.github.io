---
layout: post
title: "PlayScript - Now has a REPL (playshell)"
date: 2015-07-15 06:35:49 -0700
comments: true
categories: 
- playscript
- playshell
- repl
- mono
- csharp
---

PlayScript now has a REPL for ActionScript scripting. This is very **alpha** right now and needs a lot of love. It will be used for running the [Tamarin Redux](http://hg.mozilla.org/tamarin-redux) [acceptance tests](https://www.mozilla.org/projects/tamarin/) so it will be evolving as those regression tests come online.

It is available in the [master branch](https://github.com/PlayScriptRedux/playscript) : 17aac5473528370b96e3349751bd2a8a017e6779

Check it out and post any [issues](https://github.com/PlayScriptRedux/playscript/issues/new) that you find. 

    * Added playshell : This is a PlayScript REPL (aka: like csharp REPL)
      - For use with Tamarin Redux test; they use Asset scripts with a test package
      - Very alpha at this point
      - Need to add PlayScript style 'import'
    * Added PsOnlyMode to compiler setting
      - Whether to enable PlayScript compiler only mode. Defaults to false.
    * mcs.master.mdw : XS/MD Workspace that will hold Solutions for all mcs
      - Added tools/csharp and tools/playshell
    * CSProj files updated via Make2CSProjUpdater to allow use in XS/MD:
      - Mono.PlayScript.csproj (and .sln)
      - Mono.CSharp.csproj (and .sln)
      - tools/charp.csproj (and .sln)
      - tools/playshell.csproj (and .sln)
