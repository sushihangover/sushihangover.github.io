---
layout: post
title: "Git: Set up a fetch-only remote | Disabling push"
date: 2015-06-14 14:57:37 -0700
comments: true
categories: 
- git
- github
---
{% img left http://sushihangover.github.io/images/gitlogo.png %} The PlayScript repo on the [PlayScriptRedux](https://github.com/PlayScriptRedux) Github organization I maintain is a down-stream fork of [Mono](https://github.com/mono/mono) so I can fetch the changes to their master branch. I also have my own [fork](https://github.com/sushihangover/playscript) of the PlayScript repo so I can code, issue pull-requests and review other people's pull-requests. But I do not want to screw up and push directly to the [Redux based repo](https://github.com/PlayScriptRedux/playscript) from my local repo, only my own fork on GitHub. Also I do not have any push permissions on the Mono repo and want to not even have git try to push to that repo if I screw up on the cmd line.

So after adding my additional remotes my local repo, it looks like this:

    git remote -v
    origin	https://github.com/sushihangover/playscript.git (fetch)
    origin	https://github.com/sushihangover/playscript.git (push)
    redux	https://github.com/PlayScriptRedux/playscript.git (fetch)
    redux	https://github.com/PlayScriptRedux/playscript.git (push)
    upstream	https://github.com/mono/mono.git (fetch)
    upstream	https://github.com/mono/mono.git (push)
    
I want to keep the fetch/pull ability from the redux and upstream remotes and remove the  'push' ability to those remotes.

You can not totally clear the push uri as it will be replaced with the fetch uri. So setting the push uri to something nonexistent works, i.e.

     git remote set-url --push upstream DISABLE
     git remote set-url --push redux DISABLE
 
And to see what that looks like now:

    git remote -v
    origin	https://github.com/sushihangover/playscript.git (fetch)
    origin	https://github.com/sushihangover/playscript.git (push)
    redux	https://github.com/PlayScriptRedux/playscript.git (fetch)
    redux	DISABLE (push)
    upstream	https://github.com/mono/mono.git (fetch)
    upstream	DISABLE (push)

Now if you push to the one of the 'disable' remotes, you will recieve the following error:

    git push redux
    fatal: 'DISABLE' does not appear to be a git repository
    fatal: Could not read from remote repository.
    
    Please make sure you have the correct access rights
    and the repository exists.

NOTE: You do not have to use "DISABLE", any nonsensical URI will do. I like DISABLE as seeing it in the git push error message is a clear indicator of the brain fart that I just typed...