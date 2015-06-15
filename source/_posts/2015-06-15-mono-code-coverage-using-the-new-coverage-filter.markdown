---
layout: post
title: "Mono - Code Coverage using the new coverage filter"
date: 2015-06-15 21:33:29 -0700
comments: true
categories: 
- mono
- profile
- codecoverage
---

## New code coverage filter:

Using the new coverage filter on the mono log profiler, you can get output like this:

    Coverage Summary:
    	xCorFlags (/Users/administrator/monocov/lib/xCorFlags.exe) 26% covered (42 methods - 11 covered)
    		<Module> ?% covered (0 methods - 1 covered)
    		CorFlags.CorFlagsSettings 25% covered (4 methods - 1 covered)
    		CorFlags.MainClass 50% covered (2 methods - 1 covered)
    		CorFlags.CommandLineParser 40% covered (20 methods - 8 covered)

{% blockquote %}
Having a suite of existing unit-tests, you can enable the coverage filter and get some quick answers to your question about how much code you are really exercising and testing.
{% endblockquote %}


## Background:

Well, it appears that Xamarin has removed the 'internal' cov profiler and monocov will not produce any output (besides mono actually loading the shared library, no functions are called) as the api has changed.

They have added a code coverage filter (Apr 7 2015) to the core log profilers and while I could not find any published documentation(?). It is easy enough to enable.

    --profile=log:coverage

    coverage             enable collection of code coverage data
    covfilter=ASSEMBLY   add an assembly to the code coverage filters
                         add a + to include the assembly or a - to exclude it
                         filter=-mscorlib
    covfilter-file=FILE  use FILE to generate the list of assemblies to be filtered

Git log info on cov removal and log coverage filter addition:

    commit 16570265149730ec6a4760cc0fa34decc1a9d981
    Author: Alex Rønne Petersen <alexrp@xamarin.com>
    Date:   Tue Apr 7 14:51:27 2015 +0200
            [profiler] Remove old mono-cov profiler.
            We're replacing this with coverage support in the log profiler.
    
    commit e91693fbb87f687a2fdb5a495c945c1872b3066c
    Author: iain holmes <iain@xamarin.com>
    Date:   Fri Feb 27 10:13:54 2015 +0000
            [cov] Install a coverage filter
    

If you are still using Mono 3.x, then my other MonoCov post as it would still work:

* [http://sushihangover.github.io/monocov-building-on-os-x/](http://sushihangover.github.io/monocov-building-on-os-x/)
* [http://stackoverflow.com/questions/30847262/how-to-build-and-use-monocov-on-a-mac/30853374#30853374](http://stackoverflow.com/questions/30847262/how-to-build-and-use-monocov-on-a-mac/30853374#30853374)
