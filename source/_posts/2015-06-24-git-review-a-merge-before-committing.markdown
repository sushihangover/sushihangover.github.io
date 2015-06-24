---
layout: post
title: "Git - Review a Merge before committing"
date: 2015-06-24 09:44:07 -0700
comments: true
categories: 
- git
- merge
---
{% img left http://sushihangover.github.io/images/gitlogo.png %} After you perform a fetch on an upstream or someone's forked repo, you want to review the changes before committing them.

You can not do a what-if or a dry-run merge but it does not matter as git is your friend in this matter. Just do the merge and review it, BUT, do not let it commit or fast forward during the merge.

	git merge --no-commit --no-ff branchname

Without the **--no-ff** flag, if Git can do a fast-forward then it will do that and commit anyway *despite* the --no-commit flag.

Setup an alias in your ~/.gitconfig for a simple shortcut

	review = merge --no-ff --no-commit

So in looking at upstream changes:

	git fetch upstream
	git review upstream/master
	git status

If you wish to back those changes, just reset that merge:

	git reset --merge



