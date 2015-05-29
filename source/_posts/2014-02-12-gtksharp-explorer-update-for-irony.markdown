---
layout: post
title: "GtkSharp-Explorer update for Irony"
date: 2014-02-12 08:14:14 -0800
comments: true
categories: 
- Irony
- Mono
- OS-X
- C#
---
[{% img left images/Irony-GtkSharp-Explorer-OS-X-ScreenCap.png  360 240 'Irony.GtkSharp.Explorer' 'Irony GtkSharp Explorer' %}](images/Irony-GtkSharp-Explorer-OS-X-ScreenCap.png) I was working on a [Irony/C#](https://irony.codeplex.com) based DSL that I wrote awhile back and noticed that I had some strange NameSpace issues with the GTK UI (exposed only within Xamarin's Stetic Designer, not sure how those naming conflicts were not a compile time error...).

Updated source for my Gtk# addition to Irony is on GitHub now. **Remember that my additions are on the "gtksharp-explorer" branch.**
{% codeblock lang:bash %}
git branch --all
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/gtksharp-explorer
  remotes/origin/master
  remotes/origin/xplat-nunit-fix
git checkout gtksharp-explorer
  Branch gtksharp-explorer set up to track remote branch gtksharp-explorer from origin.
  Switched to a new branch 'gtksharp-explorer'

git branch --all
* gtksharp-explorer
  master
  remotes/origin/HEAD -> origin/master
  remotes/origin/gtksharp-explorer
  remotes/origin/master
  remotes/origin/xplat-nunit-fix  
open Irony_All.MonoDevelop.sln 
{% endcodeblock %}  

==============================
Grammar Explorer based on Gtk#
==============================
*For cross-platform Irony work in Mono 3.2.X and MonoDevelop/Xamarin 4.1.X/4.2.X*
Instructions for building on Mono:

Via MonoDevelop/Xamarin IDE:
----------------------------
* Release or Debug Targets:
        Load and build via the Irony_All.MonoDevelop.sln
Via cmd line:
-----------------

* Release:
xbuild /p:Configuration=Release Irony_All.MonoDevelop.sln
mono Irony.GrammarExplorer.GtkSharp/bin/Release/Irony.GrammarExplorer.GtkSharp.exe

* Debug:
xbuild /p:Configuration=Release Irony_All.MonoDevelop.sln 
mono Irony.GrammarExplorer.GtkSharp/bin/Debug/Irony.GrammarExplorer.GtkSharp.exe
