---
layout: post
title: "Mono - Another benchmark between 32-bit and 64-bit Mono / LLVM"
date: 2015-06-09 20:24:45 -0700
comments: true
categories: 
- mono
- llvm
- benchmark
---

While I was still in the benchmark [mood](http://sushihangover.github.io/mono-64-bit-vs-32-bit-benchmark-using-scimark/), I thought I would run a perf test that someone wrote years ago. Not sure where it came from originally, but it includes 5 simple tests with only one being numeric related.

Per the [Mono LLVM web page](http://www.mono-project.com/docs/advanced/mono-llvm/), LLVM is not able to support some of the features that Mono needs, so in those cases the JIT compiler will still fall back to Mono’s JIT engine (i.e. Methods that contain try/catch clauses or methods that do interface calls).

One of the included tests is throwing and catching 100,000 exceptions and the 32/64-bit results show that enabling LLVM does not help.

		Note: The Mono web pages are notorious for begin out of date or lacking of details, even the 'new' ones, so I usually like confirmation. 

As the [SciMark test](http://sushihangover.github.io/mono-64-bit-vs-32-bit-benchmark-using-scimark/) showed, numeric operations under LLVM native code jit totally rocks over the built-in one, over 2x faster in this simple test.

String related functions can be 2x faster in the 64-bit mono, but enabling LLVM for either 32 or 64-bit does not really help that much, LLVM is still better but by micro-seconds (uS).

Enabling LLVM in Mono:

* Methods with Exceptions: No Help at all
* Numerics: Still rule
* String functions: No much help using LLVM, but 64-bit Mono kicks its 32-bit brother in the butt.
* Refection: Not much help either, as expected, but again 64-bit rules.

Net Results:

I am still not seeing a reason not to use a 64-bit version of Mono and not enabling LLVM as I am not using any 32-bit frameworks on OS-X (i.e.: OS-X Carbon API wrappers or GTK# 2.x).

Try it yourself: [Gist](https://gist.github.com/sushihangover/3d4d9d53770c501bf054)
    
    mcs -optimize+ -debug- -sdk:4.5 -target:exe -platform:x64 perftest.cs -out:perftest-64-release.exe

Next up: [How much does AOT'ing your CIL exe/dll images help...or not.](http://sushihangover.github.io/mono-32-bit-vs-64-bit-ahead-of-time-compilation-aot/))

## Additional Reading: 

* [Mono LLVM](http://www.mono-project.com/docs/advanced/mono-llvm/)
* [LLVM Backend](http://www.mono-project.com/docs/advanced/runtime/docs/llvm-backend/) 
* [Mono - 64-bit vs. 32-bit Benchmark Using SciMark](http://sushihangover.github.io/mono-64-bit-vs-32-bit-benchmark-using-scimark/
)



    $which mono
    /Users/administrator/mono/mono-llvm-64/bin/mono
    
    $mcs -optimize+ -debug- -sdk:4.5 -target:exe -platform:x64 perftest.cs -out:perftest-64-release.exe
    
	$mono perftest-64-release.exe 
    ArrayList strings test.............408 ms
    StringBuilder test.................499 ms
    Integer & Floating ADD.............3616 ms
    Exception test.....................375 ms
    Reflection and recursion...........2730 ms
    
    $ mono --llvm perftest-64-release.exe 
    ArrayList strings test.............497 ms
    StringBuilder test.................505 ms
    Integer & Floating ADD.............1620 ms
    Exception test.....................407 ms
    Reflection and recursion...........2790 ms
    
	$which mono
	/Users/administrator/mono/mono-llvm-32/bin/mono
	
	$mcs -optimize+ -debug- -sdk:4.5 -target:exe -platform:x86 perftest.cs -out:perftest-32-release.exe
    
    $mono perftest-32-release.exe 
    ArrayList strings test.............777 ms
    StringBuilder test.................958 ms
    Integer & Floating ADD.............3610 ms
    Exception test.....................589 ms
    Reflection and recursion...........4557 ms
    
    mono --llvm perftest-32-release.exe 
    ArrayList strings test.............830 ms
    StringBuilder test.................873 ms
    Integer & Floating ADD.............1731 ms
    Exception test.....................617 ms
    Reflection and recursion...........4441 ms
    


