---
layout: post
title: "Using redirection within xargs"
date: 2015-11-28 06:29:15 -0800
comments: true
categories: 
- bash
- xargs
- redirection
---
I needed to convert a bunch of AppleScript `.scpt` files to uncompiled `.txt` files, so a simple `find` piped to `xargs` and I'll be done... well...

OS-X provides a `osadecompile` cmd that will read a `.scpt` file and output the text to `stdout` (It does not provide a output file option). So a simple redirection and I should be done:


	# This will not work, you will end up with a file 
	# named {}.txt that includes the test of all the scripts
	find *.scpt -print0 | xargs -0 -n 1 -I {} osadecompile '{}' > '{}.txt' 


But that will not work as the redirection applies to the `xargs` cmd, not the `osadecompile` cmd that xargs is calling. So a quick fix is to create a subshell and include the redirection in the passed cmd string (via `-c`)

So this will work:

	find *.scpt -print0 | xargs -0 -n 1 -I {} sh -c "osadecompile '{}' > '{}.txt'"


Still simple enough, and since I only have a couple of dozen files in this case the performance impact of creaing subshells is not a problem... 

**Homework:** How would you get around this in using a bash [one-liner](https://en.wikipedia.org/wiki/One-liner_program) without a subshell?

