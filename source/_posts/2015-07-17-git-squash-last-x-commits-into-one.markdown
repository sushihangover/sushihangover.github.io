---
layout: post
title: "Git - Squash last X commits into one"
date: 2015-07-17 10:35:06 -0700
comments: true
categories: 
- git
---
{% img left http://sushihangover.github.io/images/gitlogo.png %} 

Use git rebase -i <after> and replace "pick" on the second and subsequent commits with "squash" or "fixup", as described in the Git [manual](http://git-scm.com/docs/git-rebase#_interactive_mode).

<after> is the commit after the last one that you wish squash together, i.e. parent of the oldest commit you want to squash.

Example:

You want to squash the last three commits into one, so lets look at the log to make sure that you want you want and to grab the commit SHA:

>git log -n 4 --pretty=oneline

	f57f7f9c28646d5049aa6b90f33de23e1e53ad2e More test cleanups
	07074c8058ed69224670987860c9db47858dab6e PlayScript compiler tests using a variant of compiler-tester
	3b80dc06b990553042b4b0cde486e36522f4171b Remove .as/.play from mcs/tests These have been already moved to mcs/play_tests/[as|play] and intregrated into the mono compiler-tester (make [astest|playtest|playscript]
	db6506ca17e49f0829ca9859a7994ddf840dbff4 * Tamarin-Redux Test Cleanup * Remove old Tamarin tests, the redux versions are the last released version
	
I want to squash the first three commits, so grab the forth SHA and:

>git rebase -i db6506ca17e49f0829ca9859a7994ddf840dbff4

	pick 3b80dc0 Remove .as/.play from mcs/tests These have been already moved to mcs/play_tests/[as|play] and intregrated into the mono compiler-tester (make [astest|playtest|playscript]
	pick 07074c8 PlayScript compiler tests using a variant of compiler-tester
	pick f57f7f9 More test cleanups

	# Rebase db6506c..f57f7f9 onto db6506c (3 command(s))

Following the directions in the commentted text. In this example: change the second and third items to squash:

	pick 3b80dc0 Remove .as/.play from mcs/tests These have been already moved to mcs/play_tests/[as|play] and intregrated into the mono compiler-tester (make [astest|playtest|playscript]
	squash 07074c8 PlayScript compiler tests using a variant of compiler-tester
	squash f57f7f9 More test cleanups

	# Rebase db6506c..f57f7f9 onto db6506c (3 command(s))

Save those changes and exit the editor and the rebase will execute

	[detached HEAD ~~~
	~~~
	Successfully rebased and updated refs/heads/play-tests.

Confirm via:
	
>git log -n 2
	

FYI: This is something you should do to your feature branch before pushing to your fork to make that [PlayScript](http://github.com/playscriptredux/playscript) pull request. ;-)
