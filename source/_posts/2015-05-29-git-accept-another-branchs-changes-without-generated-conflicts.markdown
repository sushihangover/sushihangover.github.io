---
layout: post
title: "Git - Accept another branch's changes without generated conflicts"
date: 2015-05-24 17:54:37 -0700
comments: true
categories: 
- git
---
I not sure when exactly **-Xtheirs** was added to git (~1.7.? timeframe), but it is a great and fast way to replace (overlay) all the changed files from one branch on top of another one without doing an interactive accept of each and every file, or doing a forced merge, etc... Great for document, multi-media files and other content that gets processed/accepted via a different **pipeline** and in a different branch and needs moved into a production/release branch.

Assuming you are already sitting in the branch that you wish to merge/replace those files *into*, you can do a **git merge** with the  **-Xtheirs** option and supply the **remote/branch** that the files are *coming from*:

{% codeblock lang:bash %}
git merge -Xtheirs contentpipeline/version123
{% endcodeblock %}

