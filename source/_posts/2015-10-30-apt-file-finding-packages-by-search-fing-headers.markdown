---
layout: post
title: "apt~file | Finding packages by searching headers"
date: 2015-10-31 06:30:29 -0700
comments: true
categories: 
- apt-get
- apt-file
- Ubuntu
---
##When you need a file or package and can't find it:

###Use apt-file

First, install `apt-file` and update it.

	sudo apt-get install apt-file
	sudo apt-file update

You can search with `apt-file` needed files or packages.

	apt-file search curses.h
	apt-file search panel.h
	apt-file search iconv.h

