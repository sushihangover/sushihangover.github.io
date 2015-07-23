---
layout: post
title: "Xamarin Studio / MonoDevelop - 'Unexpected binary element: 0' build failure"
date: 2015-07-23 11:21:41 -0700
comments: true
categories: 
- mono
- monodevelop
- xamarin
- xamarinstudio
---

Getting an 'Unexpected binary element: 0' when you are trying to build a project in Xamarin Studio / MonoDevelop? I found this when using a parallal mono install on OS-X and it seems others have also. 

If you are also getting it build failure, please add your findings to:

[Bug 29958 - Mono 4.0 - Causing 'Unexpected binary element: 0' build failure when compiling against previous mono version](https://bugzilla.xamarin.com/show_bug.cgi?id=29958)

It appears not to be OS dependent either:

[Building empty ASP.NET project in MonoDevelop (Xamarin Studio) generates “Unexpected binary element: 0” error](http://stackoverflow.com/questions/31594099/building-empty-asp-net-project-in-monodevelop-xamarin-studio-generates-unexpe)

