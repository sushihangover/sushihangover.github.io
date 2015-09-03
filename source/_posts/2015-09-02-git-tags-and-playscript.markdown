---
layout: post
title: "Git tags and PlayScript"
date: 2015-09-02 21:47:36 -0700
comments: true
categories: 
- github
- git
- playscript
---
{% img left http://sushihangover.github.io/images/PlayscriptLogo_small.png %} Seems I not found a way to update the 'upstream' master of [PlayScript](https://github.com/PlayScriptRedux/playscript) without actually push the tag directly to the repo.

So first I de-reference the tags to get the matching commit SHA for the tag I need to push:

	git show-ref --tags --dereference | grep play
	9e82533b52d5be2f10f8c0ddacff848810b8d736 refs/tags/play-3.10.0001
	a317c758ea3136347c4bc2a360c34fbacfce6d34 refs/tags/play-3.2.7
	a317c758ea3136347c4bc2a360c34fbacfce6d34 refs/tags/play-3.2.7001
	e97e27071414fdafba9ce95d4b7ca6c0c6da2a3c refs/tags/play-3.4.1001
	cfc55b6a587eba190042045e1a686388923310b0 refs/tags/play-3.6.1001
	b509d6711135bfba5b32cf3f7e2090964c67daa0 refs/tags/play-3.8.1001

That is done on my fork of the [PlayScript](https://github.com/sushihangover/playscript) repo as I try to never work directly on the 'upstream' master.

So in the case of tag "play-3.10.0001" that is not in the upstream PlayScript repo, I need to add it to the repo.

I switch the PlayScriptRedux org's [PlayScript](https://github.com/PlayScriptRedux/playscript) repo that I have a local clone of and update it.

First pull the latest changes, all done through pull-requests:

	git pull origin playscript

Now I can add the new tag:

	git tag play-3.10.0001 9e82533b52d5be2f10f8c0ddacff848810b8d736
	
And finally push it to the repo:

	git push origin play-3.10.0001

	Total 0 (delta 0), reused 0 (delta 0)
	To https://github.com/PlayScriptRedux/playscript.git
	 * [new tag]         play-3.10.0001 -> play-3.10.0001

	 
I still want to know if this is available through pull-requests somehow.


{% img right http://sushihangover.github.io/images/gitlogo.png %}
