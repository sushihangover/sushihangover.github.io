---
layout: post
title: "C# - Native Interop Helloworld"
date: 2015-06-23 18:40:28 -0700
comments: true
categories: 
- mono
- c#
- interop
---


#### The simplest Interop case HelloWorld I can create, give it a try and see what happens:

`>cat countbyone.cpp`

	extern "C" int SomeMethod(int num) {
	  return num++;
	}

**Compile your shared library:**

* Linux:
`gcc -g -shared -fPIC countbyone.cpp -o libcountbyone.so`
* OS-X:
`clang -dynamiclib countbyone.cpp -o libcoutbyone.dylib`

`>cat interop.cs`

	using System;
	using System.Runtime.InteropServices;
	namespace InteropDemo
	{
	    class MainClass
	    {
	        [DllImport("countbyone")]
	        private static extern int SomeMethod(int num);

	        public static void Main (string[] args)
	        {
	            var x = SomeMethod(0);
	            Console.WriteLine(x);
	        }
	    }
	}

**Compile your .Net/Mono app:**

`>mcs interop.cs`

**Run it:**

	>mono interop.exe
	1

**Output should be 1 and no errors...**

#### If the shared (native) library is not found, you receive:

`XXXXX failed to initialize, the exception is: System.DllNotFoundException
`

####If you have a entry point mismatch you would receive a:

`XXXXX failed to initialize, the exception is: System.EntryPointNotFoundException
`

From my answer on [Stackoverflow](http://stackoverflow.com/questions/31013147/check-if-p-invoke-was-successful/31015964#31015964)
