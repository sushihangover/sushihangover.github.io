---
layout: post
title: "Add a local repo as a remote to a different local repo"
date: 2015-05-27 19:34:36 -0700
comments: true
categories: 
- git
---
Have a two local repos that you what to mash and merge together so you can live with just one local/remote repo? 

Will, you are in luck, git allows a file based uri to be used vs. using https or git protocols.

{% codeblock lang:bash %}
git remote add NewRemoteName /file/path/to/existing/repo/.git
{% endcodeblock %}

{% codeblock lang:bash %}
git remote add 2013nov22 /Users/administrator/Documents/Code/playscript/playscript-mono-2013nov22-compile/.git
{% endcodeblock %}