---
layout: post
title: "PowerShell and Bash 'Dot' Sourcing"
date: 2014-02-17 06:21:11 -0800
comments: true
categories: 
- PowerShell
- Bash
- CMD Line
---
Parent/Child scoping of variables and functions can really mess with people starting out with PowerShell (or Bash).

In terms of "Dot-sourcing" a .ps1 file, it is like running the PowerShell script it contains **inline** in the current scope. Thus when that script finishes, any variables set/updated within it are changed within the current scope.

Let create a .ps1 file that increments the variable $x by one and 'outputs' it to the pipe:

```
echo "`$x++;`$x;" > inc_x_by_one.ps1
```
Now assign the variable $x to be 1

```
$x=1
$x
1
```
Now run the *inc_x_by_one.ps1* routine:

```
.\inc_x_by_one.ps1
2
```
So we got a result of 2 which is what you wanted right? Well, maybe... Let run the same thing again:

```
.\inc_x_by_one.ps1
2
$x
1
```
What? Why is it not 3(?), and it is still 1!!! Well that is because the $x++ is executing in a *child scope*. Basically your script is getting a copy of $x, not a reference (pointer) to that variable. Same thing that you experience in passing variables to functions in C, C#, Java, etc...

If your desire is to actually change $x in your shell (the current scope), you can 'dot-source' the call. 

```
. .\inc_x_by_one.ps1
2
. .\inc_x_by_one.ps1
3
$x
3
```

This is compariable to the way shell variables work under bash, zsh, ... and I'm assuming the PowerShell term borrowed 'dot sourcing' in that regard as the syntax if the same: **Period Space File.ps1|.sh**

Take a few minutes and read the help on **scope**, it just might save you a headache in the future ;-)

```
help scope
```

Note: In PowerShell, you can assign variables to the global scope and not 'worry' about parent/child scoping rules. Normally this is not a preferred way  as it create it creates messy code, issues of which function/module is changing it, debugging nightmares, etc... 





