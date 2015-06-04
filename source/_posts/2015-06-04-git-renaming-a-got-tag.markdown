---
layout: post
title: "Git - Renaming a got tag"
date: 2015-06-04 07:39:49 -0700
comments: true
categories: 
- git
---
-{% img left http://sushihangover.github.io/images/gitlogo.png %}  Everyone screws up, and that comes to finger flops when typing that new tag name. 

If the tag is only local, it is two step process, create a new tag from the old tag and delete the old tag:

    git tag new_tag_name old_tag_name
    git tag -d old_tag_name

But if you have pushed that bad tag name to a remote, then you have another two steps. Deleting that remote tag makes use of the refspec reference and only using a destination with an ''empty' source. Assuming your remote is named origin (git remote -v), than this what you need to do (REMEMBER TO INCLUDE THAT **COLON**):

    git push origin :refs/tags/old_tag_name

And push the new tag to your remote so everyone else will receive that new tag on a pull:

    git push origin --tags

**Note**: The colon isn't a "delete flag". Git push and git pull both accept zero or more refspecs as their final argument(s). Now read about [refspecs](http://git-scm.com/book/en/v2/Git-Internals-The-Refspec), really read it... . A colon separates source from destination in a refspec. The command git push origin :foo has an empty source and essentially says "push nothing to branch foo of origin", or, in other words, "make branch foo on origin not exist". 

**Sub-Note**: This is NOT the same as pushing an **empty** branch or tag, you really are pushing 'nothing' and thus with nothing to reference that tag vanishes (Well I'm assuming it exists somewhere till [garbage collection](https://www.kernel.org/pub/software/scm/git/docs/git-gc.html) is run)

**Sub-Sub-Note**: ;-) Yes, I agree with a lot of others that instead of using an empty source in the ref spec it would be *waaaayyyyy* more initiative to allow a remote parameter to be passed to the existing branch and tag delete options to do this type of deletion.

