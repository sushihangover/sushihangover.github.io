---
layout: post
title: "Git - Turn multiple commits into a single commit"
date: 2015-06-30 18:10:36 -0700
comments: true
categories: 
- git
---
{% img left http://sushihangover.github.io/images/gitlogo.png %} Getting ready for an upstream pull request? You really need to turn it into a single commit for a clean request that will result in a fast-forward merge.

### Switch to the upstream/master branch and make sure you are up to date.
	git checkout master
	git fetch upstream/master 	
	git merge master

### Create a new feature/topic branch:

	git checkout -b MyPullRequest
	git merge MyMultiCommitBranch

### Reset the branch to origin's state.

	git reset origin/MyPullRequest
	git status

**Note: Git now considers all changes as unstaged changes.**


### We can add these changes as one commit.

	git add --all
	git commit

You can push those changes to your remote repo and then issue that pull request to the upstream that you forked from.
