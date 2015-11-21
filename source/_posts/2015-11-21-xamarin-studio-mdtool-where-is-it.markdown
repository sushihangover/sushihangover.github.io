---
layout: post
title: "Xamarin Studio mdtool - Where is it?"
date: 2015-11-21 08:36:11 -0800
comments: true
categories: 
- mono
- xamarin studio
- monodevelop
- mdtool
---
I'm not sure if it is a bug or not, but older versions of Xamarin Studio (and MonoDevelop) on OS-X (prior to El Capitan) installed a `mdtool` shell script in `/usr/local/bin` but that no longer happens(?).

`mdtool` original/missing shell script:

	#!/bin/bash
	MONO_EXEC="exec mono-sgen"
	EXE_PATH="/Applications/Xamarin Studio.app/Contents/Resources/lib/monodevelop/bin/mdtool.exe"
	$MONO_EXEC $MONO_OPTIONS "$EXE_PATH" "$@"
	
So create the script with the content above and place it into a directory in your path. `/usr/local/bin` is fine, but I personally install my shell scripts into a `$HOME/.scripts` directory that is included in my path so I can backup, via a git repo, my personal scripts and distinguish what I have created verus what gets installed in the `/usr/local/bin` by applications such a `brew`...

Note: Make sure that you `chmod a+x mdtool` in order to make it executable...

As always, have fun... ;-)


	$mdtool
	
	Xamarin Studio Tool Runner
	
	Usage: mdtool [options] <tool> ... : Runs a tool.
	       mdtool setup ... : Runs the setup utility.
	       mdtool -q : Lists available tools.
	
	Options:
	  --verbose (-v)   Increases log verbosity. Can be used multiple times.
	  --no-reg-update  Skip updating addin registry. Faster but results in
	                   random errors if registry is not up to date.
	
	Available tools:
	- build: Project build tool
	- dbgen: Parser database generation tool
	- project-export: Project conversion tool
	- gsetup: Graphical add-in setup utility
	- archive: Project archiving tool
	- account: Xamarin account tool
	- mac-bundle: Mac application bundle and installer generator.
	
