---
layout: post
title: "Adding nuget packages to your MonoDevelop Addin Templates"
date: 2016-01-01 21:48:44 -0800
comments: true
categories: 
- playscript
- mono
- monodevelop
- xamarin studio
- xamarin
---
I recently created nugets for the PlayScript AOT assemblies as well as a separtate MSBuild target nuget and it ended up working really well in a x-plat way.

But one thing that I could not find quickly was how to tag my templates with the package info so they are automatically installed when the solution/projects are created. 

Well the answer was kind-of right under my nose ([RTFM](https://en.wikipedia.org/wiki/RTFM)):

>Conditionally Adding a NuGet Package from a Project Template
A NuGet package be conditionally installed based on a boolean parameter defined by the project template wizard.

	<Packages>
	    <Package id="Xamarin.GooglePlayServices" version="19.0.0.1" if="UseGooglePlayServices" />
	</Packages>

>The conditions that can be specified do not support the more complicated condition that grouped templates do.

Re: [Conditionally Adding a NuGet Package from a Project Template](http://www.monodevelop.com/developers/articles/project-templates/#conditionally-adding-a-nuget-package-from-a-project-template) 
 
So in my templates I currently do not have to lock them to a version and want the most recent ones available so I skip the version attribute:

	<Packages>
	    <Package id="PlayScript.AOT" />
	    <package id="PlayScript.MSBuild" />
	</Packages>

