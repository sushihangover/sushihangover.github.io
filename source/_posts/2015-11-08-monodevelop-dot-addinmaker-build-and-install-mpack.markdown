---
layout: post
title: "MonoDevelop.AddinMaker - CI Build and Install .mpack"
date: 2015-11-08 11:54:48 -0800
comments: true
categories: 
- mono
- monodevelop
- xamarin studio
- addin
---
Using mhutch/MonoDevelop.AddinMaker to create your Addins? If not, you should convert your Addin Project (see his "Migrating Existing Projects" notes in the repo's [README.md](https://github.com/mhutch/MonoDevelop.AddinMaker/blob/master/README.md) file)

Need to intergate building, creating the `.mpack`, and installing it into Xamarin Studio into your CI process?

###Package your Addin to a .mpack file

`xbuild PlayScript.Addin.csproj /t:CreatePackage`

###Install your .mpack 

`mdtool setup install bin/Debug/PlayScript.Addin.PlayScript.Addin_1.0.mpack`


FYI: Using [mhutch/MonoDevelop.AddinMaker](https://github.com/mhutch/MonoDevelop.AddinMaker) makes developing and debugging Addins so much easier, there is still a **huge** documention gap in the MonoDevelop Addin system, but M. Hutch's AddinMaker sure helps a ton (thanks mhutch!).
 
