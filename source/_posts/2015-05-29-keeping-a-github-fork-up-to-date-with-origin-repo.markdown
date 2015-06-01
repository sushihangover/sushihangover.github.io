---
layout: post
title: "Keeping a GitHub fork up to date with origin repo"
date: 2015-05-29 17:22:05 -0700
comments: true
categories: 
- PlayScript
- ActionScript
- Mono
- Github
- git
---

In the PlayScript work that I am doing on the Mono mcs compiler, keeping the PlayScript compiler in-sync with Mono's mcs can be a pain due to the large number of changes that occur on that repo.

While I have different 'tricks' to try to help merging, the first thing is you have to keep one branch of your fork in-sync with the original repo that your forked, mono/mono.git in my case.

I created two local clones of my GitHub forked repo and added an 'upstream' remote to the original mono repo.

{% codeblock lang:bash %}
git remote -v
origin	https://github.com/sushihangover/PlayScript.git (fetch)
origin	https://github.com/sushihangover/PlayScript.git (push)
upstream	https://github.com/mono/mono.git (fetch)
upstream	https://github.com/mono/mono.git (push)
{% endcodeblock %}

One local clone is named **PlayScript-master** and the other is **PlayScript**. 

The **PlayScript-master** is used to keep in-sync with the upstream repo, build the bleed-edge mono framework and compiler and run the mono unit-tests. This is so I always know what the current mono master looks like and how the unit tests are running so I can review the changes I am making in the local **PlayScript** repo and make sure that I am not injecting regression failures in the C# side of the compiler. (I'll blog about that later). While the **PlayScript-master repo** will always Fast-forward on a "*git merge upstream/master*", the PlayScript repo will not, I only merge one branch/tag mono release at a time to *master branch* and then merge/rebase *playscript branch* in order to maintain my sanity (some of the internal API changes on even Mono minor releases can drive a person to drink). 

So to quickly update my master mono as it will always fast-forward, I have a script in the root repo called **mono-master-update-install.sh**.

{% codeblock lang:bash %}
cd ../PlayScript-master
git fetch upstream
git merge upstream/master
git push origin
make
make install
{% endcodeblock %}

**Note**: You can add the mono unit tests to the end of that script if you wish.

**Note**:: I have the **PlayScript-master** *master branch* installing into a prefix of <u>~/mono-install</u> and the **PlayScript** *playscript branch* installing into the <u>~/playscript-install</u>. That way I can always switch quickly between the installed 'released' Mono framework, the pure bleeding-edge mono build and the PlayScript build with a simple path change.

