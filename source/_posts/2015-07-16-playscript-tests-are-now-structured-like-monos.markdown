---
layout: post
title: "PlayScript : Tests are now structured like Mono's"
date: 2015-07-16 20:08:45 -0700
comments: true
categories: 
- mono
- playscript
- playc-tester
- compiler-tester
---
I [moved all the .play and .as tests](https://github.com/PlayScriptRedux/playscript/pull/8) under the play_test directory. They are in two separtate dirs now, **play** for the extended PlayScript language/format and **as** for the standard ActionScript tests.

In doing this and making them conform to how Mono's compiler tests are written and run, I ended up copying the tools/compiler-tester to tools/playc-tester. The number of changes I was making to the program seems out of place to keep in within Mono's version and long term this will keep up with trying to keep any changes to the actual Mono code base at a minimun to allow faster and cleaner merging of their master branch. This tool will have very little commit activity compared to the mcs.exe/playc.exe compilers.

### Playc-tester.exe

	mono playc-tester.exe
	PlayScript compiler tester, (C) 2009 Novell, Inc. (C) SushiHangover/RobertN
	playc-tester -mode:[pos|neg] -compiler:FILE -files:file-list [options]

	   -compiler:FILE   The file which will be used to compiler tests
	   -compiler-options:OPTIONS  Add global compiler options
	   -il:IL-FILE      XML file with expected IL details for each test
	   -issues:FILE     The list of expected failures
	   -log:FILE        Writes any output also to the file
	   -help            Lists all options
	   -mode:[pos|neg]  Specifies compiler test mode
	   -safe-execution  Runs compiled executables in separate app-domain
	   -update-il       Updates IL-FILE to match compiler output
	   -update-ref      Updates the debug xml to match debug compiler mdb output
	   -verbose         Prints more details during testing


Example test run of the current as tests:

    make astest
    ~~~
    ./as/test-debug-015.as...   NOT TESTED
    ./as/test-debug-AllowDynamics.as... KNOWN ISSUE (Execution error)
    ./as/test-debug-DivideByZeroTest.as...      KNOWN ISSUE (Compilation error)
    ./as/test-debug-UntypedVariableTest.as...   KNOWN ISSUE (Compilation error)
    Done

    40 test cases passed (93.02%)
    1 test(s) ignored
    3 known issue(s)
    
With these changes and the addition of the playshell REPL in the last set of changes will allow the Tamarin Redux tests to start coming online. Then CI deployment will be the step after that.
 
As always [post](https://github.com/PlayScriptRedux/playscript/issues) any isses that you find. ;-)