---
layout: post
title: "Mono - NUnit Hello World"
date: 2015-06-24 22:11:16 -0700
comments: true
categories: 
- mono
- os-x
- nunit
- nunit-console
- cmdline
---

From my Answer for "[Run NUnit test on Ubuntu from command line](Run NUnit test on Ubuntu from command line)" on [Stackoverflow](http://stackoverflow.com/questions/31038629/run-nunit-test-on-ubuntu-from-command-line/31041709#31041709):

Lets start from the beginning:

Get the latest and greatest NUnit **AND** it's Runner tools

    curl https://api.nuget.org/downloads/nuget.exe -o nuget.exe
    mono nuget.exe install NUnit
    mono nuget.exe install NUnit.Runners

Make sure the mono is finding those assemblies **first** (vs the GAC)

    export MONO_PATH=$(PWD)/NUnit.Runners.2.6.4/tools;$(PWD)/NUnit.2.6.4/lib

Create your test example (save it to vi OnlyTest.cs):


	using System;
	using System.Text;
	using System.Collections.Generic;
	using NUnit.Framework;

	[TestFixture]
	public class OnlyTest
	{
	    [Test]
	    public void MyTest() 
	    {
	        int a = 10;
	        Assert.AreEqual(10, a);
	    }
	}

 Compile it:

      mcs OnlyTest.cs -target:library -r:NUnit.2.6.4/lib/nunit.framework.dll -out:OnlyTest.dll

Run it:

    mono ./NUnit.Runners.2.6.4/tools/nunit-console.exe OnlyTest.dll -noresult

Output:

    Using default runtime: v4.0.30319
    NUnit-Console version 2.6.4.14350
    Copyright (C) 2002-2012 Charlie Poole.
    Copyright (C) 2002-2004 James W. Newkirk, Michael C. Two, Alexei A. Vorontsov.
    Copyright (C) 2000-2002 Philip Craig.
    All Rights Reserved.
    
    Runtime Environment -
       OS Version: Unix 14.3.0.0
      CLR Version: 4.0.30319.17020 ( Mono 4.0 ( 4.3.0 (master/b044a27 Thu Jun 18 15:17:08 PDT 2015) ) )
    
    ProcessModel: Default    DomainUsage: Single
    Execution Runtime: mono-4.0
    .
    Tests run: 1, Errors: 0, Failures: 0, Inconclusive: 0, Time: 0.0280499 seconds
      Not run: 0, Invalid: 0, Ignored: 0, Skipped: 0






