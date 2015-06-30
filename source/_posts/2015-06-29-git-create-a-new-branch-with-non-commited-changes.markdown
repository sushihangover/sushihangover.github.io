---
layout: post
title: "Git - Create a new branch with non-commited changes"
date: 2015-06-29 05:28:05 -0700
comments: true
categories: 
- git
---
{% img left http://sushihangover.github.io/images/gitlogo.png %} Have you started making changes and than realize that you should have created a new branch first. Well, there is a slick way to create a new branch and have those changes 'moved' to from master to your topic (the new branch).

	git branch newbranch
	git reset --hard HEAD
	git checkout newbranch

This works even if you have made commits to your local branch, just subsititute **HEAD** with the number of commits back you would like to go, i.e. **HEAD~2**, or use the SHA.


