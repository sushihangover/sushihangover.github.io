---
layout: post
title: "Undo your most recent (screwed up) git merge"
date: 2015-05-28 18:24:08 -0700
comments: true
categories: 
- git
---
Ok, you just have a major brain-fart and you did a merge from a remote that has more conflicts than the Sahel region... before you do ANYTHING to your local repo, just do a: 

{% codeblock lang:bash %}
git reset --merge ORIG_HEAD
{% endcodeblock  %}

Or, depending upon your git version, you can also:

{% codeblock lang:bash %}
git merge --abort
{% endcodeblock %}

The merge is gone and that list of 1000+ file conflicts that scrolled endlessly when you hit the return key will not haunt your dreams tonight.

