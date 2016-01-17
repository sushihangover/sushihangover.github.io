---
layout: post
title: "Nuget and MSBuild Targets"
date: 2016-01-17 00:18:21 -0800
comments: true
categories: 
- nuget
- jay
- playscript
---
In adding support for [incremental](https://msdn.microsoft.com/en-us/library/ms171483.aspx) MSBuild support for Mono's [Jay](https://github.com/mono/mono/tree/master/mcs/jay) (Yacc-based) parser generator I could not get my resulting MSBuild target to automatically add the import statement to the `.csproj` via the nuget I created. The `.target` file was functional and correct and inside a "build" dir, but it would not update the project file, over and over I tested, looked at different nuget version, re-read the docs, etc... still no luck... 

I ended up reading the blog posting for the Nuget v2.5 release for "Support for Native Projects" was my answer:

> the file name must match your package id with either a “.props” or “.targets” extension

Also the release notes for version 2.5 they state this:

> Under this folder, you can place two files with fixed names, {packageid}.targets or {packageid}.props. 

Why are these 'notes' not in the 'normal' documention section and only listed on a blog posting and in release notes? 

So in-case someone else needs this information:

[Support for Native Projects](http://blog.nuget.org/20130426/native-support.html)

[NuGet 2.5 Release Notes](http://docs.nuget.org/release-notes/nuget-2.5)

##Automatic import of msbuild targets and props files

A new conventional folder has been created at the top level of the NuGet package. As a peer to \lib, \content, and \tools, you can now include a '\build' folder in your package. Under this folder, you can place two files with fixed names, {packageid}.targets or {packageid}.props. These two files can be either directly under \build or under framework-specific folders just like the other folders. The rule for picking the best-matched framework folder is exactly the same as in those.

When NuGet installs a package with \build files, it will add an MSBuild <Import> element in the project file pointing to the .targets and .props files. The .props file is added at the top, whereas the .targets file is added to the bottom.

##MSBuild Integration
C++ projects tend to have many different configurations–more than what NuGet is able to handle. To address NuGet’s configuration limitations, we are relying heavily on MSBuild properties and targets for native packages. These MSBuild properties and targets do the heavy lifting of providing references at build time, based on your project’s configuration.

To make MSBuild integration better, NuGet has created a new convention for automatically importing MSBuild properties and targets from a NuGet package. Alongside the existing \content, \lib, and \tools folders, NuGet now recognizes a new top-level folder: \build.

Within the \build folder, you can provide a “.props” file and/or a “.targets” file that will be automatically imported into the project. For this convention, the file name must match your package id with either a “.props” or “.targets” extension. For example, the ‘cpprestsdk’ package includes a ‘cpprestsdk.targets’ file in its \build folder. Files with the “.props” extension will be imported at the top of the project file, and files with the “.targets” extension will be imported at the bottom of the project file.

Note that this \build folder can be used for all NuGet packages and not just native packages. The \build folder respects target frameworks just like the \content, \lib, and \tools folders do. This means you can create a \build\net40 folder and a \build\net45 folder and NuGet will import the appropriate props and targets files into the project. You no longer need to write PowerShell install.ps1/uninstall.ps1 scripts to import MSBuild targets files!
