---
layout: post
title: "Xamarin OS-X Addins Location"
date: 2015-11-08 09:59:55 -0800
comments: true
categories: 
- mono
- xamarin
- xamarin studio
- monodevelop
- playscript
---
In the process of working on an Xamarin Studio Language Addin for PlayScript I needed to to manually find and update some of the installed Addin files. But where are the Addin files?

Within the `~/Library/Application Support` directory you will find one based on the version of Xamarin Studio or Monodevelop that you are using:


* `MonoDevelop-4.0`
* `MonoDevelop-5.0`
* `MonoDevelop-6.0`
* `XamarinStudio-4.0`
* `XamarinStudio-5.0`
* `XamarinStudio-6.0`

Within one of those directories you will find:

* `LocalInstall/Addins`

So for me, that ended up being:

`~/Library/Application Support/XamarinStudio-6.0/LocalInstall/Addins
`
`~/Library/Application Support/MonoDevelop-6.0/LocalInstall/Addins`