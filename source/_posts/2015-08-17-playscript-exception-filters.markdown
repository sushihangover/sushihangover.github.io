---
layout: post
title: "PlayScript | Exception Filters"
date: 2015-08-17 18:34:18 -0700
comments: true
categories: 
- playscript
- mono
- C#
---

{% img left http://sushihangover.github.io/images/PlayscriptLogo_small.png %} [PlayScript](https://github.com/PlayScriptRedux/playscript) (.play) now has Exception Filters like C# 6.0. 

These are actually really cool and nice addition to ActionScript.

From the [C# Frequently Asked Questions](http://blogs.msdn.com/b/csharpfaq) blog:

> Exception filters are a CLR capability that is exposed in Visual Basic and F#, but hasn’t been in C# – until now. This is what they look like in C#:

	try { … } 
	catch (MyException e) if (myfilter(e)) 
	{ 
	     … 
	}

[New Features in C# 6](http://blogs.msdn.com/b/csharpfaq/archive/2014/11/20/new-features-in-c-6.aspx)

And here is what they look like in PlayScript:

### play/test-ps-ex-filter-01.play

	package {
	    public class Foo {
	        public static function Main():int {
			var x:int = 4;
			try {
				throw new Error("Throw");
			} catch (e:Error) if (x > 0) {
				trace("Catch");
				return 0;
			}
			return 1;
	        }
	    }
	}

### play/test-ps-ex-filter-02.play

	package {
	    public class Foo {
	        public static function Main():int {
			var x:int = 4;
			try {
				x = 5;
				throw new Error("Throw");
			} catch (e:Error) if (x < 5) {
				trace("No Catch Please");
				return 0;
			} catch (myError:Error) {
				trace("Catch Here");
				return 0;
			}
			return 1;
	        }
	    }
	}
	
If you have any problems with them, post an [issue](https://github.com/PlayScriptRedux/playscript/issues). 