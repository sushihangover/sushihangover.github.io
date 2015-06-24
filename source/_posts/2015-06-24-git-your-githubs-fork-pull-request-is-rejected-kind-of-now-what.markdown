---
layout: post
title: "Git : Your Github's fork pull request is rejected, kind-of, now what?"
date: 2015-06-24 07:46:41 -0700
comments: true
categories: 
- git
- github
- pull request
---
{% img left http://sushihangover.github.io/images/gitlogo.png %} So you have a Github fork of a project and you find a problem. You whip up a fix, commit it in a local branch and push it to your fork you Github. Than you issue a pull request to the upstream repo. Life is good. {% img right http://sushihangover.github.io/images/github_logo.png %}

But... your pull request is 'rejected', kind-of, as the fix is applied differently to their branch. Now your GitHub and local repo are history mismatched to the upstream master. Fetching upstream and merging upstream/master produces conflicts ;-(

First, I do not want to lose the commit that I did do. I want to keep the work/history so a 'simple' git hard reset to a prior sha is out of the question.

So lets put your changes on a new branch and reset the master branch back to match the upstream.

### Move last commit to a new branch

Note: You *will* lose uncommitted work, stash first if needed!

	git branch newbranch
	git reset --hard HEAD~1 # Go back 1 commit or use SHA
	git checkout newbranch

### Re-sync your Github fork

Now, lets get everything re-sync'd.

	git checkout master

Since you already push this branch to your Github fork, you will see the message:

	"Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded."

That contains *your* fix, but you need to merge in the upstream/master changes.

	git fetch upstream
	git merge upstream/master

And your local master should *Fast-forward* to match the upstream. All is good, except your repo on Github is not correct as it contains your original commit on the wrong branch.

	git push --force

If you want to keep (backup) that new branch to Github than use the following instead:

	git push --all --force

Note: You should not be forcing a push if others have already pulled from your repo/fork. That causes bad git mojo and everyone else that pulled your repo will need to be notified that you 'changed' history... That is a git fixup story for another day.
